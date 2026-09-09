"""Closed-dependency track operations for simple local WAV libraries.

No new media is synthesized. Track import restores a complete native record
from another snapshot of the same library lineage, including its location blob.
Other media/store/cloud/history profiles fail closed.
"""
from __future__ import annotations
import copy
from .binary import uint, put
from .errors import FormatError, UnsupportedError
from .library import Track, read_text, set_text
from .model import Node
from .operations import Allocator, require_simple_library, _all_bytes, _item

AUX = {9: (b'miah', 88, (300, 301, 302)), 11: (b'miih', 100, (400,))}


def _profile(library) -> None:
    require_simple_library(library)
    for playlist in library.playlists:
        if playlist.is_smart and uint(playlist.node.header, 0x238) == 0:
            raise UnsupportedError('custom smart-playlist dependency evaluation is not implemented')


def _wave(track: Track) -> None:
    if len(track.node.header) != 756 or track.get('kind') != 'WAV audio file':
        raise UnsupportedError('track structural/index edits currently require a native local WAV template')
    if uint(track.node.header, 0x14) != 1 or uint(track.node.header, 0x8c) != 1463899680:
        raise UnsupportedError('unverified local WAV record flags')
    known = {1, 2, 3, 4, 5, 6, 8, 11, 12, 13, 27, 30, 31, 32, 33}
    if any(c.tag != b'mhoh' or c.type_code not in known for c in track.node.children or ()):
        raise UnsupportedError('track contains unverified data-object dependencies')
    url = track.get('url')
    if not isinstance(url, str) or not url.lower().startswith('file://'):
        raise UnsupportedError('track has no supported local file URL')


def _aux_profile(node: Node, section: int) -> None:
    tag, size, codes = AUX[section]
    if node.tag != tag or len(node.header) != size:
        raise UnsupportedError('unknown album/artist record profile')
    known = {0, 4, 8, 12, 16, 20, 24, 28}
    if section == 9:
        known.add(40)
    if any(uint(node.header, o) for o in range(0, size, 4) if o not in known):
        raise UnsupportedError('album/artist record has unknown nonzero state')
    if uint(node.header, 28) not in ((2, 0x10002) if section == 9 else (2,)):
        raise UnsupportedError('unverified album/artist flags')
    seen = set()
    for child in node.children or ():
        if child.tag != b'mhoh' or child.type_code not in codes or child.type_code in seen:
            raise UnsupportedError('unverified or ambiguous album/artist metadata')
        read_text(child)
        seen.add(child.type_code)


def _aux(library, section: int, local_id: int) -> Node:
    values = [n for n in library._records(section, AUX[section][0]) if uint(n.header, 16) == local_id]
    if len(values) != 1:
        raise UnsupportedError('track album/artist reference is missing or ambiguous')
    _aux_profile(values[0], section)
    return values[0]


def _text_key(node: Node, section: int) -> tuple:
    values = {c.type_code: read_text(c) for c in node.children or ()}
    return tuple(values.get(code, '') for code in AUX[section][2])


def _external_pid(library, pid: int) -> bool:
    raw = _all_bytes(library)
    return any(n in raw for n in (pid.to_bytes(8, 'little'), pid.to_bytes(8, 'big'),
                                  f'{pid:016X}'.encode(), f'{pid:016x}'.encode()))


def _gc(library, candidates: dict[int, int]) -> list[int]:
    removed = []
    for section, old_id in candidates.items():
        offset = 0xdc if section == 9 else 0x1e0
        if any(uint(t.node.header, offset) == old_id for t in library.tracks):
            continue
        node = _aux(library, section, old_id)
        pid = uint(node.header, 20, 8)
        library._root(section).children.remove(node)
        removed.append(pid)
    return removed


def _check_removed_references(library, pids) -> None:
    if any(_external_pid(library, pid) for pid in set(pids)):
        raise UnsupportedError('removed identities remain in opaque or unsupported dependency records')


def _updated_aux(library, section: int, old: Node, key: tuple, allocator: Allocator) -> int:
    if _text_key(old, section) == key:
        return uint(old.header, 16)
    if any(key):  # Native blank albums/artists are deliberately separate objects.
        for existing in library._records(section, AUX[section][0]):
            _aux_profile(existing, section)
            if _text_key(existing, section) == key:
                return uint(existing.header, 16)
    node = copy.deepcopy(old)
    local_id = allocator.local()
    put(node.header, 16, local_id); put(node.header, 20, allocator.persistent(), 8)
    for code, value in zip(AUX[section][2], key):
        if value:
            set_text(node, code, value)
        else:
            node.children = [c for c in node.children or () if c.type_code != code]
    put(node.header, 28, 2 | (0x10000 if section == 9 and not any(key) else 0))
    library._root(section).children.append(node)
    return local_id


