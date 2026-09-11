# Native experiments: what iTunes accepted, and how we know

This phase was allowed to run real iTunes again. Two experiments were run under
the declared protocol: declare the intent in writing first, install the
candidate library, open iTunes, quit it, then restart twice, and judge only by
what survives. A COM call that returns success, or an empty library that iTunes
happily creates from nothing, is not counted as acceptance.

iTunes on this machine is 12.13.11.1. The live library was written by that same
version, so every semantic write path in itlkit refuses it (see
`write-gates-and-refusal-surface.md`). The only writing available was therefore
at the container level: read the library and rebuild it from the parsed model.

## EXP-01: does iTunes accept a container itlkit rebuilt?

The candidate was produced with a full rebuild of the parsed library, not a
byte copy. It came out 3,392 bytes against the native 4,524, with identical
logical content, because the rebuild does not reproduce native slack.

| Stage | Bytes | sha256 (first 32 hex) |
| --- | --- | --- |
| Native baseline, preserved before the experiment | 4524 | `19D088455F692CC86F3D4F70C5FC74FD` |
| Installed candidate (itlkit rebuild) | 3392 | `7D86F19F6709AF30CDC303C7D2F7E98D` |
| After open and quit | 4525 | `56430C181F8CD3723C14A55EF1659A6A` |
| After restart 1 | 4524 | `A9F3644B0E2D5D57BD02208E122CC1E1` |
| After restart 2 | 4525 | `02A66A8170BD710E40BA1EEDDC0929EF` |

In all three sessions iTunes reached its main window, COM attached on the first
attempt, and reported version 12.13.11.1, one library track, database id 71 and
the track name `a10-tone-440hz-2s`. No damaged or rebuilt files appeared, the
directory file count stayed at five, and iTunes exited cleanly each time.
itlkit re-read every stage and found one track, fourteen playlists, the same
track name and the same library persistent id `C54F0D3E83DBDA0F`.

iTunes rewrites the library on every quit, which is why the hash changes at each
stage. That behaviour was already observed on the untouched native baseline, so
it is iTunes being iTunes, not a symptom of the candidate.

One reading needed explaining: COM reports 7 playlists where itlkit reads 14.
That gap is resolved by the baseline control below, and it is not caused by the
rebuild.

## EXP-02: the negative control that makes EXP-01 mean something

An acceptance result is worthless if the harness cannot detect a rejection. So
the same rebuild was corrupted deliberately: sixteen bytes at offset 1024 were
XORed with 0xFF, leaving the header intact, giving a 3,392 byte file with
digest `367B8E422A258B9E...`. itlkit itself refuses that file with
`invalid encrypted/zlib payload`, which confirms the corruption reaches the
compressed body rather than being cosmetic.

iTunes refused it, unmistakably:

- Two modal dialogs appeared instead of the main window, both reading: *The
  file "iTunes Library.itl" does not appear to be a valid iTunes library file.
  iTunes has created a new iTunes library and renamed this file to "iTunes
  Library (Damaged).itl".*
- `main_window_ready=False`, where the accepted candidate gave True.
- Six consecutive COM attempts failed with `0x80080005`
  (`CO_E_SERVER_EXEC_FAILURE`), ending in `COM_UNAVAILABLE`, where the accepted
  candidate attached on attempt 1.
- The run took 532 seconds against 36 seconds for the accepted file, because
  nothing the harness knows how to click was ever on screen.
- Afterwards the directory contained `iTunes Library (Damaged).itl` at the
  corrupted digest, and no live library at all.

One detail deserves care rather than enthusiasm: the dialog announces that a
new library was created, but no new library file existed when the harness gave
up, because the modal was never dismissed. The announcement is a statement of
intent, not evidence of a file on disk.

The preserved native baseline was then restored, back to 4,524 bytes and
`19D088455F692CC86F3D4F70C5FC74FD`.

## The baseline control: what COM says when nothing was changed

