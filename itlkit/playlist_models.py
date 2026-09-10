"""Bounded read-only playlist observations; never mutation authority.

Pure bytes APIs, immutable outputs, local diagnostics. See
``docs/playlist-models-v2.md`` for evidence levels and limits protocol.
"""
from __future__ import annotations

from collections import Counter
from collections.abc import Mapping
from dataclasses import dataclass, field, fields, is_dataclass
import hashlib
import io
import json

__all__ = ["PlaylistLimitError", "Diagnostic", "RawSpan", "WireField",
           "SmartRule", "SmartTree", "MetadataOccurrence", "EntryModel",
           "ParentEdge", "PlaylistModel", "SectionModel", "PlaylistDocument",
           "inspect_playlists", "inspect_playlist_payload", "parse_smart_rules",
           "models_json"]

_DEFAULTS = dict(max_file_bytes=16 * 1024**2, max_plain_bytes=16 * 1024**2,
                 max_nodes=100000, max_depth=32, max_text_bytes=4 * 1024**2,
                 max_json_bytes=64 * 1024**2, memory_budget_bytes=512 * 1024**2)
_SMART_EVIDENCE = "iTunes 12.13.10.3 RVA bf0dd0/bf0a80; static SLst schema"
_ITEM_EVIDENCE = "iTunes 12.13.10.3 RVA 1070770/107ee90; mtph schema"
_RECORD_EVIDENCE = "observed 3500-byte miph/84-byte mtph profile"


class PlaylistLimitError(ValueError):
    """Global input/model/export budget: no partial success is returned."""


@dataclass(frozen=True, slots=True)
class Diagnostic:
    code: str
    offset: int
    level: str
    detail: str


@dataclass(frozen=True, slots=True)
class RawSpan:
    offset: int
    size: int
    _buffer: bytes = field(repr=False)

    def __post_init__(self):
        if (type(self._buffer) is not bytes or type(self.offset) is not int or
                type(self.size) is not int or self.offset < 0 or self.size < 0 or
                self.offset + self.size > len(self._buffer)):
            raise ValueError("invalid immutable raw span")

    def read(self) -> bytes:
        """Extract these exact bytes. No normalization/reconstruction/setter."""
        return self._buffer[self.offset:self.offset + self.size]


@dataclass(frozen=True, slots=True)
class WireField:
    name: str
    offset: int
    width: int
    endian: str
    value: int
    level: str
    evidence: str


@dataclass(frozen=True, slots=True)
class SmartRule:
    index: int
    raw: RawSpan
    header: RawSpan
    payload: RawSpan
    padding: RawSpan
    field_code: int
    action_bits: int
    nested_flag: int
    disabled_flag: int
    tree: SmartTree | None
    diagnostics: tuple[Diagnostic, ...]


@dataclass(frozen=True, slots=True)
class SmartTree:
    raw: RawSpan
    header: RawSpan
    version: int | None
    secondary_version: int | None
    declared_count: int | None
    root_flag_bytes: tuple[int, ...]
    rules: tuple[SmartRule, ...]
    unparsed: RawSpan
    diagnostics: tuple[Diagnostic, ...]
    wire_complete: bool
    semantic_level: str = "uninterpreted"
    native_level: str = "not-qualified"


@dataclass(frozen=True, slots=True)
class MetadataOccurrence:
    child_index: int
    occurrence_index: int
    raw: RawSpan
    header: RawSpan
    payload: RawSpan
    type_code: int | None
    pool_slot_raw: int | None
    encoding: int | None
    text: str | None
    fields: tuple[WireField, ...]
    smart_tree: SmartTree | None
    diagnostics: tuple[Diagnostic, ...]


@dataclass(frozen=True, slots=True)
class EntryModel:
    child_index: int
    raw: RawSpan
    header: RawSpan
    fields: tuple[WireField, ...]
    metadata: tuple[MetadataOccurrence, ...]
    physical_children: tuple[EntryModel, ...]
    opaque_children: tuple[RawSpan, ...]
    diagnostics: tuple[Diagnostic, ...]

    def value(self, name: str) -> int | None:
        return next((f.value for f in self.fields if f.name == name), None)


