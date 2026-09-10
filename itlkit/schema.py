"""Experimental immutable evidence records and bounded readers.

These records describe evidence; they are never caller-issued write permission.
No allocator, semantic setter, native oracle, or legacy behavior is replaced.
"""
from __future__ import annotations
from dataclasses import dataclass, fields, is_dataclass, field
from collections.abc import Mapping
from types import MappingProxyType
from pathlib import Path
import json
import hashlib
import re
import math
import os
from .errors import FormatError, UnsupportedError
from .binary import prefix, uint
from .container import Container
from .model import LIST_ROOTS, CONTAINERS


class LimitError(UnsupportedError):
    """A declared resource limit was exceeded (not an OS RSS guarantee)."""


@dataclass(frozen=True)
class ReadLimits:
    max_file_bytes: int = 16 * 1024 * 1024
    max_plain_bytes: int = 16 * 1024 * 1024
    max_nodes: int = 100000
    max_depth: int = 32
    max_text_bytes: int = 4 * 1024 * 1024
    max_json_bytes: int = 64 * 1024 * 1024
    memory_budget_bytes: int = 512 * 1024 * 1024

    def __post_init__(self):
        for f in fields(self):
            v = getattr(self, f.name)
            if type(v) is not int or v < 1:
                raise ValueError(f'{f.name} must be a positive integer')
        if self.max_depth > 32:
            raise ValueError('max_depth cannot exceed the current core depth 32')

    def check(self, kind: str, amount: int) -> None:
        names = {'file': 'max_file_bytes', 'plain': 'max_plain_bytes',
                 'nodes': 'max_nodes', 'depth': 'max_depth', 'text': 'max_text_bytes',
                 'json': 'max_json_bytes', 'memory': 'memory_budget_bytes'}
        if kind not in names or type(amount) is not int or amount < 0:
            raise ValueError('invalid budget dimension or amount')
        if amount > getattr(self, names[kind]):
            raise LimitError(f'{kind} budget exceeded: {amount} > {getattr(self, names[kind])}')


def get_limits(limits=None) -> ReadLimits:
    if limits is None:
        return ReadLimits()
    if type(limits) is not ReadLimits:
        raise TypeError('limits must be ReadLimits')
    return limits


def freeze(value):
    """Defensively freeze JSON-like descriptions, preserving typed records."""
    if isinstance(value, Record):
        if not is_dataclass(value) or not value.__dataclass_params__.frozen or any(not f.init for f in fields(value)):
            raise TypeError('only frozen constructor-validated evidence records are supported')
        # Reconstruct nested records too: a frozen dataclass can still contain a
        # caller-owned list or MappingProxyType backed by a mutable dictionary.
        # Do not replay constructors while recursively copying: their own freeze
        # pass would double-copy every history level. These records are evidence,
        # already constructed/validated; this is not a public deserializer.
        detached=object.__new__(type(value))
        for f in fields(value):object.__setattr__(detached,f.name,freeze(getattr(value,f.name)))
        return detached
    if isinstance(value, Mapping):
        if any(type(k) is not str for k in value):
            raise TypeError('record mapping keys must be strings')
        return MappingProxyType({k: freeze(v) for k, v in value.items()})
    if isinstance(value, (tuple, list)):
        return tuple(freeze(v) for v in value)
    if value is None or type(value) in (str, int, bool):
        return value
    if type(value) is float and math.isfinite(value):
        return value
    raise TypeError(f'unsupported record value: {type(value).__name__}')


def plain(value):
    """A detached report. There is deliberately no executable inverse."""
    if is_dataclass(value):
        return {f.name: plain(getattr(value, f.name)) for f in fields(value)
                if not f.name.startswith('_')}
    if isinstance(value, Mapping):
        return {k: plain(v) for k, v in value.items()}
    if isinstance(value, (tuple, list)):
        return [plain(v) for v in value]
    return value