The 7-versus-14 discrepancy could have meant two very different things: either
COM shows a narrower view than the file contains, or the rebuild quietly lost
seven playlists. Guessing between those was not acceptable, so the preserved
native original was restored and opened with no modification at all, under the
same declare-first protocol.

COM reported `playlist_count=7` on the untouched original as well, and this
time the harness enumerated them:

| # | Name | Kind | Special | Tracks |
| --- | --- | --- | --- | --- |
| 1 | Library | 1 | | 1 |
| 2 | Music | 2 | 6 | 1 |
| 3 | Movies | 2 | 7 | 0 |
| 4 | TV Shows | 2 | 8 | 0 |
| 5 | Podcasts | 2 | 3 | 0 |
| 6 | Audiobooks | 2 | 9 | 0 |
| 7 | Genius | 2 | 11 | 0 |

Every one is a built-in special playlist. itlkit reads 14 playlist records in
the same file, so the COM surface is simply exposing the special playlists and
not the full record set. The conclusion is that the discrepancy belongs to COM,
not to the rebuild, and EXP-01's acceptance stands.

The control also reproduced the rewrite behaviour: iTunes rewrote the library
on quit, from 4,524 bytes to 4,526 (`7159DBF86A04DBE3D8C866B651E0D11C`), and
rewrote the Extras database while leaving the Genius database untouched. That
is the same pattern seen after the rebuilt candidate, which is what makes it
uninteresting as a signal.

One incidental observation: the file iTunes had renamed to `iTunes Library
(Damaged).itl` during EXP-02 was still sitting in the directory during this
control, and iTunes ignored it entirely.

## EXP-03 - pre-registered probe: is the writer-version gate load-bearing, or merely conservative?

**Status: executed on real iTunes 12.13.11.1 on 2026-09-11. The application ACCEPTED the itlkit-built playlist and kept it across two restarts.**
Nothing in this section is authoritative, and nothing in it may be used to widen itlkit's accepted-profile set.

### Why

itlkit refuses semantic writes unless the library was written by a profile it has actually observed
natively (12.13.9.1 or 12.13.10.3). The machine used for the G4 native work runs 12.13.11.1, so every
semantic write on it is refused. That refusal is the *conservative* answer. It is not evidence that
12.13.11.1 would reject a library built by itlkit - nobody had tested that. EXP-03 tests it.

### What is relaxed, and what is not

The probe lives in `research/g4/exp03/gate_bypass.py`, outside `itlkit/`. It does not edit itlkit and
does not reimplement any check. It relaxes exactly one thing: `Container.version` is made to report
`12.13.10.3` while the real, unmodified `operations.require_simple_library` runs, and the patch is
removed before anything is serialized, so the candidate keeps its true version string. Identity and
reference validation, the 144-byte header rule, the compression-trailer rule, the section allowlist,
the empty-grandchild rules, the store-index shape and the global-metadata child codes are all still
enforced by the real code.

### What the two gates say about the live 12.13.11.1 library

```
version           : 12.13.11.1
header bytes      : 144
trailer present   : False
tracks / playlists: 1 / 14
real gate    : UnsupportedError: writes require the observed Windows iTunes 12.13.9.1/12.13.10.3 profile
relaxed gate : PASS
```

This is already a result, independent of what the application later does: **every structural
precondition itlkit knows how to check is satisfied by the 12.13.11.1 library.** The only thing
standing between itlkit and a semantic write on this machine is the version string itself.

### The candidate

`create_playlist(name='exp03-itlkit-playlist', track_persistent_ids=('C54F0D3E83DBDA0F',))`
produced 3520 bytes, sha256 `109a09644c3a27d3...`, version still `12.13.11.1`, and itlkit re-reads it
as 1 track / 15 playlists with the new playlist present. itlkit re-reading its own output is *not*
acceptance; it is only a precondition for putting the file in front of the application.

### Two corrections made while building this probe

