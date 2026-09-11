# a09 synthetic fixtures and declared expectation manifests

Task a09 of the G4-B parallel research phase. Everything here is synthetic,
reproducible from committed code, and task local. No iTunes, no COM, no UI, no
native library was touched to produce it. No private library, real media,
artwork, or original reference archive content is committed or referenced.

Owned paths: `research/g4/a09/`, `docs/g4/a09/`, `tests/test_g4_a09*.py`.

## What this delivers

1. A generator that reproduces the G2 reference fixture bit exactly.
2. A documented family of additional fixtures covering the variation the other
   G4-B tasks need: sample rate, duration, channel count and metadata shape.
3. Declared expectation manifests plus a validator that refuses an incomplete
   declaration, so a10 cannot run native without a complete predeclaration.

Generators are committed, binaries are not. `write_fixture` refuses to
materialise into the repository; regenerate into a scratch directory instead.

## Objective 1: reference reproduction, observed result

The reference identity was **quoted** from
`evidence/20260910/g2-final-hardening.json#new_pcm`, written during the G2
phase. a09 did not observe those values being produced. The following results
were **observed by a09 on the linux runner** at authoring time:

| Check | Result |
| --- | --- |
| Regenerated size | 144044 bytes, equal to the quoted 144044 |
| Regenerated SHA-256 | `87e45bff7acf44a05a818fa0f33edec429d6648751bcd8aa91ccf91a764b2e05`, equal to the quoted hash |
| Regenerated PCM payload SHA-256 | `fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e`, equal to the quoted hash |
| Byte comparison against `evidence/20260910/g2-new-media/ITL-G2-PCM-48000-001.wav` | identical, every byte |

No expected hash was edited. Had regeneration differed, the computed hash would
have been reported as a discrepancy instead.

## Determinism rules

- Pure standard library, integer arithmetic only.
- No randomness, no clock reads, no locale or environment input.
- Division is Python floor division applied to the whole product, including
  negative products. This detail is what makes the historical formula
  reproducible; C style truncation toward zero produces different bytes.
- File modification times are declared constants applied with `os.utime`, so a
  regenerated tree is stable for mtime sensitive comparisons.
- Canonical 44 byte PCM header unless a spec declares extra chunks.
- The registry records the SHA-256 of the generator itself, so a stale registry
  is a test failure rather than a silent drift.

## Waveform

The family generalises the historical G2 formula:

```
tri(n)   = period//4 - abs(((n + phase) % period) - period//2)
env(n)   = min(n, frames - 1 - n, fade)
value[n] = (peak_scale * tri(n) * env(n)) // fade
```

With `period=192`, `peak_scale=64`, `fade=480`, `phase=0`, `frames=72000` this
is exactly the recorded reference formula
`(64*(48-abs((n%192)-96))*min(n,71999-n,480))//480`. `invert` negates the
already floored value, which is how the stereo fixture makes its two channels
distinguishable. `silence` is the digital black negative control.

Validation refuses a period that is not a positive multiple of four, and
refuses a peak that would not fit in signed 16-bit.

## Fixture family

Generator: `research/g4/a09/fixtures.py`\
Recorded hashes: `research/g4/a09/fixture-registry.json` (schema
`itlkit.g4.a09.fixture-registry.v1`, generator SHA-256 `76d6490a8051e6e599aa8615a46f27971db853a2483407ecc31d8e8df9c2f520`)

| Fixture ID | Rate | Ch | Frames | ms | Bytes | Metadata shape | Chunk order | SHA-256 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `ITL-G2-PCM-48000-001` | 48000 | 1 | 72000 | 1500 | 144044 | none | fmt + data | `87e45bff7acf44a05a818fa0f33edec429d6648751bcd8aa91ccf91a764b2e05` |
| `ITL-G4-A09-PCM-44100-MONO-1000` | 44100 | 1 | 44100 | 1000 | 88244 | none | fmt + data | `4997cb388167df3a3f372f211d3cf6decb78c28c8b6a58bf3430ce1cdb73702c` |
| `ITL-G4-A09-PCM-22050-MONO-0500` | 22050 | 1 | 11025 | 500 | 22094 | none | fmt + data | `3a121b88fbc16b852f91aed95026517ce5c4a42a94d3a5ef82fb4c364047a0fb` |
| `ITL-G4-A09-PCM-8000-MONO-3000` | 8000 | 1 | 24000 | 3000 | 48044 | none | fmt + data | `2c6efb02095e31c59458d0e155865903206c1e0a0e97d83d2dbc9cbb0742b966` |
| `ITL-G4-A09-PCM-48000-STEREO-1500` | 48000 | 2 | 72000 | 1500 | 288044 | none | fmt + data | `b8419806d19ebb5cbc761cd473c700ded2ae47a2636a46a9eb5c0bcbd0c765b9` |
| `ITL-G4-A09-PCM-48000-MONO-0010-SILENCE` | 48000 | 1 | 480 | 10 | 1004 | none | fmt + data | `f33c27764e56d1c6b80cfb26005f2702978d6614cf42a38b28fb58cae17130c4` |
| `ITL-G4-A09-PCM-48000-MONO-1500-INFO` | 48000 | 1 | 72000 | 1500 | 144282 | riff-info-ascii | fmt + data + LIST | `c0e1f2ca8fdd10f32253ac9177e9256609fadc47d7116ddd324a11877cd2a599` |
| `ITL-G4-A09-PCM-48000-MONO-1500-INFO-ODD` | 48000 | 1 | 72000 | 1500 | 144120 | riff-info-odd | fmt + LIST + data | `2a8c375224a58ce830c58588c515c1748a96964f0376c414df3495e1747fe081` |
| `ITL-G4-A09-PCM-48000-MONO-1500-ID3U` | 48000 | 1 | 72000 | 1500 | 144242 | id3v23-unicode | fmt + data + id3 | `22f2acf5854bfa5f0afd7bb346b0e7e7298bfb0ddbef18151d2fae5eb4bf01db` |

