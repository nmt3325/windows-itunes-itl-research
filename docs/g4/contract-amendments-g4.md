# G4 contract amendments requested by the tasks

Every task was asked to report the contract changes its work implies rather
than to make them. This file collects those requests so the next phase amends
the contract once, deliberately, instead of absorbing the changes silently.
Each item names the task that raised it. The authoritative wording stays in
that task's own report; this is an index, not a replacement.

## Native operation, from a10

1. A first run of iTunes 12.13.11.1 presents a licence gate, and automation
   that ignores it observes `0x80080005` from COM rather than a usable
   application object. The protocol must dismiss the gate before any COM call.
2. 12.13.11.1 installs self contained under `C:\Program Files\iTunes`, so the
   contract must stop describing the component layout of older builds.
3. The codec field profile must be version gated. It was derived on 12.13.10.3
   and this build is not that build.
4. The main window must be detected by window class `iTunes`, not by title, and
   both modal dialogs share the class `iTunesCustomModalDialog`.
5. COM enumerates 7 of the 14 playlists a fresh library contains, so COM counts
   are not library counts and the contract must not use them interchangeably.
6. Cross environment checkers need a shared location, because a Windows only
   artifact cannot be reviewed from the Linux environment.

## Acceptance and evidence, from a08, a09, a11 and a12

7. a08 defined gates G1 to G10 for the native acceptance protocol, and
   acceptance requires all of them, not a successful COM call.
8. a09 registered the provisional manifest id `itlkit.g4.a09.expectation.v1`,
   which must be versioned before anything depends on it.
9. a11 established that the depth counter is 0 based, which changes what every
   depth limit in the contract means.
10. a11 could not review a02's diff from the Linux environment because the
    branch was not visible there, so the contract needs a review location that
    both environments can read.
11. a12 fixed the reported baseline as 2125 passed with 6 skipped under the
    three gate variables, verified the collection law `collected = 1966 + 3N`
    at three values of N, and requires the JUnit rule that `tests=` counts
    primary elements plus subtest reports.
12. a12 requires that a pseudonym key be committed with the pseudonymised
    artifact, and notes that a single shared committer identity means commit
    authorship cannot attribute work to a task.

## Library invariants, from a07

13. `itlkit/operations.py require_simple_library` needs an `stsh-count-guard`,
    because the current predicate accepts libraries whose section count does
    not match the header.

## Amendment: a native acceptance claim requires a paired negative control

EXP-01 and EXP-02 establish a rule for this project. An observation that iTunes
opened a candidate library proves acceptance only when the same harness, on the
same machine, is shown to reject a deliberately corrupted candidate. Without
that pairing, "iTunes opened it" is indistinguishable from "iTunes opened
something, possibly a library it silently created itself".

The control must be run close in time to the experiment, must differ from the
accepted candidate only in the corruption, and its rejection must be visible in
more than one channel. In EXP-02 it was visible in four: the modal dialog text,
`main_window_ready`, the COM failure code, and the renamed file left on disk.

Amendment: a native acceptance claim without its control is downgraded to a
suggestive observation and may not be recorded as acceptance.