@dataclass(frozen=True, slots=True)
class ParentEdge:
    child_index: int
    child_local_id: int | None
    parent_local_id: int | None
    parent_index: int | None
    status: str
    namespace: str = "playlist-local-entry-id"
    level: str = "schema"


@dataclass(frozen=True, slots=True)
class PlaylistModel:
    section_index: int
    section_kind: int
    playlist_index: int
    raw: RawSpan
    header: RawSpan
    fields: tuple[WireField, ...]
    metadata: tuple[MetadataOccurrence, ...]
    entries: tuple[EntryModel, ...]
    opaque_children: tuple[RawSpan, ...]
    parent_edges: tuple[ParentEdge, ...]
    diagnostics: tuple[Diagnostic, ...]
    folder_parent_status: str = "undecoded-not-a-root-assertion"
    semantic_write_level: str = "none"
    native_level: str = "not-qualified"

    def value(self, name: str) -> int | None:
        return next((f.value for f in self.fields if f.name == name), None)


@dataclass(frozen=True, slots=True)
class SectionModel:
    index: int
    kind: int
    raw: RawSpan
    header: RawSpan
    list_header: RawSpan | None
    declared_count: int | None
    playlists: tuple[PlaylistModel, ...]
    diagnostics: tuple[Diagnostic, ...]


@dataclass(frozen=True, slots=True)
class PlaylistDocument:
    schema: str
    raw: RawSpan
    byteorder: str
    sections: tuple[SectionModel, ...]
    primary_track_ids: tuple[int, ...]
    track_reference_coverage: str
    diagnostics: tuple[Diagnostic, ...]
    node_count: int
    max_observed_depth: int
    decoded_text_bytes: int
    estimated_model_bytes: int
    input_sha256: str
    envelope_sha256: str | None = None
    semantic_write_level: str = "none"
    native_level: str = "not-qualified"

    @property
    def playlists(self) -> tuple[PlaylistModel, ...]:
        return tuple(p for s in self.sections for p in s.playlists)


def _limits(value):
    result = dict(_DEFAULTS)
    if value is not None:
        if isinstance(value, Mapping):
            if set(value) - set(result):
                raise ValueError("unknown read limit")
            result.update(value)
        else:
            # Structural ReadLimits protocol; no substitute shared schema class.
            try:
                result = {k: getattr(value, k) for k in result}
            except AttributeError as exc:
                raise TypeError("limits must be a mapping or ReadLimits protocol") from exc
    for k, v in result.items():
        if type(v) is not int or v < 1:
            raise ValueError(f"{k} must be a positive integer")
    if result["max_depth"] > 64:
        raise ValueError("playlist recursion ceiling is 64")
    return result


class _Budget:
    def __init__(self, limits, raw_size):
        self.limits, self.nodes, self.text = limits, 0, 0
        self.depth = 0
        # Conservative accounting, not a promise about process-wide RSS.
        self.estimated = 4 * raw_size
        self.reserve(0)

    def reserve(self, size):
        self.estimated += size
        if self.estimated > self.limits["memory_budget_bytes"]:
            raise PlaylistLimitError("estimated model memory budget")

    def node(self, depth):
        if depth > self.limits["max_depth"]:
            raise PlaylistLimitError("record depth budget")
        self.depth = max(self.depth, depth)
        self.nodes += 1
        if self.nodes > self.limits["max_nodes"]:
            raise PlaylistLimitError("record node budget")
        self.reserve(2048)

    def text_bytes(self, size):
        self.text += size
        if self.text > self.limits["max_text_bytes"]:
            raise PlaylistLimitError("aggregate text byte budget")
        self.reserve(4 * size)


def _input(data, limit, memory_budget, *, memory_factor=4):
    if not isinstance(data, (bytes, bytearray, memoryview)):
        raise TypeError("expected bytes, bytearray or memoryview")
    size = data.nbytes if isinstance(data, memoryview) else len(data)
    if size > limit:
        raise PlaylistLimitError("input byte budget")
    if memory_factor * size > memory_budget:
        raise PlaylistLimitError("estimated input memory budget")
    return bytes(data)


def _span(data, lo, hi):
    return RawSpan(lo, hi - lo, data)


def _u(data, pos, width=4, endian="little"):
    return int.from_bytes(data[pos:pos + width], endian)


def _diag(code, offset, detail, level="wire"):
    return Diagnostic(code, offset, level, detail)


