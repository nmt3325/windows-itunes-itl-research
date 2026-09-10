"""Additive, side-effect-free cross-library import building blocks.

The early checkpoint exposes a structured BLOCKED prepare result until the
parent-pinned planning/identity APIs and remaining semantic proofs are integrated.
Private structural assembly is not semantic admission or a native-qualified importer.
No native automation, media IO, fixture digests, environment paths or legacy bypass.
"""
from __future__ import annotations

from collections import Counter
from copy import deepcopy
from dataclasses import dataclass, replace, field
from datetime import datetime
import hashlib
import importlib.util
import json
import re
import sys
import xml.etree.ElementTree as ET

from .binary import uint, put
from .container import Container
from .errors import ITLError
from .library import Library, read_text
from .model import serialize_sections
from .schema import (ReadLimits, LimitError, get_limits, load_container,
                     preflight_payload, encode_json)
from .operations import require_plain
from .trackops import _profile, _aux, _check_item, _rule_signature

SECTIONS = (16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4)
ENROLL_ROLES = ('master', 'downloaded_music', 'music')
SYSTEM_KINDS = {
    1024: 'music', 16640: 'downloaded_music', 12032: 'music_videos',
    16384: 'tv_movies', 1792: 'rentals', 16896: 'downloaded_video',
    512: 'movies', 12288: 'home_videos', 17152: 'downloaded_tv',
    768: 'tv', 2561: 'podcasts', 1280: 'audiobooks', 6656: 'genius',
}
_POOLS = {}
for _tag, _codes, _pool in (
    (b'mith', (2,), 'name'), (b'mith', (3,), 'album'),
    (b'miah', (300,), 'album'), (b'mith', (4, 12, 27), 'artist'),
    (b'miah', (301, 302), 'artist'), (b'miih', (400,), 'artist'),
    (b'mith', (5,), 'genre'), (b'mith', (6,), 'kind'),
    (b'mith', (8,), 'comment'), (b'mith', (30,), 'sort_name'),
    (b'mith', (31,), 'sort_album'), (b'mith', (32, 33), 'sort_artist'),
):
    for _code in _codes:
        _POOLS[_tag, _code] = _pool
_DEFAULTS = {
    'max_file_bytes': 16 * 1024**2, 'max_plain_bytes': 16 * 1024**2,
    'max_nodes': 100000, 'max_depth': 32, 'max_text_bytes': 4 * 1024**2,
    'max_json_bytes': 64 * 1024**2, 'memory_budget_bytes': 512 * 1024**2,
}
_LOCAL_CAP = 1000000
_ATOM_CAP = 65535


class ImportRefusal(ITLError):
    """A concrete, non-recoverable admission/transform blocker."""
    def __init__(self, code, detail=''):
        self.code = str(code)
        self.detail = str(detail)
        super().__init__(self.code + (': ' + self.detail if self.detail else ''))


def _require(condition, code, detail=''):
    if not condition:
        raise ImportRefusal(code, detail)


def _normal_python():
    _require(not sys.flags.optimize and __debug__, 'OPTIMIZED_PYTHON_REFUSED')


def _sha(data):
    return hashlib.sha256(data).hexdigest()


def _hx(value):
    return f'{value:016X}'


def _limits(limits=None):
    # Canonical, parent-pinned type for defaults AND explicit reductions.
    _require(limits is None or type(limits) is ReadLimits, 'INVALID_LIMITS_TYPE')
    caps = get_limits(limits)
    for key, maximum in _DEFAULTS.items():
        value = getattr(caps, key)
        _require(type(value) is int and 0 < value <= maximum,
                 'LIMIT_OUTSIDE_INITIAL_ENGINE_CAP', key)
    return caps


_SEED_DOMAIN = b'itlkit.cross-import.seed.v1\x00'


def encode_seed(seed=None):
    """Explicit deterministic bytes protocol, not repr(), hash(), or an allocator.

    SHA256(domain || 00) for None; SHA256(domain || 01 || uint32be(len(UTF8))
    || strict UTF8) for a string. No Unicode normalization. No ID reservation.
    """
    _require(seed is None or (type(seed) is str and 0 < len(seed) <= 128),
             'INVALID_SEED')
    if seed is None:
        return hashlib.sha256(_SEED_DOMAIN + b'\x00').digest()
    try:
        data = seed.encode('utf-8', errors='strict')
    except UnicodeEncodeError as exc:
        raise ImportRefusal('INVALID_SEED_UTF8') from exc
    return hashlib.sha256(_SEED_DOMAIN + b'\x01' +
                          len(data).to_bytes(4, 'big') + data).digest()


def _pid_list(values):
    _require(type(values) in (list, tuple) and 0 < len(values) <= 128,
             'INVALID_SELECTION')
    result = []
    for value in values:
        _require(type(value) is str and re.fullmatch('[0-9a-fA-F]{16}', value)
                 and int(value, 16) != 0, 'INVALID_TRACK_PID')
        result.append(int(value, 16))
    _require(len(result) == len(set(result)), 'DUPLICATE_SELECTION')
    return tuple(result)


