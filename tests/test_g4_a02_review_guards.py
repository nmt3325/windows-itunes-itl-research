"""G4-B a02 review guards: auxiliary qualification and the shared export preflight.

The legacy_* helpers below are pre-fix behaviour re-derived inside this file as
red controls. They are reconstructions, not historical artifacts, and no
publication script is imported or executed. Synthetic fixtures are structural
controls only, never evidence of native iTunes acceptance.
"""
from __future__ import annotations

from dataclasses import fields, is_dataclass
import io
import json
import struct
from types import SimpleNamespace

import pytest

from itlkit import FormatError, Library, Node, UnsupportedError
from itlkit.admission import require_complete_master
from itlkit.binary import put, uint
from itlkit.playlist_models import (
    PlaylistDocument, PlaylistLimitError, RawSpan, SmartTree, _limits,
    inspect_playlist_payload, models_json, parse_smart_rules,
)
from itlkit.schema import LimitError, ReadLimits
from test_core_support import library_bytes
from test_core_support import playlist as core_playlist
from test_core_support import record as core_record
from test_core_support import track as core_track

# ---------------------------------------------------------------------------
# Fix 1: qualify auxiliary album/artist records before reading any identity
# ---------------------------------------------------------------------------

# (section kind, qualified record tag, qualified header size, track reference offset)
AUXILIARY = ((9, b"miah", 88, 0xdc), (11, b"miih", 100, 0x1e0))
AUXILIARY_IDS = ("album", "artist")
FIRST_PID = 0xAABB000000000007
SECOND_PID = 0xAABB000000000008
BYPASS_CASES = ("unknown_width_zero_persistent_id", "unknown_width_duplicate_persistent_id",
                "unknown_record_tag", "absent_children", "unqualified_kind")


def admitted_library():
    """The GATE01 happy path: one master playlist covering every track."""
    return Library.from_bytes(library_bytes(tracks=[core_track(1)],
                                            playlists=[core_playlist([1], master=True)]))


def auxiliary_node(tag, size, local, persistent, *, kind="total", children=()):
    node = Node(bytearray(core_record(tag, size, count=0, fields=((16, local),))),
                kind, None if children is None else list(children))
    put(node.header, 20, persistent, 8)
    return node


def with_auxiliary(kind, nodes, reference=None, offset=None):
    lib = admitted_library()
    root = lib._root(kind)
    assert root is not None and root.children == []
    root.children = list(nodes)
    if reference is not None:
        put(lib._root(1).children[0].header, offset, reference)
    return lib


def bypass_nodes(case, record_tag, size):
    unqualified = {
        "unknown_width_zero_persistent_id": lambda: auxiliary_node(record_tag, size + 4, 8, 0),
        "unknown_width_duplicate_persistent_id": lambda: auxiliary_node(record_tag, size + 4, 8, FIRST_PID),
        "unknown_record_tag": lambda: auxiliary_node(b"zzzz", size, 8, 0),
        "absent_children": lambda: auxiliary_node(record_tag, size, 8, SECOND_PID, children=None),
        "unqualified_kind": lambda: auxiliary_node(record_tag, size, 8, SECOND_PID, kind="count"),
    }[case]()
    return [auxiliary_node(record_tag, size, 7, FIRST_PID), unqualified]


def legacy_auxiliary_identity(lib, kind, record_tag, header_size):
    """Re-derived pre-fix auxiliary pass; a red control, not a restored artifact.

    Records were filtered by tag alone, and persistent IDs were validated only
    for the two known header widths, so any other shape still contributed a
    local ID while its persistent ID went unchecked.
    """
    root = lib._root(kind)
    records = [] if root is None else [n for n in root.children if n.tag == record_tag]
    local, persistent = set(), set()
    for node in records:
        value = uint(node.header, 16)
        if not value or value in local:
            raise FormatError("GATE01: zero or duplicate album/artist local ID")
        local.add(value)
    for node in records:
        if len(node.header) != header_size:
            continue
        value = uint(node.header, 20, 8)
        if not value or value in persistent:
            raise FormatError("GATE01: zero or duplicate album/artist persistent ID")
        persistent.add(value)
    return local