def _frame(data, pos, end, *, count_root=False):
    if end - pos < 12:
        raise ValueError("truncated record header")
    hlen, total = _u(data, pos + 4), _u(data, pos + 8)
    if hlen < 12 or hlen > end - pos:
        raise ValueError("invalid header extent")
    if count_root:
        return data[pos:pos + 4], pos + hlen, end, total
    if total < hlen or total > end - pos:
        raise ValueError("invalid record extent")
    return data[pos:pos + 4], pos + hlen, pos + total, None


def _slots(data, start, header_end, spec, expected_size, evidence):
    level = "schema" if header_end - start == expected_size else "wire"
    return tuple(WireField(name, start + off, width, endian,
                           _u(data, start + off, width, endian), level, evidence)
                 for name, off, width, endian in spec if start + off + width <= header_end)


def _smart(data, start, end, budget, depth):
    budget.node(depth)
    h_end = min(end, start + 136)
    diags, rules = [], []
    version = secondary = count = None
    flags = ()
    pos = h_end
    if end - start < 136 or data[start:start + 4] != b"SLst":
        diags.append(_diag("smart_header", start, "expected complete 136-byte SLst header"))
        pos = start
    else:
        version, secondary = _u(data, start + 4, 2, "big"), _u(data, start + 6, 2, "big")
        count, flags = _u(data, start + 8, 4, "big"), tuple(data[start + 14:start + 16])
        if version not in (0, 1):
            diags.append(_diag("smart_version", start + 4, "unsupported tree version; body retained", "schema"))
        else:
            for i in range(count):
                if end - pos < 56:
                    diags.append(_diag("smart_rule_header", pos, "declared rule header is truncated"))
                    break
                budget.node(depth + 1)
                size = _u(data, pos + 52, 4, "big")
                body_end, rule_end = pos + 56 + size, pos + 56 + size + (size & 1)
                if rule_end > end:
                    diags.append(_diag("smart_rule_extent", pos + 52, "payload or odd padding crosses tree boundary"))
                    break
                field_code, action = _u(data, pos, 4, "big"), _u(data, pos + 4, 4, "big")
                nested, disabled = data[pos + 8], data[pos + 9]
                local, tree = [], None
                if nested:
                    if not action & 1:
                        local.append(_diag("nested_action_bit", pos + 4, "native reader requires action bit0", "schema"))
                    tree = _smart(data, pos + 56, body_end, budget, depth + 2)
                else:
                    local.append(_diag("opaque_rule_leaf", pos + 56,
                                       "field/action retained; no string guessing or predicate evaluation", "semantic"))
                rules.append(SmartRule(i, _span(data, pos, rule_end), _span(data, pos, pos + 56),
                                       _span(data, pos + 56, body_end), _span(data, body_end, rule_end),
                                       field_code, action, nested, disabled, tree, tuple(local)))
                pos = rule_end
            if pos != end and len(rules) == count:
                diags.append(_diag("smart_trailing_bytes", pos, "unclaimed tree tail retained"))
    complete = (count is not None and version in (0, 1) and len(rules) == count and
                pos == end and all(r.tree is None or r.tree.wire_complete for r in rules))
    return SmartTree(_span(data, start, end), _span(data, start, h_end), version, secondary,
                     count, flags, tuple(rules), _span(data, pos, end), tuple(diags), complete)


def parse_smart_rules(payload, *, limits=None) -> SmartTree:
    """Read one mhoh101 body, always BE; opaque leaves are never evaluated."""
    lim = _limits(limits)
    data = _input(payload, lim["max_plain_bytes"], lim["memory_budget_bytes"])
    return _smart(data, 0, len(data), _Budget(lim, len(data)), 0)


