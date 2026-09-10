# Sample rate versus count-like storage

The previously published reader incorrectly labelled `mith+0xf4` low uint32 as `sample_rate`. The one-second 44,100 Hz fixtures accidentally had the same rate and frame count, concealing the defect.

For the independently observed Windows iTunes 12.13.10.3 little-endian 756-byte `mith` profile:

- `sample_rate`: `mith+0x98`, IEEE-754 little-endian float32. The public getter returns an integer only for finite, nonnegative, integral Hz values; it does not clamp or round. Unsupported versions/shapes, NaN/infinity, negative and fractional values produce a local field diagnostic. Zero is represented as zero, without asserting an unset/native meaning.
- `mith_0xf4_u64_raw`: the independent full eight-byte unsigned quantity at `+0xf4`. Its name is deliberately offset-neutral. Neither field is writable through semantic setters.
- Read-only inspection and JSON round trips preserve all original bytes, including unrecognized numeric representations.

## Independent evidence

The 20 synthetic native-imported tracks in `evidence/20260910/checkpoint-01/native-snapshots/donor-v1-twenty-reopen2.itl` all have 48,000 Hz in media headers, recorded COM SampleRate, and `mith+0x98`. Their source PCM contains 60,000 mono frames (1.25 seconds), separating rate from length.

The independent `+0xf4` values are 60,000 for the sixteen WAV/AIFF/AAC/ALAC tracks and 60,950 / 60,916 / 60,968 / 60,987 for the four MP3 tracks. AAC decoder output has 60,416 frames although the field is 60,000. Therefore this is **not** a universally exact source/decoded-frame count. Raw duration is 1,250 ms for the non-MP3 tracks; COM Duration is the separate integer-second projection. Do not conflate media bytes, rates, frames, duration, or packet ticks.

Static writer RVA `0x106daf0` copies four bytes from track+0x48 to mith+0x98 and eight bytes from track+0x2e0 to mith+0xf4; reader RVA `0x107b460` has matching transfers. These decompiled widths alone do not prove float semantics; independent media/COM observations supply that evidence.

The fixture hashes below are provenance/integrity pins, not semantic eligibility allowlists:

- Native ITL: `79686fa16cd29adf2d22f52d7842e4c8fd92eb8877a3e060368f7accccd1d588`
- Recorded COM: `8271c6dd6fe5022df46f01683d9fe560b35f622ba2ab26fe582a2dcffd4faed1`
- Minimal 48 kHz WAVE: `c245bbd0d53d7497bb5395840a25ff03148ee9c632db38f850c462f153842be3`

`tests/test_sample_rate_reader.py` includes the real synthetic native witness and separate counterfactual value/shape/JSON policies. Those controls are not new native writer or playback qualification. No private original library or media is needed.