@pytest.mark.parametrize("kind,record_tag,size,offset", AUXILIARY, ids=AUXILIARY_IDS)
def test_qualified_auxiliary_admission_baseline_is_unchanged(kind, record_tag, size, offset):
    require_complete_master(admitted_library())
    lib = with_auxiliary(kind, [auxiliary_node(record_tag, size, 7, FIRST_PID)], 7, offset)
    assert legacy_auxiliary_identity(lib, kind, record_tag, size) == {7}
    require_complete_master(lib)


@pytest.mark.parametrize("case", BYPASS_CASES)
@pytest.mark.parametrize("kind,record_tag,size,offset", AUXILIARY, ids=AUXILIARY_IDS)
def test_unqualified_auxiliary_headers_no_longer_bypass_identity(case, kind, record_tag, size, offset):
    lib = with_auxiliary(kind, bypass_nodes(case, record_tag, size), 7, offset)
    # Red control: the re-derived pre-fix pass admitted this shape.
    assert legacy_auxiliary_identity(lib, kind, record_tag, size)
    # Green: qualification now precedes every identity read.
    with pytest.raises(UnsupportedError, match="unqualified direct auxiliary"):
        require_complete_master(lib)


@pytest.mark.parametrize("flaw,persistent", (("zero", 0), ("duplicate", FIRST_PID)))
@pytest.mark.parametrize("kind,record_tag,size,offset", AUXILIARY, ids=AUXILIARY_IDS)
def test_qualified_persistent_identity_refusals_are_retained(kind, record_tag, size, offset, flaw, persistent):
    nodes = [auxiliary_node(record_tag, size, 7, FIRST_PID),
             auxiliary_node(record_tag, size, 8, persistent)]
    lib = with_auxiliary(kind, nodes, 7, offset)
    with pytest.raises(FormatError):
        legacy_auxiliary_identity(lib, kind, record_tag, size)
    with pytest.raises(FormatError):
        require_complete_master(lib)


def node_fingerprint(node):
    children = None if node.children is None else [node_fingerprint(c) for c in node.children]
    return (bytes(node.header), bytes(node.payload), node.kind, children)


def library_fingerprint(lib):
    """In-memory node bytes only: no serializer, no writer, no file is touched."""
    return [node_fingerprint(s) for s in lib.sections]


@pytest.mark.parametrize("kind,record_tag,size,offset", AUXILIARY, ids=AUXILIARY_IDS)
def test_reference_closure_and_read_only_purity_are_preserved(kind, record_tag, size, offset):
    lib = with_auxiliary(kind, [auxiliary_node(record_tag, size, 7, FIRST_PID)], 7, offset)
    accepted = library_fingerprint(lib)
    require_complete_master(lib)
    assert library_fingerprint(lib) == accepted
    # Closure is still checked for qualified records: 9 resolves to nothing.
    put(lib._root(1).children[0].header, offset, 9)
    refused = library_fingerprint(lib)
    with pytest.raises(FormatError):
        require_complete_master(lib)
    # An opt-in predicate: refusing never rewrites, repairs or permits a write.
    assert library_fingerprint(lib) == refused


# ---------------------------------------------------------------------------
# Fix 2: one shared schema.encode_json preflight for the diagnostic export
# ---------------------------------------------------------------------------


def number(data, offset, value, size=4, endian="little"):
    data[offset:offset + size] = value.to_bytes(size, endian)


def record(tag, size, body=b"", slots=()):
    h = bytearray(size)
    h[:4] = tag
    number(h, 4, size)
    number(h, 8, size + len(body))
    for off, value, width in slots:
        number(h, off, value, width)
    return bytes(h) + body


def metadata(t, body=b"", slot=0):
    return record(b"mhoh", 24, body, [(12, t, 4), (16, slot, 4)])


def title(value="Title", encoding=1, t=100):
    raw = value.encode("utf-16-le")
    return metadata(t, struct.pack("<II", encoding, len(raw)) + b"\0" * 8 + raw)


def item(local=11, parent=0, track=1, group=0, token=99, pid=None, children=()):
    return record(b"mtph", 84, b"".join(children), [(12, len(children), 4), (16, local, 4),
                  (20, parent, 4), (24, track, 4), (28, group, 1), (32, token, 4),
                  (68, 100000 + local if pid is None else pid, 8)])


