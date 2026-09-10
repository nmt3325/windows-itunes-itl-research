"""NEW G2 production guards for an immutable, two-save passive validation path.

No COM/UI imports or actions. This module is used by g2_native_acceptance.py,
not by the old discovery controller. Original source and its xfails stay intact.
Raw support is deliberately bounded to the observed LE 756/3500 profile.
Unknown section bytes are preserved, not assigned invented semantics.
"""
from __future__ import annotations
import collections
import datetime as dt
import hashlib
import json
import math
import os
from pathlib import Path
import re
import stat
import zlib

MAX_BYTES = 32 * 1024 * 1024
# Separate EXE budget. Never use this for ITL, plans, media or saved libraries.
MAX_EXE_BYTES = 64 * 1024 * 1024
EXE_CHUNK_BYTES = 1024 * 1024
EXE_BYTES = 38952912
EXE_SHA = '30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d'
VERSION = '12.13.10.3'
G2_CUTOFF = '2026-09-10T08:35:00+00:00'
SESSION = frozenset(['TrackID', 'trackID', 'TrackDatabaseID', 'PlayOrderIndex',
                     'Index', 'SourceID', 'PlaylistID', 'sourceID', 'playlistID'])
CORE_TEXT = ('Name Artist Album AlbumArtist Composer Genre Comment Grouping Lyrics '
             'SortName SortArtist SortAlbum SortAlbumArtist Location').split()
CORE_NUMBER = ('Rating AlbumRating PlayedCount SkippedCount TrackNumber TrackCount '
               'DiscNumber DiscCount Year BPM VolumeAdjustment Duration SampleRate BitRate Size').split()
CORE_BOOL = ['Compilation', 'Enabled', 'Unplayed']
CORE_DATES = ['PlayedDate', 'SkippedDate', 'DateAdded', 'ModificationDate']
CORE = set(CORE_TEXT + CORE_NUMBER + CORE_BOOL + CORE_DATES)


class Rejected(ValueError):
    def __init__(self, code, detail=''):
        self.code = code
        super().__init__(code + (': ' + str(detail) if detail else ''))


def need(condition, code, detail=''):
    if not condition:
        raise Rejected(code, detail)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'),
                      ensure_ascii=True, allow_nan=False).encode('utf-8')


def unique_object(pairs):
    value = {}
    for key, item in pairs:
        need(key not in value, 'duplicate_json_key', key)
        value[key] = item
    return value


def load_json(data):
    try:
        return json.loads(data.decode('utf-8'), object_pairs_hook=unique_object,
                          parse_constant=lambda x: (_ for _ in ()).throw(Rejected('nonfinite_json', x)))
    except (UnicodeError, json.JSONDecodeError) as exc:
        raise Rejected('invalid_json', str(exc)) from exc


def integer(value, minimum=0):
    return type(value) is int and value >= minimum


def finite(value):
    return type(value) in (int, float) and math.isfinite(value)


def utc(value):
    need(type(value) is str, 'missing_timestamp')
    try:
        result = dt.datetime.fromisoformat(value.replace('Z', '+00:00'))
    except ValueError as exc:
        raise Rejected('invalid_timestamp', value) from exc
    need(result.tzinfo is not None and result.utcoffset() == dt.timedelta(0), 'timestamp_not_utc')
    return result


def valid_pid(value):
    return type(value) is str and re.fullmatch('[0-9A-F]{16}', value) is not None and int(value, 16) != 0


def id_list(values, label):
    need(type(values) is list and all(valid_pid(x) for x in values), 'invalid_ids', label)
    need(len(values) == len(set(values)), 'duplicate_ids', label)
    return set(values)


def within(path, root):
    path, root = Path(path), Path(root).resolve()
    need(path.is_absolute(), 'relative_path', path)
    resolved = path.resolve()
    need(resolved != root and resolved.is_relative_to(root), 'path_outside_scope', path)
    for entry in [path, *path.parents]:
        if entry == root:
            break
        if entry.exists():
            need(not entry.is_symlink() and not (getattr(entry.lstat(), 'st_file_attributes', 0) & 0x400),
                 'reparse_path', entry)
    return resolved