class Record:
    def __post_init__(self):
        for f in fields(self):
            object.__setattr__(self, f.name, freeze(getattr(self, f.name)))

    def to_dict(self):
        return plain(self)


@dataclass(frozen=True)
class ByteSpan(Record):
    start: int
    end: int
    level: str = 'unknown'
    evidence_refs: tuple = ()

    def __post_init__(self):
        super().__post_init__()
        if type(self.start) is not int or type(self.end) is not int or not 0 <= self.start < self.end:
            raise ValueError('invalid half-open byte span')
        if not self.level:
            raise ValueError('span evidence level required')


@dataclass(frozen=True)
class FieldSpec(Record):
    record_tag: str
    section_kind: int | None
    profile: str
    header_size: int
    offset_or_payload_layout: object
    width: int
    endian: str
    signedness_or_mask: object
    namespace: str | None
    read_level: str
    write_level: str
    evidence_refs: tuple
    opaque_ranges: tuple = ()
    name: str = ''

    def __post_init__(self):
        super().__post_init__()
        if type(self.record_tag) is not str or len(self.record_tag) != 4:
            raise ValueError('record_tag must be four characters')
        if type(self.header_size) is not int or self.header_size < 0 or type(self.width) is not int or self.width < 0:
            raise ValueError('invalid field dimensions')
        if not self.read_level or not self.write_level or not self.evidence_refs:
            raise ValueError('field evidence and explicit read/write levels required')
        for span in self.opaque_ranges:
            if type(span) is not ByteSpan or span.end > self.header_size:
                raise ValueError('opaque header span outside header')


@dataclass(frozen=True)
class Blocker(Record):
    code: str
    message: str
    path: str = ''
    evidence_refs: tuple = ()


@dataclass(frozen=True)
class ProfileReport(Record):
    version: str = ''
    endian: str = ''
    record_shapes: tuple = ()
    invariants: tuple = ()
    capabilities: tuple = ()
    blockers: tuple = ()
    evidence_refs: tuple = ()

    @property
    def blocked(self):
        return bool(self.blockers)


@dataclass(frozen=True)
class ScopedID(Record):
    namespace: str
    scope: str
    value: int
    width: int

    def __post_init__(self):
        super().__post_init__()
        if not isinstance(self.namespace, str) or not self.namespace or not isinstance(self.scope, str) or not self.scope:
            raise ValueError('namespace and scope must be explicit')
        if type(self.width) is not int or self.width not in (1, 2, 4, 8):
            raise ValueError('identity width is measured in bytes')
        if type(self.value) is not int or not 0 <= self.value < 1 << (8 * self.width):
            raise ValueError('identity outside unsigned storage width')


def _sha256_hex(value):
    if type(value) is not str or re.fullmatch('[0-9a-f]{64}', value) is None:
        raise ValueError('canonical SHA256 hex required')
    return value


@dataclass(frozen=True)
class SnapshotKey(Record):
    """Exact wire/plain provenance, never fixture-based admission."""
    digest: str
    file_pid: int
    plain_digest: str

    def __post_init__(self):
        super().__post_init__()
        _sha256_hex(self.digest); _sha256_hex(self.plain_digest)
        if type(self.file_pid) is not int or not 0 < self.file_pid < 2**64:
            raise ValueError('file_pid must be a positive uint64')


@dataclass(frozen=True)
class SourceBinding(Record):
    """A nonempty registered source binding, not just an external-ID argument."""
    snapshot: SnapshotKey
    pool: str
    wire_id: int
    value_digest: str

    def __post_init__(self):
        super().__post_init__()
        if type(self.snapshot) is not SnapshotKey:
            raise TypeError('typed source SnapshotKey required')
        if type(self.pool) is not str or not self.pool or len(self.pool) > 64:
            raise ValueError('exact bounded source pool required')
        if type(self.wire_id) is not int or not 0 < self.wire_id < 2**31:
            raise ValueError('registered source wire_id must be positive signed32')
        _sha256_hex(self.value_digest)


