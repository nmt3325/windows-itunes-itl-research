"""Read-only, bounded native-save identity/reference audit for the observed LE profile.
Uses record boundaries, not marker searches. Unknown record semantics are not certified.
"""
import argparse
import collections
import pathlib
import struct
import zlib
from passive_native import facts, load, write_json, digest

MAX_BYTES = 32 * 1024 * 1024


def need(ok, message):
    if not ok:
        raise ValueError(message)


def number(data, offset, size=4, endian='little'):
    need(0 <= offset and offset + size <= len(data), 'Integer outside record')
    return int.from_bytes(data[offset:offset + size], endian)


def frames(data):
    rows = []; pos = 0
    while pos < len(data):
        need(pos + 12 <= len(data), 'Truncated record prefix')
        header = number(data, pos + 4); total = number(data, pos + 8)
        need(12 <= header <= total <= len(data) - pos, 'Invalid record boundary')
        rows.append((data[pos:pos + total], header)); pos += total
    return rows


def text(record, header):
    need(record[:4] == b'mhoh' and header >= 16, 'Not string metadata')
    body = record[header:]; need(len(body) >= 16, 'Short text prefix')
    encoding = number(body, 0); size = number(body, 4); code = number(record, 12)
    need(size <= len(body) - 16, 'String outside metadata record')
    codecs = {1: 'utf-16le', 3: 'latin1'}
    if encoding == 2 and code == 11:
        codecs[2] = 'ascii'
    need(encoding in codecs, 'Unsupported string representation')
    return body[16:16 + size].decode(codecs[encoding], errors='strict')


def children(record, header):
    return frames(record[header:])


def strings(rows, codes):
    result = {}
    for rec, h in rows:
        if rec[:4] == b'mhoh' and number(rec, 12) in codes:
            code = number(rec, 12); need(code not in result, 'Duplicate selected metadata type')
            result[code] = text(rec, h)
    return result


def decode(path):
    raw = path.read_bytes(); need(144 <= len(raw) <= MAX_BYTES and raw[:4] == b'hdfm', 'Unsupported envelope')
    h = number(raw, 4, endian='big'); need(144 <= h <= len(raw), 'Invalid outer header')
    need(number(raw, 8, endian='big') == len(raw), 'Outer length mismatch')
    need(raw[0x52] != 0, 'LE audit only')
    body = raw[h:]; mode = raw[0x41]; cap = number(raw, 0x5c, endian='big')
    need(mode in (0, 1, 2), 'Unknown encryption mode')
    n = (0 if mode == 0 else len(body) if mode == 1 else min(len(body), cap)) & ~15
    if n:
        from Crypto.Cipher import AES
        decoded = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(body[:n]) + body[n:]
    else:
        decoded = body
    if raw[0x43]:
        decoder = zlib.decompressobj(); plain = decoder.decompress(decoded, MAX_BYTES)
        need(decoder.eof and not decoder.unused_data and not decoder.unconsumed_tail, 'Invalid or oversized compressed body')
    else:
        plain = decoded
    return raw, plain