def stable_read(path, limit=MAX_BYTES):
    path = Path(path)
    with path.open('rb') as handle:
        before = os.fstat(handle.fileno())
        need(0 <= before.st_size <= limit, 'file_size_limit', path)
        data = handle.read(limit + 1)
        after = os.fstat(handle.fileno())
    current = path.stat()
    signature = lambda s: (s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns)
    need(signature(before) == signature(after) == signature(current), 'file_changed_during_read', path)
    need(len(data) == before.st_size, 'short_or_oversized_read', path)
    return data, dict(path=str(path.resolve()), bytes=len(data), sha256=sha(data), mtime_ns=before.st_mtime_ns)


def executable_pin(path, expected_sha256, *, expected_bytes=EXE_BYTES):
    """Read-only, one-open, bounded streaming EXE verification; never launches.

    Identity covers the original pathname, opened descriptor, and final path.
    This is a read-interval pin, NOT an atomic verified-execution guarantee.
    """
    need(type(expected_sha256) is str and re.fullmatch('[0-9a-f]{64}', expected_sha256)
         and integer(expected_bytes, 1) and expected_bytes <= MAX_EXE_BYTES,
         'invalid_executable_pin')
    path = Path(path)
    need(path.is_absolute(), 'relative_executable_path')
    resolved = within(path, Path(path.anchor))
    initial = path.stat()
    # Windows path.stat adds executable mode bits from the pathname, while
    # fstat does not. Python 3.12 path stat reports birth time in st_ctime_ns
    # but fstat reports change time. Compare these only within their API.
    signature = lambda s: (s.st_dev, s.st_ino, stat.S_IFMT(s.st_mode),
                           s.st_size, s.st_mtime_ns)
    need(stat.S_ISREG(initial.st_mode), 'executable_not_regular')
    digest = hashlib.sha256(); total = 0
    with path.open('rb') as handle:
        before = os.fstat(handle.fileno())
        need(signature(initial) == signature(before), 'executable_identity_changed')
        need(0 < before.st_size <= MAX_EXE_BYTES, 'executable_size_limit')
        need(before.st_size == expected_bytes, 'executable_size_mismatch')
        while True:
            chunk = handle.read(min(EXE_CHUNK_BYTES, MAX_EXE_BYTES + 1 - total))
            if not chunk:
                break
            total += len(chunk)
            need(total <= MAX_EXE_BYTES, 'executable_size_limit')
            digest.update(chunk)
        after = os.fstat(handle.fileno())
        current = path.stat()
        need(signature(initial) == signature(before) == signature(after) == signature(current)
             and (initial.st_mode, initial.st_ctime_ns) == (current.st_mode, current.st_ctime_ns)
             and (before.st_mode, before.st_ctime_ns) == (after.st_mode, after.st_ctime_ns)
             and within(path, Path(path.anchor)) == resolved, 'executable_identity_changed')
    need(total == before.st_size, 'executable_short_read')
    actual_sha = digest.hexdigest()
    need(actual_sha == expected_sha256, 'exe_pin_changed')
    return dict(path=str(resolved), bytes=total, sha256=actual_sha,
                mtime_ns=before.st_mtime_ns, device=before.st_dev, inode=before.st_ino)


def check_pin(pin, root, *, mtime=True):
    need(type(pin) is dict and {'path', 'bytes', 'sha256', 'mtime_ns'} <= pin.keys(), 'incomplete_file_pin')
    path = within(pin['path'], root)
    data, actual = stable_read(path)
    for key in ['bytes', 'sha256'] + (['mtime_ns'] if mtime else []):
        need(type(pin[key]) is type(actual[key]) and pin[key] == actual[key], 'file_pin_changed', str(path) + '/' + key)
    return data, actual


def media_inventory(pins, root):
    need(type(pins) is list and pins, 'missing_media_inventory')
    paths = [str(within(p['path'], root)).casefold() for p in pins]
    need(len(paths) == len(set(paths)), 'duplicate_media_path')
    return [check_pin(p, root)[1] for p in pins]