# This is the explicit identity-v2 transport vocabulary, not a general format census.
IDENTITY_V2_POOLS = frozenset(('L+0x178','L+0x1c0','L+0x208','L+0x328',
    'L+0x370','L+0x400','L+0x1768','L+0x17b0','L+0x17f8','L+0x640',
    'L+0x1840','L+0x910'))
IDENTITY_V2_WIDTHS = MappingProxyType({
    **{k:4 for k in ('track.common_local','track.file_local','album.local',
                     'artist.local','playlist.local','item.local','item.order_token')},
    **{k+'.pid':8 for k in ('track','album','artist','playlist','item','file','master')},
    **{'pool:'+p:4 for p in IDENTITY_V2_POOLS}})
IMPORTER_POOL_DOMAINS = MappingProxyType(dict(name='L+0x178',album='L+0x1c0',
    artist='L+0x208',genre='L+0x328',kind='L+0x370',comment='L+0x400',
    sort_name='L+0x1768',sort_album='L+0x17b0',sort_artist='L+0x17f8'))


def importer_pool_domain(alias: str) -> str:
    """Translate only the pinned importer's exact aliases. Context still matters."""
    if type(alias) is not str or alias not in IMPORTER_POOL_DOMAINS:
        raise ValueError('unknown importer pool alias')
    return IMPORTER_POOL_DOMAINS[alias]


def identity_snapshot_digest(identity: ScopedID, *, identity_v2=False) -> str:
    """Validate snapshot[/playlist:PID] without stripping the retained scope."""
    if type(identity) is not ScopedID:
        raise TypeError('typed ScopedID required')
    if identity_v2 and IDENTITY_V2_WIDTHS.get(identity.namespace) != identity.width:
        raise ValueError('identity-v2 namespace/width mismatch')
    m = re.fullmatch(r'([0-9a-f]{64})(?:/playlist:([0-9A-F]{16}))?', identity.scope)
    if m is None:
        raise ValueError('canonical snapshot identity scope required')
    playlist = m.group(2)
    if playlist is not None and (int(playlist,16)==0 or identity.namespace not in
                                ('item.local','item.pid','item.order_token')):
        raise ValueError('invalid playlist-local identity scope')
    if identity.namespace == 'item.order_token' and playlist is None:
        raise ValueError('order token requires playlist-local scope')
    return m.group(1)


def snapshot_key(data: bytes, *, limits=None) -> SnapshotKey:
    """Hash bounded immutable input bytes, never serialize or repair a Library."""
    c = load_container(data, limits=limits)
    if len(c.header) < 60:
        raise FormatError('snapshot file identity header is unavailable')
    return SnapshotKey(hashlib.sha256(data).hexdigest(),
        int.from_bytes(c.header[52:60], 'big'), hashlib.sha256(c.payload).hexdigest())


def encode_seed(seed: str, *, domain: str) -> bytes:
    """Deterministic, domain-separated UTF-8 seed transport; no normalization/RNG.

    Pass the resulting32 bytes to identity.ReservationAllocator. Its commitment
    is SHA256(result), not SHA256(the unencoded user string). None stays None at
    the engine boundary and randomness is generated once, during prepare only.
    """
    if type(seed) is not str or not 0 < len(seed) <= 128:
        raise ValueError('seed must be a nonempty string of at most128 characters')
    if type(domain) is not str or re.fullmatch(r'[A-Za-z0-9_.-]{1,64}', domain) is None:
        raise ValueError('bounded ASCII engine domain required')
    d = domain.encode('ascii'); b = seed.encode('utf-8','strict')
    return hashlib.sha256(b'itlkit.seed.v1\0'+len(d).to_bytes(4,'big')+d+
                          len(b).to_bytes(4,'big')+b).digest()


