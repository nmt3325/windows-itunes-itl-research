"""A boundary-driven section/record tree; opaque data is never tag-scanned."""
from __future__ import annotations
from dataclasses import dataclass, field
from .binary import uint, put, prefix
from .errors import FormatError

LIST_ROOTS = {1: b'mlth', 2: b'mlph', 9: b'mlah', 11: b'mlih',
              12: b'mhgh', 13: b'mlth', 14: b'mlph', 15: b'mlrh', 21: b'mlsh'}
CONTAINERS = {b'mith', b'miph', b'miah', b'miih', b'miqh', b'mtph'}
CHILD_COUNT = {b'mith', b'miah', b'miih', b'miqh', b'mtph'}
KINDS = {'total', 'section', 'count', 'fixed', 'mixed'}

@dataclass
class Node:
    header: bytearray
    kind: str = 'total'
    children: list[Node] | None = None
    payload: bytes = b''
    offset: int | None = None

    @property
    def tag(self) -> bytes:
        return bytes(self.header[:4])

    @property
    def section_type(self) -> int | None:
        return uint(self.header, 12) if self.tag == b'msdh' else None

    @property
    def type_code(self) -> int | None:
        return uint(self.header, 12) if self.tag == b'mhoh' else None

    def walk(self):
        yield self
        for child in self.children or ():
            yield from child.walk()

    def to_bytes(self) -> bytes:
        if self.kind not in KINDS or len(self.header) < 12:
            raise FormatError('invalid node model')
        if self.children is not None and self.payload:
            raise FormatError('node cannot have both children and opaque payload')
        body = b''.join(c.to_bytes() for c in self.children) if self.children is not None else bytes(self.payload)
        h = bytearray(self.header)
        put(h, 4, len(h))
        if self.kind in ('total', 'section'):
            put(h, 8, len(h) + len(body))
        if self.children is not None:
            if self.kind == 'count':
                put(h, 8, len(self.children))
            elif self.kind == 'mixed':
                put(h, 12, sum(c.tag == b'mhoh' for c in self.children))
                put(h, 16, sum(c.tag == b'miqh' for c in self.children))
            elif self.tag in CHILD_COUNT:
                put(h, 12, len(self.children))
            elif self.tag == b'miph':
                put(h, 12, sum(c.tag == b'mhoh' for c in self.children))
                put(h, 16, sum(c.tag == b'mtph' for c in self.children))
        return bytes(h) + body

    def to_dict(self) -> dict:
        result = {'tag': self.tag.decode('ascii', errors='replace'), 'kind': self.kind,
                  'header_hex': self.header.hex(), 'offset': self.offset}
        if self.children is None:
            result['payload_hex'] = self.payload.hex()
        else:
            result['children'] = [c.to_dict() for c in self.children]
        return result

    @classmethod
    def from_dict(cls, value: dict, *, depth: int = 0) -> Node:
        if depth > 32:
            raise FormatError('JSON tree exceeds maximum depth')
        try:
            h = bytearray.fromhex(value['header_hex'])
            kind = value['kind']
            if kind not in KINDS:
                raise FormatError('invalid JSON node kind')
            if 'children' in value:
                if value.get('payload_hex'):
                    raise FormatError('ambiguous JSON children and payload')
                children = [cls.from_dict(c, depth=depth + 1) for c in value['children']]
                return cls(h, kind, children)
            return cls(h, kind, None, bytes.fromhex(value['payload_hex']))
        except (KeyError, TypeError, ValueError) as exc:
            if isinstance(exc, FormatError):
                raise
            raise FormatError(f'invalid node JSON: {exc}') from exc


def _check_counts(node: Node) -> None:
    children = node.children or []
    checks = []
    if node.kind == 'count':
        checks.append((8, len(children)))
    elif node.kind == 'mixed':
        checks.extend(((12, sum(c.tag == b'mhoh' for c in children)), (16, sum(c.tag == b'miqh' for c in children))))
    elif node.tag in CHILD_COUNT:
        checks.append((12, len(children)))
    elif node.tag == b'miph':
        checks.extend(((12, sum(c.tag == b'mhoh' for c in children)), (16, sum(c.tag == b'mtph' for c in children))))
    for offset, expected in checks:
        actual = uint(node.header, offset)
        if actual != expected:
            raise FormatError(f'{node.tag!r} child count {actual} != {expected}', (node.offset or 0) + offset)


def _sequence(data: bytes, start: int, end: int, *, fixed_tag: bytes | None = None,
              depth: int = 0) -> list[Node]:
    if depth > 32:
        raise FormatError('record nesting exceeds maximum depth', start)
    result = []
    while start < end:
        tag, hlen, total = prefix(data, start, end)
        if fixed_tag:
            if tag != fixed_tag:
                raise FormatError(f'expected {fixed_tag!r}, got {tag!r}', start)
            total = hlen
        elif not hlen <= total <= end - start:
            raise FormatError(f'invalid {tag!r} total length {total}', start + 8)
        h = bytearray(data[start:start + hlen])
        if tag == b'mhoh' and hlen < 16:
            raise FormatError('mhoh header too short for type code', start)
        node = Node(h, 'fixed' if fixed_tag else 'total', None, data[start + hlen:start + total], start)
        if tag in CONTAINERS and not fixed_tag:
            node.children = _sequence(data, start + hlen, start + total, depth=depth + 1)
            node.payload = b''
            _check_counts(node)
        result.append(node)
        start += total
    return result


def parse_sections(data: bytes) -> list[Node]:
    """Parse msdh boundaries, retaining unknown section bodies as single opaque spans."""
    data = bytes(data)
    sections = []
    start = 0
    while start < len(data):
        tag, hlen, total = prefix(data, start, len(data))
        if tag != b'msdh' or hlen < 16 or not hlen <= total <= len(data) - start:
            raise FormatError('invalid msdh section boundary', start)
        kind = uint(data, start + 12)
        h = bytearray(data[start:start + hlen])
        pos, end = start + hlen, start + total
        sec = Node(h, 'section', None, data[pos:end], start)
        if kind in LIST_ROOTS or kind in (16, 20):
            root_tag, root_hlen, _ = prefix(data, pos, end)
            expected = LIST_ROOTS.get(kind, b'mfdh' if kind == 16 else b'mlqh')
            if root_tag != expected:
                raise FormatError(f'section {kind} expected {expected!r}, got {root_tag!r}', pos)
            root = Node(bytearray(data[pos:pos + root_hlen]), 'fixed', None, b'', pos)
            if kind == 16:
                if pos + root_hlen != end:
                    raise FormatError('unexpected data following mfdh header', pos + root_hlen)
            else:
                root.kind = 'mixed' if kind == 20 else 'count'
                root.children = _sequence(data, pos + root_hlen, end, fixed_tag=b'mprh' if kind == 15 else None)
                _check_counts(root)
            sec.children, sec.payload = [root], b''
        sections.append(sec)
        start = end
    return sections


def serialize_sections(sections: list[Node]) -> bytes:
    return b''.join(section.to_bytes() for section in sections)