def complete_state(value, fields, fixture_root):
    need(type(value) is dict, 'missing_state')
    need(value.get('version') == VERSION, 'wrong_native_version')
    need(type(fields) is list and len(fields) == len(set(fields)) and CORE <= set(fields), 'incomplete_field_contract')
    need(value.get('typelib_track_scalar_properties') == fields, 'scalar_inventory_mismatch')
    tracks, playlists = value.get('tracks'), value.get('playlists')
    need(type(tracks) is list and type(playlists) is list, 'missing_enumeration')
    for key, count in [('track_count', len(tracks)), ('reported_track_count', len(tracks)),
                       ('reported_playlist_count', len(playlists))]:
        need(integer(value.get(key)) and value[key] == count, 'explicit_reported_count', key)
    need(valid_pid(value.get('library_persistent_id')), 'missing_master_pid')
    need(integer(value.get('sound_volume')) and value['sound_volume'] <= 100, 'missing_volume')
    ids = id_list([t.get('persistent_id') for t in tracks], 'tracks')
    pids = id_list([p.get('persistent_id') for p in playlists], 'playlists')
    for track in tracks:
        need(CORE | set(fields) <= track.keys(), 'missing_metadata', track.get('persistent_id'))
        for name in CORE | set(fields):
            v = track[name]
            need(type(v) in (str, int, float, bool) and (type(v) is not float or math.isfinite(v)),
                 'unavailable_metadata', name)
        for name in CORE_TEXT + CORE_DATES:
            need(type(track[name]) is str, 'metadata_type', name)
        for name in CORE_NUMBER:
            need(finite(track[name]), 'metadata_type', name)
        for name in CORE_BOOL:
            need(type(track[name]) is bool, 'metadata_type', name)
        within(track['Location'], fixture_root)
        need(track.get('file_exists') is True, 'missing_media_observation')
        # Unexpected non-scalar fields cannot hide unavailable observations.
        for key, item in track.items():
            need(type(item) in (str, int, float, bool), 'non_scalar_track_observation', key)
    by_id = {t['persistent_id']: t for t in tracks}
    masters = [p for p in playlists if p.get('kind') == 1]
    need(len(masters) == 1 and masters[0]['persistent_id'] == value['library_persistent_id'], 'master_identity')
    for pl in playlists:
        need(type(pl.get('name')) is str and integer(pl.get('kind'), 1), 'playlist_metadata')
        need('special_kind' in pl and (pl['special_kind'] is None or integer(pl['special_kind'])), 'playlist_classification')
        need(type(pl.get('Smart')) is bool and 'parent_persistent_id' in pl, 'playlist_metadata')
        need(pl['kind'] != 2 or integer(pl['special_kind']), 'playlist_classification')
        parent = pl['parent_persistent_id']
        need(parent is None or (valid_pid(parent) and parent in pids and parent != pl['persistent_id']), 'playlist_parent')
        members = pl.get('members')
        need(type(members) is list, 'missing_members')
        manual = pl['kind'] == 2 and pl['special_kind'] == 0 and pl['Smart'] is False
        for member in members:
            need(member.get('persistent_id') in ids, 'dangling_visible_member')
            need(type(member.get('name')) is str and member['name'] == by_id[member['persistent_id']]['Name'], 'member_name_mismatch')
            if manual:
                need(integer(member.get('play_order_index'), 1), 'manual_order_token')
        if manual:
            tokens = [m['play_order_index'] for m in members]
            need(len(tokens) == len(set(tokens)), 'manual_order_token', 'ambiguous duplicate')
        # Any additional captured property is compared, never silently dropped.
        for key, item in pl.items():
            if key != 'members':
                need(item is None or type(item) in (str, int, float, bool), 'unavailable_playlist_metadata', key)
    need(collections.Counter(m['persistent_id'] for m in masters[0]['members']) == collections.Counter(ids), 'master_closure')
    for pl in playlists:
        seen = {pl['persistent_id']}; parent = pl['parent_persistent_id']
        while parent is not None:
            need(parent not in seen, 'playlist_parent_cycle'); seen.add(parent)
            parent = next(p for p in playlists if p['persistent_id'] == parent)['parent_persistent_id']
    return value