@dataclass(frozen=True)
class ReferenceEdge(Record):
    source: ScopedID
    target: ScopedID
    relation: str
    evidence_refs: tuple
    owner_locator: str = ''
    source_snapshot: SnapshotKey | None = None
    evidence_level: str = 'known-wire-reference'

    def __post_init__(self):
        super().__post_init__()
        if type(self.source) is not ScopedID or type(self.target) is not ScopedID:
            raise TypeError('reference endpoints must be canonical ScopedID records')
        if type(self.relation) is not str or not self.relation or not self.evidence_refs:
            raise ValueError('reference relation and evidence required')
        if type(self.owner_locator) is not str or type(self.evidence_level) is not str:
            raise TypeError('reference labels must be immutable strings')
        if self.source_snapshot is not None:
            if type(self.source_snapshot) is not SnapshotKey or any(
                    identity_snapshot_digest(x) != self.source_snapshot.digest
                    for x in (self.source,self.target)):
                raise ValueError('reference snapshot/scope mismatch')


@dataclass(frozen=True)
class ReferenceGraph(Record):
    typed_edges: tuple = ()
    owners: tuple = ()
    opaque_possible_edges: tuple = ()
    coverage: object = field(default_factory=dict)
    snapshot: SnapshotKey | None = None

    def __post_init__(self):
        super().__post_init__()
        if any(type(x) is not ReferenceEdge for x in self.typed_edges) or any(
                type(x) is not ScopedID for x in self.owners):
            raise TypeError('graph requires canonical typed endpoints and edges')
        if self.snapshot is not None and type(self.snapshot) is not SnapshotKey:
            raise TypeError('graph SnapshotKey required')


@dataclass(frozen=True)
class AllocationReservation(Record):
    namespace: str
    scope: str
    old_identity: ScopedID | SourceBinding | None
    reserved_identity: ScopedID
    consumers: tuple
    capacity_check: object
    source_snapshot: SnapshotKey | None = None
    target_snapshot: SnapshotKey | None = None

    def __post_init__(self):
        super().__post_init__()
        r = self.reserved_identity; old = self.old_identity
        if type(r) is not ScopedID or (r.namespace,r.scope) != (self.namespace,self.scope):
            raise ValueError('reservation namespace/scope mismatch')
        expected_width=IDENTITY_V2_WIDTHS.get(r.namespace)
        if expected_width is not None and r.width!=expected_width:
            raise ValueError('reservation identity-v2 namespace/width mismatch')
        if type(old) is ScopedID:
            # Source ownership is retained: foreign snapshots MUST NOT be relabeled.
            if old.namespace != r.namespace or old.width != r.width:
                raise ValueError('old identity namespace/width mismatch')
        elif type(old) is SourceBinding:
            if r.namespace != 'pool:'+old.pool or r.width != 4:
                raise ValueError('source binding namespace/width mismatch')
            if self.source_snapshot is None:
                object.__setattr__(self,'source_snapshot',old.snapshot)
            elif self.source_snapshot != old.snapshot:
                raise ValueError('source binding SnapshotKey mismatch')
        elif old is not None:
            raise TypeError('old identity must be canonical ScopedID or SourceBinding')
        if type(self.consumers) is not tuple or any(type(x) is not str or not x or len(x)>512 for x in self.consumers):
            raise TypeError('consumers must be bounded immutable strings')
        if not isinstance(self.capacity_check,Mapping) or self.capacity_check.get('passed') is not True:
            raise ValueError('explicit successful capacity check required')
        for key in (self.source_snapshot,self.target_snapshot):
            if key is not None and type(key) is not SnapshotKey:
                raise TypeError('canonical SnapshotKey required')
        if self.source_snapshot is not None:
            if old is None or (type(old) is ScopedID and
                    identity_snapshot_digest(old)!=self.source_snapshot.digest):
                raise ValueError('source SnapshotKey/scope mismatch')
        if self.target_snapshot is not None and identity_snapshot_digest(r)!=self.target_snapshot.digest:
            raise ValueError('target SnapshotKey/scope mismatch')


