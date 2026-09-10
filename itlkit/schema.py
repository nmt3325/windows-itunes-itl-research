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
        return value
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


@dataclass(frozen=True)
class ReferenceEdge(Record):
    source: ScopedID
    target: ScopedID
    relation: str
    evidence_refs: tuple


@dataclass(frozen=True)
class ReferenceGraph(Record):
    typed_edges: tuple = ()
    owners: tuple = ()
    opaque_possible_edges: tuple = ()
    coverage: object = field(default_factory=dict)


@dataclass(frozen=True)
class AllocationReservation(Record):
    namespace: str
    scope: str
    old_identity: ScopedID | None
    reserved_identity: ScopedID
    consumers: tuple
    capacity_check: object

    def __post_init__(self):
        super().__post_init__()
        r = self.reserved_identity
        if type(r) is not ScopedID or (r.namespace, r.scope) != (self.namespace, self.scope):
            raise ValueError('reservation namespace/scope mismatch')
        if self.old_identity is not None and (type(self.old_identity) is not ScopedID or
                (self.old_identity.namespace, self.old_identity.scope) != (self.namespace, self.scope)):
            raise ValueError('old identity namespace/scope mismatch')
        if not isinstance(self.capacity_check, Mapping) or self.capacity_check.get('passed') is not True:
            raise ValueError('explicit successful capacity check required')


@dataclass(frozen=True)
class AllocationLedger(Record):
    reservations: tuple = ()

    def __post_init__(self):
        super().__post_init__()
        if any(type(x) is not AllocationReservation for x in self.reservations):
            raise TypeError('ledger requires typed AllocationReservation records')
        ids = [(r.namespace, r.scope, r.reserved_identity.value) for r in self.reservations]
        if len(ids) != len(set(ids)):
            raise ValueError('duplicate reservation in the same namespace/scope')

    def __iter__(self):
        return iter(self.reservations)

    def __len__(self):
        return len(self.reservations)


def encode_json(value, *, limits=None) -> bytes:
    """Bound depth, aggregate elements, and serialized UTF-8 before joining."""
    limits = get_limits(limits)
    stack = [(value, 0, frozenset())]
    count = 0
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
            if is_dataclass(v):
                values = [getattr(v, f.name) for f in fields(v) if not f.name.startswith('_')]
            elif isinstance(v, Mapping):
                if any(type(k) is not str for k in v):
                    raise FormatError('JSON keys must be strings')
                values = list(v.values())
            else:
                values = v
            if len(values) > limits.max_nodes * 32:
                raise LimitError('JSON aggregate element budget exceeded')
            limits.check('memory', (count + len(stack) + len(values)) * 256)
            stack.extend((item, depth + 1, lineage) for item in values)
        elif type(v) is str:
            if len(v) > limits.max_json_bytes:
                raise LimitError('JSON string budget exceeded')
        elif v is not None and type(v) not in (int, bool, float):
            raise FormatError('non-JSON value')
    value = plain(value)
    chunks = []
    size = 0
    try:
        for part in json.JSONEncoder(ensure_ascii=True, allow_nan=False, sort_keys=True,
                                     separators=(',', ':')).iterencode(value):
            b = part.encode('utf8'); size += len(b)
            limits.check('json', size)
            limits.check('memory', 4 * size)
            chunks.append(b)
    except (ValueError, TypeError, RecursionError) as exc:
        if isinstance(exc, (FormatError, UnsupportedError)):
            raise
        raise FormatError(f'invalid JSON: {exc}') from exc
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
        limits.check('memory', len(payload) * 6 + nodes * 1024)

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
    limits.check('file', len(data)); limits.check('memory', 6 * len(data))
    container = Container.from_bytes(data, max_plain_bytes=limits.max_plain_bytes)
    limits.check('memory', 6 * len(data) + 6 * len(container.payload))
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
    """Stat before allocation, bounded read, and detect file replacement/growth."""
    limits = get_limits(limits)
    path = Path(path); first = path.stat(); limits.check('file', first.st_size)
    with path.open('rb') as f:
        opened = os.fstat(f.fileno())
        if (first.st_dev, first.st_ino, first.st_size, first.st_mtime_ns) != (opened.st_dev, opened.st_ino, opened.st_size, opened.st_mtime_ns):
            raise FormatError('input changed before read')
        data = f.read(limits.max_file_bytes + 1)
        last = os.fstat(f.fileno())
    limits.check('file', len(data))
    if (opened.st_size, opened.st_mtime_ns) != (last.st_size, last.st_mtime_ns) or len(data) != opened.st_size:
        raise FormatError('input changed during read')
    return data
