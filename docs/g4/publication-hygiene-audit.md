# Publication hygiene: repository-wide audit of CI identifiers

Evidence class A. Measured on RUNNER-G4B-LINUX against the pushed head of
`integration/itl-20260911-g4`, commit `6af562e`, with every tracked file read as
bytes. Files that decode as UTF-8 were treated as text; the rest were scanned as
binary. Literal identifier values are deliberately not reproduced in this
document; only the classes and the counts are.

## Identifier classes counted

| class | what it is |
| --- | --- |
| `broker_name` | the name of the execution broker that hosts the runners |
| `ci_temp_root` | the CI temporary root path, in both slash conventions |
| `runner_id` | per-environment runner identifiers |
| `runner_host` | runner host names |
| `ci_user` | the CI account name |
| `posix_home` | the POSIX home directory of the CI account |

## Result

| metric | value |
| --- | --- |
| tracked files | 1025 |
| tracked bytes | 33,118,170 |
| text files with at least one hit | 262 |
| binary files with at least one hit | 2 |
| `broker_name` occurrences | 3513 |
| `ci_temp_root` occurrences | 214 |
| `runner_id` occurrences | 7 |
| `runner_host` occurrences | 4 |
| `ci_user` occurrences | 2 |
| `posix_home` occurrences | 0 |

Affected text files by area: `evidence/native` 177, `evidence/research` 58,
`evidence/static` 20, `evidence/codec` 5, `evidence/tests` 2. The single worst
file is `evidence/static/phase4/donor-census.json` with 259 occurrences. The two
binary files are `evidence/native/research/trace-empty-load/000012.bin` with one
occurrence and
`evidence/native/research/traced-runs/060-attached-native-save/trace/000003.bin`
with twenty-one.

## Why the publication gate did not catch this

The gate compares only the lines a commit *adds* inside the range from the G4
base commit to the candidate head. Every file above was added before that base,
so the gate is structurally blind to it. This is not a regression introduced by
G4 work: across the entire range, the number of forbidden tokens on added lines
is zero. The gate was doing exactly what it was written to do, and what it was
written to do was not enough.

## Remediation plan

Not yet applied. Recorded here so that the finding is preserved even if the
rewrite is not finished in this session.

1. Text files: apply the established mapping from literal CI identifiers to
   stable pseudonyms, in longest-match-first order, handling both the raw and the
   JSON-escaped spellings of Windows paths.
2. `evidence/native/oracles` is consumed by the test suite through an environment
   variable, so the full regression must be re-run after any rewrite under
   `evidence/`, not merely spot-checked.
3. The two binary files are raw trace dumps. Rewriting bytes inside them would
   corrupt the trace and silently falsify evidence. They must either be removed
   with a note recording what they contained, or retained and excluded from any
   export outside this private repository. They must not be edited in place.
4. The rewrite must be a separate, clearly labelled commit, so that a reader can
   tell mechanical redaction apart from substantive changes to findings.
