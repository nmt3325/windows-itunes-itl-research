# G3 provenance ledger (task a01, G4-B)

Authored on the project's Linux CI runner on 2026-09-11. Branch `g4/a01`,
base commit `1bb05edc2494abc9aa9b59cd2392026f830615a2`. No production file was read
for modification and none was changed.

> Sanitization note: operational identifiers (runner environment IDs, host names,
> command identifiers and absolute runner paths) are deliberately withheld from
> this published record. Recovered command streams are referenced by the stable
> pseudonyms S1-S5, later commands by X1-X3, and runner roots by <..._ROOT>
> placeholders. The mapping to the original identifiers and the raw stream
> transcriptions are retained outside this repository. Sanitization changed only
> these identifiers; no measurement, hash, count or conclusion was altered.

## 0. Evidence classes

Every claim below carries one label.

- **class A** - observed now: bytes returned to a01 during this phase by a read-only
  call, with the call metadata recorded.
- **class B** - historical, not re-observed: reported by an earlier phase and not
  re-observed here.
- **class C** - reconstructed: text that a02 (or any G4-B task) re-derives. Not
  original G3 bytes.
- **missing** - not recoverable from anything a01 could read. Recorded as missing,
  never inferred.

## 1. Headline: the G3 command output survived, the G3 tree did not

**class A.** All five cached command IDs on the EXPIRED environment `RUNNER-G3-WIN`
returned their complete output to `exec_read` (from_byte 0, single read each,
`eof: true`). Every response carried `state: exited`, `returned_because: exit`,
`source: broker_ring`, `runner_gone: true`, `range_evicted: false`,
`head_discarded_bytes: 0`, `truncated: false`, and `cwd`
`<G3_ROOT>\repo`. Byte counts matched the expected
sizes exactly.

| command_id | role | exit | total_bytes | expected | runtime_ms | idle_seconds |
| --- | --- | --- | --- | --- | --- | --- |
| S1 | baseline | 0 | 1419 | 1419 | 25735 | 52287 |
| S2 | red-fix-green-full | 0 | 2350 | 2350 | 24927 | 52100 |
| S3 | depth/final tests + failure | 1 | 1029 | 1029 | 26678 | 51777 |
| S4 | read-only reconciliation | 0 | 1050 | 1050 | 875 | 51639 |
| S5 | publication-only failure | 1 | 912 | 912 | 3950 | 51552 |

No `runner_gone` error, no `range_evicted`, no eviction of any range. The earlier
working assumption that the G3 evidence was gone is wrong for these five streams.

**class A, limits.** Only the recorded stdout/stderr survives. The G3 worktree, its
JUnit XML files and the modified sources went with the runner. Any G3 fact never
printed into one of these five streams is **missing**, not recoverable by a01.

**class A, timeline cross-check.** `idle_seconds` places the last output of
S2 at 2026-09-10T10:00:14Z, which is exactly the timestamp that stream
prints on its own last-but-one line (`2026-09-10T10:00:14.1610168Z`). The same
arithmetic places the reads at approximately 2026-09-11T00:28:3xZ (09:28 JST) and is
consistent across all five. These are the original G3 streams, not a replay.

**class A, operational note for the coordinator.** The ring still held output roughly
14.5 hours after the runner died. Other G3 command IDs, if the coordinator holds any,
may still be readable, but eviction should be assumed imminent. a01 was given only
these five.

## 2. Recovered streams

All blocks below are **class A**. Transcriptions are LF-normalised; the originals were
CRLF on the Windows runner, which the byte deltas confirm (1419/1401, 2350/2317,
1029/1016, 1050/1043, 912/899 = 18/33/13/7/13 CR bytes). Full transcriptions live in
the external report dir under `raw/`.

### 2.1 baseline - S1 (exit 0, 1419 B)

The stream is only the warnings summary and the short test summary; with
`head_discarded_bytes: 0` and `truncated: false` this is the complete recorded stream,
not a truncation. Decisive line:

```text
2125 passed, 6 skipped, 4 warnings, 36 subtests passed in 21.69s
```

Skips recorded: 4 + 1 in `tests/test_codec_native_profiles.py` (no COM oracle, no
after-state COM oracle) and 1 in `tests/test_cow_v2.py:93`.

### 2.2 red-fix-green-full - S2 (exit 0, 2350 B)

