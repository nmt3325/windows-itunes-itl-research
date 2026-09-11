"""Bounded, read-only complete-primary-master predicate; never a write permit.

This module has no automatic hooks into core or planning. See admission-v2.md.
"""
from __future__ import annotations

from .binary import uint
from .container import Container
from .errors import FormatError, UnsupportedError
from .library import Library, Playlist
from .model import KINDS, Node
from .schema import ReadLimits, get_limits

__all__ = ['require_complete_master']
_ITEM_WORDS = frozenset((0, 4, 8, 12, 16, 24, 32, 68, 72))


def _bad(message: str) -> None:
    raise FormatError('GATE01: ' + message)


def _unsupported(message: str) -> None:
    raise UnsupportedError('GATE01: ' + message)


def _storage(value, label: str) -> int:
    if type(value) not in (bytes, bytearray):
        _bad('invalid byte storage: ' + label)
    return len(value)


def _bounded_model(library: Library, limits: ReadLimits) -> dict[int, Node]:
    """Validate current object topology before using any record accessor.

    No serialization, recursive walk, snapshot hashing, or caller callbacks.
    Counts/total-length caches and offsets do not define current membership.
    """
    c = library.container
    retained = 0
    for name in ('header', 'payload', 'trailer'):
        value = getattr(c, name, None)
        amount = _storage(value, 'container.' + name)
        ReadLimits.check(limits, 'plain', amount)
        retained += amount
        ReadLimits.check(limits, 'memory', retained * 4)
    if c._original is not None:
        amount = _storage(c._original, 'container._original')
        ReadLimits.check(limits, 'file', amount)
        retained += amount
        ReadLimits.check(limits, 'memory', retained * 4)
    if c._baseline is not None:
        if type(c._baseline) is not tuple or len(c._baseline) != 3:
            _bad('invalid baseline tuple')
        for value in c._baseline:
            amount = _storage(value, 'container._baseline')
            ReadLimits.check(limits, 'plain', amount)
            retained += amount
            ReadLimits.check(limits, 'memory', retained * 4)
    if type(getattr(library, 'sections', None)) is not list:
        _bad('invalid section list')
    ReadLimits.check(limits, 'nodes', len(library.sections))
    ReadLimits.check(limits, 'memory', retained * 4 + len(library.sections) * 2048)
    stack = [(n, 0) for n in reversed(library.sections)]
    seen = set()
    model_bytes = text_bytes = 0
    while stack:
        node, depth = stack.pop()
        if type(node) is not Node or id(node) in seen:
            _bad('cyclic, shared, or unsupported node model')
        seen.add(id(node))
        ReadLimits.check(limits, 'nodes', len(seen))
        ReadLimits.check(limits, 'depth', depth)
        header_size = _storage(getattr(node, 'header', None), 'node.header')
        payload_size = _storage(node.payload, 'node.payload')
        model_bytes += header_size + payload_size
        ReadLimits.check(limits, 'plain', model_bytes)
        ReadLimits.check(limits, 'memory', (retained + model_bytes) * 4 + (len(seen) + len(stack)) * 2048)
        if type(node.kind) is not str or len(node.kind) > 7 or node.kind not in KINDS:
            _bad('invalid node kind')
        if header_size < 12 or uint(node.header, 4) != header_size:
            _bad('invalid node header length')
        if node.offset is not None and (type(node.offset) is not int or node.offset < 0):
            _bad('invalid diagnostic offset')
        if node.tag == b'mhoh':
            if header_size < 16 or node.kind != 'total' or node.children is not None:
                _bad('invalid metadata node shape')
            text_bytes += payload_size
            ReadLimits.check(limits, 'text', text_bytes)
        if node.children is not None:
            if type(node.children) is not list or payload_size:
                _bad('invalid children or simultaneous opaque payload')
            scheduled = len(seen) + len(stack) + len(node.children)
            ReadLimits.check(limits, 'nodes', scheduled)
            ReadLimits.check(limits, 'memory', (retained + model_bytes) * 4 + scheduled * 2048)
            if node.children:
                ReadLimits.check(limits, 'depth', depth + 1)
                stack.extend((child, depth + 1) for child in reversed(node.children))
    sections = {}
    for section in library.sections:
        if section.tag != b'msdh' or section.kind != 'section' or len(section.header) < 16:
            _bad('invalid top-level section shape')
        kind = uint(section.header, 12)
        if kind in sections:
            _bad('duplicate section type')
        sections[kind] = section
    return sections


def _root(sections: dict[int, Node], kind: int, tag: bytes, *, required=False,
          size=None) -> Node | None:
    section = sections.get(kind)
    if section is None:
        if required:
            _unsupported('missing required primary/main root')
        return None
    if section.children is None or len(section.children) != 1 or section.payload:
        _bad('section must have exactly one direct root')
    root = section.children[0]
    if root.tag != tag:
        _bad('unexpected section root tag')
    expected_kind = 'fixed' if kind == 16 else 'count'
    if root.kind != expected_kind or (kind != 16 and root.children is None):
        _bad('unexpected section root kind')
    if size is not None and (len(section.header) != 96 or len(root.header) != size):
        _unsupported('unqualified primary/main framing shape')
    if kind == 16 and (root.children or root.payload):
        _bad('main fixed header has children or payload')
    return root


