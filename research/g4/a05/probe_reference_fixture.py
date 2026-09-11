"""Read-only probe of the never-imported G2 reference fixture.

No native operation, no re-import and no mutation: the fixture is opened
read-only with its declared provenance pinned. Output is written next to this
script as reference-fixture-probe.json. Absolute runner paths are omitted.
"""
from dataclasses import asdict
from pathlib import Path
import json
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from itlkit.media import new_track_media_fields, probe_file, unmet_new_media_conditions

RELATIVE = 'evidence/20260910/g2-new-media/ITL-G2-PCM-48000-001.wav'
DECLARED = {'size_bytes': 144044,
            'sha256': '87e45bff7acf44a05a818fa0f33edec429d6648751bcd8aa91ccf91a764b2e05',
            'sample_rate': 48000, 'channels': 1, 'bits_per_sample': 16,
            'frames': 72000, 'duration_ms': 1500}


def main():
    observation = probe_file(ROOT / RELATIVE, expected_sha256=DECLARED['sha256'],
                             expected_size=DECLARED['size_bytes'])
    facts = observation.facts
    observed = {'size_bytes': facts.size_bytes, 'sha256': facts.sha256,
                'sample_rate': facts.sample_rate, 'channels': facts.channels,
                'bits_per_sample': facts.bits_per_sample, 'frames': facts.frames,
                'duration_ms': facts.exact_pcm_milliseconds}
    result = {
        'fixture_relative_path': RELATIVE,
        'declared': DECLARED,
        'observed': observed,
        'declared_matches_observed': observed == DECLARED,
        'duration_is_exact_milliseconds': facts.pcm_milliseconds_are_exact,
        'millisecond_remainder': facts.pcm_millisecond_remainder,
        'bitrate_kbps': facts.bitrate_bps // 1000,
        'chunks': list(facts.chunks),
        'chunk_spans': [list(span) for span in facts.chunk_spans],
        'embedded_metadata_present': facts.embedded_metadata_present,
        'metadata_carriers': list(facts.metadata_carriers),
        'artwork_carriers': list(facts.artwork_carriers),
        'mtime_ns_observed': observation.mtime_ns,
        'new_track_media_fields': [asdict(row) for row in new_track_media_fields(facts, observation)],
        'unmet_conditions_with_file_observation': list(unmet_new_media_conditions(facts, observation)),
        'notes': ['read-only probe; the fixture was not imported into iTunes in this phase',
                  'structural and classification evidence only, not native acceptance'],
    }
    out = Path(__file__).with_name('reference-fixture-probe.json')
    out.write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(json.dumps({'declared_matches_observed': result['declared_matches_observed'],
                      'unmet_conditions': len(result['unmet_conditions_with_file_observation'])}))


if __name__ == '__main__':
    main()