def set_indexed_fields(library, persistent_id, fields) -> Track:
    candidate = copy.deepcopy(library)
    _profile(candidate)
    track = candidate.track(persistent_id=persistent_id)
    _wave(track)
    old_ids = {9: track.get('album_id'), 11: track.get('artist_id')}
    album, artist = _aux(candidate, 9, old_ids[9]), _aux(candidate, 11, old_ids[11])
    indexed = {k: v for k, v in fields.items() if k in ('album', 'artist', 'album_artist')}
    plain = {k: v for k, v in fields.items() if k not in indexed}
    track.set(**plain)
    for name, value in indexed.items():
        if not isinstance(value, str):
            raise ValueError('indexed text must be a string; use an empty string to clear it')
        set_text(track.node, {'album': 3, 'artist': 4, 'album_artist': 27}[name], value)
    album_name = track.get('album') or ''
    album_artist = track.get('album_artist') or ''
    artist_name = track.get('artist') or ''
    if uint(track.node.header, 0x50) & 0x01000000 and not album_artist:
        raise UnsupportedError('compilation grouping without an explicit album artist is unverified')
    effective_artist = album_artist or artist_name
    allocator = Allocator(candidate)
    put(track.node.header, 0xdc, _updated_aux(candidate, 9, album,
        (album_name, effective_artist, album_artist), allocator))
    put(track.node.header, 0x1e0, _updated_aux(candidate, 11, artist, (effective_artist,), allocator))
    removed = _gc(candidate, old_ids)
    _check_removed_references(candidate, removed)
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections
    return library.track(persistent_id=persistent_id)


def _import_aux(target, source, section: int, source_id: int, allocator: Allocator) -> int:
    original = _aux(source, section, source_id)
    pid = uint(original.header, 20, 8)
    for existing in target._records(section, AUX[section][0]):
        if uint(existing.header, 20, 8) != pid:
            continue
        _aux_profile(existing, section)
        left, right = copy.deepcopy(existing), copy.deepcopy(original)
        put(left.header, 16, 0); put(right.header, 16, 0)
        if left.to_bytes() != right.to_bytes():
            raise UnsupportedError('same album/artist persistent ID has conflicting content')
        return uint(existing.header, 16)
    allocator.persistent(pid)  # collision/ref guard across all existing bytes
    node = copy.deepcopy(original)
    local_id = allocator.local(); put(node.header, 16, local_id)
    target._root(section).children.append(node)
    return local_id


def _rule_signature(playlist) -> tuple:
    return tuple(c.to_bytes() for c in playlist.node.children or ()
                 if c.tag == b'mhoh' and c.type_code in (101, 102, 103))


def _check_item(node: Node) -> None:
    allowed = {0, 4, 8, 12, 16, 24, 32, 68, 72}
    if len(node.header) != 84 or node.children or node.payload:
        raise UnsupportedError('unknown playlist item dependencies')
    if any(uint(node.header, o) for o in range(0, 84, 4) if o not in allowed):
        raise UnsupportedError('playlist item has unknown nonzero state')


def add_track_from(library, source, persistent_id) -> Track:
    candidate = copy.deepcopy(library)
    _profile(candidate); _profile(source)
    if candidate.persistent_id != source.persistent_id:
        raise UnsupportedError('track restoration currently requires snapshots of the same library lineage')
    original = source.track(persistent_id=persistent_id)
    _wave(original)
    pid = original.persistent_id
    if any(t.persistent_id == pid for t in candidate.tracks):
        raise ValueError('track persistent ID already exists in the destination')
    allocator = Allocator(candidate)
    allocator.persistent(pid)
    album_id = _import_aux(candidate, source, 9, original.get('album_id'), allocator)
    artist_id = _import_aux(candidate, source, 11, original.get('artist_id'), allocator)
    node = copy.deepcopy(original.node)
    new_id = allocator.local(); put(node.header, 16, new_id)
    put(node.header, 0x1f4, allocator.local())
    put(node.header, 0xdc, album_id); put(node.header, 0x1e0, artist_id)
    candidate._root(1).children.append(node)
    donor_playlists = {p.persistent_id: p for p in source.playlists}
    for playlist in candidate.playlists:
        donor = donor_playlists.get(playlist.persistent_id)
        if donor is None:
            if playlist.is_smart or playlist.is_master:
                raise UnsupportedError('destination system/smart playlist has no matching donor definition')
            continue
        if _rule_signature(playlist) != _rule_signature(donor):
            raise UnsupportedError('source and destination playlist rules differ')
        for membership in donor.items:
            if uint(membership.header, 24) == original.track_id:
                _check_item(membership)
                playlist.node.children.append(_item(new_id, allocator))
    if not any(p.is_master and new_id in p.track_ids for p in candidate.playlists):
        raise UnsupportedError('restored track would not belong to the master playlist')
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections
    return library.track(persistent_id=pid)


def delete_track(library, persistent_id) -> None:
    candidate = copy.deepcopy(library)
    _profile(candidate)
    track = candidate.track(persistent_id=persistent_id)
    _wave(track)
    old_ids = {9: track.get('album_id'), 11: track.get('artist_id')}
    for section, old in old_ids.items():
        _aux(candidate, section, old)
    removed_pids = [track.persistent_id]
    for playlist in candidate.playlists:
        children = []
        for node in playlist.node.children or ():
            if node.tag == b'mtph' and uint(node.header, 24) == track.track_id:
                _check_item(node)
                removed_pids.append(uint(node.header, 68, 8))
            else:
                children.append(node)
        playlist.node.children = children
    candidate._root(1).children.remove(track.node)
    removed_pids.extend(_gc(candidate, old_ids))
    _check_removed_references(candidate, removed_pids)
    candidate.to_bytes()
    library.container, library.sections = candidate.container, candidate.sections