def playlist(metas=None, items=(), pid=7):
    metas = [title(), metadata(105, b"view-a"), metadata(105, b"view-b")] if metas is None else metas
    return record(b"miph", 3500, b"".join(metas) + b"".join(items),
                  [(12, len(metas), 4), (16, len(items), 4), (0x1b8, pid, 8), (0xd40, 71, 4)])


def section(kind, records, tag=b"mlph"):
    root = record(tag, 16, b"".join(records), [(8, len(records), 4)])
    return record(b"msdh", 96, root, [(12, kind, 4)])


def payload(playlists):
    tracks = [record(b"mith", 756, slots=[(16, x, 4)]) for x in (1, 2)]
    return section(1, tracks, b"mlth") + section(2, playlists)


def smart_rule(body=b"abc", field=0xfffffff0, action=0xabcdef02, nested=0, disabled=0, padding=b"\xe7"):
    h = bytearray(56)
    struct.pack_into(">II", h, 0, field, action)
    h[8], h[9] = nested, disabled
    struct.pack_into(">I", h, 52, len(body))
    return bytes(h) + body + (padding if len(body) & 1 else b"")


def smart(rules=(), version=1, secondary=1):
    h = bytearray(136)
    h[:4] = b"SLst"
    struct.pack_into(">HHI", h, 4, version, secondary, len(rules))
    h[14:16] = b"\x02\x07"
    h[30:34] = b"KEEP"
    return bytes(h) + b"".join(rules)


def exported_document():
    """Duplicate 105 occurrences plus one smart tree, so order survives sorting."""
    metas = [title(), metadata(105, b"view-a"), metadata(105, b"view-b"),
             metadata(101, smart([smart_rule()]))]
    data = payload([playlist(metas=metas, items=[item()])])
    return data, inspect_playlist_payload(data)


def key_orders(text):
    """Every JSON object's key order, in document order."""
    orders = []

    def hook(pairs):
        orders.append([key for key, _ in pairs])
        return dict(pairs)

    json.loads(text, object_pairs_hook=hook)
    return orders


def legacy_models_json(model, *, limits=None, include_raw=False):
    """Re-derived pre-fix exporter; a red control, not a restored artifact.

    Budgets were charged per encoded chunk after the fact, so JSON keys and the
    payload_hex expansion never reached the text budget at all.
    """
    lim = _limits(limits)
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
            node, depth = todo.pop()
            checked += 1
            if checked > lim["max_nodes"] or depth > lim["max_depth"]:
                raise PlaylistLimitError("export smart-tree node/depth budget")
            if isinstance(node, SmartTree):
                todo.extend((rule, depth + 1) for rule in reversed(node.rules))
            elif node.tree is not None:
                todo.append((node.tree, depth + 1))
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
        document["payload_hex"] = raw.read().hex()
        document["payload_base_offset"] = raw.offset
    encoder = json.JSONEncoder(default=default, ensure_ascii=True, separators=(",", ":"))
    output, count = io.StringIO(), 0
    for chunk in encoder.iterencode(document):
        count += len(chunk)
        if count > lim["max_json_bytes"]:
            raise PlaylistLimitError("JSON byte budget")
        if estimated + 8 * count > lim["memory_budget_bytes"]:
            raise PlaylistLimitError("estimated export memory budget")
        output.write(chunk)
    return output.getvalue()


def test_shared_preflight_sorts_keys_and_keeps_the_public_span_facts():
    data, document = exported_document()
    encoded = models_json(document, include_raw=True)
    assert type(encoded) is str
    value = json.loads(encoded)
    assert bytes.fromhex(value["payload_hex"]) == data and value["payload_base_offset"] == 0
    assert encoded.count("payload_hex") == 1 and "_buffer" not in encoded
    assert value["model"]["raw"] == {"offset": 0, "size": len(data)}
    rows = [row for s in value["model"]["sections"] for row in s["playlists"]]
    occurrences = rows[0]["metadata"]
    assert [m["type_code"] for m in occurrences] == [100, 105, 105, 101]
    assert [m["occurrence_index"] for m in occurrences] == [0, 0, 1, 0]
    assert all(keys == sorted(keys) for keys in key_orders(encoded))
    # Red control: the pre-fix exporter emitted declaration order.
    legacy = legacy_models_json(document, include_raw=True)
    assert json.loads(legacy) == value and legacy != encoded
    assert any(keys != sorted(keys) for keys in key_orders(legacy))


