# EXP-04 - do the other playlist operations survive real iTunes too?

EXP-03 established one thing: real iTunes 12.13.11.1 accepted a playlist that itlkit created, and
kept it across two restarts. That is a single operation, and it would have been easy to quietly
generalise it. EXP-04 tests the two playlist operations itlkit also refuses on this version.

Both candidates were built from the live library with **only the version string** relaxed; every
other precondition was checked by unmodified itlkit code. The probe lives outside `itlkit/` and
changes nothing about the shipped gate, which still refuses 12.13.11.1.

## Result: both accepted

| Candidate | Built by | COM playlists, all three sessions | exp04 playlist | Track |
| --- | --- | --- | --- | --- |
| EXP-04a | create, empty, refill | 8 | present, kind=2 special=0, 1 track | present |
| EXP-04b | the same, then delete | 7 | absent, as intended | present |

Each candidate ran the full protocol: declare, install, open, normal COM Quit, restart, restart.
No damaged-file dialog, no rebuilt or fallback library, the library directory stayed at five files,
and `main_window_ready` and `com_create` succeeded on the first attempt in all six sessions.
itlkit could still read every file the application left behind.

## The prediction I got wrong, recorded in advance

The declaration predicted EXP-04a would likely be accepted and called EXP-04b "genuinely uncertain",
on the reasoning that deletion has to leave surrounding indices consistent. It was accepted on the
first attempt. The uncertainty was real when written and is reported as it stood, not rewritten.

## Captures

The binary captures are deliberately not published: each embeds an absolute media path from the CI
machine. Their digests are recorded so any claim about them stays checkable.

| Candidate | Capture | Bytes | SHA-256 (first 32) |
| --- | --- | --- | --- |
| EXP-04a | `lib01-exp04a-open.itl` | 4708 | `b5f087dc4911ecd5645270cff0eb356a` |
| EXP-04a | `lib01-exp04a-restart1.itl` | 4708 | `7863dda654d8b59b71bae0a76fc6583d` |
| EXP-04a | `lib01-exp04a-restart2.itl` | 4708 | `e4254d8dde87b4ba58fd983d8e116694` |
| EXP-04b | `lib01-exp04b-open.itl` | 4524 | `ac3cf4d87dd992694c5e3bbceddc1df8` |
| EXP-04b | `lib01-exp04b-restart1.itl` | 4524 | `3bcc3951b8a2119746c7b61c9904735b` |
| EXP-04b | `lib01-exp04b-restart2.itl` | 4524 | `cedf18d6a3f345058141efacc65c2548` |

## What this does not establish

One machine, one version, one track, one playlist, two restarts per candidate, no playback. It says
nothing about libraries with real media, smart or folder playlists, or other iTunes builds. It does
**not** widen itlkit's accepted-profile set, and the shipped gate is unchanged. Byte identity is not
used as evidence anywhere here: iTunes' own rewrite is not deterministic, and neither is any stage
that carries playlist members.
