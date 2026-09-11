# a08 preflight review procedure (G4-B)

Scope: how a08 reviews a candidate before the coordinator schedules it. a08
performs no iTunes, COM or UI operation at any point in this procedure. Review
is a desk check over declared JSON and over the harness in
`research/g4/a08/`.

A candidate that was generated independently, by any agent other than the
operator that will run it, needs an a08 approval and an a11 approval before the
coordinator may schedule it. Either reviewer may refuse alone.

## 1. Inputs a08 requires

- The declaration file, at `reports/a10/declarations/<declaration_id>.json`.
- Its sha256, recorded by the submitter, which becomes `declaration_sha256`.
- The intended library path and the sha256 of the pristine input library.
- The rollback plan, including where the untouched copy of the input lives.
- A statement of the iTunes version and installer sha256 that will be used.

If any input is absent, a08 does not infer it. Missing input is a refusal, not
a question to be resolved in the reviewer's head.

## 2. Mechanical check

Run the declaration through the offline validator and require zero findings:

```
cd <worktree>
python3 -c "import json,sys; sys.path.insert(0,'research/g4/a08'); import g4_a08_acceptance as a; print(json.dumps(a.validate_declaration(json.load(open(sys.argv[1]))),indent=2))" <declaration.json>
```

Any `D_` finding is a blocking defect. The most common ones are
`D_IDS_INCOMPLETE` for submitting a delta instead of complete old and new id
sets, `D_ORDER_NOT_PERMUTATION` for an order that does not match the declared
membership, and `D_VERSION_TARGET_MISMATCH` for a declaration still aimed at
the historical build.

## 3. Judgement checks the validator cannot make

1. Minimality. The permitted change set is the smallest set that answers the
   question being asked. A candidate that permits `remove_track` in order to
   test an addition is over-scoped.
2. Reversibility. The rollback restores the exact input bytes, and the input
   copy is stored outside the directory the native run will touch.
3. Distinguishability. If the candidate succeeds, the predicted end state is
   different from the state a rebuild would produce. A candidate whose success
   state is indistinguishable from a silently rebuilt library cannot be
   accepted no matter how the run goes, so it must be redesigned first.
4. Preservation. The original input and any earlier failed observations are
   kept, not overwritten by this run.
5. Blast radius. Only the declared library file and the declared media files
   are in scope. No profile-wide or system-wide action is implied.

## 4. Version binding

The declaration must name 12.13.11.1 and the authorized installer sha256 for
this phase. If the submitter intends to compare the outcome against a result
produced on 12.13.10.3, the comparison must be declared as historical and
flagged, otherwise the capture will fail G8 after the fact. a08 raises this at
review time rather than letting the run burn.

## 5. Verdict

a08 records exactly one of three verdicts:

- `approved`: every mechanical check is clean and every judgement check holds.
- `changes_requested`: specific, enumerated defects, each with the field name.
- `refused`: the candidate cannot be made safe by editing fields, for example
  because it is not distinguishable from a rebuild, or because it asks for a
  native operation outside the authorization.

The verdict goes into `reviews.a08` in the declaration. The capture later
echoes `declaration_sha256`, so any edit made after approval changes the hash
and fails G10 rather than silently passing as reviewed.

## 6. Division of labour with a11

a08 reviews the declaration against the acceptance protocol: form, scope,
reversibility, version binding, and whether the planned capture can actually
produce the evidence the gates demand. a11 reviews adversarially: whether a
passing result would admit an alternative explanation, and whether the claim
survives a hostile reading. The two reviews are independent and are not
merged; the coordinator sees both.

## 7. What a08 never does

- Never runs the candidate, and never asks another agent to run it early.
- Never edits the declaration on the submitter's behalf.
- Never approves conditionally, and never approves pending a fix.
- Never weakens a gate to let a specific candidate through. If a gate is wrong,
  that is a contract change request, raised as such and reported to the
  coordinator, not a local edit.
