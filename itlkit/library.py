"""Conservative semantic view over the reversible record tree.

Only named, understood operations are allowed. Raw bytes are exposed for research,
not as a promise that unknown fields may be edited safely.
"""
from __future__ import annotations
from pathlib import Path
import copy
from datetime import datetime, timedelta, timezone
from .binary import uint, put
from .container import Container
from .model import Node, parse_sections, serialize_sections
from .errors import FormatError, UnsupportedError

TEXT_FIELDS = {'name': 2, 'album': 3, 'artist': 4, 'genre': 5, 'kind': 6,
               'comment': 8, 'url': 11, 'composer': 12, 'path': 13,
               'album_artist': 27, 'sort_name': 30, 'sort_album': 31,
               'sort_artist': 32, 'sort_album_artist': 33, 'purchaser_name': 60}
NUMBER_FIELDS = {
    'track_id': (0x10, 4), 'record_kind_raw': (0x14, 4),
    'date_modified': (0x20, 4), 'file_size': (0x24, 4), 'total_time': (0x28, 4),
    'track_number': (0x2c, 4), 'track_count': (0x30, 4), 'year': (0x34, 4),
    'bit_rate': (0x38, 4), 'play_count': (0x4c, 4), 'play_date': (0x64, 4),
    'disc_number': (0x68, 2), 'disc_count': (0x6a, 2), 'rating': (0x6c, 1),
    'name_refresh_flag_raw': (0x6d, 1), 'played_flag_raw': (0xee, 1),
    'rating_aux_raw': (0x6d, 1), 'play_count_aux_raw': (0x60, 4), 'skip_count_aux_raw': (0x118, 4),
    'date_added': (0x78, 4), 'persistent_id': (0x80, 8), 'skip_count': (0xd8, 4),
    'album_id': (0xdc, 4), 'skip_date': (0x11c, 4), 'artist_id': (0x1e0, 4),
    'sample_rate': (0xf4, 4)}
READ_ONLY_FIELDS = {'track_id', 'persistent_id', 'album_id', 'artist_id', 'record_kind_raw',
                    'name_refresh_flag_raw', 'played_flag_raw',
                    'rating_aux_raw', 'play_count_aux_raw', 'skip_count_aux_raw', 'purchaser_name', 'kind', 'sample_rate'}
INDEXED_TEXT_FIELDS = {'album', 'artist', 'album_artist'}
# Encoding 2 is restricted below to the observed ASCII URL subset.
ENCODINGS = {1: 'utf-16-le', 2: 'ascii', 3: 'latin-1'}
DIRECT_PAYLOAD_TYPES = {1, 0x13, 0x42}
HFS_EPOCH_DELTA = 2082844800


def hfs_from_datetime(value: datetime) -> int:
    """Encode the displayed local wall time, with an explicit aware datetime."""
    if value.tzinfo is None or value.utcoffset() is None:
        raise ValueError('an aware datetime is required; timezone is never guessed')
    # Encode local wall time by arithmetic, independent of platform timestamps.
    delta = value.replace(tzinfo=None) - datetime(1904, 1, 1)
    # Check the signed wall-time interval BEFORE discarding fractional seconds.
    # int(negative_fraction) would silently turn an invalid date into raw0/unset.
    if not timedelta(0) <= delta < timedelta(seconds=2**32):
        raise ValueError('datetime is outside the HFS uint32 range')
    return delta.days * 86400 + delta.seconds


def hfs_to_datetime(value: int, *, utc_offset_seconds: int) -> datetime | None:
    """Decode with a caller-provided offset; zero is the unset sentinel."""
    if type(value) is not int or not 0 <= value < 2**32:
        raise ValueError('HFS timestamp must be a uint32')
    if value == 0:
        return None
    tz = timezone(timedelta(seconds=utc_offset_seconds))
    return datetime(1904, 1, 1, tzinfo=tz) + timedelta(seconds=value)


