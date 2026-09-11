#!/usr/bin/env python3
"""G4-B a07: structural census of ITL msdh sections 4, 21 (msph800) and 23.

Read-only research tool. It never launches iTunes, never writes an .itl file
and never edits production modules. Every fact comes from the native snapshots
already committed under evidence/native/snapshots/.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import plistlib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from itlkit.binary import uint  # noqa: E402
from itlkit.container import Container  # noqa: E402
from itlkit.model import parse_sections, serialize_sections  # noqa: E402

EXPECTED_ORDER = [16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4]
REGIONS = (4, 21, 23)


def sha(data):
    return hashlib.sha256(bytes(data)).hexdigest()


def nonzero_words(buf, skip=()):
    out = {}
    for off in range(0, len(buf) - 3, 4):
        if off in skip:
            continue
        value = uint(buf, off, 4)
        if value:
            out['+0x%x' % off] = value
    return out


def plain(value):
    if isinstance(value, dict):
        return {str(k): plain(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [plain(v) for v in value]
    if isinstance(value, (bytes, bytearray)):
        return bytes(value).hex()
    if hasattr(value, 'isoformat'):
        return value.isoformat()
    return value


def mhoh_text(node):
    payload = bytes(node.payload)
    if len(payload) < 16:
        return None
    encoding = uint(payload, 0, 4)
    length = uint(payload, 4, 4)
    data = payload[16:16 + length]
    if encoding == 1:
        text = data.decode('utf-16-le', 'replace')
    else:
        text = data.decode('latin-1')
    return {'encoding': encoding, 'byte_length': length, 'text': text,
            'suffix_bytes': len(payload) - 16 - length}


def xml_facts(xml):
    facts = {'bytes': len(xml), 'sha256': sha(xml),
             'ascii_only': all(b < 128 for b in xml),
             'declares_utf8': b'encoding="UTF-8"' in xml[:80],
             'has_apple_doctype': b'<!DOCTYPE plist' in xml[:200],
             'ends_with_newline': xml.endswith(b'\n'),
             'trailing_nul': xml.endswith(b'\x00')}
    try:
        value = plistlib.loads(xml)
    except Exception as exc:  # noqa: BLE001
        facts['parse_error'] = type(exc).__name__ + ': ' + str(exc)
        return facts
    facts['is_dict'] = isinstance(value, dict)
    if isinstance(value, dict):
        facts['keys'] = sorted(value)
        facts['scalars'] = {k: plain(v) for k, v in sorted(value.items())
                            if not isinstance(v, (list, dict))}
        facts['collections'] = {k: {'type': type(v).__name__, 'len': len(v)}
                                for k, v in sorted(value.items())
                                if isinstance(v, (list, dict))}
        nested = value.get('defaultSettings')
        if isinstance(nested, dict):
            facts['defaultSettings'] = {k: plain(v) for k, v in sorted(nested.items())}
    return facts


def section4_facts(section):
    payload = bytes(section.payload)
    text = None
    try:
        text = payload.decode('ascii')
    except UnicodeDecodeError:
        pass
    facts = {'declared_total': uint(section.header, 8),
             'msdh_header_len': len(section.header),
             'payload_len': len(payload),
             'payload_sha256': sha(payload),
             'msdh_extra_nonzero': nonzero_words(section.header, skip=(0, 4, 8, 12)),
             'parsed_as_children': section.children is not None,
             'ascii': text is not None,
             'first4': payload[:4].decode('latin-1'),
             'framed_record_plausible': bool(
                 len(payload) >= 12 and 12 <= uint(payload, 4) <= len(payload)
                 and uint(payload, 4) <= uint(payload, 8) <= len(payload)),
             'nul_terminated': payload.endswith(b'\x00'),
             'total_equals_header_plus_payload':
                 uint(section.header, 8) == len(section.header) + len(payload)}
    if text is not None:
        facts['text'] = text
        facts['text_sha256'] = sha(text.encode())
        facts['is_file_localhost_url'] = text.startswith('file://localhost/')
        facts['trailing_slash'] = text.endswith('/')
        facts['percent_escapes'] = text.count('%')
    return facts


def section23_facts(section):
    payload = bytes(section.payload)
    facts = {'declared_total': uint(section.header, 8),
             'msdh_header_len': len(section.header),
             'payload_len': len(payload),
             'payload_sha256': sha(payload),
             'msdh_extra_nonzero': nonzero_words(section.header, skip=(0, 4, 8, 12)),
             'parsed_as_children': section.children is not None,
             'root_tag': payload[:4].decode('latin-1', 'replace'),
             'total_equals_header_plus_payload':
                 uint(section.header, 8) == len(section.header) + len(payload)}
    if len(payload) >= 16:
        facts['root_header_len'] = uint(payload, 4)
        facts['root_plus8'] = uint(payload, 8)
        facts['root_plus12'] = uint(payload, 12)
        facts['bytes_after_root_header'] = len(payload) - uint(payload, 4)
        facts['root_header_spans_payload'] = uint(payload, 4) == len(payload)
        facts['nonzero_words'] = nonzero_words(payload, skip=(0, 4))
        facts['tail_after_16_all_zero'] = not any(payload[16:])
    return facts


def section21_facts(section):
    facts = {'declared_total': uint(section.header, 8),
             'msdh_header_len': len(section.header),
             'msdh_extra_nonzero': nonzero_words(section.header, skip=(0, 4, 8, 12))}
    root = section.children[0] if section.children else None
    if root is None:
        facts['root'] = None
        return facts
    children = list(root.children or ())
    facts['root'] = {'tag': root.tag.decode('latin-1', 'replace'),
                     'header_len': len(root.header),
                     'count_at_plus8': uint(root.header, 8),
                     'child_count': len(children),
                     'count_matches_children': uint(root.header, 8) == len(children),
                     'extra_nonzero': nonzero_words(root.header, skip=(0, 4, 8))}
    records = []
    for child in children:
        payload = bytes(child.payload)
        record = {'tag': child.tag.decode('latin-1', 'replace'),
                  'header_len': len(child.header),
                  'declared_total': uint(child.header, 8),
                  'plus12': uint(child.header, 12),
                  'header_tail_after_16_zero': not any(child.header[16:]),
                  'payload_len': len(payload),
                  'record_sha256': sha(child.to_bytes()),
                  'total_equals_header_plus_payload':
                      uint(child.header, 8) == len(child.header) + len(payload)}
        if len(payload) >= 24 and payload[:4] == b'mhoh':
            record['mhoh'] = {'header_len': uint(payload, 4),
                              'declared_total': uint(payload, 8),
                              'type_code': uint(payload, 12),
                              'reserved_16_24_zero': not any(payload[16:24]),
                              'body_bytes': len(payload) - 24,
                              'total_equals_payload_len': uint(payload, 8) == len(payload)}
            record['xml'] = xml_facts(payload[24:])
        records.append(record)
    facts['records'] = records
    total = (len(section.header) + len(root.header)
             + sum(uint(c.header, 8) for c in children))
    facts['section_total_equals_sum_of_frames'] = uint(section.header, 8) == total
    return facts


def track_locations(sections):
    out = []
    for section in sections:
        if section.section_type != 1 or not section.children:
            continue
        for track in section.children[0].children or ():
            if track.tag != b'mith':
                continue
            for child in track.children or ():
                if child.tag == b'mhoh' and child.type_code in (11, 13):
                    text = mhoh_text(child)
                    if text:
                        out.append({'type_code': child.type_code, **text})
    return out


def inspect(path):
    data = path.read_bytes()
    container = Container.from_bytes(data)
    payload = container.payload
    sections = parse_sections(payload)
    header = container.header
    record = {'file': path.name,
              'file_bytes': len(data),
              'file_sha256': sha(data),
              'plain_bytes': len(payload),
              'plain_sha256': sha(payload),
              'version': container.version,
              'encryption_flag': container.encryption_flag,
              'compression_flag': container.compression_flag,
              'byteorder': container.payload_byteorder,
              'trailer_bytes': len(container.trailer),
              'file_pid': '%016X' % uint(header, 0x34, 8, endian='big'),
              'header_counts': {'tracks': uint(header, 0x44, 4, endian='big'),
                                'playlists': uint(header, 0x48, 4, endian='big'),
                                'albums': uint(header, 0x4c, 4, endian='big'),
                                'artists': uint(header, 0x54, 4, endian='big')},
              'section_order': [s.section_type for s in sections],
              'payload_roundtrip_exact': serialize_sections(sections) == payload}
    by_type = {}
    for section in sections:
        by_type.setdefault(section.section_type, []).append(section)
    record['region_counts'] = {str(k): len(by_type.get(k, [])) for k in REGIONS}
    record['section4'] = [section4_facts(s) for s in by_type.get(4, [])]
    record['section23'] = [section23_facts(s) for s in by_type.get(23, [])]
    record['section21'] = [section21_facts(s) for s in by_type.get(21, [])]
    locations = track_locations(sections)
    media_url = record['section4'][0].get('text') if record['section4'] else None
    urls = [x for x in locations if x['type_code'] == 11]
    record['locations'] = {
        'url_objects': len(urls),
        'path_objects': len(locations) - len(urls),
        'url_encodings': sorted({x['encoding'] for x in urls}),
        'urls_prefixed_by_section4': (
            sum(1 for x in urls if media_url and x['text'].startswith(media_url))
            if media_url else None),
        'section4_url_appears_verbatim_elsewhere': (
            payload.count(media_url.encode()) if media_url else None)}
    invariants = {
        'section_order_matches_importer_profile': record['section_order'] == EXPECTED_ORDER,
        'payload_roundtrip_exact': record['payload_roundtrip_exact'],
        'exactly_one_section4': len(by_type.get(4, [])) == 1,
        'exactly_one_section21': len(by_type.get(21, [])) == 1,
        'exactly_one_section23': len(by_type.get(23, [])) == 1,
    }
    if record['section4']:
        f4 = record['section4'][0]
        invariants['section4_opaque_unframed'] = not f4['framed_record_plausible']
        invariants['section4_ascii_file_url'] = bool(f4.get('is_file_localhost_url'))
        invariants['section4_no_nul_terminator'] = not f4['nul_terminated']
        invariants['section4_total_arithmetic'] = f4['total_equals_header_plus_payload']
        invariants['section4_msdh_header_clean'] = not f4['msdh_extra_nonzero']
    if record['section23']:
        f23 = record['section23'][0]
        invariants['section23_root_is_stsh'] = f23['root_tag'] == 'stsh'
        invariants['section23_root_header_spans_payload'] = f23.get('root_header_spans_payload')
        invariants['section23_plus8_is_zero'] = f23.get('root_plus8') == 0
        invariants['section23_tail_zero'] = f23.get('tail_after_16_all_zero')
        invariants['section23_total_arithmetic'] = f23['total_equals_header_plus_payload']
    if record['section21']:
        f21 = record['section21'][0]
        root = f21.get('root') or {}
        recs = f21.get('records') or []
        invariants['section21_root_is_mlsh'] = root.get('tag') == 'mlsh'
        invariants['section21_count_matches_children'] = bool(root.get('count_matches_children'))
        invariants['section21_single_msph'] = len(recs) == 1
        invariants['section21_frame_arithmetic'] = bool(f21.get('section_total_equals_sum_of_frames'))
        if recs:
            r0 = recs[0]
            invariants['msph_header_48'] = r0['header_len'] == 48
            invariants['msph_plus12_is_1'] = r0['plus12'] == 1
            invariants['msph_header_tail_zero'] = r0['header_tail_after_16_zero']
            invariants['msph_total_arithmetic'] = r0['total_equals_header_plus_payload']
            mhoh = r0.get('mhoh') or {}
            invariants['msph_payload_is_mhoh800'] = mhoh.get('type_code') == 800
            invariants['mhoh800_header_24'] = mhoh.get('header_len') == 24
            invariants['mhoh800_total_arithmetic'] = bool(mhoh.get('total_equals_payload_len'))
            xml = r0.get('xml') or {}
            invariants['mhoh800_body_is_plist_dict'] = bool(xml.get('is_dict'))
            invariants['mhoh800_no_trailing_nul'] = not xml.get('trailing_nul', False)
    record['invariants'] = invariants
    record['invariant_failures'] = sorted(k for k, v in invariants.items() if not v)
    return record


def cluster(records, getter):
    out = {}
    for record in records:
        key, extra = getter(record)
        if key is None:
            continue
        entry = out.setdefault(key, {'files': [], 'sample': extra})
        entry['files'].append(record['file'])
    for entry in out.values():
        entry['file_count'] = len(entry['files'])
    return out


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--snapshots', default=str(ROOT / 'evidence/native/snapshots'))
    parser.add_argument('--out', default=None)
    args = parser.parse_args()
    paths = sorted(Path(args.snapshots).glob('*.itl'))
    records, errors = [], []
    for path in paths:
        try:
            records.append(inspect(path))
        except Exception as exc:  # noqa: BLE001
            errors.append({'file': path.name, 'error': type(exc).__name__ + ': ' + str(exc)})
    s4 = cluster(records, lambda r: ((r['section4'][0]['payload_sha256'], )[0] if r['section4'] else None,
                                     {'text': r['section4'][0].get('text'),
                                      'payload_len': r['section4'][0]['payload_len']} if r['section4'] else None))
    s23 = cluster(records, lambda r: (r['section23'][0]['payload_sha256'] if r['section23'] else None,
                                      {'payload_len': r['section23'][0]['payload_len'],
                                       'root_plus8': r['section23'][0].get('root_plus8')} if r['section23'] else None))

    def msph_key(r):
        recs = (r['section21'][0].get('records') if r['section21'] else None) or []
        if not recs or 'xml' not in recs[0]:
            return None, None
        xml = recs[0]['xml']
        return xml['sha256'], {'bytes': xml['bytes'], 'keys': xml.get('keys'),
                               'scalars': xml.get('scalars')}
    s21 = cluster(records, msph_key)
    all_failures = {}
    for record in records:
        for name in record['invariant_failures']:
            all_failures.setdefault(name, []).append(record['file'])
    summary = {
        'schema': 'g4.a07.section-census.v1',
        'snapshot_dir': str(Path(args.snapshots).relative_to(ROOT)),
        'snapshot_count': len(paths),
        'decoded': len(records),
        'decode_errors': errors,
        'versions': sorted({r['version'] for r in records}),
        'section_orders': sorted({tuple(r['section_order']) for r in records}),
        'section4_clusters': s4,
        'section23_clusters': s23,
        'msph800_xml_clusters': s21,
        'invariant_failures': all_failures,
        'roundtrip_failures': [r['file'] for r in records if not r['payload_roundtrip_exact']],
    }
    summary['section_orders'] = [list(x) for x in summary['section_orders']]
    document = {'summary': summary, 'files': records}
    if args.out:
        Path(args.out).parent.mkdir(parents=True, exist_ok=True)
        Path(args.out).write_text(json.dumps(plain(document), indent=1, sort_keys=True) + '\n',
                                  encoding='utf-8')
    print('snapshots:', len(paths), 'decoded:', len(records), 'errors:', len(errors))
    print('versions:', summary['versions'])
    print('distinct section orders:', summary['section_orders'])
    print('roundtrip failures:', summary['roundtrip_failures'])
    print('invariant failures:', json.dumps(all_failures, indent=1, sort_keys=True))
    print('--- section 4 clusters (%d) ---' % len(s4))
    for digest, entry in sorted(s4.items(), key=lambda kv: -kv[1]['file_count']):
        print(' ', digest[:16], entry['file_count'], 'files, len',
              entry['sample']['payload_len'], repr(entry['sample']['text']))
    print('--- section 23 clusters (%d) ---' % len(s23))
    for digest, entry in sorted(s23.items(), key=lambda kv: -kv[1]['file_count']):
        print(' ', digest[:16], entry['file_count'], 'files, sample', entry['sample'])
    print('--- msph800 xml clusters (%d) ---' % len(s21))
    for digest, entry in sorted(s21.items(), key=lambda kv: -kv[1]['file_count']):
        print(' ', digest[:16], entry['file_count'], 'files, bytes', entry['sample']['bytes'])
        print('    scalars:', json.dumps(entry['sample']['scalars'], sort_keys=True, ensure_ascii=False))
    if records:
        print('--- keys observed ---',
              json.dumps(sorted({k for r in records for rec in (r['section21'][0].get('records') or [])
                                 for k in (rec.get('xml', {}).get('keys') or [])}), ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
