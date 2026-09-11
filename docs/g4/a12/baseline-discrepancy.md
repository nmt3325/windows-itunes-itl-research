# G4-B / a12: why the fresh baseline differs from the historical record

Status: explained and reproduced end to end on runner `win-r6qwbqfz`
(2026-09-11 UTC), worktree base commit
`dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3` (tests/, itlkit/ and pyproject.toml
are byte identical between that commit and my branch head `1bb05edc`, verified
in command_id 706278b6a1884918, so the code under test is the same).

## The question

A fresh full run at dc4b1c7 on this runner with pytest 9.1.1 produced
1919 passed, 50 skipped, 26 subtests, JUnit `tests=1995` and 1969 `//testcase`
elements. The historical record for the same commit claims 2125 passed,
6 skipped, 36 subtests and 2131 primary cases: 162 fewer elements collected
and 44 more skips.

## The answer, reproduced rather than asserted

Collection and skipping are gated by three environment variables. With all
three set to evidence directories that already exist in the worktree, the same
commit on the same interpreter reproduces the historical numbers exactly:

```
2125 passed, 6 skipped, 4 warnings, 36 subtests passed in 23.21s
primary <testcase> elements: 2131   tests=2167   subtest inflation: 36
```

(command_id a08bd7b73ddb40ee, JUnit `reports/a12/a12-fullgate-pytest991.xml`)

| variable | mechanism | unset | set |
| --- | --- | --- | --- |
| `ITLKIT_NATIVE_ROOT` | `NATIVE_FILES = sorted(Path(NATIVE_ROOT).glob("*.itl")) if NATIVE_ROOT else []` feeds three parametrized functions | each function collects one `got empty parameter set` placeholder | each function collects one item per `.itl` file |
| `ITLKIT_NATIVE_REPORTS` | `test_native_byte_exact_and_com_values` needs a recorded COM oracle | all 55 items skip with `no COM oracle` | 50 pass, 4 skip `no COM oracle`, 1 skips `no after-state COM oracle` |
| `ITLKIT_FRESH_SNAPSHOT_DIR` | `@unittest.skipUnless(...)` on `FreshSnapshotImporterTests` (tests/test_importer_v2.py:213) | 46 skips, and the 10 `self.subTest` call sites inside that class never run | 46 pass, subtests rise 26 -> 36 |

### Collection law

Measured, not derived: `collected = 1966 + 3N`, where `N` is the number of
`.itl` files visible through `ITLKIT_NATIVE_ROOT`.

| N | collected | evidence |
| --- | --- | --- |
| 0 | 1969 | control, command_id 64fdf2e73f474295 |
| 7 | 1987 | synthetic root of 7 files, same command |
| 55 | 2131 | `evidence/native/snapshots`, command_ids d2382b79e2694e4b and a08bd7b73ddb40ee |

### Where the 162 elements live

Per-module `//testcase` counts, ungated run vs full-gate run
(command_id dfb24c7cad22417a):

| module | ungated | full gate | delta |
| --- | --- | --- | --- |
| tests.test_admission_v2 | 170 | 224 | +54 (55 items replace 1 placeholder) |
| tests.test_codec_native_profiles | 12 | 120 | +108 (2 x 55 items replace 2 placeholders) |
| every other module | unchanged | unchanged | 0 |
| total | 1969 | 2131 | +162 |

`tests.test_importer_v2` keeps 66 elements in both states because its gate is a
runtime `skipUnless`, not a collection filter; only its skipped count changes
(46 -> 0).

### Skip inventory

| state | skips | composition |
| --- | --- | --- |
| ungated (1969 elements) | 50 | 46 fresh-snapshot gate + 3 empty parameter set + 1 `test_cow_v2.py:93` |
| native root + fresh snapshots only | 56 | 55 `no COM oracle` + 1 cow |
| full gate | 6 | 4 `no COM oracle` + 1 `no after-state COM oracle` + 1 cow |

The last row matches the historical 6 skips. `evidence/native/oracles` holds 51
oracles, 51 of which match snapshot stems and 50 of which carry an after state,
which is exactly 50 passes, 1 after-state skip and 4 missing-oracle skips
(command_id 646d453e5a03487f).

## Candidate causes that were tested and disproved

- **pytest major version.** pytest 8.4.2 in an isolated venv collects 1969,
  identical to pytest 9.1.1 (command_id 4a5a6680422b49e6). Version does not
  change collection.
- **Missing `frida`.** No test imports frida; the only references are
  `scripts/windows/trace_itunes.py`, a docstring in
  `scripts/windows/analyze_trace.py`, the pyproject `windows` extra and prose in
  evidence files (command_id b7f91d6940c6429a).
- **Absence of an installed iTunes.** Collection was 1969 at 00:30:20Z with no
  iTunes present (command_id 706278b6a1884918) and still 1969 at 00:45:28Z with
  `C:\Program Files\iTunes\iTunes.exe` and the `iTunes.Application` COM key
  present after a10 installed 12.13.11.1 (command_id f3bfed9c8ef847af). The
  gates are environment variables, and the COM comparisons read recorded
  oracle JSON rather than live COM.
- **A `conftest.py` or plugin.** There is no `conftest.py` anywhere in the
  repository and `pytest-subtests` is not installed (command_id 11aee4e13677438c).

## Subtest and `tests=` accounting

A dedicated probe (command_ids 234b5ac2a84d4eac and 4a5a6680422b49e6) shows:

- pytest 9.1.1 reports stdlib `unittest.subTest` outcomes in the summary line
  and counts them in `tests=`, but gives them no `<testcase>` element; a failing
  subtest attaches a `<failure>` to its parent element. Probe: 3 elements,
  `tests=9`, console `1 failed, 3 passed, 5 subtests passed`.
- pytest 8.4.2 with no `pytest-subtests` does not report subtests at all: same
  probe gives `tests=3` and console `1 failed, 2 passed`.

Therefore `tests= == primary elements + subtest reports` is a pytest 9.x rule,
and a historical run that reported 36 subtests cannot have been produced by
pytest 8.x through this mechanism.

## Open, not reproducible

The brief also records a historical `tests=2189` as 2153 elements plus 36
subtests. My reproduction has 2131 elements, so its `tests=` attribute is 2167.
The 2189/2153 pair is internally consistent but needs 22 elements that this
commit does not collect. Candidate explanations are duplicate
`(classname, name)` elements or a merged multi-phase XML; neither can be tested
because the original XML and the per-phase logs were never recovered. All four
XMLs I produced contain zero duplicate identities, so nothing in the current
tree reproduces a 2153-element file.

## Baseline status

Both numbers are now valid descriptions of the same commit under different
environments:

| environment | passed | skipped | elements | subtests | tests= |
| --- | --- | --- | --- | --- | --- |
| no gates set | 1919 | 50 | 1969 | 26 | 1995 |
| native root + fresh snapshots | 2075 | 56 | 2131 | 36 | 2167 |
| all three gates set | 2125 | 6 | 2131 | 36 | 2167 |

Any published claim must state which of these three environments produced it.