def text_nodes(parent: Node, code: int) -> list[Node]:
    return [c for c in parent.children or () if c.tag == b'mhoh' and c.type_code == code]


def read_text(node: Node) -> str:
    if node.tag != b'mhoh' or node.children is not None or len(node.payload) < 16:
        raise UnsupportedError('record does not have a known string payload')
    if node.type_code in DIRECT_PAYLOAD_TYPES:
        raise UnsupportedError('direct binary mhoh payload does not use the text prefix')
    encoding, length = uint(node.payload, 0), uint(node.payload, 4)
    if encoding not in ENCODINGS:
        raise UnsupportedError(f'unknown string encoding {encoding}')
    if length > len(node.payload) - 16:
        raise FormatError('string length exceeds mhoh payload', node.offset)
    if encoding == 2 and (node.type_code != 11 or not node.payload[16:16 + length].isascii()):
        raise UnsupportedError('encoding 2 is only provisionally interpreted for observed ASCII URL objects; other bytes remain opaque')
    try:
        return node.payload[16:16 + length].decode(ENCODINGS[encoding], errors='strict')
    except UnicodeDecodeError as exc:
        raise FormatError(f'invalid {ENCODINGS[encoding]} string', node.offset) from exc


def set_text(parent: Node, code: int, value: str) -> None:
    if not isinstance(value, str) or '\x00' in value:
        raise ValueError('text must be a string without embedded NUL characters')
    if code in DIRECT_PAYLOAD_TYPES:
        raise UnsupportedError('direct binary mhoh types cannot be written as text')
    nodes = text_nodes(parent, code)
    if len(nodes) > 1:
        raise UnsupportedError('ambiguous duplicate string fields')
    if parent.children is None:
        raise UnsupportedError('cannot append a string to an opaque parent')
    if nodes:
        node = nodes[0]
        if len(node.header) != 24:
            raise UnsupportedError('unverified mhoh header layout')
        read_text(node)  # refuses undecodable/unknown string representations
        old_length = uint(node.payload, 4)
        encoding = uint(node.payload, 0)
        suffix = node.payload[16 + old_length:]
        prefix_bytes = bytearray(node.payload[:16])
    else:
        h = bytearray(24)
        h[:4] = b'mhoh'; put(h, 4, 24); put(h, 8, 40); put(h, 12, code)
        node = Node(h)
        old_length, suffix, prefix_bytes, encoding = 0, b'', bytearray(16), 3
    if code == 11:
        encoding = 2  # Provisional observed ASCII/percent-encoded URL profile only.
    elif any(ord(ch) > 127 for ch in value):
        encoding = 1
    try:
        data = value.encode(ENCODINGS[encoding], errors='strict')
    except UnicodeEncodeError as exc:
        raise ValueError('URL must be ASCII/percent-encoded') from exc
    if suffix and len(data) != old_length:
        raise UnsupportedError('cannot resize a string with an unknown trailing suffix')
    put(prefix_bytes, 0, encoding); put(prefix_bytes, 4, len(data))
    node.payload = bytes(prefix_bytes) + data + suffix
    if not nodes:
        # Keep all mhoh metadata before item records.
        index = next((i for i, c in enumerate(parent.children) if c.tag != b'mhoh'), len(parent.children))
        parent.children.insert(index, node)


def _parse_pid(value) -> int:
    if isinstance(value, str):
        text = value[2:] if value.startswith(('0x', '0X')) else value
        if len(text) != 16 or any(c not in '0123456789abcdefABCDEF' for c in text):
            raise ValueError('persistent ID must contain exactly 16 hexadecimal digits')
        value = int(text, 16)
    if type(value) is not int or not 0 < value < 2**64:
        raise ValueError('persistent ID must be a nonzero uint64')
    return value