def state_projection(value):
    result = {k: v for k, v in value.items() if k not in ['tracks', 'playlists']}
    result['tracks'] = {t['persistent_id']: {k: v for k, v in t.items() if k not in SESSION} for t in value['tracks']}
    result['playlists'] = {}
    for pl in value['playlists']:
        row = {k: v for k, v in pl.items() if k != 'members' and k not in SESSION}
        ordered = pl['kind'] == 2 and pl['special_kind'] == 0 and pl['Smart'] is False
        members = sorted(pl['members'], key=lambda m: m['play_order_index']) if ordered else sorted(pl['members'], key=lambda m: m['persistent_id'])
        row['members'] = [{k: v for k, v in m.items() if k not in SESSION and k != 'play_order_index'} for m in members]
        result['playlists'][pl['persistent_id']] = row
    return result


def match_state(expected, actual, fields, root):
    # Validate BOTH sides. Equally incomplete observations are not equality.
    complete_state(expected, fields, root); complete_state(actual, fields, root)
    need(canonical(state_projection(expected)) == canonical(state_projection(actual)), 'state_intent_mismatch')


def number(b, offset, size=4, endian='little'):
    need(0 <= offset and offset + size <= len(b), 'raw_integer_boundary')
    return int.from_bytes(b[offset:offset + size], endian)


def frames(data):
    pos = 0; out = []
    while pos < len(data):
        need(pos + 12 <= len(data), 'raw_prefix_boundary')
        h, total = number(data, pos + 4), number(data, pos + 8)
        need(12 <= h <= total <= len(data) - pos, 'raw_record_boundary')
        out.append((data[pos:pos + total], h)); pos += total
        need(len(out) <= 100000, 'raw_record_limit')
    return out


def preserved_header_sha(header, mutable_fields=()):
    """Hash every byte except an explicit closed list of parsed structural fields.

    No inferred padding, unknown field or flag bit is discarded. Field offsets
    are constants at call sites; no plan-supplied ignore mask is accepted.
    """
    parts = []; start = 0
    for low, high in mutable_fields:
        need(start <= low < high <= len(header), 'invalid_header_mask')
        parts.append(header[start:low]); start = high
    parts.append(header[start:])
    return sha(b''.join(parts))


