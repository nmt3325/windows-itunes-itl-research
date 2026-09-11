# G4-B resumption addendum - 2026-09-11

This addendum amends `docs/g4/research-contract.md` for the resumption the user authorized on 2026-09-11. Where the two conflict, this addendum prevails.

## 1. Authorization and deadline

The user explicitly re-authorized ITL research and native experiments with ten or more subagents on 2026-09-11, and set a new absolute deadline of **2026-09-11 21:00 Asia/Tokyo**. The 2026-09-10 19:12:32 and 2026-09-11 09:00 deadlines are historical. The earlier "preservation only, no new runner, no native experiments" restriction is superseded for this phase only, and only to the extent the user re-authorized.

## 2. File authoring policy (correction)

The base contract states that new or editable helper files are authored with Computer and transferred with checksum verification. That is superseded by the currently active long-term instruction: the Computer sandbox is reserved for transferring user attachments and must not be used for AI file authoring, editing, code or shell execution, or as a staging area for GHA transfers.

All G4-B code, tests, harnesses and reports are authored directly on the GHA runners with `file_write`, `file_edit` and `exec`. Authorship statements for G4-B say GHA. Historical G3 helpers were authored on Computer; that history is preserved as written and is never restated as GHA authorship.

## 3. Environments and task map

| env_id | platform | role |
| --- | --- | --- |
| RUNNER-G4B-WIN | windows | native operation, authoritative regression, integration, publication |
| RUNNER-G4B-LINUX | linux | static analysis, research, fixtures, independent review |

Both leases began about 2026-09-11 09:16 JST with a 330 minute TTL, so both expire before 21:00 JST. The coordinator owns renewal, replacement and handoff. Children never call `env_create`, `env_extend`, `env_destroy`, or `exec_kill` with `all`, and never administer git worktrees.

- RUNNER-G4B-WIN: a02, a10, a12
- RUNNER-G4B-LINUX: a01, a03, a04, a05, a06, a07, a08, a09, a11

## 4. Observed baseline discrepancy - do not paper over

A fresh full run at `dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3` on RUNNER-G4B-WIN with pytest 9.1.1 produced:

`1919 passed, 50 skipped, 4 warnings, 26 subtests passed`, JUnit `tests=1995`, 1969 testcase elements.

The historical G2/G3 record for the same commit is 2125 passed, 6 skipped, 36 subtests, 2131 primary cases. Both cannot describe the same collection. Until a12 explains the gap, the historical figures remain historical and the fresh figures are the only baseline actually observed in this phase. Candidate causes to test rather than assert: pytest major version difference, missing optional dependencies such as `frida`, absence of an installed native iTunes profile, and fixture or environment gated collection. No later result may be compared to a baseline without naming which baseline it used.

## 5. Reporting rules

Every report separates (a) what was actually executed in this phase from what was planned, (b) reconstructed text from originally observed bytes, (c) primary testcase elements from subtests, and (d) structural validity, preservation, semantics, native acceptance, persistence and playback. Missing evidence is recorded as missing and never inferred.
