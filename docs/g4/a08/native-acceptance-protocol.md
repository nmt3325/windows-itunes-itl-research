# a08 native acceptance protocol (G4-B)

Owner: a08. Executor: a10 only. This file is the acceptance definition for native
ITL experiments in phase G4-B. It is offline-validated: every blocking gate below
has at least one negative control in `tests/test_g4_a08_acceptance.py` that proves
the checker actually detects the failure.

Authored on the GHA linux runner (env linux-xm801aqb) with exec/file_write.
No iTunes, COM or UI operation was performed by a08.

## 0. What acceptance is not

- A successful COM `AddFile` call is NOT acceptance. It is one observation inside
  one step.
- An empty library being generated is NOT acceptance, even if it opens cleanly.
- Structural or static validity is NOT acceptance (base contract, Gates).
- Playback is NOT part of acceptance. It is a separate endpoint, reported in its
  own section, never folded in. A failed playback does not retract acceptance and
  a successful playback never substitutes for a missing acceptance gate.

## 1. Version binding (blocking)

The installer available in this phase is iTunes **12.13.11.1**,
SHA-256 `25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08`.
This is NOT the 12.13.10.3 build used in historical G2/G3 native work.

Every native result MUST state the exact version actually used, evidenced by the
installed binary, not by assumption:

- `environment.itunes_version` = version string read from the installed
  `iTunes.exe` file version (or the About dialog), recorded verbatim.
- `environment.installer_sha256` = SHA-256 of the installer actually executed.
- `environment.version_evidence` = how the version was obtained, plus the command
  or property used.

Comparing a new native result to any historical native result without flagging the
version difference is a blocking failure. If `comparison.baseline_kind` is
`historical`, then `comparison.version_difference_flagged` MUST be true and
`comparison.baseline_itunes_version` MUST be stated. Per the G4-B addendum, a
baseline must always be named; an unnamed baseline is not a baseline.

## 2. Declaration binding (blocking)

No native mutation runs without a candidate declaration that passed preflight
review. The capture MUST carry:

- `declaration.declaration_id` and `declaration.declaration_sha256`
- `declaration.reviews.a08` = `approved` AND `declaration.reviews.a11` = `approved`
- `declaration.coordinator_scheduled` = true
- `declaration.permitted_native_changes` = exhaustive allow-list of change kinds

The change kinds actually observed between the baseline step and the final restart
step MUST be a subset of `permitted_native_changes`. Any extra observed change kind
is a blocking failure, including changes that look harmless.

## 3. Step model

A capture is an ordered list of steps. Required phases, in order:

1. `baseline` - library opened, read, exited normally, before any mutation.
2. `candidate_apply` - the declared native changes are applied and saved.
3. `restart_1` - first full restart cycle.
4. `restart_2` - second full restart cycle.

Every step records, at minimum:

- `opened_library_paths`: every `.itl` the process actually opened.
- `process`: launch flag, `exit_kind`, `exit_code`, crash dumps, dialog texts,
  repair log lines, kill flag.
- `disk`: raw on-disk observation - path, sha256, size, library persistent id,
  track ids, per-track metadata and location, playlists with ordered item ids,
  sibling files in the library directory, and the list of
  `Previous iTunes Libraries` snapshots.
- `com`: COM-visible observation of the same logical content.

Both `disk` and `com` MUST be present at every step. A step with only one of them
cannot be compared and is a blocking failure.

## 4. The gates (all blocking, all must hold)

Gate ids are stable and are emitted verbatim by
`research/g4/a08/g4_a08_acceptance.py`.

### G1 intended library actually opened

- `G1_NO_OPEN_RECORD` - a launched step recorded no opened library path.
- `G1_WRONG_LIBRARY_OPENED` - an opened path does not normalize-equal
  `library.intended_path` (case-insensitive, separator-normalized for Windows).
- `G1_MULTIPLE_LIBRARIES_OPENED` - more than one distinct `.itl` was opened.
- `G1_BASELINE_HASH_MISMATCH` - baseline `disk.sha256` differs from
  `library.intended_pre_sha256`. The file opened must be the file declared.

### G2 no damaged-file fallback, rebuild or repair path

- `G2_DAMAGED_DIALOG` - any dialog text matching damaged / rebuild / repair /
  recreate / "cannot be read" wording.
- `G2_DAMAGED_SIBLING` - a sibling file appears whose name marks a quarantined or
  damaged library.
- `G2_NEW_PREV_LIBRARY_SNAPSHOT` - the `Previous iTunes Libraries` snapshot set
  grew relative to baseline. A new snapshot is the normal fingerprint of a
  rebuild or upgrade and must never be silently accepted.