def raw_projection(data):
    """Ordered records AND ordered children, never sorted membership multisets."""
    need(144 <= len(data) <= MAX_BYTES and data[:4] == b'hdfm', 'raw_envelope')
    h = number(data, 4, endian='big')
    need(h == 144 and number(data, 8, endian='big') == len(data), 'raw_envelope_length')
    need(data[0x52] == 1 and data[0x43] in (0, 1), 'raw_profile')
    body, mode = data[h:], data[0x41]
    need(mode in (0, 1, 2), 'raw_encryption')
    count = (0 if mode == 0 else len(body) if mode == 1 else min(len(body), number(data, 0x5c, endian='big'))) & ~15
    if count:
        from Crypto.Cipher import AES
        body = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(body[:count]) + body[count:]
    if data[0x43]:
        decoder = zlib.decompressobj(); body = decoder.decompress(body, MAX_BYTES + 1)
        need(len(body) <= MAX_BYTES and decoder.eof and not decoder.unused_data and not decoder.unconsumed_tail, 'raw_compression')
    sections = []; roots = {}
    for sec, sh in frames(body):
        need(sec[:4] == b'msdh' and sh >= 16, 'raw_section')
        kind = number(sec, 12)
        need(kind not in roots, 'raw_duplicate_section'); roots[kind] = (sec, sh)
    need({1, 2, 9, 11} <= roots.keys(), 'raw_missing_sections')
    local = {}; track_ids = set(); playlists = {}; aux = {9: set(), 11: set()}
    record_counts = {}
    # Track identity mapping is built first, independent of on-disk section order.
    def records(kind):
        sec, sh = roots[kind]; payload = sec[sh:]
        tag = {1: b'mlth', 2: b'mlph', 9: b'mlah', 11: b'mlih'}[kind]
        need(payload[:4] == tag and len(payload) >= 12, 'raw_list')
        lh = number(payload, 4); need(12 <= lh <= len(payload), 'raw_list_header')
        rows = frames(payload[lh:]); need(len(rows) == number(payload, 8), 'raw_list_count')
        record_counts[kind] = len(rows)
        return rows
    for tr, th in records(1):
        need(tr[:4] == b'mith' and th == 756, 'raw_track_header')
        pid, lid = f'{number(tr, 0x80, 8):016X}', number(tr, 16)
        need(valid_pid(pid) and pid not in track_ids and lid and lid not in local, 'raw_track_identity')
        track_ids.add(pid); local[lid] = pid
    for kind in [9, 11]:
        pids = set()
        for rec, rh in records(kind):
            need(rec[:4] == (b'miah' if kind == 9 else b'miih') and rh >= 28, 'raw_aux_header')
            lid, pid = number(rec, 16), f'{number(rec, 20, 8):016X}'
            need(lid and lid not in aux[kind] and valid_pid(pid) and pid not in pids, 'raw_aux_identity')
            aux[kind].add(lid); pids.add(pid)
    def metadata(rec, rh):
        need(rec[:4] == b'mhoh' and rh >= 16, 'raw_metadata')
        return dict(tag='mhoh', type=number(rec, 12), bytes=len(rec), sha256=sha(rec))
    for kind, (sec, sh) in roots.items():
        if kind not in [1, 2, 9, 11]:
            sections.append(dict(type=kind, opaque_sha256=sha(sec)))
            continue
        ordered = []
        for rec, rh in records(kind):
            children = frames(rec[rh:]); row = {}
            if kind == 1:
                row.update(pid=f'{number(rec, 0x80, 8):016X}', local_id=number(rec, 16), album_id=number(rec, 0xdc), artist_id=number(rec, 0x1e0))
                need(row['album_id'] in aux[9] and row['artist_id'] in aux[11], 'raw_aux_reference')
                need(len(children) == number(rec, 12), 'raw_track_child_count')
                row['children'] = [metadata(c, ch) for c, ch in children]
                row['preserved_header_sha256'] = sha(rec[:rh])
            elif kind in [9, 11]:
                row.update(pid=f'{number(rec, 20, 8):016X}', local_id=number(rec, 16), record_sha256=sha(rec))
            else:
                need(rec[:4] == b'miph' and rh == 3500, 'raw_playlist_header')
                pid, lid = f'{number(rec, 0x1b8, 8):016X}', number(rec, 0xd40)
                need(valid_pid(pid) and pid not in playlists and lid and all(lid != p['local_id'] for p in playlists.values()), 'raw_playlist_identity')
                items = []; child_list = []; iids = set(); ipids = set(); metadata_count = 0
                for c, ch in children:
                    if c[:4] == b'mhoh':
                        child_list.append(metadata(c, ch)); metadata_count += 1
                    else:
                        need(c[:4] == b'mtph' and ch >= 0x4c, 'raw_member_header')
                        ref, iid, ipid = number(c, 0x18), number(c, 16), f'{number(c, 0x44, 8):016X}'
                        need(ref in local and iid and iid not in iids and valid_pid(ipid) and ipid not in ipids, 'raw_member_identity')
                        iids.add(iid); ipids.add(ipid); items.append(local[ref])
                        child_list.append(dict(tag='mtph', local_id=iid, pid=ipid, track_pid=local[ref], parent_entry=number(c, 0x14), group_byte=c[0x1c], header_sha256=sha(c[:ch]), children=[metadata(x, xh) for x, xh in frames(c[ch:])]))
                need(metadata_count == number(rec, 12) and len(items) == number(rec, 16), 'raw_playlist_child_count')
                row.update(pid=pid, local_id=lid, is_master=bool(number(rec, 0x14) & 0x10000), kind_word=number(rec, 0x238), members=items, children=child_list)
                # Only parsed record length and member count may grow on append.
                row['preserved_header_sha256'] = preserved_header_sha(rec[:rh], ((8, 12), (16, 20)))
                playlists[pid] = row
            ordered.append(row)
        payload = sec[sh:]; lh = number(payload, 4)
        sections.append(dict(type=kind, records=ordered,
                             preserved_header_sha256=preserved_header_sha(sec[:sh], ((8, 12),)),
                             preserved_list_header_sha256=preserved_header_sha(payload[:lh], ((8, 12),))))
    masters = [p for p in playlists.values() if p['is_master']]
    need(len(masters) == 1 and collections.Counter(masters[0]['members']) == collections.Counter(track_ids), 'raw_master_closure')
    for offset, kind in [(0x44, 1), (0x48, 2), (0x4c, 9), (0x54, 11)]:
        need(number(data, offset, endian='big') == record_counts[kind], 'raw_outer_counts')
    file_pid = f'{number(data, 0x34, 8, "big"):016X}'; need(valid_pid(file_pid), 'raw_file_pid')
    # Exact complement of wire length, parsed codec controls and checked counts.
    # Compression/AES representation may differ; decoded content must not.
    envelope = preserved_header_sha(data[:h], ((8, 12), (0x41, 0x42),
        (0x43, 0x50), (0x54, 0x58), (0x5c, 0x60)))
    return dict(profile='LE-756-3500-preserved-v2', file_pid=file_pid,
                master_pid=masters[0]['pid'], preserved_envelope_sha256=envelope, sections=sections)