def _metadata(data, pos, h_end, end, child_i, occurrence, budget, depth):
    budget.node(depth)
    t = _u(data, pos + 12) if h_end - pos >= 16 else None
    slot = _u(data, pos + 16) if h_end - pos >= 20 else None
    encoding = text = tree = None
    values, diags = (), []
    if h_end - pos != 24:
        diags.append(_diag("metadata_header_profile", pos + 4, "non-24-byte mhoh header retained", "schema"))
    if t in (100, 200, 201):
        if end - h_end < 16:
            diags.append(_diag("text_header", h_end, "incomplete text header"))
        else:
            encoding, size = _u(data, h_end), _u(data, h_end + 4)
            if size > end - h_end - 16:
                diags.append(_diag("text_extent", h_end + 4, "declared text bytes cross metadata boundary"))
            elif encoding not in (1, 3):
                diags.append(_diag("unknown_text_encoding", h_end, "no ACP/UTF8/ASCII fallback", "schema"))
            else:
                budget.text_bytes(size)
                try:
                    text = data[h_end + 16:h_end + 16 + size].decode("utf-16-le" if encoding == 1 else "latin1")
                except UnicodeDecodeError:
                    diags.append(_diag("invalid_text", h_end + 16, "strict decoding failed; bytes retained"))
    elif t == 101:
        tree = _smart(data, h_end, end, budget, depth + 1)
    elif t == 102:
        if end - h_end != 112:
            diags.append(_diag("smart_preferences_shape", h_end, "expected 112-byte body; raw slots only", "schema"))
        spec = [(f"byte_{n:02x}", n, 1, "big") for n in (0, 1, 2, 3, 12, 13, 14, 15, 20, 21)]
        spec += [(f"u32_{n:02x}", n, 4, "big") for n in (4, 8, 16)]
        values = _slots(data, h_end, end, spec, 112, "iTunes 12.13.10.3 RVA 10710d0; meanings unassigned")
    else:
        diags.append(_diag("opaque_metadata", h_end, "no payload semantic decoder", "semantic"))
    return MetadataOccurrence(child_i, occurrence, _span(data, pos, end), _span(data, pos, h_end),
                              _span(data, h_end, end), t, slot, encoding, text, values, tree, tuple(diags))


def _children(data, start, end, budget, depth):
    metadata, entries, opaque, diags, seen = [], [], [], [], Counter()
    pos, index = start, 0
    while pos < end:
        try:
            tag, h_end, stop, _ = _frame(data, pos, end)
        except ValueError as exc:
            budget.node(depth)
            opaque.append(_span(data, pos, end))
            diags.append(_diag("child_framing", pos, str(exc)))
            break
        if tag == b"mhoh":
            t = _u(data, pos + 12) if h_end - pos >= 16 else None
            metadata.append(_metadata(data, pos, h_end, stop, index, seen[t], budget, depth))
            seen[t] += 1
        elif tag == b"mtph":
            entries.append(_entry(data, pos, h_end, stop, index, budget, depth))
        else:
            budget.node(depth)
            opaque.append(_span(data, pos, stop))
            diags.append(_diag("opaque_child", pos, "unknown child tag retained without scanning"))
        pos, index = stop, index + 1
    return tuple(metadata), tuple(entries), tuple(opaque), diags


_ENTRY_SLOTS = [("local_id", 0x10, 4, "little"), ("parent_entry_id", 0x14, 4, "little"),
                ("track_id", 0x18, 4, "little"), ("group_flag", 0x1c, 1, "little"),
                ("order_token", 0x20, 4, "little"), ("persistent_id", 0x44, 8, "little")]
_PLAYLIST_SLOTS = [("master_flags_raw", 0x14, 4, "little"), ("flags_18_raw", 0x18, 4, "little"),
                   ("flags_1b4_raw", 0x1b4, 4, "little"), ("persistent_id", 0x1b8, 8, "little"),
                   ("special_kind", 0x238, 4, "little"), ("local_id", 0xd40, 4, "little")]


def _entry(data, pos, h_end, end, index, budget, depth):
    budget.node(depth)
    values = _slots(data, pos, h_end, _ENTRY_SLOTS, 84, _ITEM_EVIDENCE)
    meta, children, opaque, diags = _children(data, h_end, end, budget, depth + 1)
    if h_end - pos != 84:
        diags.append(_diag("entry_header_profile", pos + 4, "non-84 header: available offsets are wire observations", "schema"))
    if h_end - pos < 16 or _u(data, pos + 12) != len(meta) + len(children) + len(opaque):
        diags.append(_diag("entry_count", pos + 12, "declared child count differs from observed records"))
    if children:
        diags.append(_diag("physical_nested_mtph", pos, "not the flat native parent-entry graph", "schema"))
    return EntryModel(index, _span(data, pos, end), _span(data, pos, h_end), values, meta,
                      children, opaque, tuple(diags))


