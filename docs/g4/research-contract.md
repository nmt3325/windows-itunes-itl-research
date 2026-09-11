# G4 research and validation contract

This is a new research phase starting from dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3. Historical G2/G3 results remain historical; source recovery, reconstruction, new execution, native acceptance, persistence, and playback are separate evidence classes. G3 was not remotely saved at phase start. Do not replay the old mutation/publication scripts.

## Scope and ownership

The coordinator manages assignments, dependencies, integration, publication and cleanup; research and experiments are delegated. Each task has its own worktree, branch, research/g4/<task>/, docs/g4/<task>/, tests/test_g4_<task>*.py, and external reports/<task>/ directory.

- a01: Recover historical G3 evidence and provenance. No production changes.
- a02: Auxiliary identity and separate playlist JSON hardening. Sole owner of itlkit/admission.py and itlkit/playlist_models.py.
- a03: Constructor and planning identity/SourceBinding integration. Sole owner of itlkit/construct.py and itlkit/planning.py.
- a04: Shared-reference graph, pools, allocation and COW research. New task-local proposals only until existing-file ownership is approved.
- a05: Media intake and genuinely new-media record construction. Sole owner of itlkit/media.py; other existing production edits require reassignment.
- a06: Smart/folder/grouped playlist membership, ordering and semantics research. No existing production changes.
- a07: Static/decompiled consumer analysis, especially section4, section23 and msph800. No existing production changes.
- a08: Independent native comparison/capture protocol and offline negative controls. Task-local harness only; no iTunes/COM/UI operations.
- a09: Reproducible synthetic media/fixtures and declared expectation manifests. Task-local outputs only; no iTunes/COM/UI operations.
- a10: Exclusive native operator. Install the official standalone iTunes in the disposable runner, verify version/hash/Apple signature, and operate isolated synthetic libraries only. No existing production changes.
- a11: Independent adversarial code review and targeted counterexamples. Read-only production; task-local tests and reports.
- a12: Independent regression, integration verification and publication-evidence audit. Read-only production; task-local verification tools and reports.

Shared schema, core, CLI, configuration, this contract, integration branch and Git settings are coordinator-owned. Request changes instead of editing outside ownership. Coordinate file transfers with exact base hashes. New/editable helper files are authored with Computer and transferred with checksum verification; GHA hosts network access and Windows execution. Do not claim GHA-only authorship.

## Gates

Use only the existing private repository. Never publish private libraries/media/artwork, original archives, vendor executables, credentials, session identifiers or operational ledgers. Only sanitized code, tests and synthetic evidence may be saved. Do not alter main or historical branches; task commits are local until the coordinator publishes approved checkpoints. No PR or merge to main.

Preserve original inputs, unknown bytes and all failed observations. Default writer and constructor blocks remain unless a separately reviewed, narrowly scoped contract is actually proved. Static/structural checks alone never authorize semantic modification. Declare candidate intent before execution: input/output hashes, complete old/new IDs, metadata, locations, playlist membership/order, and allowed native changes. Native acceptance requires the intended library, absence of damaged-file fallback/repair, normal save/exit and two restart cycles with raw disk and COM comparisons. Playback is a separate endpoint.

Only a10 may launch/control iTunes, COM or UI. Native installation/setup and synthetic baseline characterization are authorized; independently generated candidates require a08/a11 preflight review and coordinator scheduling. Other tasks must not touch native library/profile directories.

Commands must specify the assigned absolute cwd and shell. Preserve command IDs, offsets, state, exit code and complete output externally; never relaunch a running or ambiguous mutation. At most two heavy checks at a time, granted by coordinator; begin with read-only scoping. No child environment lifecycle changes, Git worktree administration, push, PR, or grandchildren.

The absolute task deadline is 2026-09-11 21:00 Asia/Tokyo, set by the user on 2026-09-11; the earlier 09:00 deadline is historical. See docs/g4/g4b-resumption-addendum.md, which prevails over this file wherever they conflict. Each runner lease can end earlier. Checkpoint work frequently and follow coordinator freeze/save/cleanup windows; missing evidence remains missing. Reports distinguish actual execution from plans, original bytes from reconstructed text, and primary testcases from subtests. Finish only on verified deliverables, not a session-completed label.
