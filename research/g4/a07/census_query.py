#!/usr/bin/env python3
"""G4-B a07: cross-snapshot differential queries over the section census JSON.

Pure read of the census document produced by section_census.py.
"""
from __future__ import annotations

import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('census')
    args = parser.parse_args()
    doc = json.loads(Path(args.census).read_text(encoding='utf-8'))
    files = doc['files']
    print('files:', len(files))

    print('\n== section 4 clusters -> members ==')
    clusters = defaultdict(list)
    for record in files:
        f4 = record['section4'][0]
        clusters[f4['payload_sha256']].append(record)
    for digest, members in sorted(clusters.items(), key=lambda kv: -len(kv[1])):
        sample = members[0]['section4'][0]
        print(' cluster', digest[:16], 'n=%d' % len(members), 'len=%d' % sample['payload_len'])
        print('   text:', sample['text'])
        if len(members) <= 3:
            for member in members:
                print('   member:', member['file'], 'counts', member['header_counts'],
                      'pid', member['file_pid'])

    print('\n== section 4 / location relation ==')
    prefix_stats = Counter()
    for record in files:
        loc = record['locations']
        urls, hits = loc['url_objects'], loc['urls_prefixed_by_section4']
        prefix_stats[(urls == 0, hits == urls)] += 1
    print(' (no_urls, all_urls_prefixed) ->', dict(prefix_stats))
    print(' url encodings observed:',
          sorted({e for r in files for e in r['locations']['url_encodings']}))
    print(' verbatim occurrences of the section-4 URL in the whole plaintext payload:',
          Counter(r['locations']['section4_url_appears_verbatim_elsewhere'] for r in files))
    examples = [(r['file'], r['locations']['url_objects'],
                 r['locations']['urls_prefixed_by_section4']) for r in files[:4]]
    print(' examples (file, url_objects, prefixed):', examples)

    print('\n== section 23 ==')
    print(' distinct payload digests:', len({r['section23'][0]['payload_sha256'] for r in files}))
    s23 = files[0]['section23'][0]
    print(' payload_len', s23['payload_len'], 'root_tag', s23['root_tag'],
          'root_header_len', s23['root_header_len'], 'root_plus8', s23['root_plus8'],
          'root_plus12', s23['root_plus12'])
    print(' nonzero words in the 96-byte payload:', s23['nonzero_words'])
    print(' msdh extra nonzero:', s23['msdh_extra_nonzero'], 'declared_total', s23['declared_total'])
    print(' identical across every snapshot:',
          len({r['section23'][0]['payload_sha256'] for r in files}) == 1)

    print('\n== section 21 / msph800 ==')
    recs = [r['section21'][0]['records'][0] for r in files]
    print(' distinct msph record digests:', len({x['record_sha256'] for x in recs}))
    print(' distinct xml digests:', len({x['xml']['sha256'] for x in recs}))
    print(' msph declared totals:', sorted({x['declared_total'] for x in recs}))
    print(' mhoh totals:', sorted({x['mhoh']['declared_total'] for x in recs}))
    print(' xml byte lengths:', sorted({x['xml']['bytes'] for x in recs}))
    print(' xml ascii_only:', {x['xml']['ascii_only'] for x in recs},
          'ends_with_newline:', {x['xml']['ends_with_newline'] for x in recs},
          'trailing_nul:', {x['xml']['trailing_nul'] for x in recs})
    print(' updatedDate values:', sorted({x['xml']['scalars']['updatedDate'] for x in recs}))
    print(' titles:', sorted({x['xml']['scalars']['title'] for x in recs}))
    print(' uuids:', sorted({x['xml']['scalars']['uuid'] for x in recs}))
    print(' defaultSettings:', json.dumps(recs[0]['xml']['defaultSettings'], sort_keys=True))
    print(' collections:', json.dumps(recs[0]['xml']['collections'], sort_keys=True))
    print(' mlsh header len / count:',
          sorted({(r['section21'][0]['root']['header_len'],
                   r['section21'][0]['root']['count_at_plus8']) for r in files}))

    print('\n== reload / mutation pairs (do the three regions move?) ==')
    pairs = [('001-one-track.itl', '001-one-track-reloaded.itl'),
             ('002-three-tracks.itl', '003-three-tracks-reloaded.itl'),
             ('050-codec-forced-reload1.itl', '050-codec-forced-reload2.itl'),
             ('070-codec-playlist-rename-reload1.itl', '070-codec-playlist-rename-reload2.itl'),
             ('071-codec-playlist-members-reload1.itl', '071-codec-playlist-members-reload2.itl'),
             ('072-codec-playlist-create-reload1.itl', '072-codec-playlist-create-reload2.itl'),
             ('110-codec-track-restore-reload1.itl', '110-codec-track-restore-reload2.itl'),
             ('000-empty.itl', '001-one-track.itl'),
             ('030-playlist-create.itl', '031-playlist-add.itl')]
    index = {r['file']: r for r in files}
    for left, right in pairs:
        a, b = index.get(left), index.get(right)
        if not a or not b:
            print(' missing pair', left, right)
            continue
        same4 = a['section4'][0]['payload_sha256'] == b['section4'][0]['payload_sha256']
        same23 = a['section23'][0]['payload_sha256'] == b['section23'][0]['payload_sha256']
        same21 = (a['section21'][0]['records'][0]['record_sha256']
                  == b['section21'][0]['records'][0]['record_sha256'])
        print('  %-46s vs %-46s sec4=%s sec23=%s msph=%s payload_equal=%s'
              % (left, right, same4, same23, same21,
                 a['plain_sha256'] == b['plain_sha256']))

    print('\n== library-scale variation (context for invariance claims) ==')
    print(' distinct plaintext payloads:', len({r['plain_sha256'] for r in files}))
    print(' distinct file persistent IDs:', len({r['file_pid'] for r in files}))
    print(' track counts observed:', sorted({r['header_counts']['tracks'] for r in files}))
    print(' playlist counts observed:', sorted({r['header_counts']['playlists'] for r in files}))
    print(' plaintext sizes:', min(r['plain_bytes'] for r in files),
          '..', max(r['plain_bytes'] for r in files))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