def _graph(entries, primary_tracks, check_tracks):
    diags, indexes = [], {}
    for i, entry in enumerate(entries):
        indexes.setdefault(entry.value("local_id"), []).append(i)
    parents, edges = [], []
    pids = Counter(entry.value("persistent_id") for entry in entries)
    for i, entry in enumerate(entries):
        own, parent, group = entry.value("local_id"), entry.value("parent_entry_id"), entry.value("group_flag")
        target, status = None, "root-sentinel" if parent == 0 else "unresolved"
        if own is None or own == 0 or len(indexes.get(own, ())) != 1:
            diags.append(_diag("entry_identity", entry.raw.offset, "missing/zero/duplicate local entry ID", "schema"))
        pid = entry.value("persistent_id")
        if pid is None or pid == 0 or pids[pid] != 1:
            diags.append(_diag("entry_persistent_identity", entry.raw.offset, "missing/zero/duplicate item PID", "schema"))
        if group not in (0, 1):
            diags.append(_diag("group_flag", entry.raw.offset, "unknown group flag; not coerced to boolean", "schema"))
        if parent not in (None, 0):
            candidates = indexes.get(parent, ())
            if len(candidates) == 1:
                target, status = candidates[0], "resolved"
                if entries[target].value("group_flag") != 1:
                    diags.append(_diag("parent_not_group", entry.raw.offset, "resolved parent is not a known group", "schema"))
                if target >= i:
                    diags.append(_diag("parent_not_before_child", entry.raw.offset, "not the observed parent-before-descendant sequence", "schema"))
            else:
                status = "missing" if not candidates else "ambiguous"
                diags.append(_diag("parent_" + status, entry.raw.offset, "parent-entry ID has no unique target", "schema"))
        if check_tracks:
            track = entry.value("track_id")
            if track not in primary_tracks and not (group == 1 and track == 0):
                diags.append(_diag("track_reference", entry.raw.offset, "missing primary track or undecoded reference", "schema"))
        parents.append(target)
        level = "schema" if entry.header.size == 84 and (target is None or entries[target].header.size == 84) else "wire"
        edges.append(ParentEdge(i, own, parent, target, status, level=level))
    # Linear iterative cycle detection, not recursive traversal of untrusted IDs.
    color = [0] * len(entries)
    for i in range(len(entries)):
        path, j = [], i
        while j is not None and color[j] == 0:
            color[j] = 1
            path.append(j)
            j = parents[j]
        if j is not None and color[j] == 1:
            diags.append(_diag("parent_cycle", entries[j].raw.offset, "cycle in entry parent graph", "schema"))
        for j in path:
            color[j] = 2
    return tuple(edges), diags


def _playlist(data, pos, h_end, end, sec_i, kind, index, budget, tracks, check_tracks):
    budget.node(2)
    values = _slots(data, pos, h_end, _PLAYLIST_SLOTS, 3500, _RECORD_EVIDENCE)
    meta, entries, opaque, diags = _children(data, h_end, end, budget, 3)
    if h_end - pos != 3500:
        diags.append(_diag("playlist_header_profile", pos + 4, "non-3500 header; offsets are wire observations", "schema"))
    if h_end - pos < 20 or _u(data, pos + 12) != len(meta) or _u(data, pos + 16) != len(entries):
        diags.append(_diag("playlist_count", pos + 12, "metadata/item counts differ from parsed immediate children"))
    if sum(m.type_code == 100 for m in meta) != 1:
        diags.append(_diag("title_occurrences", pos, "no single title chosen; all occurrences retained", "schema"))
    graph, graph_diags = _graph(entries, tracks, check_tracks and kind == 2)
    diags.extend(graph_diags)
    diags.append(_diag("folder_parent_undecoded", pos, "entry parents do not identify playlist-folder parents", "semantic"))
    return PlaylistModel(sec_i, kind, index, _span(data, pos, end), _span(data, pos, h_end),
                         values, meta, entries, opaque, graph, tuple(diags))


