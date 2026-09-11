# Incident, 2026-09-11: loss of the Windows runner with one prepared commit unpushed

Evidence class A for everything observed through the execution broker's control
plane while it was happening. Evidence class C for the contents of files that
existed only on the lost machine; those are described here from the operator's
contemporaneous session record, not from the files themselves.

## Sequence

1. The EXP-05 publication commit was assembled on the Windows environment
   RUNNER-G4B-WIN, on a detached HEAD in a worktree of
   `integration/itl-20260911-g4`. Nine files were staged and committed locally.
   The commit was never pushed.
2. Three publication gates ran against that commit and all three refused to push,
   each for a different and, in hindsight, instructive reason:
   - gate A crashed after the commit succeeded, because `git diff` output was
     decoded with the Windows ANSI code page instead of as bytes;
   - gate B blocked on a false positive: it counted forbidden tokens anywhere in
     the range patch text, including the lines that earlier pseudonymisation
     commits had *removed*;
   - gate C, after the scan was corrected to added lines only, reported zero
     added-line hits but blocked on a repository-wide condition that predates
     this work. That condition is documented in
     `docs/g4/publication-hygiene-audit.md`.
3. A fourth gate was queued. It never started. The broker reported the runner as
   last seen 769 seconds earlier while the hosting job still reported itself as
   running, and two queued commands were never dispatched. A kill was accepted
   but never acknowledged by the runner.
4. A replacement Windows environment, RUNNER-G4C-WIN, was created and the
   repository re-cloned there. The Linux environment RUNNER-G4B-LINUX was
   unaffected and remained at the pushed head with a clean worktree.

## What was lost

The nine files of the unpushed commit, with the sizes measured by the publisher
run that produced them:

| path | size | status |
| --- | --- | --- |
| `docs/g4/native-experiments.md` | 426 -> 459 lines | modification lost |
| `evidence/g4/native/capture-manifest.json` | 27 -> 32 entries | modification lost |
| `evidence/g4/native/exp05/README.md` | 4983 B | lost |
| `evidence/g4/native/exp05/exp05-build-report.json` | 829 B | lost |
| `evidence/g4/native/exp05/exp05-declaration.json` | 3810 B | lost |
| `evidence/g4/native/exp05/exp05-declaration-amendment-01.json` | 3433 B | lost |
| `evidence/g4/native/exp05/session-exp05-open.log` | 4514 B | lost |
| `evidence/g4/native/exp05/session-exp05-restart1.log` | 4531 B | lost |
| `evidence/g4/native/exp05/session-exp05-restart2.log` | 4531 B | lost |

Also lost, because they lived in the runner's working area and were never
published: the built candidate library for EXP-05 (3476 B), the three live
libraries captured after each session (4622 B each), the preserved pre-experiment
library and its two sidecar databases, the installed iTunes 12.13.11.1 build, the
native harness scripts, and the local tree-wide token audit file.

## What survives

- Everything already pushed, i.e. the branch head at the time of the loss.
- The EXP-05 *outcome*, as recorded in the operator's session transcript. It is
  reproduced in `docs/g4/native-experiments.md` and is labelled class C there.
- The code paths the experiment exercised: `research/g4/exp05/track_fields.py`
  and `research/g4/exp03/gate_bypass.py` were pushed before the loss.

## Consequences for the claims

- EXP-05's acceptance claim is retained as an observation but its evidence class
  drops from A-with-artifacts to C-reconstruction. Until the protocol is re-run
  and fresh logs are published, the EXP-05 section is a record, not evidence.
- No other claim in this repository depends on the lost files. EXP-01 through
  EXP-04 were published before the loss and are unaffected.

## Rule adopted after this incident

A commit that exists only on an ephemeral runner is not preserved, however
carefully it was built. From now on, as soon as a commit exists it is pushed to a
quarantine ref that is never merged, and only then is the publication gate run to
decide whether the integration branch may advance. Gating before preservation
trades a recoverable hygiene problem for an unrecoverable data loss.