class FrozenCase:
    """Externally supplied plan SHA is checked before every side-effect boundary."""
    def __init__(self, path, expected_sha256, root):
        self.root = Path(root).resolve(); self.fix = self.root / 'fixtures/dynamic4'
        self.path = within(path, self.root / 'reports/dynamic')
        data, self.pin = stable_read(self.path)
        need(re.fullmatch('[0-9a-f]{64}', expected_sha256 or '') is not None and sha(data) == expected_sha256, 'plan_pin')
        self.data = data; self.spec = load_json(data)
        s = self.spec
        need(s.get('schema') == 'itl4.g2.strict-passive-plan.v1', 'plan_schema')
        need(s.get('classification') in ['passive_preservation', 'independent_writer_append'], 'unsupported_case_classification')
        need(s.get('dwell_seconds') == [45, 30], 'two_observation_windows')
        need(utc(s['frozen_utc']) <= dt.datetime.now(dt.timezone.utc), 'future_expectation')
        need(s.get('expected_origin') == 'independent_pre_native_intent', 'self_observed_expectation')
        old = id_list(s.get('old_track_pids'), 'old'); new = id_list(s.get('new_track_pids'), 'new')
        need(not old & new, 'overlapping_old_new')
        need(bool(new) == (s['classification'] == 'independent_writer_append'), 'case_classification_ids')
        fields = s['track_fields']; self.fields = fields
        complete_state(s['before'], fields, self.fix); complete_state(s['expected'], fields, self.fix)
        need(old == {t['persistent_id'] for t in s['before']['tracks']}, 'old_id_partition')
        need(old | new == {t['persistent_id'] for t in s['expected']['tracks']}, 'expected_id_partition')
        need(old | new, 'empty_library_not_qualified')
        need(s['before']['library_persistent_id'] == s['expected']['library_persistent_id'], 'master_intent_changed')
        before_tracks = state_projection(s['before'])['tracks']; after_tracks = state_projection(s['expected'])['tracks']
        need(all(before_tracks[p] == after_tracks[p] for p in old), 'old_track_changed_by_intent')
        self.live = within(s['live'], self.fix)
        self.candidate_bytes, self.candidate = check_pin(s['candidate'], self.fix)
        self.baseline_bytes, self.baseline = check_pin(s['baseline'], self.fix)
        candidate_raw = raw_projection(self.candidate_bytes); baseline_raw = raw_projection(self.baseline_bytes)
        need(candidate_raw == s.get('expected_raw'), 'raw_intent_not_candidate')
        need(baseline_raw == s.get('before_raw'), 'raw_before_not_baseline')
        need(candidate_raw['file_pid'] == baseline_raw['file_pid'] == s.get('file_pid'), 'raw_selected_file_pid')
        need(candidate_raw['master_pid'] == baseline_raw['master_pid'] == s['expected']['library_persistent_id'], 'raw_com_master_disagree')
        need(candidate_raw['preserved_envelope_sha256'] == baseline_raw['preserved_envelope_sha256'],
             'raw_old_envelope_changed')
        raw_tracks = lambda r: {x['pid']: x for sec in r['sections'] if sec['type'] == 1 for x in sec['records']}
        bt, at = raw_tracks(baseline_raw), raw_tracks(candidate_raw)
        need(set(bt) == old and set(at) == old | new, 'raw_track_partition')
        need(all(bt[p] == at[p] for p in old), 'raw_old_track_changed')
        # Non-primary unknown sections remain exact; an append cannot invent closure.
        opaque = lambda r: [x for x in r['sections'] if 'opaque_sha256' in x]
        need(opaque(baseline_raw) == opaque(candidate_raw), 'opaque_section_changed')
        before_pl = {x['pid']: x for sec in baseline_raw['sections'] if sec['type'] == 2 for x in sec['records']}
        after_pl = {x['pid']: x for sec in candidate_raw['sections'] if sec['type'] == 2 for x in sec['records']}
        need(before_pl.keys() == after_pl.keys(), 'old_raw_playlist_set_changed')
        for pid, row in before_pl.items():
            current = after_pl[pid]
            kept = [x for x in current['children'] if x['tag'] != 'mtph' or x['track_pid'] in old]
            need(kept == row['children'], 'old_raw_physical_order_changed', pid)
            need([x for x in current['members'] if x in old] == row['members'], 'old_raw_membership_changed', pid)
            need(all(current[k] == row[k] for k in ['local_id', 'is_master', 'kind_word', 'preserved_header_sha256']), 'old_raw_playlist_identity_changed')
        need([x['type'] for x in candidate_raw['sections']] == [x['type'] for x in baseline_raw['sections']], 'raw_section_order_changed')
        for kind in [1, 2, 9, 11]:
            bsec = next(x for x in baseline_raw['sections'] if x['type'] == kind)
            asec = next(x for x in candidate_raw['sections'] if x['type'] == kind)
            need(all(bsec[k] == asec[k] for k in ['preserved_header_sha256', 'preserved_list_header_sha256']),
                 'raw_old_section_header_changed', kind)
            before_rows = next(x['records'] for x in baseline_raw['sections'] if x['type'] == kind)
            after_rows = next(x['records'] for x in candidate_raw['sections'] if x['type'] == kind)
            old_pids = {x['pid'] for x in before_rows}
            need([x['pid'] for x in after_rows if x['pid'] in old_pids] == [x['pid'] for x in before_rows], 'old_raw_record_order_changed')
            if kind in [9, 11]:
                need([x for x in after_rows if x['pid'] in old_pids] == before_rows, 'old_aux_record_changed')
        if not new:
            need(candidate_raw == baseline_raw and state_projection(s['expected']) == state_projection(s['before']), 'passive_intent_not_preservation')
        self.media = media_inventory(s.get('media'), self.fix)
        locations = {str(within(t['Location'], self.fix)).casefold() for t in s['expected']['tracks']}
        need(locations == {p['path'].casefold() for p in self.media}, 'incomplete_media_inventory')
        self.verify()

    def verify(self):
        data, pin = stable_read(self.path)
        need(data == self.data and pin == self.pin, 'frozen_plan_changed')
        need(canonical(self.spec) == canonical(load_json(self.data)), 'frozen_plan_in_memory_changed')
        check_pin(self.spec['candidate'], self.fix); check_pin(self.spec['baseline'], self.fix)
        need(media_inventory(self.spec['media'], self.fix) == self.media, 'media_inventory_changed')

    def state(self, actual):
        match_state(self.spec['expected'], actual, self.fields, self.fix)

    def raw(self, data):
        actual = raw_projection(data)
        need(actual == self.spec['expected_raw'], 'raw_full_order_or_intent_mismatch')
        return actual

    def cycle(self, value, index, previous_sha):
        self.verify(); need(index in (1, 2), 'cycle_index')
        need(type(value) is dict and value.get('index') == index, 'cycle_index')
        need(value.get('worker_exit_code') == 0 and type(value.get('worker_exit_code')) is int, 'worker_exit')
        com = value.get('com')
        need(type(com) is dict and com.get('ok') is True and com.get('quit_returned') is True, 'strict_com_success')
        need(com.get('errors') == [] and com.get('explicit_actions') == [] and com.get('update_info_from_file_called') is False, 'passive_worker_contract')
        need(value.get('native_exit_code') == 0 and type(value.get('native_exit_code')) is int and value.get('native_stopped') is True, 'normal_native_exit')
        need(value.get('input_sha256') == previous_sha and com.get('plan_sha256') == self.pin['sha256'], 'cycle_chain_or_plan')
        need(value.get('selection_verified') is True and value.get('selected_path') == str(self.live), 'selected_library_path')
        need(value.get('file_pid') == self.spec['file_pid'], 'selected_file_pid')
        need(value.get('modal_events') == [] and value.get('fallback_detected') is False, 'modal_or_fallback')
        start, end = utc(value['started_utc']), utc(value['completed_utc'])
        need(utc(self.spec['frozen_utc']) < start <= end and self.pin['mtime_ns'] <= int(start.timestamp()*1000000000), 'expectations_not_precommitted')
        samples = com.get('samples'); need(type(samples) is list and len(samples) >= 3, 'insufficient_observations')
        elapsed = [x.get('elapsed_seconds') for x in samples]
        need(all(finite(x) and x >= 0 for x in elapsed), 'observation_time')
        need(elapsed[0] <= 2 and all(0 < b - a <= 5 for a, b in zip(elapsed, elapsed[1:])), 'observation_coverage')
        need(elapsed[-1] - elapsed[0] >= self.spec['dwell_seconds'][index-1], 'insufficient_dwell')
        need((end-start).total_seconds() >= elapsed[-1], 'observation_clock_inconsistent')
        for sample in samples:
            self.state(sample.get('state'))
            need(sample.get('media') == self.media and sample.get('modal_events') == [], 'sample_media_or_modal')
        self.state(com.get('after')); need(com['after'] == samples[-1]['state'], 'final_observation_mismatch')
        saved = value.get('saved'); data, pin = check_pin(saved, self.root / 'reports/dynamic')
        need(pin['path'] != self.candidate['path'], 'saved_is_candidate')
        self.raw(data)
        return pin


