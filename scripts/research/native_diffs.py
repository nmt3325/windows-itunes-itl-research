"""Compare closed synthetic iTunes snapshots; never modifies inputs.
Usage: python native_diffs.py SNAPSHOT_DIRECTORY OUTPUT_JSON
Dependency: pycryptodome. This is evidence extraction, not a writer.
Only the observed little-endian, compressed, capped-encryption profile is accepted.
"""
import hashlib
import json
import struct
import sys
import zlib
from pathlib import Path
from Crypto.Cipher import AES


def u32(b, p):
    return struct.unpack_from('<I', b, p)[0]


def digest(b):
    return hashlib.sha256(b).hexdigest()


def inspect(path):
    raw = path.read_bytes()
    assert raw[:4] == b'hdfm'
    hs = struct.unpack_from('>I', raw, 4)[0]
    cap = struct.unpack_from('>I', raw, 92)[0]
    if hs != 0x90 or raw[0x41] != 2 or not raw[0x43] or not raw[0x52]:
        raise ValueError('unsupported profile for this evidence-only extractor')
    if len(raw) < hs or struct.unpack_from('>I', raw, 8)[0] != len(raw):
        raise ValueError('physical file size mismatch')
    n = min(len(raw) - hs, cap) & ~15
    decoded = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(raw[hs:hs+n]) + raw[hs+n:]
    inflater = zlib.decompressobj()
    budget = 64 * 1024 * 1024
    plain = inflater.decompress(decoded, budget + 1)
    if len(plain) > budget or inflater.unconsumed_tail or not inflater.eof or inflater.unused_data:
        raise ValueError('incomplete, trailing, or excessive compressed data')
    sections, tracks = {}, {}
    pos = 0
    while pos < len(plain):
        assert plain[pos:pos+4] == b'msdh'
        head, size, kind = struct.unpack_from('<III', plain, pos+4)
        assert 16 <= head <= size and pos + size <= len(plain)
        assert kind not in sections, 'Duplicate section type: adapt evidence extractor'
        section = plain[pos:pos+size]
        sections[kind] = section
        if kind == 1:
            p = head
            assert section[p:p+4] == b'mlth'
            count = u32(section, p+8)
            p += u32(section, p+4)
            for _ in range(count):
                assert section[p:p+4] == b'mith'
                length = u32(section, p+8)
                record = section[p:p+length]
                assert len(record) == length and length >= u32(record, 4) >= 0x88
                pid = f'{struct.unpack_from("<Q", record, 0x80)[0]:016X}'
                assert pid not in tracks
                tracks[pid] = record
                p += length
            assert p == len(section)
        pos += size
    assert pos == len(plain)
    return {'file_sha256': digest(raw), 'plain_sha256': digest(plain), 'sections': sections, 'tracks': tracks}


def metadata(record):
    pos = u32(record, 4)
    result = {}
    while pos < len(record):
        assert record[pos:pos+4] == b'mhoh'
        size = u32(record, pos+8)
        assert 24 <= size and pos+size <= len(record)
        kind = u32(record, pos+12)
        result.setdefault(kind, []).append(digest(record[pos:pos+size]))
        pos += size
    assert pos == len(record)
    return result


def compare(a, b):
    section_changes = [k for k in sorted(a['sections'].keys() | b['sections'].keys()) if a['sections'].get(k) != b['sections'].get(k)]
    changes = []
    for pid in sorted(a['tracks'].keys() | b['tracks'].keys()):
        x, y = a['tracks'].get(pid), b['tracks'].get(pid)
        if x == y:
            continue
        if x is None or y is None:
            changes.append({'pid': pid, 'kind': 'added' if x is None else 'removed'})
            continue
        xh, yh = u32(x, 4), u32(y, 4)
        xm, ym = metadata(x), metadata(y)
        changes.append({'pid': pid, 'header_sizes': [xh, yh], 'header_changed_byte_offsets': [hex(i) for i in range(min(xh, yh)) if x[i] != y[i]], 'metadata_types_changed': [hex(k) for k in sorted(xm.keys() | ym.keys()) if xm.get(k) != ym.get(k)]})
    return {'section_types_changed': section_changes, 'tracks': changes}


def main():
    folder, output = map(Path, sys.argv[1:3])
    names = ['003-three-tracks-reloaded.itl', '010-name-unicode.itl', '011-name-long.itl', '012-name-short.itl', '013-artist-unicode.itl', '014-album.itl', '015-album-artist.itl', '016-comment.itl', '017-rating.itl', '018-play-count.itl', '019-skip-count.itl', '020-play-date.itl', '021-skip-date.itl', '022-year.itl', '023-track-number.itl', '024-compilation.itl', '030-playlist-create.itl', '031-playlist-add.itl', '032-playlist-rename.itl', '033-playlist-order.itl', '034-playlist-remove.itl', '035-playlist-create-delete.itl', '036-playlist-delete.itl']
    rows = []
    for before, after in zip(names, names[1:]):
        if not (folder/before).exists() or not (folder/after).exists():
            rows.append({'before': before, 'after': after, 'status': 'missing input'})
            continue
        a, b = inspect(folder/before), inspect(folder/after)
        rows.append({'before': before, 'after': after, 'before_sha256': a['file_sha256'], 'after_sha256': b['file_sha256'], **compare(a, b)})
    with output.open('x', encoding='utf-8') as f:
        json.dump(rows, f, ensure_ascii=False, indent=2)
    for r in rows:
        print(r['after'], 'sections', r.get('section_types_changed'), 'track_changes', r.get('tracks'))


if __name__ == '__main__':
    main()