def test_shared_text_budget_counts_json_keys_and_payload_hex():
    data, document = exported_document()
    budget = {"max_text_bytes": 4096}
    assert document.decoded_text_bytes < 4096 < 2 * len(data)
    # Red control: only the model's decoded text was weighed before.
    assert json.loads(legacy_models_json(document, include_raw=True, limits=budget))["payload_hex"]
    with pytest.raises(PlaylistLimitError) as refusal:
        models_json(document, include_raw=True, limits=budget)
    assert isinstance(refusal.value.__cause__, LimitError)
    assert models_json(document, include_raw=True, limits={"max_text_bytes": 4 * 1024**2}) == \
        models_json(document, include_raw=True)


def test_export_budget_refusals_keep_the_playlist_vocabulary():
    _data, document = exported_document()
    encoded = models_json(document, include_raw=True)
    assert models_json(document, include_raw=True, limits={"max_json_bytes": len(encoded)}) == encoded
    with pytest.raises(PlaylistLimitError) as refusal:
        models_json(document, include_raw=True, limits={"max_json_bytes": len(encoded) - 1})
    assert not isinstance(refusal.value, UnsupportedError)
    assert isinstance(refusal.value.__cause__, LimitError)
    # Red control: the pre-fix exporter only noticed while writing chunks.
    assert legacy_models_json(document, include_raw=True, limits={"max_json_bytes": len(encoded)})


def test_retained_model_memory_is_subtracted_before_the_output_cap():
    _data, document = exported_document()
    estimated = document.estimated_model_bytes
    for budget in (estimated - 1, estimated):
        with pytest.raises(PlaylistLimitError, match="estimated export memory budget"):
            models_json(document, limits={"memory_budget_bytes": budget})
    # A remainder of 8 bytes funds a one byte cap, not a full export.
    with pytest.raises(PlaylistLimitError):
        models_json(document, limits={"memory_budget_bytes": estimated + 8})
    assert json.loads(models_json(document))["model"]


@pytest.mark.parametrize("depth", (33, 48, 64))
def test_physical_depth_is_mapped_onto_the_shared_json_ceiling(depth):
    _data, document = exported_document()
    # Red control: the shared class refuses the unmapped physical depth.
    with pytest.raises(ValueError, match="max_depth"):
        ReadLimits(max_depth=depth)
    encoded = models_json(document, limits={"max_depth": depth})
    assert encoded == models_json(document, limits={"max_depth": 32})
    assert json.loads(encoded)["model"]["max_observed_depth"] == document.max_observed_depth
    with pytest.raises(ValueError):
        models_json(document, limits={"max_depth": 65})


def test_physically_deep_entries_still_export_through_the_shared_ceiling():
    nested = item(local=60)
    for index in range(30):
        nested = item(local=59 - index, children=[nested])
    data = payload([playlist(metas=[title()], items=[nested])])
    with pytest.raises(PlaylistLimitError):
        inspect_playlist_payload(data, limits={"max_depth": 32})
    document = inspect_playlist_payload(data, limits={"max_depth": 64})
    assert document.max_observed_depth > 32
    exported = json.loads(models_json(document, limits={"max_depth": 64}))
    assert exported["model"]["max_observed_depth"] == document.max_observed_depth
    with pytest.raises(PlaylistLimitError, match="export model budget"):
        models_json(document, limits={"max_depth": 32})


def test_smart_tree_export_keeps_its_own_budget_and_the_shared_preflight():
    tree = parse_smart_rules(smart([smart_rule()]))
    encoded = models_json(tree)
    assert json.loads(encoded)["model"]["wire_complete"] is True
    assert all(keys == sorted(keys) for keys in key_orders(encoded))
    with pytest.raises(PlaylistLimitError, match="smart-tree"):
        models_json(tree, limits={"max_nodes": 1})


def test_limits_keyword_api_and_return_type_are_preserved():
    _data, document = exported_document()
    assert models_json(document, limits=SimpleNamespace(**_limits(None))) == models_json(document)
    with pytest.raises(TypeError):
        models_json(document, True)
    with pytest.raises(TypeError):
        models_json(document, include_raw=1)
    with pytest.raises(TypeError):
        models_json({"model": "not a model"})