def _json_bytes(value, cap, *, limits=None, resident_bytes=0):
    """Canonical bounded JSON, including coexistence with input/model estimates."""
    caps = _limits(limits)
    _require(type(cap) is int and 0 < cap <= caps.max_json_bytes,
             'JSON_AGGREGATE_BUDGET')
    _require(type(resident_bytes) is int and resident_bytes >= 0,
             'INVALID_RESIDENT_ESTIMATE')
    caps.check('memory', resident_bytes + 8)
    remaining = caps.memory_budget_bytes - resident_bytes
    json_caps = replace(caps, max_json_bytes=min(cap, remaining // 8),
                        memory_budget_bytes=remaining)
    try:
        return encode_json(value, limits=json_caps)
    except LimitError as exc:
        raise ImportRefusal('JSON_AGGREGATE_BUDGET', str(exc)) from exc


def _preflight_inputs(snapshots, limits):
    """Bound all decoded inputs BEFORE constructing ANY Library/Node model.

    File cap is per input; plain/nodes/text are aggregate across this operation.
    A conservative coexistence estimate reserves all inputs, nested parser copies,
    models and diagnostic working space. Remaining memory shrinks the actual zlib
    output ceiling before decoding, not after allocating a too-large payload.
    Unknown bytes are never searched for tags. These are not OS RSS promises.
    """
    _normal_python()
    caps = _limits(limits)
    _require(type(snapshots) is tuple and 0 < len(snapshots) <= 3,
             'INVALID_SNAPSHOT_SET')
    for data in snapshots:
        _require(type(data) is bytes and 0 < len(data) <= caps.max_file_bytes,
                 'FILE_BUDGET_OR_TYPE')
    file_bytes = sum(map(len, snapshots))
    fixed = file_bytes * 12
    caps.check('memory', fixed)  # Before Container.from_bytes or AES/zlib.
    factor = caps.max_depth + 16
    plain_bytes = nodes = text_bytes = 0
    containers = []; statistics = []
    estimate = fixed
    for data in snapshots:
        caps.check('plain', plain_bytes + 1)
        caps.check('memory', estimate + factor * 2)
        ceiling = min(caps.max_plain_bytes - plain_bytes,
                      (caps.memory_budget_bytes - estimate) // factor - 1)
        # +1 decoder sentinel is covered; canonical caps never grow.
        local_caps = replace(caps, max_plain_bytes=ceiling)
        container = load_container(data, limits=local_caps)
        _require(container.payload_byteorder == 'little', 'UNSUPPORTED_PAYLOAD_ENDIAN')
        _require(not container.trailer, 'UNKNOWN_COMPRESSION_TRAILER')
        stats = preflight_payload(container.payload, limits=local_caps)
        plain_bytes += stats['plain_bytes']; nodes += stats['nodes']
        text_bytes += stats['text_bytes']
        caps.check('plain', plain_bytes); caps.check('nodes', nodes)
        caps.check('text', text_bytes)
        estimate = fixed + factor * plain_bytes + nodes * 6144 + text_bytes * 8
        caps.check('memory', estimate)
        containers.append(container); statistics.append(stats)
    return tuple(containers), tuple(statistics), estimate


def _library_from_preflight(container):
    # Called only after every input passed aggregate framing/resource admission.
    lib = Library(container)
    _profile(lib)
    _require(tuple(s.section_type for s in lib.sections) == SECTIONS,
             'UNKNOWN_SECTION_PROFILE')
    _require(lib.persistent_id and uint(lib._root(16).header, 0x34, 8)
             == lib.persistent_id, 'FILE_PID_MISMATCH')
    # Do not normalize/reparse with Library.to_bytes(), even for input hashing.
    _require(serialize_sections(lib.sections) == container.payload,
             'LOSSLESS_INPUT_REQUIRED')
    return lib


def _parse(data, limits=None):
    containers, _, _ = _preflight_inputs((data,), _limits(limits))
    return _library_from_preflight(containers[0])


def role_catalog(lib, *, target=False):
    """Classify by structural role, not localized name, PID or input track count.

    Source nonselected media are not required to be WAV or copied. Target initial
    admission requires complete music/downloaded membership and empty other roles.
    Classification alone does not prove arbitrary smart-rule evaluation.
    """
    roles = {}
    ordinary = []
    for playlist in lib.playlists:
        header = playlist.node.header
        codes = [c.type_code for c in playlist.node.children or () if c.tag == b'mhoh']
        if playlist.is_master:
            _require(uint(header, 0x238) == 0, 'MASTER_KIND_CONFLICT')
            role = 'master'
        elif playlist.is_plain:
            require_plain(playlist)
            ordinary.append(playlist)
            continue
        else:
            kind = uint(header, 0x238)
            _require(kind in SYSTEM_KINDS, 'UNKNOWN_PLAYLIST_ROLE', kind)
            role = SYSTEM_KINDS[kind]
        _require(role not in roles, 'DUPLICATE_PLAYLIST_ROLE', role)
        flags = {'rentals': 65584, 'podcasts': 65568, 'tv': 65574,
                 'downloaded_tv': 65574, 'movies': 65541,
                 'home_videos': 65541, 'downloaded_video': 65541}.get(role, 65543)
        _require(uint(header, 0x18) == flags, 'UNKNOWN_ROLE_FLAGS', role)
        expected = {
            'master': [100, 105, 105, 108],
            'downloaded_music': [100, 102, 101, 105, 105, 108],
            'music': [100, 102, 101, 105, 105, 108, 109],
            'podcasts': [100, 103, 105, 105, 108, 109],
        }.get(role, [100, 102, 101, 105, 105, 108])
        _require(codes == expected, 'UNKNOWN_ROLE_CHILD_SEQUENCE', role)
        if target and role not in ENROLL_ROLES:
            _require(not playlist.items, 'NONMUSIC_TARGET_MEMBERSHIP', role)
        for item in playlist.items:
            _check_item(item)
        roles[role] = playlist
    _require(set(ENROLL_ROLES) <= roles.keys(), 'MISSING_REQUIRED_ROLE')
    all_tracks = Counter(t.track_id for t in lib.tracks)
    _require(Counter(roles['master'].track_ids) == all_tracks, 'MASTER_CLOSURE')
    if target:
        _require(all_tracks, 'EMPTY_TARGET_NOT_YET_QUALIFIED')
        for role in ENROLL_ROLES:
            _require(Counter(roles[role].track_ids) == all_tracks,
                     'TARGET_ROLE_CLOSURE', role)
    return roles, tuple(ordinary)


def _text_atom(owner, child, ordinal):
    _require(child.tag == b'mhoh' and len(child.header) == 24
             and len(child.payload) >= 16 and uint(child.header, 20) == 0,
             'UNKNOWN_TEXT_SHAPE')
    _require(child.payload[8:16] == bytes(8)
             and len(child.payload) == 16 + uint(child.payload, 4),
             'OPAQUE_TEXT_EXTENSION')
    value = read_text(child)
    _require(type(value) is str, 'BINARY_NOT_TEXT')
    external = uint(child.header, 16)
    _require(external <= _ATOM_CAP, 'ATOM_CAPACITY')
    pool = _POOLS.get((owner.tag, child.type_code))
    if pool is None:
        _require(owner.tag == b'mith' and child.type_code in (11, 13),
                 'UNKNOWN_POOL_DOMAIN')
        return None
    # Omitted or empty materialization is not silently treated as a known alias.
    _require(value or external == 0, 'EMPTY_REFERENCE_BINDING_UNPROVEN')
    binding = (pool, external) if external else (
        pool, 'unkeyed', owner.tag.decode(), uint(owner.header, 16), ordinal)
    return (binding, value.encode('utf-16-le'), external, pool)


def selected_wav_profile(track):
    """Positive WAVE wire profile, without a localized Kind string equality gate."""
    h = track.node.header
    _require(len(h) == 756 and uint(h, 0x14) == 1
             and uint(h, 0x8c) == 1463899680, 'SELECTED_NON_WAVE_PROFILE')
    codes = [c.type_code for c in track.node.children or ()]
    _require(len(codes) == len(set(codes)), 'DUPLICATE_TRACK_FIELD')
    _require({2, 6, 11, 13} <= set(codes) <=
             {2, 3, 4, 5, 6, 8, 11, 12, 13, 27, 30, 31, 32, 33},
             'SELECTED_OPAQUE_OR_UNKNOWN_FIELD')
    _require(track.get('kind') and track.get('name'), 'MISSING_MATERIALIZED_TEXT')
    url, path = track.get('url'), track.get('path')
    _require(type(url) is str and url.startswith('file://localhost/')
             and type(path) is str and re.match(r'^[A-Za-z]:[\\/]', path)
             and '\x00' not in path and '\x00' not in url,
             'UNSUPPORTED_LOCATION_PROFILE')
    _require(uint(h, 0xdc) and uint(h, 0x1e0), 'UNRESOLVED_AUXILIARY_REF')
    return tuple(_text_atom(track.node, c, i)
                 for i, c in enumerate(track.node.children or ()))


@dataclass(frozen=True)
class ClosureRecord:
    section: int
    tag: str
    source_local: int
    persistent_id: str
    record_bytes: bytes
    selected_consumers: tuple[str, ...]


def selected_closure(donor, selected):
    """Only selected tracks and their typed album/artist closure; blanks stay distinct."""
    ids = _pid_list(selected)
    by_pid = {t.persistent_id: t for t in donor.tracks}
    _require(set(ids) <= by_pid.keys(), 'SOURCE_TRACK_MISSING')
    tracks = [by_pid[pid] for pid in ids]
    for track in tracks:
        selected_wav_profile(track)
    records = []
    for section, tag, key in ((9, 'miah', 'album_id'), (11, 'miih', 'artist_id')):
        for old in dict.fromkeys(t.get(key) for t in tracks):
            node = _aux(donor, section, old)
            for i, child in enumerate(node.children or ()):
                _text_atom(node, child, i)
            records.append(ClosureRecord(section, tag, old,
                _hx(uint(node.header, 20, 8)), node.to_bytes(),
                tuple(_hx(t.persistent_id) for t in tracks if t.get(key) == old)))
    records.extend(ClosureRecord(1, 'mith', t.track_id, _hx(t.persistent_id),
                   t.node.to_bytes(), (_hx(t.persistent_id),)) for t in tracks)
    return tuple(records)


def _pool_census(lib):
    bindings = {}
    rows = []
    for section, tag in ((1, b'mith'), (9, b'miah'), (11, b'miih')):
        for owner in lib._records(section, tag):
            for ordinal, child in enumerate(owner.children or ()):
                if (tag, child.type_code) not in _POOLS:
                    # Nonselected unknown fields are not copied or guessed as atoms.
                    continue
                atom = _text_atom(owner, child, ordinal)
                if atom is None:
                    continue
                binding, value, external, pool = atom
                if value:
                    _require(binding not in bindings or bindings[binding] == value,
                             'POOL_ID_TEXT_CONFLICT', pool)
                    bindings[binding] = value
                rows.append((tag.decode(), uint(owner.header, 16), ordinal,
                             child.type_code, pool, external, _sha(value)))
    return tuple(rows)


def decode_msph800(node):
    """Bounded dictionary inspection. Never reserializes or confers write authority."""
    _require(node.tag == b'msph' and len(node.header) == 48
             and uint(node.header, 12) == 1 and not any(node.header[16:]),
             'UNKNOWN_MSPH_HEADER')
    raw = node.payload
    _require(24 < len(raw) <= 65536 and raw[:4] == b'mhoh'
             and uint(raw, 4) == 24 and uint(raw, 8) == len(raw)
             and uint(raw, 12) == 800 and not any(raw[16:24]),
             'UNKNOWN_MSPH800_BOUNDARY')
    xml = raw[24:]
    _require(b'<!ENTITY' not in xml.upper(), 'XML_ENTITY_REFUSED')
    try:
        root = ET.fromstring(xml)
    except (ET.ParseError, ValueError) as exc:
        raise ImportRefusal('INVALID_SETTINGS_XML') from exc
    count = 0
    def value(element, depth=0):
        nonlocal count
        count += 1
        _require(depth <= 8 and count <= 512, 'SETTINGS_TREE_BUDGET')
        _require(not element.attrib and not (element.tail or '').strip(),
                 'UNKNOWN_SETTINGS_ATTRIBUTES')
        children = list(element)
        tag = element.tag
        if tag == 'dict':
            _require(not (element.text or '').strip() and len(children) % 2 == 0,
                     'INVALID_SETTINGS_DICTIONARY')
            result = {}
            for i in range(0, len(children), 2):
                key = children[i]
                _require(key.tag == 'key' and not key.attrib and not list(key)
                         and key.text and key.text not in result
                         and not (key.tail or '').strip(), 'DUPLICATE_OR_INVALID_SETTINGS_KEY')
                count += 1
                result[key.text] = value(children[i + 1], depth + 1)
            return result
        if tag == 'array':
            _require(not (element.text or '').strip(), 'INVALID_SETTINGS_ARRAY')
            return [value(child, depth + 1) for child in children]
        _require(not children, 'UNKNOWN_SETTINGS_LEAF')
        text = element.text or ''
        if tag == 'string':
            return text
        if tag == 'integer':
            _require(re.fullmatch(r'-?[0-9]{1,10}', text), 'SETTINGS_INTEGER_BUDGET')
            return int(text)
        if tag in ('true', 'false'):
            _require(not text.strip(), 'INVALID_SETTINGS_BOOLEAN')
            return tag == 'true'
        if tag == 'date':
            try:
                datetime.strptime(text, '%Y-%m-%dT%H:%M:%SZ')
            except ValueError as exc:
                raise ImportRefusal('INVALID_SETTINGS_DATE') from exc
            return {'date': text}
        raise ImportRefusal('UNKNOWN_SETTINGS_LEAF', tag)
    _require(root.tag == 'plist' and root.attrib == {'version': '1.0'}
             and len(root) == 1 and not (root.text or '').strip(), 'UNKNOWN_PLIST_ROOT')
    result = value(root[0])
    keys = {'containerOrder', 'defaultSettings', 'includesAllPodcasts', 'podcasts',
            'settings', 'sortOrder', 'syncedToCloud', 'title', 'ungroupedList',
            'updatedDate', 'uuid'}
    _require(type(result) is dict and set(result) == keys, 'UNKNOWN_SETTINGS_KEYS')
    expected_ints = {'containerOrder': 1, 'includesAllPodcasts': 1,
                     'sortOrder': 1, 'ungroupedList': 1}
    _require(all(type(result[k]) is int and result[k] == v for k, v in expected_ints.items())
             and result['syncedToCloud'] is False, 'UNPROVEN_SETTINGS_VARIANT')
    expected_defaults = {'episodesToShow': 1, 'episodesToShowTruth': 1,
                         'mediaType': 0, 'showPlayedEpisodes': 1}
    defaults = result['defaultSettings']
    _require(type(defaults) is dict and set(defaults) == set(expected_defaults)
             and all(type(defaults[k]) is int and defaults[k] == v
                     for k, v in expected_defaults.items()), 'UNPROVEN_DEFAULT_SETTINGS')
    _require(result['podcasts'] == [] and result['settings'] == [],
             'NONEMPTY_SETTINGS_REFERENCE_CLOSURE')
    _require(type(result['title']) is str and 0 < len(result['title']) <= 256
             and result['uuid'] == 'PlaylistMostRecent'
             and type(result['updatedDate']) is dict, 'UNPROVEN_SETTINGS_IDENTITY')
    return {'profile': 'empty-podcast-settings-dictionary.v1',
            'dictionary': result, 'record_sha256': _sha(node.to_bytes()),
            'semantic_independence_proven': False,
            'blocker': 'MSPH800_BUSINESS_SEMANTICS_UNPROVEN'}


@dataclass(frozen=True)
class TypedPatch:
    namespace: str
    offset: int
    before: bytes
    after: bytes
    evidence: str


_SLOT_MAP = {
    b'mith': {'local': (0x10, 4, 'local.track'),
              'album': (0xdc, 4, 'ref.album.local'),
              'artist': (0x1e0, 4, 'ref.artist.local'),
              'secondary': (0x1f4, 4, 'local.secondary')},
    b'miah': {'local': (0x10, 4, 'local.album')},
    b'miih': {'local': (0x10, 4, 'local.artist')},
    b'mtph': {'local': (0x10, 4, 'local.item'),
              'track': (0x18, 4, 'ref.track.local'),
              'token': (0x20, 4, 'token.playlist'),
              'pid': (0x44, 8, 'pid.item')},
}


def transform_record(node, values, atom_ids=None):
    """Pure typed-slot transformation of a clone, with an exhaustive delta whitelist.

    This helper is not apply/prepare. It cannot allocate, authorize or publish.
    Caller reservations are untrusted until a future prepare validates the ledger.
    Original PIDs/ranks/flags/text/path and every other byte remain identical.
    """
    _normal_python()
    sizes = {b'mith': 756, b'miah': 88, b'miih': 100, b'mtph': 84}
    _require(node.tag in sizes and len(node.header) == sizes[node.tag],
             'TRANSFORM_RECORD_PROFILE')
    slots = _SLOT_MAP[node.tag]
    _require(type(values) is dict and set(values) == set(slots),
             'EXACT_TYPED_RESERVATIONS_REQUIRED')
    original = node.to_bytes()
    clone = deepcopy(node)
    patches = []
    for key, (offset, width, namespace) in slots.items():
        val = values[key]
        cap = (2**64 - 1) if width == 8 else _LOCAL_CAP
        _require(type(val) is int and 0 < val <= cap, 'RESERVATION_CAPACITY', key)
        before = bytes(clone.header[offset:offset + width])
        after = val.to_bytes(width, 'little')
        put(clone.header, offset, val, width)
        patches.append(TypedPatch(namespace, offset, before, after,
                                  'native wire field mapping; allocation validation separate'))
    atom_ids = {} if atom_ids is None else atom_ids
    _require(type(atom_ids) is dict and all(type(k) is int and k >= 0 for k in atom_ids),
             'INVALID_ATOM_RESERVATIONS')
    offset = len(clone.header)
    consumed = set()
    for ordinal, child in enumerate(clone.children or ()):
        if ordinal in atom_ids:
            atom = _text_atom(clone, child, ordinal)
            _require(atom is not None and atom[1], 'EMPTY_OR_OWNER_LOCAL_ATOM_REWRITE')
            val = atom_ids[ordinal]
            _require(type(val) is int and 0 < val <= _ATOM_CAP, 'ATOM_CAPACITY')
            before = bytes(child.header[16:20])
            after = val.to_bytes(4, 'little')
            put(child.header, 16, val)
            patches.append(TypedPatch('atom.' + atom[3], offset + 16, before, after,
                                      'owner-qualified mhoh external ID; content untouched'))
            consumed.add(ordinal)
        offset += len(child.to_bytes())
    _require(consumed == set(atom_ids), 'UNKNOWN_ATOM_OCCURRENCE')
    result = clone.to_bytes()
    expected = bytearray(original)
    for patch in patches:
        stop = patch.offset + len(patch.before)
        _require(bytes(expected[patch.offset:stop]) == patch.before,
                 'PATCH_PREIMAGE_CHANGED')
        expected[patch.offset:stop] = patch.after
    _require(result == bytes(expected), 'UNWHITELISTED_RECORD_DELTA')
    _require(node.to_bytes() == original, 'SOURCE_RECORD_MUTATED')
    return clone, tuple(patches)


def _pair_context(target_bytes, donor_bytes, selected, *, limits=None):
    """Return source-derived closure/preservation facts; no materialization authority."""
    caps = _limits(limits)
    ids = _pid_list(selected)
    containers, statistics, memory_estimate = _preflight_inputs((target_bytes, donor_bytes), caps)
    target, donor = tuple(_library_from_preflight(c) for c in containers)
    _require(target.persistent_id != donor.persistent_id, 'SAME_LINEAGE_NOT_CROSS_IMPORT')
    ids = _pid_list(selected)
    _require(not set(ids) & {t.persistent_id for t in target.tracks}, 'EXISTING_TRACK_PID')
    tr, ordinary = role_catalog(target, target=True)
    dr, _ = role_catalog(donor)
    records = selected_closure(donor, selected)
    by_pid = {t.persistent_id: t for t in donor.tracks}
    for role in ENROLL_ROLES:
        _require(_rule_signature(tr[role]) == _rule_signature(dr[role]),
                 'ROLE_RULE_MISMATCH', role)
        _require(all(by_pid[p].track_id in dr[role].track_ids for p in ids),
                 'SELECTED_SOURCE_ROLE_MEMBERSHIP_MISSING', role)
    target_pools, donor_pools = _pool_census(target), _pool_census(donor)
    settings = [decode_msph800(n) for n in target._records(21, b'msph')]
    _require(len(settings) == 1, 'UNKNOWN_SETTINGS_COLLECTION')
    target_track_pids = {t.track_id: _hx(t.persistent_id) for t in target.tracks}
    expected = {
        'file_pid': _hx(target.persistent_id), 'master_pid': _hx(tr['master'].persistent_id),
        'old_tracks': [{'pid': _hx(t.persistent_id), 'wire_sha256': _sha(t.node.to_bytes()),
                        'metadata': t.to_dict()} for t in target.tracks],
        'new_tracks': [{'pid': _hx(p), 'wire_sha256': _sha(by_pid[p].node.to_bytes()),
                        'metadata': by_pid[p].to_dict()} for p in ids],
        'old_aux': {str(sec): [{'local': uint(n.header, 16),
                    'pid': _hx(uint(n.header, 20, 8)), 'wire_sha256': _sha(n.to_bytes())}
                    for n in target._records(sec, tag)]
                    for sec, tag in ((9, b'miah'), (11, b'miih'))},
        'playlists': [{'pid': _hx(p.persistent_id),
                      'old_record_sha256': _sha(p.node.to_bytes()),
                      'old_members': [target_track_pids[tid] for tid in p.track_ids],
                      'append_pids': [_hx(pid) for pid in ids] if p.persistent_id in {tr[r].persistent_id for r in ENROLL_ROLES} else [],
                      'metadata_sha256': [_sha(n.to_bytes()) for n in p.node.children or ()
                                          if n.tag != b'mtph']}
                      for p in target.playlists],
        'opaque_sections': [{'section': s.section_type, 'sha256': _sha(s.to_bytes())}
                            for s in target.sections if s.section_type in (4, 21, 23)],
        'scope': 'Complete known wire preservation expectations, not complete native getter decoding',
    }
    expected_bytes = _json_bytes(expected, caps.max_json_bytes, limits=caps,
                                 resident_bytes=memory_estimate)
    facts = {'status': 'profile_inspected_not_authorized',
            'input_digests': {'target': _sha(target_bytes), 'donor': _sha(donor_bytes)},
            'selected': tuple(_hx(x) for x in ids), 'closure': records,
            'resource_profile': {'input_statistics': statistics,
                'coexistence_estimate_bytes': memory_estimate,
                'expected_json_bytes': len(expected_bytes), 'rss_guarantee': False},
            'target_pools': target_pools, 'source_pools': donor_pools,
            'settings': tuple(settings), 'expected_wire_state_json': expected_bytes,
            'expected_wire_state_digest': _sha(expected_bytes),
            'ordinary_preserved': tuple(_hx(p.persistent_id) for p in ordinary),
            'blockers': ('MSPH800_BUSINESS_SEMANTICS_UNPROVEN',
                         'SYSTEM_RULE_EVALUATION_NOT_YET_QUALIFIED',
                         'PINNED_TYPED_ALLOCATOR_AND_PLANNING_ADAPTER_REQUIRED')}
    return caps, target, donor, tr, dr, ids, records, facts


def inspect_pair(target_bytes, donor_bytes, selected, *, limits=None):
    return _pair_context(target_bytes, donor_bytes, selected, limits=limits)[-1]


@dataclass(frozen=True)
class _WireRecord:
    """Source-derived structural recipe, deliberately NOT a reservation ledger."""
    section: int
    role: str
    source_local: int
    source_pid: int
    source_bytes: bytes = field(repr=False)
    slots: tuple
    atoms: tuple
    expected_bytes: bytes = field(repr=False)


@dataclass(frozen=True)
class _WireLayout:
    """Non-executable expectation. No report import or semantic admission route."""
    target_digest: str
    source_digest: str
    selected: tuple
    header: bytes = field(repr=False)
    sections: tuple = field(repr=False)
    records: tuple = field(repr=False)
    role_pids: tuple
    known_wire_expected_json: bytes = field(repr=False)
    resident_estimate: int
    input_plain_bytes: int
    input_nodes: int
    input_text_bytes: int
    blockers: tuple


def _record_expected(source, slots, atoms):
    """Independent byte reconstruction: does not call transform_record/builder."""
    raw = source.to_bytes(); output = bytearray(raw)
    shape = _SLOT_MAP[source.tag]
    _require(type(slots) is dict and len(slots) == len(shape)
             and set(slots) == set(shape), 'EXACT_TYPED_RESERVATIONS_REQUIRED')
    for name, (offset, width, _) in shape.items():
        v = slots[name]
        _require(type(v) is int and 0 < v <= (2**64 - 1 if width == 8 else _LOCAL_CAP),
                 'RESERVATION_CAPACITY', name)
        output[offset:offset + width] = v.to_bytes(width, 'little')
    _require(type(atoms) is dict and len(atoms) <= len(source.children or ()),
             'INVALID_ATOM_RESERVATIONS')
    needed = set(); pos = len(source.header)
    for i, child in enumerate(source.children or ()):
        binding = _text_atom(source, child, i)
        if binding is not None and binding[1]:
            needed.add(i)
            _require(i in atoms and type(atoms[i]) is int and 0 < atoms[i] <= _ATOM_CAP,
                     'EXACT_NONEMPTY_POOL_REKEY_REQUIRED')
            output[pos + 16:pos + 20] = atoms[i].to_bytes(4, 'little')
        pos += len(child.to_bytes())
    _require(all(type(k) is int for k in atoms) and set(atoms) == needed,
             'EXACT_NONEMPTY_POOL_REKEY_REQUIRED')
    return bytes(output)


def _wire_record(section, role, source, slots, atoms):
    expected = _record_expected(source, slots, atoms)
    clone, _ = transform_record(source, slots, atoms)
    _require(clone.to_bytes() == expected, 'INDEPENDENT_RECORD_RECONSTRUCTION')
    pid_offset = 0x44 if source.tag == b'mtph' else 0x80 if source.tag == b'mith' else 20
    return _WireRecord(section, role, uint(source.header, 16),
        uint(source.header, pid_offset, 8), source.to_bytes(), tuple(slots.items()),
        tuple(atoms.items()), expected)


def _check_proposed_values(target, donor, records, caps):
    """Recheck numeric exclusion/alias facts; NOT a substitute typed allocator.

    No identities are chosen, reserved or retired here. Unknown-consumer blockers
    still prevent public preparation. A real allocator failure must poison and
    discard the enclosing future transaction, never fall back to these values.
    """
    raw = target.container.header + target.container.payload
    locals_new = []; pids_new = []; scan_bytes = 0
    source_nodes = {(sec, uint(n.header, 16)): n for sec, tag in
                    ((1, b'mith'), (9, b'miah'), (11, b'miih'))
                    for n in donor._records(sec, tag)}
    pool_used = {}; dest_by_binding = {}; binding_by_dest = {}
    for row in _pool_census(target):
        if row[5]: pool_used.setdefault(row[4], set()).add(row[5])
    for record in records:
        values = dict(record.slots)
        locals_new.extend(values[k] for k in ('local', 'secondary', 'token') if k in values)
        pids_new.append(values['pid'] if record.role else record.source_pid)
        if record.role:
            continue
        node = source_nodes[record.section, record.source_local]
        for i, value in record.atoms:
            binding, text, _, pool = _text_atom(node, node.children[i], i)
            key = (binding, _sha(text)); destination = (pool, value)
            _require(value not in pool_used.get(pool, ()), 'PROPOSED_POOL_ID_OCCUPIED')
            _require(key not in dest_by_binding or dest_by_binding[key] == destination,
                     'SOURCE_POOL_ALIAS_SPLIT')
            _require(destination not in binding_by_dest or binding_by_dest[destination] == key,
                     'DISTINCT_SOURCE_BINDINGS_MERGED')
            dest_by_binding[key] = destination; binding_by_dest[destination] = key
    _require(len(locals_new) == len(set(locals_new)), 'PROPOSED_LOCAL_OR_TOKEN_COLLISION')
    _require(len(pids_new) == len(set(pids_new)), 'PROPOSED_PID_COLLISION')
    for value, width in [(x, 4) for x in locals_new] + [(x, 8) for x in pids_new]:
        patterns = [value.to_bytes(width, 'little'), value.to_bytes(width, 'big')]
        if width == 8: patterns.extend((_hx(value).encode('ascii'), _hx(value).lower().encode('ascii')))
        for pattern in patterns:
            scan_bytes += len(raw)
            _require(scan_bytes <= min(64 * 1024**2, caps.memory_budget_bytes),
                     'PROPOSED_ID_SCAN_BUDGET')
            _require(pattern not in raw, 'PROPOSED_ID_OPAQUE_OR_KNOWN_COLLISION')


def _freeze_wire_layout(target_bytes, donor_bytes, selected, object_values,
                        membership_values, *, limits=None):
    """Freeze complete append/count expectations BEFORE whole-image assembly.

    Values-only dictionaries are inputs to this PRIVATE structural component,
    not an API for allocation or a means of bypassing prepare's blockers. There
    is intentionally no shared-ledger converter or success ProfileReport here.
    """
    caps, target, donor, tr, dr, ids, closure, facts = _pair_context(
        target_bytes, donor_bytes, selected, limits=limits)
    keys = {(r.section, r.source_local) for r in closure}
    _require(type(object_values) is dict and len(object_values) == len(keys)
             and set(object_values) == keys, 'EXACT_SELECTED_OBJECT_VALUES_REQUIRED')
    _require(type(membership_values) is dict and len(membership_values) == len(ENROLL_ROLES)
             and set(membership_values) == set(ENROLL_ROLES), 'EXACT_ROLE_VALUES_REQUIRED')
    source_nodes = {(sec, uint(n.header, 16)): n for sec, tag in
                    ((1, b'mith'), (9, b'miah'), (11, b'miih'))
                    for n in donor._records(sec, tag)}
    stats = facts['resource_profile']['input_statistics']
    projected_record_bytes = sum(len(r.record_bytes) for r in closure) + 84 * len(ids) * len(ENROLL_ROLES)
    retained = 8 * (len(target.container.payload) + 2 * projected_record_bytes +
                    len(facts['expected_wire_state_json'])) + 4096 * (len(closure) + len(ids) * len(ENROLL_ROLES))
    resident = facts['resource_profile']['coexistence_estimate_bytes'] + retained
    caps.check('memory', resident)
    extra_nodes = sum(1 + len(source_nodes[r.section, r.source_local].children or ()) for r in closure)
    extra_nodes += len(ids) * len(ENROLL_ROLES)
    caps.check('nodes', sum(x['nodes'] for x in stats) + extra_nodes)
    records = []
    for record in closure:
        value = object_values[record.section, record.source_local]
        _require(type(value) is dict and set(value) == {'slots', 'atoms'},
                 'EXACT_RECORD_VALUE_KEYS_REQUIRED')
        node = source_nodes[record.section, record.source_local]
        if record.section == 1:
            for name, section, offset in (('album', 9, 0xdc), ('artist', 11, 0x1e0)):
                target_local = object_values[section, uint(node.header, offset)]['slots']['local']
                _require(value['slots'].get(name) == target_local, 'SELECTED_REFERENCE_MAP_MISMATCH')
        records.append(_wire_record(record.section, '', node, value['slots'], value['atoms']))
    track_map = {r.source_pid: dict(r.slots)['local'] for r in records if r.section == 1}
    by_pid = {t.persistent_id: t for t in donor.tracks}
    for role in ENROLL_ROLES:
        table = membership_values[role]
        _require(type(table) is dict and len(table) == len(ids) and set(table) == set(ids),
                 'EXACT_SELECTED_MEMBERSHIP_VALUES_REQUIRED')
        for pid in ids:
            items = [n for n in dr[role].items if uint(n.header, 24) == by_pid[pid].track_id]
            _require(len(items) == 1, 'SOURCE_ITEM_TEMPLATE_NOT_UNIQUE', role)
            _require(type(table[pid]) is dict and table[pid].get('track') == track_map[pid],
                     'MEMBERSHIP_TARGET_REFERENCE_MISMATCH')
            records.append(_wire_record(2, role, items[0], table[pid], {}))
    _check_proposed_values(target, donor, records, caps)
    # Final known-wire expectations are projected only from source + fixed values,
    # never extracted from an assembled candidate. Native COM expectations remain
    # independently frozen outside this module; raw sample_rate is not relabeled.
    expected = json.loads(facts['expected_wire_state_json'])
    tracks = {r.source_pid: r for r in records if r.section == 1}
    for row in expected['new_tracks']:
        record = tracks[int(row['pid'], 16)]; values = dict(record.slots)
        row['source_wire_sha256'] = row['wire_sha256']
        row['wire_sha256'] = _sha(record.expected_bytes)
        for name, key in (('track_id', 'local'), ('album_id', 'album'), ('artist_id', 'artist')):
            row['metadata'][name] = values[key]
        row['secondary_local'] = values['secondary']
    expected['new_aux'] = {str(sec): [{'source_local': r.source_local,
        'local': dict(r.slots)['local'], 'pid': _hx(r.source_pid),
        'source_wire_sha256': _sha(r.source_bytes), 'wire_sha256': _sha(r.expected_bytes)}
        for r in records if r.section == sec] for sec in (9, 11)}
    for row in expected['playlists']:
        role = next((r for r in ENROLL_ROLES if _hx(tr[r].persistent_id) == row['pid']), None)
        row['expected_members'] = row['old_members'] + row['append_pids']
        row['new_items'] = [{'source_pid': _hx(r.source_pid), **dict(r.slots),
                             'wire_sha256': _sha(r.expected_bytes)}
                            for r in records if role is not None and r.role == role]
    expected['counts'] = {'tracks': len(target.tracks) + len(ids),
        'albums': len(target._records(9, b'miah')) + len(expected['new_aux']['9']),
        'artists': len(target._records(11, b'miih')) + len(expected['new_aux']['11']),
        'playlists': len(target.playlists)}
    expected['native_qualified'] = False
    expected_bytes = _json_bytes(expected, caps.max_json_bytes, limits=caps, resident_bytes=resident)
    resident += 8 * len(expected_bytes); caps.check('memory', resident)
    return _WireLayout(_sha(target_bytes), _sha(donor_bytes), tuple(ids),
        target.container.header, tuple((s.section_type, s.to_bytes()) for s in target.sections),
        tuple(records), tuple((role, tr[role].persistent_id) for role in ENROLL_ROLES),
        expected_bytes, resident,
        sum(x['plain_bytes'] for x in stats), sum(x['nodes'] for x in stats),
        sum(x['text_bytes'] for x in stats), facts['blockers'])


def _assemble_wire(layout, *, limits=None):
    """Private bounded byte assembler; returns structural bytes, NOT PreparedMutation.

    Never called by public prepare while consumers/typed ledger remain unproved.
    No Library.to_bytes/_sync, allocation, admission flag, disk IO or raw fallback.
    """
    _normal_python(); caps = _limits(limits)
    _require(type(layout) is _WireLayout, 'FROZEN_WIRE_LAYOUT_REQUIRED')
    _require(type(layout.sections) is tuple and len(layout.sections) == len(SECTIONS)
             and tuple(sec for sec, _ in layout.sections) == SECTIONS,
             'INVALID_LAYOUT_SECTIONS')
    _require(type(layout.header) is bytes and len(layout.header) == 144,
             'INVALID_LAYOUT_HEADER')
    _require(type(layout.records) is tuple and 0 < len(layout.records) <= 768,
             'INVALID_LAYOUT_RECORDS')
    for record in layout.records:
        _require(type(record) is _WireRecord and type(record.expected_bytes) is bytes
                 and 12 <= len(record.expected_bytes) <= caps.max_plain_bytes,
                 'INVALID_LAYOUT_RECORD')
        tag = b'mtph' if record.role else {1: b'mith', 9: b'miah', 11: b'miih'}.get(record.section)
        _require(record.expected_bytes[:4] == tag and uint(record.expected_bytes, 8) == len(record.expected_bytes),
                 'INVALID_LAYOUT_RECORD_FRAME')
    for value in (layout.resident_estimate, layout.input_plain_bytes,
                  layout.input_nodes, layout.input_text_bytes):
        _require(type(value) is int and value >= 0, 'INVALID_LAYOUT_ACCOUNTING')
    caps.check('memory', layout.resident_estimate)
    caps.check('nodes', layout.input_nodes)
    added = sum(len(r.expected_bytes) for r in layout.records)
    plain_size = sum(len(raw) for _, raw in layout.sections) + added
    caps.check('plain', layout.input_plain_bytes + plain_size)
    # Standard zlib compressBound for default window/memory settings, plus header.
    file_bound = len(layout.header) + plain_size + (plain_size >> 12) + (plain_size >> 14) + (plain_size >> 25) + 13
    caps.check('file', file_bound)
    caps.check('memory', layout.resident_estimate + 32 * plain_size + 12 * file_bound)
    # Count all resulting frames/text BEFORE joining a candidate image.
    baseline_stats = [preflight_payload(raw, limits=caps) for _, raw in layout.sections]
    output_nodes = sum(x['nodes'] for x in baseline_stats)
    output_text = sum(x['text_bytes'] for x in baseline_stats)
    caps.check('nodes', layout.input_nodes + output_nodes)
    caps.check('text', layout.input_text_bytes + output_text)
    for record in layout.records:
        raw = record.expected_bytes
        wrapper = bytearray(28); wrapper[:4] = b'msdh'
        put(wrapper, 4, 16); put(wrapper, 8, 28 + len(raw)); put(wrapper, 12, 1)
        wrapper[16:20] = b'mlth'; put(wrapper, 20, 12); put(wrapper, 24, 1)
        stats = preflight_payload(bytes(wrapper) + raw, limits=caps)
        output_nodes += stats['nodes'] - 2; output_text += stats['text_bytes']
        caps.check('nodes', layout.input_nodes + output_nodes)
        caps.check('text', layout.input_text_bytes + output_text)
    caps.check('memory', layout.resident_estimate + 32 * plain_size +
               12 * file_bound + output_nodes * 6144)
    object_groups = {sec: tuple(r.expected_bytes for r in layout.records if r.section == sec)
                     for sec in (1, 9, 11)}
    item_groups = {pid: tuple(r.expected_bytes for r in layout.records if r.role == role)
                   for role, pid in layout.role_pids}
    parts = []
    for section, raw in layout.sections:
        if section in object_groups:
            additions = object_groups[section]
            hlen = uint(raw, 4); out = bytearray(raw)
            put(out, 8, len(raw) + sum(map(len, additions)))
            put(out, hlen + 8, uint(raw, hlen + 8) + len(additions))
            parts.append(bytes(out) + b''.join(additions))
        elif section == 2:
            hlen = uint(raw, 4); root_end = hlen + uint(raw, hlen + 4)
            children = []; pos = root_end
            while pos < len(raw):
                _require(pos + 12 <= len(raw), 'TRUNCATED_LAYOUT_PLAYLIST')
                size = uint(raw, pos + 8)
                _require(3500 <= size <= len(raw) - pos and raw[pos:pos + 4] == b'miph',
                         'INVALID_LAYOUT_PLAYLIST_BOUNDARY')
                before = raw[pos:pos + size]
                pid = uint(before, 0x1b8, 8); additions = item_groups.get(pid, ())
                if additions:
                    out = bytearray(before)
                    put(out, 8, len(before) + sum(map(len, additions)))
                    put(out, 16, uint(before, 16) + len(additions))
                    children.append(bytes(out) + b''.join(additions))
                else: children.append(before)
                pos += size
            out = bytearray(raw[:root_end]); put(out, 8, root_end + sum(map(len, children)))
            parts.append(bytes(out) + b''.join(children))
        else: parts.append(raw)
    header = bytearray(layout.header)
    main_index = next(i for i, (sec, _) in enumerate(layout.sections) if sec == 16)
    main = bytearray(parts[main_index]); root_at = uint(main, 4)
    for offset, section in ((0x44, 1), (0x4c, 9), (0x54, 11)):
        value = uint(layout.header, offset, endian='big') + len(object_groups[section])
        put(header, offset, value, endian='big'); put(main, root_at + offset, value)
    put(main, root_at + 8, plain_size + len(header)); parts[main_index] = bytes(main)
    payload = b''.join(parts)
    _require(len(payload) == plain_size, 'ASSEMBLED_SIZE_MISMATCH')
    stats = preflight_payload(payload, limits=caps)
    caps.check('nodes', layout.input_nodes + stats['nodes'])
    caps.check('text', layout.input_text_bytes + stats['text_bytes'])
    caps.check('memory', layout.resident_estimate + 32 * plain_size +
               12 * file_bound + stats['nodes'] * 6144)
    # Parse/serialize only with declared bounds; serializer gets no live Library.
    result = Container(bytes(header), payload).to_bytes(compression_level=6)
    caps.check('file', len(result))
    _require(len(result) <= file_bound, 'ENCODED_BOUND_EXCEEDED')
    return result


def _validate_wire_assembly(target_bytes, donor_bytes, selected, layout, candidate_bytes, *, limits=None):
    """Full byte-preservation proof independent of assembler/allocator execution.

    A true return proves only the declared structural delta, NOT pool business
    semantics, typed-ledger provenance, native getters, or write authorization.
    Public preparation is still blocked. Never load this layout from a report.
    """
    caps = _limits(limits)
    _require(type(layout) is _WireLayout and layout.target_digest == _sha(target_bytes)
             and layout.source_digest == _sha(donor_bytes) and layout.selected == _pid_list(selected),
             'WIRE_EXPECTATION_INPUT_MISMATCH')
    retained = 8 * (len(layout.header) + sum(len(raw) for _, raw in layout.sections)
        + len(layout.known_wire_expected_json) + sum(len(r.source_bytes) + len(r.expected_bytes)
        for r in layout.records)) + 4096 * len(layout.records)
    caps.check('memory', retained + 1)
    local_caps = replace(caps, memory_budget_bytes=caps.memory_budget_bytes - retained)
    containers, _, _ = _preflight_inputs((target_bytes, donor_bytes, candidate_bytes), local_caps)
    target, donor, candidate = tuple(_library_from_preflight(c) for c in containers)
    tr, _ = role_catalog(target, target=True); dr, _ = role_catalog(donor)
    cr, _ = role_catalog(candidate, target=True)
    _require(target.persistent_id != donor.persistent_id, 'SAME_LINEAGE_NOT_CROSS_IMPORT')
    _require(not set(layout.selected) & {t.persistent_id for t in target.tracks}, 'EXISTING_TRACK_PID')
    by_source_pid = {t.persistent_id: t for t in donor.tracks}
    for role in ENROLL_ROLES:
        _require(_rule_signature(tr[role]) == _rule_signature(dr[role]), 'ROLE_RULE_MISMATCH')
        _require(all(by_source_pid[pid].track_id in dr[role].track_ids for pid in layout.selected),
                 'SELECTED_SOURCE_ROLE_MEMBERSHIP_MISSING')
    _require(layout.header == target.container.header and layout.sections ==
             tuple((s.section_type, s.to_bytes()) for s in target.sections), 'WIRE_BASELINE_TAMPERED')
    expected_roles = tuple((role, tr[role].persistent_id) for role in ENROLL_ROLES)
    _require(layout.role_pids == expected_roles, 'WIRE_ROLES_TAMPERED')
    closure = selected_closure(donor, selected)
    source_nodes = {(sec, uint(n.header, 16)): n for sec, tag in
                    ((1, b'mith'), (9, b'miah'), (11, b'miih'))
                    for n in donor._records(sec, tag)}
    objects = [r for r in layout.records if not r.role]
    _require([(r.section, r.source_local) for r in objects] ==
             [(r.section, r.source_local) for r in closure], 'WIRE_SELECTED_CLOSURE_TAMPERED')
    groups = {sec: [r for r in objects if r.section == sec] for sec in (1, 9, 11)}
    by_pid = {t.persistent_id: t for t in donor.tracks}
    record_map = {(r.section, r.source_local): r for r in objects}
    for record in layout.records:
        _require(type(record) is _WireRecord and type(record.slots) is tuple and type(record.atoms) is tuple
                 and len(dict(record.slots)) == len(record.slots) and len(dict(record.atoms)) == len(record.atoms),
                 'NONCANONICAL_WIRE_RECORD')
        if record.role:
            _require(record.role in ENROLL_ROLES, 'UNKNOWN_WIRE_ROLE')
            matches = [n for n in dr[record.role].items if uint(n.header, 16) == record.source_local]
            _require(len(matches) == 1, 'SOURCE_ITEM_TEMPLATE_NOT_UNIQUE')
            node = matches[0]
        else: node = source_nodes[record.section, record.source_local]
        pid_at = 0x44 if record.role else 0x80 if record.section == 1 else 20
        _require(record.source_pid == uint(node.header, pid_at, 8), 'SOURCE_PID_PROVENANCE_CHANGED')
        if record.section == 1:
            values = dict(record.slots)
            for name, sec, offset in (('album', 9, 0xdc), ('artist', 11, 0x1e0)):
                _require(values[name] == dict(record_map[sec, uint(node.header, offset)].slots)['local'],
                         'SELECTED_REFERENCE_MAP_MISMATCH')
        _require(record.source_bytes == node.to_bytes() and record.expected_bytes ==
                 _record_expected(node, dict(record.slots), dict(record.atoms)),
                 'SOURCE_DERIVED_RECORD_MISMATCH')
    _check_proposed_values(target, donor, layout.records, caps)
    for section, tag in ((1, b'mith'), (9, b'miah'), (11, b'miih')):
        before = target._records(section, tag); after = candidate._records(section, tag)
        _require(len(after) == len(before) + len(groups[section]), 'APPENDED_RECORD_COUNT')
        _require([n.to_bytes() for n in after[:len(before)]] == [n.to_bytes() for n in before],
                 'OLD_OBJECT_BYTES_CHANGED')
        _require([n.to_bytes() for n in after[len(before):]] == [r.expected_bytes for r in groups[section]],
                 'APPENDED_OBJECT_BYTES_CHANGED')
    _require([p.persistent_id for p in candidate.playlists] == [p.persistent_id for p in target.playlists],
             'PLAYLIST_IDENTITY_OR_ORDER_CHANGED')
    for before, after in zip(target.playlists, candidate.playlists):
        role = next((r for r in ENROLL_ROLES if before.persistent_id == tr[r].persistent_id), None)
        if role is None:
            _require(after.node.to_bytes() == before.node.to_bytes(), 'UNTOUCHED_PLAYLIST_CHANGED')
            continue
        records = [r for r in layout.records if r.role == role]
        for pid, record in zip(layout.selected, records):
            matches = [n for n in dr[role].items if uint(n.header, 24) == by_pid[pid].track_id]
            _require(len(matches) == 1 and record.source_local == uint(matches[0].header, 16),
                     'SOURCE_MEMBERSHIP_PROVENANCE_CHANGED')
        expected_tracks = [dict(r.slots)['local'] for r in groups[1]]
        _require(len(records) == len(layout.selected) and
                 [dict(r.slots)['track'] for r in records] == expected_tracks, 'WIRE_MEMBERSHIP_INTENT_CHANGED')
        old_children = before.node.children; new_children = after.node.children
        _require(len(new_children) == len(old_children) + len(records), 'SYSTEM_CHILD_COUNT_CHANGED')
        _require([n.to_bytes() for n in new_children[:len(old_children)]] ==
                 [n.to_bytes() for n in old_children], 'OLD_SYSTEM_CHILD_BYTES_CHANGED')
        _require([n.to_bytes() for n in new_children[len(old_children):]] ==
                 [r.expected_bytes for r in records], 'APPENDED_ITEM_BYTES_CHANGED')
        expected_h = bytearray(before.node.header)
        put(expected_h, 8, len(before.node.to_bytes()) + sum(len(r.expected_bytes) for r in records))
        put(expected_h, 16, len(before.items) + len(records))
        _require(after.node.header == expected_h, 'SYSTEM_HEADER_DELTA_OUTSIDE_WHITELIST')
    # Every section/root/header and every unmodified opaque byte is covered.
    for before, after in zip(target.sections, candidate.sections):
        section = before.section_type
        if section not in (16, 1, 9, 11, 2):
            _require(after.to_bytes() == before.to_bytes(), 'OPAQUE_OR_UNTOUCHED_SECTION_CHANGED')
            continue
        section_h = bytearray(before.header); put(section_h, 8, len(after.to_bytes()))
        _require(after.header == section_h, 'SECTION_HEADER_DELTA_OUTSIDE_WHITELIST')
        br = before.children[0]; ar = after.children[0]; root_h = bytearray(br.header)
        if section in groups: put(root_h, 8, len(br.children) + len(groups[section]))
        elif section == 16:
            put(root_h, 8, len(candidate.container.payload) + len(candidate.container.header))
            for offset, sec in ((0x44, 1), (0x4c, 9), (0x54, 11)):
                put(root_h, offset, uint(br.header, offset) + len(groups[sec]))
        _require(ar.header == root_h, 'ROOT_HEADER_DELTA_OUTSIDE_WHITELIST')
    expected_header = bytearray(target.container.header)
    put(expected_header, 8, len(candidate_bytes), endian='big')
    for offset, section in ((0x44, 1), (0x4c, 9), (0x54, 11)):
        put(expected_header, offset, uint(target.container.header, offset, endian='big') + len(groups[section]), endian='big')
    _require(candidate.container.header == expected_header, 'OUTER_HEADER_DELTA_OUTSIDE_WHITELIST')
    return True


def prepare(target_bytes, intent, sources=None, *, limits=None, seed=None):
    """Standard early-checkpoint entry. Structured blocked output, never a fake plan.

    Intent exactly: operation='cross_import', source=<key>, track_pids=[16hex...].
    sources exactly {<key>: immutable donor bytes}. No callback/guard override keys.
    """
    try:
        _normal_python()
        _require(type(intent) is dict and set(intent) == {'operation', 'source', 'track_pids'}
                 and intent['operation'] == 'cross_import', 'UNKNOWN_IMPORT_INTENT')
        _require(type(intent['source']) is str and 0 < len(intent['source']) <= 64,
                 'INVALID_SOURCE_KEY')
        _require(type(sources) is dict and set(sources) == {intent['source']},
                 'EXACT_SOURCE_SET_REQUIRED')
        seed_material = encode_seed(seed)
        facts = inspect_pair(target_bytes, sources[intent['source']], intent['track_pids'],
                             limits=limits)
        missing = tuple(name for name in ('schema', 'planning', 'identity', 'graph')
                        if importlib.util.find_spec(__package__ + '.' + name) is None)
        return {'status': 'blocked', 'engine': 'cross_import.v2',
                'profile_report': {'capabilities': ('inspect', 'closure', 'typed_record_transform'),
                                   'blockers': facts['blockers'],
                                   'missing_dependencies': missing},
                'input_digests': facts['input_digests'],
                'seed_encoding': 'sha256-domain-tag-length-utf8.v1',
                'seed_material_sha256': _sha(seed_material),
                'expected_wire_state_digest': facts['expected_wire_state_digest'],
                'prepared_candidate_digest': None, 'native_acceptance': False}
    except ITLError as exc:
        return {'status': 'blocked', 'engine': 'cross_import.v2',
                'profile_report': {'capabilities': (),
                    'blockers': (getattr(exc, 'code', type(exc).__name__),), 'detail': str(exc)},
                'prepared_candidate_digest': None, 'native_acceptance': False}