1. The first version of the probe tried to assign the spoofed version onto the library object. That
   failed with `AttributeError: property 'version' of 'Container' object has no setter`, and the failure
   is recorded rather than quietly edited away. The spoof is now installed on the class for the duration
   of the gate call only - which is also *required* for correctness, because `create_playlist` gates a
   deep copy of the library rather than the object it was handed.
2. The first inertness control compared a gated build against a bypassed build byte-for-byte and
   reported DIFFERENT. That verdict was wrong, not because the bypass changed anything, but because
   `create_playlist` is not byte-deterministic: it allocates a fresh persistent id and stamps a
   timestamp, so two *identical gated* builds already differ. With `--persistent-id` and
   `--timestamp-hfs` pinned, the gated and bypassed builds are byte-identical
   (`170ae6d705274b20...` twice) on a supported profile. Only that pinned comparison licenses the claim
   that the bypass changes nothing except which libraries are allowed through.

### Acceptance criteria (pre-registered, not invented afterwards)

Recorded in the declaration before any modification: iTunes must open the intended file with no
damaged-file dialog and no new library file; COM must enumerate a user playlist named
`exp03-itlkit-playlist` containing the expected track; the session must end in a normal COM Quit; the
playlist must survive restart 1 and restart 2; and itlkit must still be able to read the file iTunes
leaves behind. A successful COM `AddFile`, an empty library, iTunes merely starting, itlkit re-reading
its own output, and the playlist appearing only before the first Quit all explicitly do **not** count.

### Result: accepted, and it persisted

Three sessions ran back to back with the same harness used for EXP-01 and EXP-02: install, launch,
dismiss the audio-access dialog, read the library over COM, normal Quit, then restart, then restart again.

| session | file presented | bytes in | COM playlist_count | `exp03-itlkit-playlist` seen over COM | file left behind |
| --- | --- | ---: | ---: | --- | ---: |
| exp03-open | the itlkit candidate | 3520 | 8 | yes - kind=2, special=0, 1 track | 4709 bytes |
| exp03-restart1 | what iTunes had written | 4709 | 8 | yes | 4709 bytes |
| exp03-restart2 | what iTunes had written | 4709 | 8 | yes | 4709 bytes |

The count of 8 is exactly the 7 playlists the application always creates - established independently by the
baseline COM control, run twice - plus the one itlkit created. `sla_dialog_seen=False` in all three sessions,
no damaged-file dialog appeared, the library directory stayed at 5 files, no `iTunes Library (Damaged).itl`
was created, and each session ended in a normal COM Quit rather than a kill.

itlkit re-read every stage afterwards:

```
pre-exp03-native      4524  version=12.13.11.1  tracks=1  playlists=14  exp03_present=False
candidate-by-itlkit   3520  version=12.13.11.1  tracks=1  playlists=15  exp03_present=True
exp03-open            4709  version=12.13.11.1  tracks=1  playlists=15  exp03_present=True
exp03-restart1        4709  version=12.13.11.1  tracks=1  playlists=15  exp03_present=True
exp03-restart2        4709  version=12.13.11.1  tracks=1  playlists=15  exp03_present=True
```

So the round trip closes in both directions: itlkit wrote a playlist the application accepted, and the
application rewrote a file itlkit can still read, with the playlist intact and the track count unchanged.
The three files the application left behind carry three different digests despite identical semantics,
which is the same non-determinism the baseline control showed, and is why byte identity was excluded from
the acceptance criteria in advance.

### What this does and does not establish

It establishes that for this operation, on this version, the version gate is **conservative rather than
load-bearing**: the file itlkit produced was structurally acceptable to the application that itlkit had
never been observed writing for.

It does not establish that other operations are safe on 12.13.11.1, that any other version behaves this
way, that libraries containing real media and large playlists behave this way, that anything about playback
was verified, or that the file is stable beyond the two restarts actually performed. One machine, one
version, one track, one playlist, two restarts.