class Track:
    def __init__(self, library: Library, node: Node):
        self.library, self.node = library, node

    @property
    def track_id(self) -> int:
        return uint(self.node.header, 0x10)

    @property
    def persistent_id(self) -> int:
        return uint(self.node.header, 0x80, 8)

    def get(self, field: str):
        if field in NUMBER_FIELDS:
            return uint(self.node.header, *NUMBER_FIELDS[field])
        if field == 'loved':
            return bool(uint(self.node.header, 0x2bf, 1) & 0x02)  # legacy 'loved' label; UI semantics not fully verified
        if field == 'unplayed':
            if self.library.container.version != '12.13.10.3' or len(self.node.header) != 756:
                raise UnsupportedError('Unplayed is verified only for the 12.13.10.3 mith profile')
            return not bool(uint(self.node.header, 0xee, 1) & 1)
        if field == 'compilation':
            return bool(uint(self.node.header, 0x50) & 0x01000000)
        if field in TEXT_FIELDS:
            nodes = text_nodes(self.node, TEXT_FIELDS[field])
            if len(nodes) > 1:
                raise UnsupportedError(f'duplicate text field {field}')
            return read_text(nodes[0]) if nodes else None
        raise UnsupportedError(f'unknown track field: {field}')

    def set(self, **fields) -> None:
        if not any(n is self.node for n in self.library._records(1, b'mith')):
            raise ValueError('stale track handle; reselect by persistent ID after a library transaction')
        self.library._require_semantic_profile()
        for name in ('url', 'path'):
            if name in fields and fields[name] != self.get(name) and any(
                    c.tag == b'mhoh' and c.type_code == 1 for c in self.node.children or ()):
                raise UnsupportedError('relocation requires updating the opaque file-location object; refusing a URL/path-only change')
        if any(name in INDEXED_TEXT_FIELDS for name in fields):
            from .trackops import set_indexed_fields
            updated = set_indexed_fields(self.library, self.persistent_id, fields)
            self.node = updated.node
            return
        if len(self.node.header) != 756:
            raise UnsupportedError('track writes require the observed 756-byte mith profile')
        from .atoms import guard_text_changes
        guard_text_changes(self.library, [(self.node, TEXT_FIELDS[k], v) for k, v in fields.items()
                                          if k in TEXT_FIELDS and k not in READ_ONLY_FIELDS])
        candidate = copy.deepcopy(self.node)
        for field, value in fields.items():
            if field in READ_ONLY_FIELDS:
                raise UnsupportedError(f'{field} is read-only (identity/derived/provenance field)')
            if field in INDEXED_TEXT_FIELDS:
                raise UnsupportedError(f'{field} changes require unresolved album/artist index maintenance')
            if field in TEXT_FIELDS:
                set_text(candidate, TEXT_FIELDS[field], value)
                if (field == 'name' and value and value != self.get('name')
                        and self.library.container.version == '12.13.10.3'):
                    # Wire6d bit0 -> common9a bit4 (path/default-title refresh).
                    # Native factorial A-only preserves Name through two saves.
                    # Do not rename it RatingKind or Unplayed, reset all ranks,
                    # renumber atoms, or erase unverified upper bits.
                    candidate.header[0x6d] &= 0xfe
            elif field == 'unplayed':
                if type(value) is not bool:
                    raise ValueError('unplayed must be true or false')
                if self.library.container.version != '12.13.10.3':
                    raise UnsupportedError('Unplayed writes require the 12.13.10.3 profile')
                flags = uint(candidate.header, 0xee, 1)
                put(candidate.header, 0xee, flags & 0xfe if value else flags | 1, 1)
            elif field == 'loved':
                if type(value) is not bool:
                    raise ValueError('loved must be true or false')
                flags = uint(candidate.header, 0x2bf, 1)
                put(candidate.header, 0x2bf, flags | 0x02 if value else flags & ~0x02, 1)
            elif field in NUMBER_FIELDS:
                if field == 'rating' and (type(value) is not int or not 0 <= value <= 100):
                    raise ValueError('rating must be an integer from 0 to 100')
                off, size = NUMBER_FIELDS[field]
                put(candidate.header, off, value, size)
                # Native COM writes prove +0x60/+0x118 are NOT unconditional mirrors.
                # Preserve those unknown counters rather than corrupt their independent state.
            else:
                raise UnsupportedError(f'unknown track field: {field}')
        self.node.header, self.node.children, self.node.payload = candidate.header, candidate.children, candidate.payload

    def to_dict(self) -> dict:
        result = {}
        for field in [*NUMBER_FIELDS, *TEXT_FIELDS, 'loved', 'compilation', 'unplayed']:
            try:
                value = self.get(field)
            except (FormatError, UnsupportedError) as exc:
                result.setdefault('field_errors', {})[field] = str(exc)
                continue
            result[field] = f'{value:016X}' if field == 'persistent_id' else value
        return result


