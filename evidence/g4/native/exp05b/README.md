# EXP-05B - track field edit, re-run for first-hand evidence

Evidence class A: everything in this directory was observed during this run.

EXP-05 established the same result earlier, but its logs, candidate and captures
were lost with the runner before they were pushed, so that section of
`docs/g4/native-experiments.md` is a class-C reconstruction. EXP-05B repeats the
protocol on a freshly built baseline so the claim rests on evidence that exists.

## What was tested

A library written by itlkit, with three text fields of an existing track changed
(`name`, `artist`, `album`), is handed to a real Apple-signed iTunes 12.13.11.1
and judged by what iTunes does with it across a save and two restarts.

## Protocol, fixed in advance

`exp05b-declaration.json` was committed and pushed **before** the candidate was
built, so the acceptance and non-acceptance rules could not be adjusted to fit
the outcome. The order was: declare, import, launch and save, quit, restart,
restart.

## Result

Accepted in all three sessions. In each one iTunes opened the library without a
corruption modal, reported version 12.13.11.1, one track, seven COM playlists,
and read back the edited name, artist and album; the library directory kept its
four files and no damaged or fallback library was created; iTunes quit normally
through COM. `exp05b-outcome.json` records each declared criterion with the
observed value.

## What this does and does not license

It licenses one claim: itlkit can edit indexed text fields of an existing track
and real iTunes accepts, persists and re-reads the result.

It does not license more:

- The shipped write gate **refuses** this edit. The candidate needs
  `operation_version_spoofed()`, which reports the container version as
  12.13.10.3 for the whole operation, not only at the entry gate, because
  `trackops.set_indexed_fields` reaches `Track.set` and
  `Library._require_semantic_profile` reads the version a second time. That is a
  strictly wider relaxation than EXP-03 and EXP-04 needed, so this result
  licenses less than they do, not more.
- itlkit's accepted-version set is unchanged. The relaxation lives in a research
  script outside `itlkit/`.
- Nothing here shows that a genuinely new track can be constructed. That remains
  unsolved.
- The post-quit files differ in size and digest across the three sessions
  (4610, 4607, 4608 bytes). iTunes' rewrite is not byte-deterministic, which was
  already observed in EXP-03 and EXP-04, so byte equality is not used as a test.
- Playback was not attempted.

## Why the binaries are not here

The candidate and the three post-quit captures are not committed. Their location
records embed the absolute media path of the machine that ran the test, and
rewriting bytes inside evidence files would falsify them. Sizes and SHA-256
digests are published instead, and the tone file is reproducible from
`scripts`-style synthesis: 44.1 kHz mono 16-bit, 2 s, 440 Hz, amplitude 0.25,
176444 bytes.

## Files

- `exp05b-declaration.json` - pre-registration, pushed before the candidate existed
- `exp05b-build-report.json` - what itlkit changed, and the relaxation it required
- `exp05b-outcome.json` - declared criteria against observed values, per session
- `session-exp05b-bootstrap.log` - how the baseline library was built by iTunes itself
- `session-exp05b-open.log`, `session-exp05b-restart1.log`, `session-exp05b-restart2.log`