The reason this acceptance is worth anything at all is EXP-02. The same harness, on the same machine, was
given a deliberately corrupted container and reported rejection unambiguously: two modal dialogs, the
`iTunes Library (Damaged).itl` rename, `main_window_ready=False`, and six failed COM attempts. A harness
that called everything acceptance would have called that acceptance too. Without the negative control this
section would be unfalsifiable and should not have been believed.

**Retraction path.** If a later run shows the playlist disappearing, the library being rebuilt, or itlkit
failing to read a file the application wrote, this result is withdrawn rather than explained away. The
sanitized logs, the pre-registered declaration, the build report and the digests are in
`evidence/g4/native/exp03/` so that the claim can be checked rather than trusted.

### Binding limits on this result

- Rejection means the gate is load-bearing on this version and stays as it is.
- Acceptance means the gate is conservative on this version - and still does not license widening the
  accepted-profile set. That would need its own declared native experiment on 12.13.11.1 with a paired
  negative control, exactly as EXP-02 paired with EXP-01.

The observed outcome was acceptance, so the second bullet is the one that binds: **itlkit's accepted-profile
set is left exactly as it was.** The gate still refuses 12.13.11.1, and the only way through it remains a
research script that lives outside `itlkit/` and says so in its first line.

## EXP-04 - pre-registered: does the acceptance generalise past one operation?

**Status: tooling built and controlled offline; native result pending.**

EXP-03 answered a question about exactly one call: `create_playlist`. It would be an easy and
wrong move to promote that into "itlkit can write playlists on 12.13.11.1". EXP-04 asks whether
the other two playlist operations itlkit refuses on this version - replacing members and deleting -
produce libraries the application also accepts, or whether creation happened to be the benign case.

The probe is `research/g4/exp04/playlist_ops.py`. It imports the EXP-03 bypass rather than
reimplementing it, so there is one version spoof in the tree and it is still only the version string
that is relaxed. Offline, on a supported 12.13.10.3 snapshot, the full round trip create -> empty ->
refill -> delete runs through the **real** gate and each stage re-reads correctly:

```
after-create   3554  playlists=15  present=True   members=1
after-empty    3524  playlists=15  present=True   members=0
after-refill   3554  playlists=15  present=True   members=1
after-delete   3427  playlists=14  present=False  members=0
```

That is a control for the tooling, not evidence about iTunes.

A byte comparison between the gated and bypassed round trips showed a one-byte difference at
`after-create`, which looks incriminating and is not. Running the **gated** path twice reproduces the
same difference: each playlist item is given a freshly allocated id, so every stage that carries
members varies run to run, while the member-free stages (`after-empty`, `after-delete`) are
byte-identical. This is the second time byte comparison has nearly produced a false alarm in this
work, after the same trap in EXP-03, and the third time non-determinism has had to be measured
rather than assumed - iTunes' own post-quit rewrite was the first.

The native protocol will present two candidates built from the live 12.13.11.1 library: the refilled
playlist, and the state after the playlist has been created and then deleted again. Acceptance
criteria are the same as EXP-03's, pre-registered per candidate, with the same explicit non-acceptance
list. Results, whichever way they fall, are appended here.

## What these results license

Together the experiment, its negative control and its baseline control support
a narrow, specific claim: **iTunes 12.13.11.1 accepted a
container that itlkit rebuilt from its own parse, and the same harness rejects
a corrupted container loudly.** Acceptance survived two restarts.

They do not license anything wider:

- No semantic change was written. The rebuild preserves content; it does not
  add, remove or edit a track, a playlist or a field. Every such path refuses
  this library version.
- Nothing here is evidence about playback, which was never attempted.
- This is a single library with one track, not a corpus. Byte-level slack that
  iTunes tolerates here may matter in a larger or older library.
- Acceptance of a rebuild is weaker than acceptance of a construction. The
  long-standing goal, a genuinely new track built from nothing, remains unmet
  and is blocked by the writer version gate rather than by missing knowledge of
  the format.

## Evidence classes

Everything in this file is class A: observed in this phase, with the harness
logs, declarations and hashes retained alongside. The interpretation paragraphs
are marked as interpretation; the tables are measurements.