class Playlist:
    def __init__(self, library: Library, node: Node):
        self.library, self.node = library, node

    @property
    def persistent_id(self) -> int:
        return uint(self.node.header, 0x1b8, 8)

    @property
    def playlist_id(self) -> int:
        return uint(self.node.header, 0xd40)

    @property
    def name(self) -> str | None:
        nodes = text_nodes(self.node, 100)
        if len(nodes) > 1:
            raise UnsupportedError('duplicate playlist title')
        return read_text(nodes[0]) if nodes else None

    @property
    def items(self) -> list[Node]:
        return [c for c in self.node.children or () if c.tag == b'mtph']

    @property
    def track_ids(self) -> list[int]:
        return [uint(c.header, 0x18) for c in self.items]

    @property
    def is_master(self) -> bool:
        return bool(uint(self.node.header, 0x14) & 0x10000)

    @property
    def is_smart(self) -> bool:
        return any(c.type_code in (101, 102) for c in self.node.children or () if c.tag == b'mhoh')

    @property
    def smart_definition(self):
        """Lossless type-101/102 AST, or ``None`` for a non-smart playlist."""
        from .smart import parse_playlist_smart
        return parse_playlist_smart(self.node)

    @property
    def is_plain(self) -> bool:
        return (len(self.node.header) == 3500 and not self.is_master and not self.is_smart
                and uint(self.node.header, 0x238) == 0
                and not any(c.type_code == 103 for c in self.node.children or () if c.tag == b'mhoh'))

    def rename(self, name: str) -> None:
        if not any(n is self.node for n in self.library._records(2, b'miph')):
            raise ValueError('stale playlist handle; reselect after a library transaction')
        self.library._require_semantic_profile()
        if not self.is_plain:
            raise UnsupportedError('only ordinary, non-system, non-smart playlists may be renamed')
        candidate = copy.deepcopy(self.node)
        set_text(candidate, 100, name)
        self.node.header, self.node.children = candidate.header, candidate.children

    def replace_members(self, track_persistent_ids) -> None:
        if not any(n is self.node for n in self.library._records(2, b'miph')):
            raise ValueError('stale playlist handle; reselect after a library transaction')
        from .operations import replace_playlist_members
        current = replace_playlist_members(self.library, self.persistent_id, track_persistent_ids)
        self.node = current.node

    def to_dict(self) -> dict:
        result = {'name': self.name, 'track_ids': self.track_ids}
        for name in ('persistent_id', 'playlist_id', 'is_master', 'is_smart', 'is_plain'):
            try:
                value = getattr(self, name)
                result[name] = f'{value:016X}' if name == 'persistent_id' else value
            except FormatError as exc:
                result.setdefault('field_errors', {})[name] = str(exc)
        result['item_persistent_ids'] = [f'{uint(n.header, 0x44, 8):016X}' if len(n.header) >= 0x4c else None for n in self.items]
        return result