```text
RED_EXIT=1
RED_TESTS=19
RED_FAILURES=15
RED_ERRORS=0
{
  "itlkit\\admission.py": "5d72aea15cbded646e62b33f050bfff7c3bc8fc67d00c223b6c57ede11bc06df",
  "itlkit\\playlist_models.py": "1e1211061e461551ba7765bf87725158b0360c47076595403b724e08058d5523"
}
19 passed in 0.37s
2144 passed, 6 skipped, 4 warnings, 36 subtests passed in 21.73s
2026-09-10T10:00:14.1610168Z
 itlkit/admission.py       |  8 ++++++--
 itlkit/playlist_models.py | 30 ++++++++++++++----------------
 2 files changed, 20 insertions(+), 18 deletions(-)
 M itlkit/admission.py
 M itlkit/playlist_models.py
?? tests/test_g3_review_guards.py
```

The red stage was 19 tests with 15 failures and 0 errors; after the fix the same 19
passed and the full suite reported 2144 passed.

### 2.3 depth/final tests and the first publication failure - S3 (exit 1, 1029 B)

```text
depth-red {'tests': 3, 'failures': 3, 'errors': 0, 'skipped': 0, 'exit_code': 1}
final-targeted {'tests': 22, 'failures': 0, 'errors': 0, 'skipped': 0, 'exit_code': 0}
final-full {'tests': 2189, 'failures': 0, 'errors': 0, 'skipped': 6, 'exit_code': 0}
AssertionError at close_and_publish.py line 31:
  full=test('final-full',['tests']);assert full['tests']==2153 and ...
throw 'Final scoped publication stopped; inspect before any retry'
```

### 2.4 read-only reconciliation - S4 (exit 0, 1050 B)

```text
2026-09-10T10:07:55.1873785Z
2147 passed, 6 skipped, 4 warnings, 36 subtests passed in 21.02s
PUBLISHED_DIR=False
dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3
 M itlkit/admission.py
 M itlkit/playlist_models.py
?? tests/test_g3_review_guards.py
baseline   tests 2167 skipped 6 elements 2131 unique_pairs 2131 duplicates []
full       tests 2186 skipped 6 elements 2150 unique_pairs 2150 duplicates []
final-full tests 2189 skipped 6 elements 2153 unique_pairs 2153 duplicates []
```

All three JUnit suites report host `HOST-G3`, timestamps 2026-09-10T09:56:45Z,
09:59:52Z and 10:05:15Z, errors 0 and failures 0. No duplicate testcase pairs.

### 2.5 publication-only failure - S5 (exit 1, 912 B)

```text
resume_publication.py line 13:
  assert passed and int(passed[-1])==len(cases)-values['failures']-values['errors']-values['skipped']
AssertionError
throw 'Publication-only stage stopped; inspect before retry'
```

## 3. Remote branch reality

**class A.** `git ls-remote origin`, run in this phase from the a01 worktree
(command_id X1, exit 0):

```text
82c10a7ada3e4ee829f222e22d0c2848d9179d79	HEAD
82c10a7ada3e4ee829f222e22d0c2848d9179d79	refs/heads/main
aa6940d02c770ec73bd444df2f449bd02acb4b3e	refs/heads/proposals/itl-20260910-g2-native-guard
dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3	refs/heads/recovery/itl-20260910-g2
ef65c5b36bbc7c3b3ee6010a962c6ec062d085f3	refs/heads/research/itl-20260910
1bb05edc2494abc9aa9b59cd2392026f830615a2	refs/heads/research/itl-20260911-g4
```

- `hardening/itl-20260910-g3-review` is **absent**. Confirmed: the grep count over the
  same output is 0. The branch reported missing at phase start really does not exist.
- Six refs total, no tags in the output.
- `recovery/itl-20260910-g2` is at `dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3`, the same
  commit the G3 runner had checked out, so the G2 base is remotely preserved.
- `research/itl-20260911-g4` is at `1bb05edc2494abc9aa9b59cd2392026f830615a2`, which
  equals the a01 base commit.

**class A, consequence.** G3 was never pushed and never published: no remote ref
carries it, the reconciliation stream shows the repo still at `dc4b1c7a` with
`itlkit/admission.py` and `itlkit/playlist_models.py` merely modified and
`tests/test_g3_review_guards.py` untracked, and `PUBLISHED_DIR=False`. The G3 source
text exists nowhere a01 can reach.

## 4. File-level provenance

| artifact | value | class | note |
| --- | --- | --- | --- |
| `itlkit/admission.py` at the red-fix-green stage | `5d72aea15cbded646e62b33f050bfff7c3bc8fc67d00c223b6c57ede11bc06df` | class A | printed by S2 |
| `itlkit/admission.py` final | same value asserted historically | class B | no recovered stream restates it after the depth correction; equality of stage and final state is not evidenced |
| `itlkit/playlist_models.py` before the depth correction | `1e1211061e461551ba7765bf87725158b0360c47076595403b724e08058d5523` | class A | explicitly NOT final |
| `itlkit/playlist_models.py` final | - | missing | never printed into any recovered stream |
| final 22-test file, hash | - | missing | only the counts `tests 22, failures 0, exit 0` survive |
| final 22-test file, test names | - | missing | not printed |
| `tests/test_g3_review_guards.py` | untracked at reconciliation time | class A (existence only) | no hash, no content |
| source text of the three changed/added files | - | class C once a02 re-derives it | reconstruction, never original G3 bytes |

