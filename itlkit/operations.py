"""Guarded structural operations for the observed standalone 12.13.10.3 profile.

Opaque/unknown dependent layouts are rejected, not silently reset. Replacing a
playlist's membership intentionally creates NEW item identities, like native
remove-all/add-in-order; it never changes the underlying track identities.
"""
from __future__ import annotations
import copy
import secrets
from .binary import uint, put
from .errors import FormatError, UnsupportedError
from .model import Node, serialize_sections
from .library import Playlist, set_text, _parse_pid


def require_simple_library(library) -> None:
    library._require_semantic_profile()
    if library.container.version != '12.13.10.3':
        raise UnsupportedError('structural edits require the native-observed 12.13.10.3 profile')
    supported = {16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4}
    for section in library.sections:
        if section.section_type not in supported:
            raise UnsupportedError(f'structural edits with section {section.section_type} are unverified')
        if section.section_type in (13, 14):
            if section.children and section.children[0].children:
                raise UnsupportedError('nonempty secondary track/playlist lists have unknown dependencies')
        if section.section_type == 23:
            if len(section.payload) != 96 or section.payload[:4] != b'stsh':
                raise UnsupportedError('nonempty store index has unresolved dependencies')
    root = library._root(12)
    if root and any(c.type_code not in (503, 508, 517) for c in root.children or ()):
        raise UnsupportedError('global metadata contains unverified structural references')


def require_plain(playlist: Playlist) -> None:
    if not playlist.is_plain:
        raise UnsupportedError('only ordinary, non-smart, non-system playlists are supported')
    node = playlist.node
    codes = [c.type_code for c in node.children or () if c.tag == b'mhoh']
    if sorted(codes) != [100, 105, 105, 108]:
        raise UnsupportedError('unknown ordinary-playlist metadata layout')
    for child in node.children or ():
        if child.tag not in (b'mhoh', b'mtph'):
            raise UnsupportedError('unknown playlist child record')
        if child.tag == b'mhoh' and child.type_code in (105, 108):
            expected = 1244 if child.type_code == 105 else 220
            if len(child.to_bytes()) != expected:
                raise UnsupportedError('unverified playlist view metadata size')
    # All observed nonzero fields in fresh/native ordinary-playlist headers.
    known = {0, 4, 8, 12, 16, 0x18, 0x1c, 0x1b4, 0x1b8, 0x1bc,
             0x274, 0x730, 0x734, 0xc74, 0xd40}
    for off in range(0, len(node.header) - 3, 4):
        if off not in known and uint(node.header, off):
            raise UnsupportedError(f'ordinary playlist has unknown nonzero state at +0x{off:x}')
    if uint(node.header, 0x18) != 0x10001 or uint(node.header, 0x1b4) != 0x008c0000:
        raise UnsupportedError('unverified ordinary-playlist flags')
    for item in playlist.items:
        if len(item.header) != 84 or item.children or item.payload:
            raise UnsupportedError('unverified playlist item shape')
        item_known = {0, 4, 8, 12, 16, 24, 32, 68, 72}
        if any(uint(item.header, o) for o in range(0, 84, 4) if o not in item_known):
            raise UnsupportedError('playlist item has unknown state that cannot be recreated')


def _all_bytes(library) -> bytes:
    return library.container.header + serialize_sections(library.sections)


class Allocator:
    def __init__(self, library):
        self.raw = _all_bytes(library)
        values = [0]
        for section in library.sections:
            for node in section.walk():
                if node.tag in (b'mith', b'miah', b'miih', b'mtph'):
                    values.append(uint(node.header, 16))
                if node.tag == b'mith':
                    values.append(uint(node.header, 0x1f4))
                elif node.tag == b'mtph':
                    values.append(uint(node.header, 32))
                elif node.tag == b'miph':
                    values.append(uint(node.header, 0xd40))
        self.next_id = max(values) + 1
        self.pids = set()

    def local(self) -> int:
        # Conservative collision guard, NOT a parser or tag-search heuristic:
        # avoid a new identifier appearing anywhere in the existing byte model.
        while self.next_id < 2**32:
            result = self.next_id; self.next_id += 1
            if result.to_bytes(4, 'little') not in self.raw:
                return result
        raise UnsupportedError('no available uint32 local identity')

    def persistent(self, requested: int | str | None = None) -> int:
        if requested is not None:
            requested = _parse_pid(requested)
        for _ in range(100):
            result = secrets.randbits(64) if requested is None else requested
            if type(result) is not int or not 0 < result < 2**64:
                raise ValueError('persistent ID must be a nonzero uint64')
            present = (result in self.pids or result.to_bytes(8, 'little') in self.raw
                       or result.to_bytes(8, 'big') in self.raw
                       or f'{result:016X}'.encode() in self.raw or f'{result:016x}'.encode() in self.raw)
            if not present:
                self.pids.add(result)
                return result
            if requested is not None:
                raise ValueError('requested persistent ID already appears in the library')
        raise UnsupportedError('failed to allocate a unique persistent ID')


