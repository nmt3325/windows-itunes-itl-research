# Native experiments: what iTunes accepted, and how we know

This phase was allowed to run real iTunes again. Two experiments were run under
the declared protocol: declare the intent in writing first, install the
candidate library, open iTunes, quit it, then restart twice, and judge only by
what survives. A COM call that returns success, or an empty library that iTunes
happily creates from nothing, is not counted as acceptance.

iTunes on this machine is 12.13.11.1. The live library was written by that same
version, so every semantic write path in itlkit refuses it (see
`write-gates-and-refusal-surface.md`). The only writing available was therefore
at the container level: read the library and rebuild it from the parsed model.

## EXP-01: does iTunes accept a container itlkit rebuilt?

The candidate was produced with a full rebuild of the parsed library, not a
byte copy. It came out 3,392 bytes against the native 4,524, with identical
logical content, because the rebuild does not reproduce native slack.

| Stage | Bytes | sha256 (first 32 hex) |
| --- | --- | --- |
| Native baseline, preserved before the experiment | 4524 | `19D088455F692CC86F3D4F70C5FC74FD` |
| Installed candidate (itlkit rebuild) | 3392 | `7D86F19F6709AF30CDC303C7D2F7E98D` |
| After open and quit | 4525 | `56430C181F8CD3723C14A55EF1659A6A` |
| After restart 1 | 4524 | `A9F3644B0E2D5D57BD02208E122CC1E1` |
| After restart 2 | 4525 | `02A66A8170BD710E40BA1EEDDC0929EF` |

In all three sessions iTunes reached its main window, COM attached on the first
attempt, and reported version 12.13.11.1, one library track, database id 71 and
the track name `a10-tone-440hz-2s`. No damaged or rebuilt files appeared, the
directory file count stayed at five, and iTunes exited cleanly each time.
itlkit re-read every stage and found one track, fourteen playlists, the same
track name and the same library persistent id `C54F0D3E83DBDA0F`.

iTunes rewrites the library on every quit, which is why the hash changes at each
stage. That behaviour was already observed on the untouched native baseline, so
it is iTunes being iTunes, not a symptom of the candidate.

One reading is not yet explained: COM reports 7 playlists where itlkit reads 14.
A control session on the untouched native original is required before claiming
the rebuild did not cause it, and that control is recorded separately.

## EXP-02: the negative control that makes EXP-01 mean something

An acceptance result is worthless if the harness cannot detect a rejection. So
the same rebuild was corrupted deliberately: sixteen bytes at offset 1024 were
XORed with 0xFF, leaving the header intact, giving a 3,392 byte file with
digest `367B8E422A258B9E...`. itlkit itself refuses that file with
`invalid encrypted/zlib payload`, which confirms the corruption reaches the
compressed body rather than being cosmetic.

iTunes refused it, unmistakably:

- Two modal dialogs appeared instead of the main window, both reading: *The
  file "iTunes Library.itl" does not appear to be a valid iTunes library file.
  iTunes has created a new iTunes library and renamed this file to "iTunes
  Library (Damaged).itl".*
- `main_window_ready=False`, where the accepted candidate gave True.
- Six consecutive COM attempts failed with `0x80080005`
  (`CO_E_SERVER_EXEC_FAILURE`), ending in `COM_UNAVAILABLE`, where the accepted
  candidate attached on attempt 1.
- The run took 532 seconds against 36 seconds for the accepted file, because
  nothing the harness knows how to click was ever on screen.
- Afterwards the directory contained `iTunes Library (Damaged).itl` at the
  corrupted digest, and no live library at all.

One detail deserves care rather than enthusiasm: the dialog announces that a
new library was created, but no new library file existed when the harness gave
up, because the modal was never dismissed. The announcement is a statement of
intent, not evidence of a file on disk.

The preserved native baseline was then restored, back to 4,524 bytes and
`19D088455F692CC86F3D4F70C5FC74FD`.

## What these two results license

The pair supports a narrow, specific claim: **iTunes 12.13.11.1 accepted a
container that itlkit rebuilt from its own parse, and the same harness rejects
a corrupted container loudly.** Acceptance survived two restarts.

They do not license anything wider:

- No semantic change was written. The rebuild preserves content; it does not
  add, remove or edit a track, a playlist or a field. Every such path refuses
  this library version.
- Nothing here is evidence about playback, which was never attempted.
- This is a single library with one track, not a corpus. Byte-level slack that
  iTunes tolerates here may matter in a larger or older library.
- Acceptance of a rebuild is weaker than acceptance of a construction. The
  long-standing goal, a genuinely new track built from nothing, remains unmet
  and is blocked by the writer version gate rather than by missing knowledge of
  the format.

## Evidence classes

Everything in this file is class A: observed in this phase, with the harness
logs, declarations and hashes retained alongside. The interpretation paragraphs
are marked as interpretation; the tables are measurements.