def profile(path):
    raw, plain = decode(path); roots = {}; section_info = []
    for sec, h in frames(plain):
        need(sec[:4] == b'msdh' and h >= 16, 'Invalid section')
        kind = number(sec, 12); need(kind not in roots, 'Duplicate section type')
        roots[kind] = sec[h:]; section_info.append({'type': kind, 'bytes': len(sec), 'sha256': digest(sec)})
    def records(kind, tag):
        data = roots[kind]; need(data[:4] == tag and len(data) >= 12, 'Wrong list root')
        h = number(data, 4); need(12 <= h <= len(data), 'Bad list header')
        rows = frames(data[h:]); need(len(rows) == number(data, 8), 'List count mismatch')
        return rows
    tracks = {}; local = {}
    for rec, h in records(1, b'mlth'):
        need(rec[:4] == b'mith' and h == 756, 'Unverified track header')
        pid = f'{number(rec, 0x80, 8):016X}'; lid = number(rec, 0x10)
        need(int(pid, 16) != 0 and pid not in tracks and lid != 0 and lid not in local, 'Duplicate/zero track identity')
        rows = children(rec, h); need(len(rows) == number(rec, 12), 'Track child count mismatch')
        tracks[pid] = {'local_id': lid, 'album_id': number(rec, 0xdc), 'artist_id': number(rec, 0x1e0),
                       'text': strings(rows, {2, 3, 4, 8, 11, 13, 27}), 'record_sha256': digest(rec)}
        local[lid] = pid
    objects = {}
    for kind, tag, item in [(9, b'mlah', b'miah'), (11, b'mlih', b'miih')]:
        bucket = {}; pids = set()
        for rec, h in records(kind, tag):
            need(rec[:4] == item and h >= 28, 'Wrong auxiliary record')
            lid = number(rec, 16); pid = f'{number(rec, 20, 8):016X}'
            need(lid and lid not in bucket and int(pid, 16) and pid not in pids, 'Duplicate/zero auxiliary identity')
            pids.add(pid); bucket[lid] = {'persistent_id': pid, 'record_sha256': digest(rec)}
        objects[kind] = bucket
    for track in tracks.values():
        need(track['album_id'] in objects[9] and track['artist_id'] in objects[11], 'Dangling album/artist reference')
    playlists = {}; playlist_lids = set()
    for rec, h in records(2, b'mlph'):
        need(rec[:4] == b'miph' and h == 3500, 'Unverified playlist header')
        pid = f'{number(rec, 0x1b8, 8):016X}'; lid = number(rec, 0xd40)
        need(int(pid, 16) and pid not in playlists and lid and lid not in playlist_lids, 'Duplicate/zero playlist identity')
        playlist_lids.add(lid); rows = children(rec, h)
        metadata = [(c, ch) for c, ch in rows if c[:4] == b'mhoh']; items = [(c, ch) for c, ch in rows if c[:4] == b'mtph']
        need(len(metadata) == number(rec, 12) and len(items) == number(rec, 16) and len(rows) == len(metadata) + len(items), 'Playlist child count/type mismatch')
        members = []; item_ids = set(); item_pids = set()
        for child, ch in items:
            need(ch >= 0x4c, 'Short membership record'); ref = number(child, 0x18)
            need(ref in local, 'Dangling membership reference')
            iid = number(child, 0x10); ipid = number(child, 0x44, 8)
            need(iid and iid not in item_ids and ipid and ipid not in item_pids, 'Duplicate/zero membership identity')
            item_ids.add(iid); item_pids.add(ipid); members.append(local[ref])
        names = strings(metadata, {100}); master = bool(number(rec, 0x14) & 0x10000)
        if master:
            need(collections.Counter(members) == collections.Counter(tracks.keys()), 'Raw master membership mismatch')
        playlists[pid] = {'name': names.get(100), 'is_master': master, 'kind_word': number(rec, 0x238), 'member_pids': members}
    need(sum(p['is_master'] for p in playlists.values()) == 1, 'Raw master not unique')
    for offset, count in [(0x44, len(tracks)), (0x48, len(playlists)), (0x4c, len(objects[9])), (0x54, len(objects[11]))]:
        need(number(raw, offset, endian='big') == count, 'Outer/list count disagreement')
    return {'file': facts(path), 'file_pid': f'{number(raw, 0x34, 8, "big"):016X}', 'expanded_sha256': digest(plain),
            'sections': section_info, 'tracks': tracks, 'playlists': playlists, 'albums': objects[9], 'artists': objects[11]}


def audit(case_path, result_path):
    case = load(case_path); result = load(result_path); request = case['producer_request']
    expected = request.get('expected_raw_playlists_before_native')
    if expected is None:
        expected = request['expected']['all_serialized_playlists']
    wanted = {p['persistent_id']: p for p in expected}; ids = {t['persistent_id'] for t in case['expected']['tracks']}
    outputs = []
    for cycle in result['cycles']:
        p = profile(pathlib.Path(cycle['saved']['path'])); need(p['file']['sha256'] == cycle['saved']['sha256'], 'Native snapshot hash changed')
        need(p['file_pid'] == case['file_persistent_id'] and set(p['tracks']) == ids, 'Saved identity set mismatch')
        need(set(p['playlists']) == set(wanted), 'Saved playlist PID set changed')
        for pid, expected_pl in wanted.items():
            actual = p['playlists'][pid]; members = expected_pl.get('member_persistent_ids', expected_pl.get('member_pids_physical_order'))
            need(members is not None, 'Incomplete expected raw membership')
            need(collections.Counter(members) == collections.Counter(actual['member_pids']), 'Saved raw membership differs')
            need(actual['name'] == expected_pl.get('raw_name', expected_pl.get('name')), 'Saved raw playlist title differs')
        outputs.append({'cycle': cycle['cycle'], 'reference_closure_passed': True, 'profile': p})
    need(len(outputs) == 2, 'Two native saves required')
    return {'case': case['name'], 'raw_gate_passed': True, 'cycles': outputs,
            'scope': 'Known LE track/object/item identities and all serialized playlist membership multisets. COM separately verifies ordinary displayed order. Unknown opaque references are not certified.'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(); parser.add_argument('--case', type=pathlib.Path, required=True); parser.add_argument('--result', type=pathlib.Path, required=True); parser.add_argument('--out', type=pathlib.Path, required=True)
    args = parser.parse_args(); need(not args.out.exists(), 'Audit output already exists'); value = audit(args.case, args.result); write_json(args.out, value); print(value['case'], value['raw_gate_passed'])