class Authorization:
    """Runtime readiness AND a separately pinned parent handoff are both required."""
    def __init__(self, root, runtime_sha, handoff_path, handoff_sha, case):
        self.root = Path(root).resolve(); self.runtime_sha = runtime_sha
        self.handoff_path = within(handoff_path, self.root / 'reports/parent')
        self.handoff_sha = handoff_sha; self.case = case

    def check(self, budget_seconds=0):
        data, _ = stable_read(self.root/'runtime.json')
        need(sha(data) == self.runtime_sha, 'runtime_pin_changed')
        r = load_json(data)
        need(r.get('generation') == 2 and r.get('native_owner') == 'dynamic', 'native_owner')
        need(r.get('native_ready') is True and r.get('native_handoff_issued') is True, 'native_not_authorized')
        schedule = r.get('g2_schedule', {})
        need(schedule.get('native_permission_granted') is True, 'native_not_authorized')
        hdata, _ = stable_read(self.handoff_path)
        need(sha(hdata) == self.handoff_sha, 'handoff_pin_changed'); h = load_json(hdata)
        need(h.get('schema') == 'itl4.g2.dynamic-native-handoff.v1' and h.get('authorized') is True,
             'explicit_handoff_required')
        need(h.get('plan_sha256') == self.case.pin['sha256'] and h.get('root') == str(self.root), 'handoff_case_scope')
        need(h.get('env_id') == r.get('env_id') and h.get('acquisition_verified') is True, 'handoff_environment')
        deadline = min(utc(G2_CUTOFF), utc(schedule['native_cutoff_utc']), utc(h['not_after_utc']))
        need(dt.datetime.now(dt.timezone.utc) + dt.timedelta(seconds=budget_seconds) < deadline, 'native_cutoff')
        self.case.verify()
        return deadline