def _unique(values, label: str) -> set[int]:
    result = set()
    for value in values:
        if not value or value in result:
            _bad('zero or duplicate ' + label)
        result.add(value)
    return result


def _ids_and_refs(tracks: list[Node], playlists: list[Playlist], sections: dict[int, Node]) -> set[int]:
    """Linear equivalent of the inspected f70 core ID/reference predicates.

    The core method is pure, but recreates an album/artist set per track and
    calls instance accessors. This implementation uses already-bounded nodes.
    It deliberately preserves the core's primary namespaces and scoped items.
    """
    known = _unique((uint(n.header, 16) for n in tracks), 'track local ID')
    _unique((uint(n.header, 0x80, 8) for n in tracks), 'track persistent ID')
    _unique((uint(n.header, 0x1f4) for n in tracks), 'secondary track ID')
    for kind, root_tag, record_tag, header_size, reference_offset in (
        (9, b'mlah', b'miah', 88, 0xdc), (11, b'mlih', b'miih', 100, 0x1e0)
    ):
        root = _root(sections, kind, root_tag)
        records = [] if root is None else root.children
        # Qualify every auxiliary record BEFORE reading any identity from it.
        # An unknown tag, kind, header width, or an absent child list used to
        # skip persistent-ID validation while still contributing a local ID.
        for node in records:
            if (node.tag != record_tag or node.kind != 'total' or
                    len(node.header) != header_size or node.children is None):
                _unsupported('unqualified direct auxiliary album/artist shape')
        local = _unique((uint(n.header, 16) for n in records), 'album/artist local ID')
        _unique((uint(n.header, 20, 8) for n in records), 'album/artist persistent ID')
        for track in tracks:
            value = uint(track.header, reference_offset)
            if value and value not in local:
                _bad('track references a missing album/artist object')
    _unique((p.playlist_id for p in playlists), 'primary playlist local ID')
    _unique((p.persistent_id for p in playlists), 'primary playlist persistent ID')
    for playlist in playlists:
        items = playlist.items
        flat = [n for n in items if len(n.header) == 84]
        _unique((uint(n.header, 16) for n in flat), 'item local ID within playlist')
        _unique((uint(n.header, 68, 8) for n in flat), 'item persistent ID within playlist')
        for node in items:
            if uint(node.header, 24) not in known:
                _bad('playlist references a missing primary track')
    return known


def require_complete_master(library: Library, *, limits=None) -> Playlist:
    """Check the current model and return a view of its existing primary master.

    Exact Library/Container types and shared ReadLimits are required. This is
    a necessary, point-in-time predicate for future v2 engines, NOT a sealed
    capability, native qualification, serialization check, or complete RW claim.
    Importing/calling it never activates legacy or generic-planning guards.
    """
    if type(library) is not Library or type(getattr(library, 'container', None)) is not Container:
        raise TypeError('GATE01: exact Library and Container types required')
    limits = get_limits(limits)
    ReadLimits.__post_init__(limits)
    sections = _bounded_model(library, limits)
    c = library.container
    Container.validate_header(c)
    if c.payload_byteorder != 'little' or c.version not in ('12.13.9.1', '12.13.10.3'):
        _unsupported('observed Windows little-endian version required')
    if len(c.header) != 144 or c.trailer:
        _unsupported('observed outer header and no unknown trailer required')
    _root(sections, 16, b'mfdh', required=True, size=144)
    track_root = _root(sections, 1, b'mlth', required=True, size=92)
    playlist_root = _root(sections, 2, b'mlph', required=True, size=92)
    tracks = track_root.children
    for node in tracks:
        if node.tag != b'mith' or node.kind != 'total' or len(node.header) != 756 or node.children is None:
            _unsupported('unqualified direct primary track shape')
    playlists = []
    for node in playlist_root.children:
        if node.tag != b'miph' or node.kind != 'total' or len(node.header) != 3500 or node.children is None:
            _unsupported('unqualified direct primary playlist shape')
        playlists.append(Playlist(library, node))
    _ids_and_refs(tracks, playlists, sections)
    masters = [p for p in playlists if p.is_master]
    if len(masters) != 1:
        _unsupported('exactly one primary master required')
    master = masters[0]
    members = []
    for node in master.node.children:
        if node.tag == b'mhoh':
            continue
        if node.tag != b'mtph':
            _unsupported('unclassified master child')
        if node.kind != 'total' or len(node.header) != 84 or node.children or node.payload:
            _unsupported('grouped or extended master membership unsupported')
        if any(uint(node.header, offset) for offset in range(0, 84, 4) if offset not in _ITEM_WORDS):
            _unsupported('parent/group/unknown master item state')
        members.append(uint(node.header, 24))
    # Lists retain multiplicity: equal sets/cardinality alone are insufficient.
    if sorted(members) != sorted(uint(n.header, 16) for n in tracks):
        _unsupported('every primary track must occur exactly once in master')
    return master
