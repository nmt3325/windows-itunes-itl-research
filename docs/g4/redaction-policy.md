# Publication redaction policy and coordinator acknowledgements (2026-09-11)

This repository publishes analysis, code, tests and synthetic or native-derived
evidence. It deliberately does not publish operational session records. This
document states the rule, because a published claim that cites a redacted
identifier must still be reproducible by someone who cannot see the original.

## What is redacted, and how

| class | example | published as |
|---|---|---|
| CI runner environment id | a broker environment name | `RUNNER-<phase>-<os>` |
| CI host name | the runner VM name | `HOST-<phase>` |
| absolute CI paths | the runner work directory | `<CI_ROOT>`, `<CI_WORK>`, `<CI_ROOT_WIN>`, `<CI_WORK_WIN>` |
| CI broker and account names | the broker directory, the runner account | `<CI_BROKER>`, `<CI_USER>` |
| broker command ids | a 16-hex execution handle | `CMD-01`, `CMD-02`, ... per task |

Pseudonyms are stable within a task and are assigned in order of first
appearance. The raw mapping is retained outside the repository, in each task's
unpublished report directory as `cmdid-map.json`.

## Why command ids are pseudonymized rather than published

A broker command id identifies one execution inside one ephemeral CI session.
It is an operational record, and the research contract excludes those. It is
also worthless to a reader: the sessions expire, so the id cannot be resolved by
anyone later, including us.

Reproducibility therefore does not rest on the id. Every published claim that
cites `CMD-nn` also states the command, the corpus and the environment gates
needed to re-run it. `docs/g4/g4b-resumption-addendum.md` section 6 records the
canonical gated test environment for exactly this reason.

A consequence worth stating plainly: a pseudonymized citation is weaker than a
resolvable one. It proves that a specific execution happened and that its output
was recorded, and it lets a reader re-run the same command, but it does not let
an outside reader fetch the original log.

Legitimate 64-bit ITL persistent identifiers are also 16 hex characters. They
are content, not session records, and are never redacted. The publication gate
therefore treats 16-hex matches as report-only and blocks only on named session
tokens.

## Coordinator acknowledgements of task a12's integrity findings

Task a12 audited the coordinator and filed four findings. All four are accepted
as accurate, and the disposition is recorded here rather than being quietly
dropped.

* **A12-INT-01, its files were modified by another actor.** Correct. The
  coordinator sanitized and pushed a12's work. The task brief told a12 not to
  push, and did not say that the coordinator would push on its behalf. That was
  a briefing defect, not a12 misreading its instructions.
* **A12-INT-02, the branch was pushed twice while a12 was reporting.** Correct,
  and for the same reason. Push authority rests with the coordinator alone.
* **A12-INT-04, the citation key was never committed.** Correct. This document
  is the answer: the policy is now published, the key stays unpublished, and the
  reason is stated above.
* **A12-INT-03, one command id was left raw while the same id was pseudonymized
  elsewhere.** Correct and now fixed. The mapping used for the fix was derived
  from this branch's own history by comparing the pre-redaction and
  post-redaction revisions, so the correction is verifiable from the repository
  without consulting the unpublished key.

One a12 open item is now closed, and not by a12: the historical `tests=2189`
run. It is the gated baseline of 2131 primary elements plus the 22 tests in the
never-committed G3 guard file, giving 2153 elements and 2189 including subtest
reports. The accounting is in `docs/g3-review-reconstruction.md` on
`hardening/itl-20260910-g3-review` and in addendum section 6.

Task a12 also recorded that a shared committer identity makes authorship
unattributable from git metadata. That is true and unresolved: every commit in
this phase carries one identity, so the commit message is the only attribution.
Commit messages in this phase name the task and say when the coordinator acted
on a task's behalf.