def inspect_playlist_payload(payload, *, byteorder="little", limits=None) -> PlaylistDocument:
    """Inspect section bytes without Library semantic admission or any writes.

    Malformed local extents stop only their enclosing region (no tag resync).
    Other bounded sections/playlists remain available; resource exhaustion raises.
    """
    lim = _limits(limits)
    data = _input(payload, lim["max_plain_bytes"], lim["memory_budget_bytes"])
    budget, diagnostics = _Budget(lim, len(data)), []
    digest = hashlib.sha256(data).hexdigest()
    if byteorder not in ("little", "big"):
        raise ValueError("byteorder must be little or big")
    specs, tracks, primary_lists, primary_complete = [], [], 0, True
    pos = 0
    if byteorder != "little":
        diagnostics.append(_diag("inner_endian", 0, "BE section profile not decoded; complete raw payload retained", "schema"))
    else:
        while pos < len(data):
            budget.node(0)
            try:
                tag, h_end, end, _ = _frame(data, pos, len(data))
                if tag != b"msdh" or h_end - pos < 16:
                    raise ValueError("expected msdh with type field")
            except ValueError as exc:
                diagnostics.append(_diag("section_framing", pos, str(exc)))
                primary_complete = False
                break
            kind = _u(data, pos + 12)
            specs.append((pos, h_end, end, kind))
            if kind == 1:
                primary_lists += 1
                try:
                    budget.node(1)
                    tag, rh, _, count = _frame(data, h_end, end, count_root=True)
                    if tag != b"mlth":
                        raise ValueError("expected primary mlth")
                    cur, found = rh, 0
                    while cur < end:
                        budget.node(2)
                        tag, th, stop, _ = _frame(data, cur, end)
                        if tag != b"mith" or th - cur != 756:
                            raise ValueError("unknown primary track header profile")
                        tracks.append(_u(data, cur + 0x10))
                        found, cur = found + 1, stop
                    if found != count:
                        raise ValueError("primary track list count mismatch")
                except ValueError as exc:
                    if isinstance(exc, PlaylistLimitError):
                        raise
                    diagnostics.append(_diag("primary_track_coverage", h_end, str(exc), "schema"))
                    primary_complete = False
            pos = end
    check_tracks = primary_complete and primary_lists == 1 and len(tracks) == len(set(tracks)) and 0 not in tracks
    track_set, sections = set(tracks), []
    for sec_i, (start, h_end, end, kind) in enumerate(specs):
        playlists, local, root_span, count = [], [], None, None
        if kind in (2, 14):
            try:
                budget.node(1)
                tag, rh, _, count = _frame(data, h_end, end, count_root=True)
                if tag != b"mlph":
                    raise ValueError("expected mlph list root")
                root_span, cur, records = _span(data, h_end, rh), rh, 0
                while cur < end:
                    tag, ph, stop, _ = _frame(data, cur, end)
                    if tag == b"miph":
                        playlists.append(_playlist(data, cur, ph, stop, sec_i, kind, records, budget, track_set, check_tracks))
                    else:
                        budget.node(2)
                        local.append(_diag("opaque_playlist_record", cur, "unrecognized list member retained"))
                    records, cur = records + 1, stop
                if records != count:
                    local.append(_diag("playlist_list_count", h_end + 8, "list count differs from observed record count"))
            except ValueError as exc:
                if isinstance(exc, PlaylistLimitError):
                    raise
                local.append(_diag("playlist_list_framing", h_end, str(exc)))
        sections.append(SectionModel(sec_i, kind, _span(data, start, end), _span(data, start, h_end),
                                     root_span, count, tuple(playlists), tuple(local)))
    return PlaylistDocument("itlkit.playlist-models.v2", _span(data, 0, len(data)), byteorder,
                            tuple(sections), tuple(tracks), "primary-header-ids" if check_tracks else "incomplete",
                            tuple(diagnostics), budget.nodes, budget.depth, budget.text, budget.estimated, digest)