- `G2_LIBRARY_IDENTITY_CHANGED` - `disk.library_persistent_id` differs from the
  baseline value. A different library identity means a different library, not an
  edited one.
- `G2_REPAIR_LOG` - any repair or rebuild line captured from logs.

### G3 normal save and exit

- `G3_NOT_LAUNCHED` - a phase that requires a process has no launch record.
- `G3_ABNORMAL_EXIT` - `exit_kind` is not `normal_quit`.
- `G3_PROCESS_KILLED` - the process was killed rather than quit.
- `G3_NONZERO_EXIT_CODE` - non-zero exit code.
- `G3_CRASH_DUMP` - a crash dump was produced.
- `G3_NO_SAVE_OBSERVED` - after `candidate_apply` the on-disk bytes are byte-identical
  to baseline. Nothing was saved, whatever COM reported in memory.

### G4 two full restart cycles

- `G4_INSUFFICIENT_RESTART_CYCLES` - fewer than two restart phases present.
- `G4_RESTART_NOT_FULL_CYCLE` - a restart phase without both a launch and a
  normal exit. Reading the file with the process still running is not a cycle.

### G5 raw disk and COM compared at each step

- `G5_MISSING_DISK_OBSERVATION` / `G5_MISSING_COM_OBSERVATION` - the pair is
  incomplete, so no comparison happened at that step.
- `G5_DISK_COM_TRACK_MISMATCH` - the track id sets disagree.
- `G5_DISK_COM_PLAYLIST_MISMATCH` - playlist membership or order disagrees.
- `G5_DISK_COM_METADATA_MISMATCH` - declared metadata fields disagree.

Agreement is required at EVERY step, not only the last one. A candidate that is
visible over COM but absent in the bytes is the exact failure this gate exists for.

### G6 persistence of the declared candidate

- `G6_CANDIDATE_ABSENT_AFTER_APPLY` - the declared new ids are missing right after
  the apply step.
- `G6_CANDIDATE_REVERTED` - the candidate is present after apply but absent at
  `restart_1` or `restart_2`. This is the reverted-after-restart mode.
- `G6_METADATA_DRIFT` - persisted metadata differs from the declared expectation.
- `G6_LOCATION_DRIFT` - persisted location differs from the declared expectation.
- `G6_PLAYLIST_MEMBERSHIP_DRIFT` - declared playlist membership not persisted.
- `G6_PLAYLIST_ORDER_DRIFT` - declared playlist order not persisted. Order is part
  of the claim, not a detail.

### G7 sentinels that must never be read as acceptance

- `G7_COM_CALL_ONLY` - COM mutation calls succeeded but the capture has no
  completed restart cycle. Success of the call is not persistence.
- `G7_EMPTY_LIBRARY` - a post-apply step shows zero tracks while the declaration
  expects a non-empty library. A freshly generated empty library is a failure that
  can otherwise masquerade as a clean open.

### G8 version statement

- `G8_VERSION_NOT_STATED`, `G8_VERSION_EVIDENCE_MISSING`,
  `G8_INSTALLER_HASH_NOT_STATED`, `G8_INSTALLER_HASH_MISMATCH`,
  `G8_BASELINE_NOT_NAMED`, `G8_UNFLAGGED_HISTORICAL_COMPARISON`.

### G9 playback separation

- `G9_PLAYBACK_FOLDED` - the capture folds playback into the acceptance verdict.
- `G9_PLAYBACK_NOT_SEPARATELY_REPORTED` - playback was attempted but not reported
  in its own section.

### G10 declaration binding

- `G10_DECLARATION_MISSING`, `G10_DECLARATION_HASH_MISSING`,
  `G10_PREFLIGHT_REVIEW_MISSING` (needs both a08 and a11),
  `G10_NOT_SCHEDULED`, `G10_NO_PERMITTED_CHANGES`,
  `G10_CHANGE_NOT_PERMITTED`.

## 5. Verdict rule

`accepted` is true only when every gate above is evaluated and no blocking finding
was emitted. The checker never infers a missing observation: absence of evidence
produces a blocking finding, never a pass. There is no partial acceptance and no
override flag in the checker; weakening acceptance requires changing this document
under coordinator review.

## 6. How a10 runs it

1. Submit the candidate declaration (see `candidate-declaration-format.md`) and
   wait for a08 + a11 preflight approval and coordinator scheduling.
2. Record the four phases, capturing disk and COM at each one.
3. Emit `capture.json` in the capture bundle schema `g4/a08/native-capture/v1`.
4. Run `python3 -m g4_a08_acceptance capture.json` (module lives in
   `research/g4/a08/`) and attach the full verdict JSON to the report.
5. Report acceptance, persistence and playback as separate sections, naming the
   iTunes version actually used in each.