@dataclass(frozen=True)
class AllocationLedger(Record):
    # Positional reservations/iteration/length retain their original API.
    reservations: tuple = ()
    snapshot: SnapshotKey | None = None
    sources: object = field(default_factory=dict)
    retired: tuple = ()
    seed_commitment: str | None = None
    history: tuple = ()

    def __post_init__(self):
        super().__post_init__()
        if type(self.reservations) is not tuple or any(type(x) is not AllocationReservation for x in self.reservations):
            raise TypeError('ledger requires typed AllocationReservation records')
        ids = [(r.namespace,r.scope,r.reserved_identity.value) for r in self.reservations]
        if len(ids)!=len(set(ids)):
            raise ValueError('duplicate reservation in the same namespace/scope')
        if self.snapshot is not None and type(self.snapshot) is not SnapshotKey:
            raise TypeError('ledger SnapshotKey required')
        if not isinstance(self.sources,Mapping) or any(type(k) is not str or not k or
                type(v) is not SnapshotKey for k,v in self.sources.items()):
            raise TypeError('sources must name typed SnapshotKey records')
        if type(self.retired) is not tuple or any(type(x) is not ScopedID for x in self.retired):
            raise TypeError('retirements require canonical ScopedID records')
        ids = [(x.namespace,x.scope,x.value) for x in self.retired]
        if len(ids)!=len(set(ids)):
            raise ValueError('duplicate retired identity')
        if self.seed_commitment is not None: _sha256_hex(self.seed_commitment)
        if type(self.history) is not tuple or any(type(x) is not AllocationLedger for x in self.history):
            raise TypeError('history requires complete canonical ledgers')
        if (self.sources or self.retired or self.seed_commitment is not None or self.history) and self.snapshot is None:
            raise ValueError('extended ledger evidence requires target SnapshotKey')
        if self.snapshot is not None:
            for past in self.history:
                if past.snapshot is None or past.snapshot.file_pid!=self.snapshot.file_pid:
                    raise ValueError('history belongs to a different target file lineage')

    def __iter__(self): return iter(self.reservations)
    def __len__(self): return len(self.reservations)