**class A shape anchors for any reconstruction.** The only surviving shape constraints
are the diffstat (`itlkit/admission.py` 8 changed lines, `itlkit/playlist_models.py` 30
changed lines, 2 files, 20 insertions, 18 deletions), the red counts (19 tests, 15
failures, 0 errors), the depth-red counts (3 tests, 3 failures) and the final targeted
count (22 tests). A reconstruction that matches these is still class C; matching them
is necessary, not sufficient.

## 5. Test-count arithmetic and why publication halted

**class A.** Across every recovered run the JUnit `tests` attribute exceeds the
testcase element count by exactly 36, the subtest count, and the reported passes equal
elements minus skips:

| run | JUnit tests | elements | difference | passed text | skipped |
| --- | --- | --- | --- | --- | --- |
| baseline | 2167 | 2131 | 36 | 2125 | 6 |
| full | 2186 | 2150 | 36 | 2144 | 6 |
| final-full | 2189 | 2153 | 36 | 2147 | 6 |

2125 + 6 = 2131, 2144 + 6 = 2150, 2147 + 6 = 2153. The primary-testcase and subtest
accounting is internally consistent in all three.

**class A, first failure.** `close_and_publish.py:31` asserted
`full['tests']==2153` while the JUnit `tests` attribute of the same run was 2189. 2153
is that run's testcase **element** count. The guard compared an element count against
the suite attribute, and the 36 subtests are exactly the gap. Nothing about the suite
itself failed: failures, errors and exit_code were 0 and skipped was 6, as the guard
also required.

**class A, second failure, with hypotheses marked.** `resume_publication.py:13`
asserted `int(passed[-1]) == len(cases) - failures - errors - skipped`. The recovered
reconciliation shows that identity **holds** for each individual run, so the failing
input was probably not one self-consistent pair. Candidate causes to test rather than
assert: (i) the `N passed` tail and the parsed XML came from different stages;
(ii) `cases` counted a differently scoped suite, for example the 22-test targeted run,
against a full-run summary; (iii) several `passed` matches in a concatenated log and
`passed[-1]` selected the wrong one. These are hypotheses, not evidence.

**class A, publication state.** Both stages stopped on their own guard
(`Final scoped publication stopped; inspect before any retry`,
`Publication-only stage stopped; inspect before retry`). Combined with
`PUBLISHED_DIR=False` and section 3, the record is unambiguous: nothing was published,
and the contract prohibition on re-running or recreating `close_and_publish.py` and
`resume_publication.py` stands.

## 6. Bearing on the G4-B baseline discrepancy (addendum section 4)

**class A.** The recovered bytes corroborate that the historical baseline figures were
genuinely emitted: 2125 passed, 6 skipped, 36 subtests, 2131 elements, on host
`HOST-G3` at 2026-09-10T09:56:45Z, with the tree at
`dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3`.

**class A.** The gap against the fresh RUNNER-G4B-WIN run recorded in the addendum
(1919 passed, 50 skipped, 26 subtests, JUnit tests 1995, 1969 elements) is therefore a
difference between two real observations, not a bookkeeping invention. a01 adds only
the anchors: same commit, 6 skipped then against 50 now, 36 subtests then against 26,
and three named skip sites in the historical run that all concern a COM oracle or a
codec dependency.

**class B.** Explaining the gap is a12 work. a01 asserts no cause.

## 7. Missing evidence register

Recorded as missing, not inferred:

- final `itlkit/playlist_models.py` hash and content - **missing**
- final 22-test file hash and test names - **missing**
- all JUnit XML artifacts and the `reports/` directory of the G3 runner - **missing**,
  gone with `RUNNER-G3-WIN`
- proof that `itlkit/admission.py` was untouched by the depth correction - **missing**,
  the final-equality claim stays **class B**
- any G3 branch, tag or published directory on the remote - confirmed absent,
  **class A**
- native acceptance, persistence and playback evidence for G3 - **missing**, no
  recovered stream contains any

## 8. What a01 did not do

**class A.** No `exec` was issued against `RUNNER-G3-WIN`; only read-only `exec_read`.
No environment was created, extended or destroyed. No worktree administration, no
push, no PR, no merge. No production file was modified. No mutation or publication
script was re-run or recreated. No tests were added, so no pytest run was required.