class Library:
    def __init__(self, container: Container):
        self.container = container
        self._require_little_endian()
        self.sections = parse_sections(container.payload)
        self._validate()

    @classmethod
    def from_bytes(cls, data: bytes, **kwargs) -> Library:
        return cls(Container.from_bytes(data, **kwargs))

    @classmethod
    def read(cls, path: str | Path, **kwargs) -> Library:
        return cls.from_bytes(Path(path).read_bytes(), **kwargs)

    def _root(self, section_type: int) -> Node | None:
        nodes = [s for s in self.sections if s.section_type == section_type]
        if len(nodes) > 1:
            raise FormatError(f'duplicate section type {section_type}')
        if not nodes:
            return None
        return nodes[0].children[0] if nodes[0].children else None

    def _records(self, section_type: int, tag: bytes) -> list[Node]:
        root = self._root(section_type)
        return [c for c in root.children or () if c.tag == tag] if root else []

    @property
    def tracks(self) -> list[Track]:
        return [Track(self, n) for n in self._records(1, b'mith')]

    @property
    def playlists(self) -> list[Playlist]:
        return [Playlist(self, n) for n in self._records(2, b'miph')]

    @property
    def persistent_id(self) -> int:
        return uint(self.container.header, 0x34, 8, endian='big')

    def track(self, *, track_id: int | None = None, persistent_id: int | str | None = None) -> Track:
        if (track_id is None) == (persistent_id is None):
            raise ValueError('supply exactly one track_id or persistent_id')
        if track_id is not None and (type(track_id) is not int or not 0 < track_id < 2**32):
            raise ValueError('track_id must be a nonzero uint32')
        if persistent_id is not None:
            persistent_id = _parse_pid(persistent_id)
        matches = [t for t in self.tracks if (t.track_id == track_id if track_id is not None else t.persistent_id == persistent_id)]
        if len(matches) != 1:
            raise ValueError(f'track selector matched {len(matches)} records')
        return matches[0]

    def playlist(self, persistent_id: int | str) -> Playlist:
        persistent_id = _parse_pid(persistent_id)
        matches = [p for p in self.playlists if p.persistent_id == persistent_id]
        if len(matches) != 1:
            raise ValueError(f'playlist selector matched {len(matches)} records')
        return matches[0]

    def add_track_from(self, source: Library, persistent_id) -> Track:
        from .trackops import add_track_from
        return add_track_from(self, source, persistent_id)

    def delete_track(self, persistent_id) -> None:
        from .trackops import delete_track
        delete_track(self, persistent_id)

    def create_playlist(self, name: str, **kwargs) -> Playlist:
        from .operations import create_playlist
        return create_playlist(self, name, **kwargs)

    def delete_playlist(self, persistent_id) -> None:
        from .operations import delete_playlist
        delete_playlist(self, persistent_id)

    def replace_playlist_members(self, persistent_id, track_persistent_ids) -> Playlist:
        from .operations import replace_playlist_members
        return replace_playlist_members(self, persistent_id, track_persistent_ids)

    def _counts(self) -> dict[int, int]:
        return {0x44: len(self.tracks), 0x48: len(self.playlists),
                0x4c: len(self._records(9, b'miah')), 0x54: len(self._records(11, b'miih'))}

    def _validate(self) -> None:
        self._require_little_endian()
        mfdh = self._root(16)
        if not mfdh:
            raise FormatError('missing main mfdh section')
        if uint(mfdh.header, 8) != len(self.container.payload) + len(self.container.header):
            raise FormatError('mfdh logical size differs from payload + outer header', mfdh.offset)
        if uint(self.container.header, 0x30, endian='big') != len(self.sections):
            raise FormatError('hdfm section count mismatch', 0x30)
        if uint(mfdh.header, 0x30) != len(self.sections):
            raise FormatError('mfdh section count mismatch', mfdh.offset)
        for offset, expected in self._counts().items():
            if uint(mfdh.header, offset) != expected or uint(self.container.header, offset, endian='big') != expected:
                raise FormatError(f'library count mismatch at header +0x{offset:x}')
        self._validate_ids_and_refs()

    def _validate_ids_and_refs(self) -> None:
        tracks = self.tracks
        ids = [t.track_id for t in tracks]
        pids = [t.persistent_id for t in tracks]
        if len(ids) != len(set(ids)) or len(pids) != len(set(pids)) or 0 in ids or 0 in pids:
            raise FormatError('zero or duplicate track identity')
        def unique_nonzero(values, label):
            if 0 in values or len(values) != len(set(values)):
                raise FormatError(f'zero or duplicate {label}')
        # These independent namespaces are modeled only at the observed sizes.
        unique_nonzero([uint(t.node.header, 0x1f4) for t in tracks
                        if len(t.node.header) == 756], 'secondary track ID')
        known = set(ids)
        for section, tag, offset in ((9, b'miah', 0xdc), (11, b'miih', 0x1e0)):
            records = self._records(section, tag)
            local_ids = [uint(n.header, 16) for n in records]
            size = 88 if section == 9 else 100
            unique_nonzero([uint(n.header, 20, 8) for n in records if len(n.header) == size],
                           'album/artist persistent ID')
            if len(local_ids) != len(set(local_ids)) or 0 in local_ids:
                raise FormatError('zero or duplicate album/artist local ID')
            if any(uint(t.node.header, offset) not in set(local_ids) | {0} for t in tracks):
                raise FormatError('track references a missing album/artist object')
        playlist_pids = []
        unique_nonzero([p.playlist_id for p in self.playlists if len(p.node.header) == 3500],
                       'playlist local ID')
        for playlist in self.playlists:
            items = [n for n in playlist.items if len(n.header) == 84]
            unique_nonzero([uint(n.header, 16) for n in items], 'item local ID within playlist')
            unique_nonzero([uint(n.header, 68, 8) for n in items], 'item persistent ID within playlist')
            if len(playlist.node.header) >= 0x1c0:
                playlist_pids.append(playlist.persistent_id)
            for track_id in playlist.track_ids:
                if track_id not in known:
                    raise FormatError(f'playlist references missing track {track_id}', playlist.node.offset)
        if len(playlist_pids) != len(set(playlist_pids)) or 0 in playlist_pids:
            raise FormatError('zero or duplicate playlist persistent ID')

    def _require_little_endian(self) -> None:
        self.container.validate_header()
        if self.container.payload_byteorder != 'little':
            raise UnsupportedError('Library supports little-endian payloads only; use Container for opaque big-endian preservation')

    def _require_semantic_profile(self) -> None:
        self._require_little_endian()
        self._validate_ids_and_refs()
        if self.container.version not in ('12.13.9.1', '12.13.10.3') or len(self.container.header) != 144:
            raise UnsupportedError('writes require the observed Windows iTunes 12.13.9.1/12.13.10.3 profile')
        if self.container.trailer:
            raise UnsupportedError('semantic writes with an unknown compression trailer are unsafe')

    def _sync(self) -> bytes:
        mfdh = self._root(16)
        if not mfdh:
            raise FormatError('cannot serialize a library without mfdh')
        header = bytearray(self.container.header)
        put(mfdh.header, 0x30, len(self.sections))
        put(header, 0x30, len(self.sections), endian='big')
        for offset, value in self._counts().items():
            put(mfdh.header, offset, value)
            put(header, offset, value, endian='big')
        self.container.header = bytes(header)
        payload = serialize_sections(self.sections)
        put(mfdh.header, 8, len(payload) + len(header))
        return serialize_sections(self.sections)

    def to_bytes(self, *, rebuild: bool = False, compression_level: int = 6) -> bytes:
        self._require_little_endian()
        self._validate_ids_and_refs()
        payload = serialize_sections(self.sections)
        if payload != self.container.payload:
            payload = self._sync()
        self.container.payload = payload
        data = self.container.to_bytes(rebuild=rebuild, compression_level=compression_level)
        # Validate reconstructed framing, derived counts and references, not just zlib.
        Library.from_bytes(data)
        return data

    def write(self, path: str | Path, **kwargs) -> None:
        from .io import write_new
        write_new(Path(path), self.to_bytes(**kwargs))

    def summary(self) -> dict:
        masters = [p for p in self.playlists if p.is_master]
        return {'version': self.container.version, 'file_persistent_id': f'{self.persistent_id:016X}',
                'library_persistent_id': f'{masters[0].persistent_id:016X}' if len(masters) == 1 else None,
                'sections': [{'type': s.section_type, 'offset': s.offset, 'size': len(s.to_bytes()),
                              'opaque': s.children is None} for s in self.sections],
                'tracks': [t.to_dict() for t in self.tracks], 'playlists': [p.to_dict() for p in self.playlists]}

    def to_dict(self) -> dict:
        # Export current state with a correct baseline (still exact for untouched input).
        current = Library.from_bytes(self.to_bytes())
        return {'schema': 'itlkit.library.v1', 'container': current.container.to_dict(),
                'sections': [s.to_dict() for s in current.sections], 'operations': []}

    @classmethod
    def from_dict(cls, value: dict) -> Library:
        if not isinstance(value, dict) or value.get('schema') != 'itlkit.library.v1':
            raise FormatError('unsupported library JSON schema')
        try:
            container = Container.from_dict(value['container'])
            if not container.unchanged:
                raise UnsupportedError('library JSON requires an intact original baseline; raw edits belong to the low-level container API')
            lib = cls(container)
            proposed = serialize_sections([Node.from_dict(s) for s in value['sections']])
            if proposed != container.payload:
                raise UnsupportedError('raw tree edits are not accepted; use the operations array or the low-level container API')
            lib.apply_operations(value.get('operations', []))
            return lib
        except (KeyError, TypeError) as exc:
            raise FormatError(f'invalid library JSON: {exc}') from exc

    def apply_operations(self, operations: list[dict]) -> None:
        if not isinstance(operations, list):
            raise ValueError('operations must be a list')
        # Transactional: no partial mutation if a later operation is rejected.
        candidate = copy.deepcopy(self)
        allowed = {
            'set_track': {'op', 'track_id', 'persistent_id', 'fields'},
            'rename_playlist': {'op', 'persistent_id', 'name'},
            'create_playlist': {'op', 'name', 'persistent_id', 'track_persistent_ids', 'template_persistent_id', 'timestamp_hfs'},
            'delete_playlist': {'op', 'persistent_id'},
            'replace_playlist_members': {'op', 'persistent_id', 'track_persistent_ids'},
            'delete_track': {'op', 'persistent_id'},
        }
        for operation in operations:
            if not isinstance(operation, dict):
                raise ValueError('each operation must be an object')
            action = operation.get('op')
            if not isinstance(action, str) or action not in allowed:
                raise UnsupportedError(f'unsupported operation: {action}')
            if set(operation) - allowed[action]:
                raise ValueError(f'unrecognized {action} key')
            if action == 'set_track':
                if not isinstance(operation.get('fields'), dict):
                    raise ValueError('set_track requires a fields object')
                if set(operation) - {'op', 'track_id', 'persistent_id', 'fields'}:
                    raise ValueError('unrecognized set_track key')
                candidate.track(track_id=operation.get('track_id'), persistent_id=operation.get('persistent_id')).set(**operation['fields'])
            elif action == 'delete_track':
                candidate.delete_track(operation['persistent_id'])
            elif action == 'rename_playlist':
                candidate.playlist(operation['persistent_id']).rename(operation['name'])
            elif action == 'create_playlist':
                candidate.create_playlist(operation['name'], track_persistent_ids=operation.get('track_persistent_ids', []),
                                          persistent_id=operation.get('persistent_id'),
                                          template_persistent_id=operation.get('template_persistent_id'),
                                          timestamp_hfs=operation.get('timestamp_hfs'))
            elif action == 'delete_playlist':
                candidate.delete_playlist(operation['persistent_id'])
            elif action == 'replace_playlist_members':
                candidate.replace_playlist_members(operation['persistent_id'], operation['track_persistent_ids'])
            else:
                raise UnsupportedError(f'unsupported operation: {action}')
        candidate.to_bytes()
        self.container, self.sections = candidate.container, candidate.sections