PCM payload hashes, declared modification times and peaks:

| Fixture ID | PCM SHA-256 | mtime_ns | Peak |
| --- | --- | --- | --- |
| `ITL-G2-PCM-48000-001` | `fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e` | 1789026300000000000 | 3072 |
| `ITL-G4-A09-PCM-44100-MONO-1000` | `eea59abc3329728e27937449ff77e6d8d040bd54dcf6d72756e1b08be05f7853` | 1789084860000000000 | 3600 |
| `ITL-G4-A09-PCM-22050-MONO-0500` | `598256fffcdd94cda8e590ebd3a7fee7c368a7d07ff857048b97f16a59988d9b` | 1789084920000000000 | 2744 |
| `ITL-G4-A09-PCM-8000-MONO-3000` | `d1fc56d0226db404c90c5ab6bfd27330aaedeee0c9a667becf98d5d43382f87d` | 1789084980000000000 | 2560 |
| `ITL-G4-A09-PCM-48000-STEREO-1500` | `77170ff894ea7066b38d1de1b018366835b02be28c0ed8769f74f2fc530e85b5` | 1789085040000000000 | 3072 |
| `ITL-G4-A09-PCM-48000-MONO-0010-SILENCE` | `3dc463a76fc170607c07b104c3cb531362ce7d6e10c1a34e0c0f370aeae08ce8` | 1789085100000000000 | 0 |
| `ITL-G4-A09-PCM-48000-MONO-1500-INFO` | `fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e` | 1789085160000000000 | 3072 |
| `ITL-G4-A09-PCM-48000-MONO-1500-INFO-ODD` | `fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e` | 1789085220000000000 | 3072 |
| `ITL-G4-A09-PCM-48000-MONO-1500-ID3U` | `fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e` | 1789085280000000000 | 3072 |

Coverage notes:

- Sample rates 8000, 22050, 44100 and 48000 Hz.
- Durations from 10 ms to 3000 ms, all exact whole millisecond counts.
- Mono and stereo, with per channel phase and polarity so channel order is
  observable rather than assumed.
- Metadata shapes: none, ASCII `LIST`/`INFO`, an odd length `INFO` value that
  forces a RIFF pad byte and sits before the `data` chunk so the audio does not
  start at byte 44, and an `id3 ` chunk carrying UTF-16 text including a non-BMP
  character.
- A digital silence control whose peak is exactly zero, for checks that must not
  quietly pass on empty audio.
- The three `1500-...` metadata fixtures share the reference PCM payload hash, so
  a consumer can separate container and tag effects from audio effects.

## Reproduce

```bash
# regenerate every fixture into a scratch directory outside the repository
python3 research/g4/a09/fixtures.py --out /tmp/a09-fixtures

# regenerate and compare against the recorded hashes
python3 research/g4/a09/fixtures.py --check-registry research/g4/a09/fixture-registry.json

# rewrite the registry after intentionally changing a spec
python3 research/g4/a09/fixtures.py --write-registry research/g4/a09/fixture-registry.json

# expectation manifests
python3 research/g4/a09/manifest.py --registry research/g4/a09/fixture-registry.json --write-templates research/g4/a09/expectations
python3 research/g4/a09/manifest.py --validate research/g4/a09/expectations/candidate-native-import-discovery.json

# checks
python3 -m pytest -q -k a09
```

Observed verification results are recorded in the task report at
`reports/a09/report.json`, not restated here.

## For the consuming tasks

- **a05, media intake.** Take fixture identity, sizes, hashes, chunk offsets and
  declared mtimes from the registry. Intake should read the declared `chunks`
  map rather than assuming audio begins at byte 44, because two fixtures
  deliberately break that assumption.
- **a08, protocol.** The manifest schema is a09 defined because a08 had
  published no format when this was authored. See
  `docs/g4/a09/expectation-manifest-format.md`. Rename or re-nest fields as
  needed; the validation rules are the part worth keeping.
- **a10, native operator.** Fill a template, set `declaration_state` to
  `declared`, then run the validator with `--require-runnable`. A non-zero exit
  means the declaration is incomplete and no native run is authorised.
  `observations` must stay null until after the run.

## Known gaps and honest limits

- a08 had not published a manifest format at authoring time, so field names here
  are provisional. Recorded as missing, not inferred from a peer worktree.
- Nothing here has been exercised against a native library. All native
  behaviour remains a declared expectation awaiting a10.
- `pytest -k a09` still imports the whole suite during collection, so unrelated
  collection failures would surface in that run. A scoped run of
  `tests/test_g4_a09_fixtures.py` is recorded alongside it in the report.