def encode_json(value, *, limits=None) -> bytes:
    """Admit keys, values and their ASCII JSON expansion before encoding/copying."""
    limits = get_limits(limits)
    stack = [(value, 0, frozenset())]
    count = text_bytes = text_chars = json_bytes = 0

    def admit(extra=0):
        limits.check('json', json_bytes)
        limits.check('text', text_bytes)
        limits.check('memory', (count + len(stack) + extra) * 256 +
                     4 * text_chars + 4 * json_bytes)

    while stack:
        v, depth, ancestors = stack.pop()
        if depth > limits.max_depth * 3 + 16:
            raise LimitError('JSON nesting budget exceeded')
        count += 1
        if count > limits.max_nodes * 32:
            raise LimitError('JSON aggregate element budget exceeded')
        if is_dataclass(v) or isinstance(v, Mapping) or type(v) in (list, tuple):
            if id(v) in ancestors:
                raise FormatError('cyclic JSON')
            lineage = ancestors | {id(v)}
            record = is_dataclass(v)
            mapping = record or isinstance(v, Mapping)
            if record:
                public = tuple(f for f in fields(v) if not f.name.startswith('_'))
                length = len(public)
            else:
                length = len(v)
            children = length * (2 if mapping else 1)
            if count + len(stack) + children > limits.max_nodes * 32:
                raise LimitError('JSON aggregate element budget exceeded')
            # Brackets, commas, and mapping colons; strings include their quotes.
            json_bytes += 2 + max(0, length - 1) + (length if mapping else 0)
            admit(children)  # Before materializing a container's traversal stack.
            if mapping:
                pairs = ((f.name, getattr(v, f.name)) for f in public) if record else v.items()
                for key, item in pairs:
                    if type(key) is not str:
                        raise FormatError('JSON keys must be strings')
                    stack.append((key, depth + 1, lineage))
                    stack.append((item, depth + 1, lineage))
            else:
                stack.extend((item, depth + 1, lineage) for item in v)
        elif type(v) is str:
            # Cheap lower bounds refuse huge existing strings before any encoding.
            limits.check('text', text_bytes + len(v))
            limits.check('json', json_bytes + len(v) + 2)
            limits.check('memory', (count + len(stack)) * 256 +
                         4 * (text_chars + len(v)) + 4 * (json_bytes + len(v) + 2))
            text_chars += len(v)
            json_bytes += 2
            for char in v:
                cp = ord(char)
                # Surrogates retain stdlib ensure_ascii behavior, counted as three
                # logical UTF-8 bytes (surrogatepass), never encoded as raw UTF-8.
                text_bytes += 1 if cp < 128 else 2 if cp < 2048 else 3 if cp < 65536 else 4
                json_bytes += (2 if char in '\"\\\b\f\n\r\t' else
                               6 if cp < 32 or 127 <= cp <= 65535 else
                               12 if cp > 65535 else 1)
                if text_bytes > limits.max_text_bytes or json_bytes > limits.max_json_bytes:
                    admit()
                if (count + len(stack)) * 256 + 4 * (text_chars + json_bytes) > limits.memory_budget_bytes:
                    admit()
        elif v is None:
            json_bytes += 4
        elif type(v) is bool:
            json_bytes += 4 if v else 5
        elif type(v) is int:
            # A lower bound is enough to reject enormous ints before decimal str().
            lower = max(1, (v.bit_length() - 1) * 30102 // 100000 + 1) + (v < 0)
            limits.check('json', json_bytes + lower)
            limits.check('memory', (count + len(stack)) * 256 + 4 * text_chars +
                         4 * (json_bytes + lower + 1))
            try:
                json_bytes += len(str(v))
            except ValueError as exc:
                raise FormatError(f'invalid JSON: {exc}') from exc
        elif type(v) is float and math.isfinite(v):
            json_bytes += len(repr(v))
        else:
            raise FormatError('non-JSON value')
        admit()
    value = plain(value)
    chunks = []
    size = 0
    try:
        for part in json.JSONEncoder(ensure_ascii=True, allow_nan=False, sort_keys=True,
                                     separators=(',', ':')).iterencode(value):
            # ensure_ascii output is ASCII; check before allocating encoded bytes.
            size += len(part)
            limits.check('json', size)
            limits.check('memory', count * 256 + 4 * text_chars + 4 * size)
            if size > json_bytes:
                raise FormatError('JSON changed during encoding')
            chunks.append(part.encode('ascii'))
    except (ValueError, TypeError, RecursionError) as exc:
        if isinstance(exc, (FormatError, UnsupportedError)):
            raise
        raise FormatError(f'invalid JSON: {exc}') from exc
    if size != json_bytes:
        raise FormatError('JSON changed during encoding')
    return b''.join(chunks)


def preflight_payload(payload: bytes, *, limits=None):
    """Walk core framing WITHOUT allocating the Node tree; no tag scanning.

    Unknown sections are one opaque body. All mhoh payload bytes count toward
    the conservative text budget, including unknown non-text metadata.
    """
    limits = get_limits(limits)
    limits.check('plain', len(payload))
    nodes = 0; text_bytes = 0; maximum_depth = 0

    def visit(start, end, depth, fixed=None):
        nonlocal nodes, text_bytes, maximum_depth
        limits.check('depth', depth)
        while start < end:
            tag, hlen, total = prefix(payload, start, end)
            if fixed:
                if tag != fixed:
                    raise FormatError('unexpected fixed record', start)
                total = hlen
            if not hlen <= total <= end - start:
                raise FormatError('invalid total record boundary', start)
            tick(depth)
            if tag == b'mhoh':
                if hlen < 16:
                    raise FormatError('short metadata header', start)
                text_bytes += total - hlen; limits.check('text', text_bytes)
            if tag in CONTAINERS and fixed is None:
                visit(start + hlen, start + total, depth + 1)
            start += total

    def tick(depth):
        nonlocal nodes, maximum_depth
        nodes += 1; maximum_depth = max(maximum_depth, depth)
        limits.check('nodes', nodes); limits.check('depth', depth)
        limits.check('memory', len(payload) * (maximum_depth + 8) + nodes * 1024)

    start = 0
    while start < len(payload):
        tag, hlen, total = prefix(payload, start, len(payload))
        if tag != b'msdh' or hlen < 16 or not hlen <= total <= len(payload) - start:
            raise FormatError('invalid section boundary', start)
        tick(0)
        kind = uint(payload, start + 12); pos = start + hlen; end = start + total
        if kind in LIST_ROOTS or kind in (16, 20):
            rt, rh, _ = prefix(payload, pos, end)
            if rt != LIST_ROOTS.get(kind, b'mfdh' if kind == 16 else b'mlqh'):
                raise FormatError('unexpected root tag', pos)
            tick(1)
            if kind == 16:
                if pos + rh != end:
                    raise FormatError('data after fixed mfdh', pos)
            else:
                visit(pos + rh, end, 2, b'mprh' if kind == 15 else None)
        start = end
    return {'nodes': nodes, 'depth': maximum_depth, 'text_bytes': text_bytes,
            'plain_bytes': len(payload)}


def load_container(data: bytes, *, limits=None) -> Container:
    limits = get_limits(limits)
    if type(data) is not bytes:
        raise TypeError('immutable bytes required')
    wire_cost = 6 * len(data)
    limits.check('file', len(data)); limits.check('memory', wire_cost)
    # Retain the sixfold estimate and reserve one plaintext slot for the core's
    # cap+1 overflow sentinel. The legacy Container default is unchanged.
    memory_cap = (limits.memory_budget_bytes - wire_cost) // 6 - 1
    if memory_cap < 1:
        raise LimitError('insufficient memory budget for bounded decompression')
    plain_cap = min(limits.max_plain_bytes, memory_cap)
    container = Container.from_bytes(data, max_plain_bytes=plain_cap)
    limits.check('memory', wire_cost + 6 * len(container.payload))
    return container


def load_library(data: bytes, *, limits=None):
    from .library import Library
    limits = get_limits(limits)
    container = load_container(data, limits=limits)
    if container.payload_byteorder != 'little':
        raise UnsupportedError('bounded Library requires little-endian payload')
    preflight_payload(container.payload, limits=limits)
    return Library(container)


def read_bytes(path, *, limits=None) -> bytes:
    """Bound allocation before opening; verify descriptor and final pathname CAS."""
    limits = get_limits(limits)
    def identity(s):
        # stat/fstat ctime can denote different clocks on Windows/Python.
        # Compare that field within each observation series, not across them.
        return (s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_mode)
    path = Path(path)
    first = path.stat()
    limits.check('file', first.st_size)
    # Include the one-byte growth sentinel, even for an empty file. Raw FileIO
    # avoids an implicit buffered-reader read-ahead beyond that admitted extent.
    limits.check('memory', 6 * (first.st_size + 1))
    with path.open('rb', buffering=0) as f:
        opened = os.fstat(f.fileno())
        if identity(first) != identity(opened):
            raise FormatError('input changed before read')
        data = f.read(opened.st_size + 1)
        last = os.fstat(f.fileno())
    limits.check('file', len(data))
    if (identity(opened) != identity(last) or opened.st_ctime_ns != last.st_ctime_ns
            or len(data) != opened.st_size):
        raise FormatError('input changed during read')
    try:
        final = path.stat()
    except OSError as exc:
        raise FormatError('input changed after read') from exc
    if identity(last) != identity(final) or first.st_ctime_ns != final.st_ctime_ns:
        raise FormatError('input changed after read')
    return data