def inspect_playlists(data, *, limits=None) -> PlaylistDocument:
    """Inspect immutable hdfm bytes; never calls Library/to_bytes/rebuild/write."""
    from dataclasses import replace
    from .container import Container
    from .errors import FormatError
    lim = _limits(limits)
    # Reserve wire/copy/AES-body buffers BEFORE copying or invoking the decoder.
    # This conservative byte estimate is not a process-wide RSS guarantee.
    raw = _input(data, lim["max_file_bytes"], lim["memory_budget_bytes"], memory_factor=6)
    remaining = lim["memory_budget_bytes"] - 6 * len(raw)
    # Container detects an overrun with cap+1; account for that sentinel too.
    plain_cap = min(lim["max_plain_bytes"], remaining // 4 - 1)
    if plain_cap < 1:
        raise PlaylistLimitError("estimated container memory budget")
    try:
        container = Container.from_bytes(raw, max_plain_bytes=plain_cap)
    except FormatError as exc:
        # Container has no dedicated size-limit subtype. Translate only its
        # two exact size-error prefixes, and only when memory reduced the cap.
        # Invalid headers/flags/zlib and an explicit plain-byte cap keep their
        # original exception, rather than being hidden as memory exhaustion.
        size_errors = (f"decompressed payload exceeds {plain_cap} bytes",
                       f"uncompressed payload exceeds {plain_cap} bytes")
        if plain_cap < lim["max_plain_bytes"] and str(exc).startswith(size_errors):
            raise PlaylistLimitError("estimated container memory budget") from exc
        raise
    # Wire buffers coexist with the payload/model; do not reuse their budget
    # for nodes/text. Other caps and the standalone payload API are unchanged.
    payload_limits = dict(lim, memory_budget_bytes=remaining)
    result = inspect_playlist_payload(container.payload, byteorder=container.payload_byteorder,
                                      limits=payload_limits)
    return replace(result, envelope_sha256=hashlib.sha256(raw).hexdigest())


def models_json(model, *, limits=None, include_raw=False) -> str:
    """Bounded diagnostic JSON, never library.v1 or an executable write plan.

    Spans are offsets into one optional root payload_hex, not repeated raw copies.
    Limits bound UTF8 output and a conservative export-memory estimate.
    """
    lim = _limits(limits)
    if not isinstance(model, (PlaylistDocument, SmartTree)) or type(include_raw) is not bool:
        raise TypeError("expected a playlist document or smart tree and boolean include_raw")
    raw = model.raw
    if raw.size > lim["max_plain_bytes"]:
        raise PlaylistLimitError("export input byte budget")
    estimated = 4 * raw.size
    if isinstance(model, PlaylistDocument):
        if (model.node_count > lim["max_nodes"] or
                model.decoded_text_bytes > lim["max_text_bytes"] or
                model.max_observed_depth > lim["max_depth"]):
            raise PlaylistLimitError("export model budget")
        estimated = model.estimated_model_bytes
    else:
        todo, checked = [(model, 0)], 0
        while todo:
            item, depth = todo.pop()
            checked += 1
            if checked > lim["max_nodes"] or depth > lim["max_depth"]:
                raise PlaylistLimitError("export smart-tree node/depth budget")
            if isinstance(item, SmartTree):
                if checked + len(todo) + len(item.rules) > lim["max_nodes"]:
                    raise PlaylistLimitError("export smart-tree node budget")
                todo.extend((rule, depth + 1) for rule in reversed(item.rules))
            elif item.tree is not None:
                todo.append((item.tree, depth + 1))
        estimated += checked * 2048
    if estimated > lim["memory_budget_bytes"]:
        raise PlaylistLimitError("estimated export memory budget")
    if include_raw and 2 * raw.size > lim["max_json_bytes"]:
        raise PlaylistLimitError("JSON byte budget")

    def default(value):
        if isinstance(value, RawSpan):
            return {"offset": value.offset, "size": value.size}
        if is_dataclass(value):
            return {f.name: getattr(value, f.name) for f in fields(value) if not f.name.startswith("_")}
        raise TypeError("not a model value")

    document = {"model": model}
    if include_raw:
        if estimated + 6 * raw.size > lim["memory_budget_bytes"]:
            raise PlaylistLimitError("estimated export memory budget")
        document["payload_hex"] = raw.read().hex()
        document["payload_base_offset"] = raw.offset
    encoder, output, count = json.JSONEncoder(default=default, ensure_ascii=True, separators=(",", ":")), io.StringIO(), 0
    for chunk in encoder.iterencode(document):
        count += len(chunk)  # ASCII JSON, including all string escapes.
        if count > lim["max_json_bytes"]:
            raise PlaylistLimitError("JSON byte budget")
        if estimated + 8 * count > lim["memory_budget_bytes"]:
            raise PlaylistLimitError("estimated export memory budget")
        output.write(chunk)
    return output.getvalue()