def _possible_external_ref(library, excluded: Node, persistent_id: int) -> bool:
    needles = [persistent_id.to_bytes(8, 'little'), persistent_id.to_bytes(8, 'big'),
               f'{persistent_id:016X}'.encode(), f'{persistent_id:016x}'.encode()]
    for section in library.sections:
        if section.section_type == 2:
            root = section.children[0]
            regions = [n.to_bytes() for n in root.children or () if n is not excluded]
        else:
            regions = [section.to_bytes()]
        if any(needle in region for region in regions for needle in needles):
            return True
    return False


def _item(track_id: int, allocator: Allocator) -> Node:
    header = bytearray(84); header[:4] = b'mtph'
    put(header, 4, 84); put(header, 8, 84)
    local_id = allocator.local()
    put(header, 16, local_id); put(header, 24, track_id); put(header, 32, local_id)
    put(header, 68, allocator.persistent(), 8)
    return Node(header, children=[])


def _replace(library, playlist: Playlist, track_persistent_ids, allocator: Allocator) -> None:
    if not isinstance(track_persistent_ids, (list, tuple)):
        raise ValueError('track_persistent_ids must be a list in the desired order')
    tracks = [library.track(persistent_id=pid) for pid in track_persistent_ids]
    for item in playlist.items:
        if _possible_external_ref(library, playlist.node, uint(item.header, 68, 8)):
            raise UnsupportedError('an existing playlist item may be referenced outside its playlist')
    metadata = [n for n in playlist.node.children if n.tag == b'mhoh']
    playlist.node.children = metadata + [_item(t.track_id, allocator) for t in tracks]


def replace_playlist_members(library, persistent_id, track_persistent_ids) -> Playlist:
    candidate = copy.deepcopy(library)
    require_simple_library(candidate)
    playlist = candidate.playlist(persistent_id)
    require_plain(playlist)
    _replace(candidate, playlist, track_persistent_ids, Allocator(candidate))
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections
    return library.playlist(persistent_id)


def create_playlist(library, name: str, *, track_persistent_ids=(), persistent_id=None,
                    template_persistent_id=None, timestamp_hfs: int | None = None) -> Playlist:
    candidate = copy.deepcopy(library)
    require_simple_library(candidate)
    if template_persistent_id is not None:
        template = candidate.playlist(template_persistent_id)
        require_plain(template)
    else:
        ordinary = [p for p in candidate.playlists if p.is_plain]
        if ordinary:
            template = ordinary[0]; require_plain(template)
        else:
            masters = [p for p in candidate.playlists if p.is_master]
            if len(masters) != 1:
                raise UnsupportedError('a native playlist view template is required')
            template = masters[0]
    views = [copy.deepcopy(n) for n in template.node.children or () if n.tag == b'mhoh' and n.type_code in (105, 108)]
    if sorted(n.type_code for n in views) != [105, 105, 108]:
        raise UnsupportedError('cannot build a playlist without native view metadata')
    if any(len(n.to_bytes()) != (1244 if n.type_code == 105 else 220) for n in views):
        raise UnsupportedError('unverified view metadata shape')
    allocator = Allocator(candidate)
    pid = allocator.persistent(persistent_id)
    header = bytearray(3500); header[:4] = b'miph'
    put(header, 4, 3500); put(header, 8, 3500); put(header, 0x18, 0x10001)
    put(header, 0x1b4, 0x008c0000); put(header, 0x1b8, pid, 8)
    put(header, 0x734, 0x01000000); put(header, 0xd40, allocator.local())
    when = uint(template.node.header, 0x274) if timestamp_hfs is None else timestamp_hfs
    put(header, 0x1c, when); put(header, 0x274, when)
    node = Node(header, children=[])
    set_text(node, 100, name)
    node.children.extend(views)
    playlist = Playlist(candidate, node)
    root = candidate._root(2)
    if root is None or root.children is None:
        raise UnsupportedError('main playlist list is missing')
    root.children.append(node)
    _replace(candidate, playlist, track_persistent_ids, allocator)
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections
    return library.playlist(pid)


def delete_playlist(library, persistent_id) -> None:
    candidate = copy.deepcopy(library)
    require_simple_library(candidate)
    playlist = candidate.playlist(persistent_id)
    require_plain(playlist)
    if _possible_external_ref(candidate, playlist.node, playlist.persistent_id):
        raise UnsupportedError('playlist may be referenced by other opaque metadata or smart rules')
    for item in playlist.items:
        if _possible_external_ref(candidate, playlist.node, uint(item.header, 68, 8)):
            raise UnsupportedError('playlist item may have an external reference')
    root = candidate._root(2)
    root.children.remove(playlist.node)
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections