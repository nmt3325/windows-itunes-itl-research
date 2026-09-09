# Windows iTunes native/dynamic validation

## Scope and honest acceptance boundary

This run used the official **standalone EXE edition of iTunes 12.13.10.3** on Windows x64, in an interactive runneradmin desktop. Installed `C:\Program Files\iTunes\iTunes.exe` SHA-256:

`30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d`

The executable signature was Valid. The native application, not a parser emulator, produced the fixtures and read back the independently written candidates. All media is deterministic synthetic WAV audio created for this run. No original user's library/music/artwork was opened in these tests. No Apple ID, cloud synchronization, device, purchase, or signing-in operation was performed.

Successful tests establish support for **the named fixtures, fields, and operations below**, not universal or complete ITL read/write support. Unknown structures and unsupported semantics must remain preserved or refused by the codec. An empty library alone cannot disprove damaged-library fallback.

`ROOT` in this document is the orchestration root. The dynamic worktree is `ROOT\wt\dynamic`, shared Python is `ROOT\tools\py\Scripts\python.exe`, evidence is `ROOT\reports\dynamic`, and synthetic material is `ROOT\fixtures\dynamic`. The shared Python installation was only read/executed.

## Identity domains and native gates

- COM `GetITObjectPersistentIDs(app.LibraryPlaylist)` gives the **master playlist ID** `9751B29CECF5340B`. The early JSON field `library_persistent_id` is a legacy name for this COM master-playlist ID.
- The outer `hdfm` file/library persistent ID is a different domain: the codec handoff reports `D2F61BE0A69CA302`. Do not compare it to the COM master playlist ID.
- Real 64-bit track persistent IDs are alpha=`D018EAABC195E072`, beta=`8F11E62B0DC9F837`, gamma=`C8ADF4DC10AFC270`.
- COM `TrackID` and `TrackDatabaseID` are not stable cross-restart identities in this run. For example, TrackDatabaseID changed 139 to 71 after the initial import/restart. Raw values remain in evidence; comparisons use the actual persistent IDs.
- Library/Music system views may be automatically sorted. User-playlist ordering is checked separately using each member's `PlayOrderIndex`, not global library enumeration order.
- COM Kind=2, SpecialKind=0 selects ordinary user playlists. Gates also check independently created or renamed playlists whose names no longer start with `Synthetic`. Missing SpecialKind is refused rather than silently weakening the check.

Each acceptance cycle verifies the full expected state inside a bounded COM subprocess before native Quit, waits for the actual iTunes process to exit with code 0, then preserves an immutable native ITL. Cycle 2 opens the exact bytes saved by cycle 1. Candidate SHA-256, input/save chain, IDs, counts, requested values, ordinary playlist names/membership/order, and unexpected modal checks are all recorded. Damaged-library dialogs are never dismissed automatically.

## Native fixture matrix

The initial empty library was created by this run, copied to `fixtures/dynamic/live/iTunes Library.itl`, and selected using the real Shift-start library picker. Subsequent tests stayed on that isolated path.

| Fixture | Native observation |
| --- | --- |
| `snapshots/000-empty.itl` | 0 tracks, 4009 bytes; SHA-256 `503736e6cf40bf5cea572595c63387db94fbaec3732016df6443b7549a8c7cf4` |
| `snapshots/001-one-track.itl` | 1 synthetic track; SHA-256 `c1aad11c66d497788be5cc417a5b2931c59d5eb2589c8cc83d31594097e9d9f1` |
| `snapshots/003-three-tracks-reloaded.itl` | 3 synthetic tracks after native restart; SHA-256 `a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4` |
| `snapshots/037-final-three-reloaded.itl` | Final native metadata/playlist baseline; SHA-256 `155e427ebaf820e177123c9787d878e1f6b655a5978db409ba742c8697675f81` |

`045-native-matrix-final-gates.json` verifies 26 native runs/restarts, against the recorded one-track recovery baseline. Fifteen one-property changes cover: Unicode/non-BMP/combining-mark title, 205-character title, 1-character title, Artist, Album, AlbumArtist, Comment, Rating, PlayedCount, SkippedCount, PlayedDate, SkippedDate, Year, TrackNumber, and Compilation. The title Unicode case contains Japanese, an emoji, accented Latin/combining text, and Arabic.

Ordinary playlist operations were isolated into native cases: create, add members, Unicode rename, replace order, remove membership, create a second playlist, delete it, and final restart. Native playlist `5F8F30E1ABE6E4A2` is the surviving test playlist. The before/after COM JSON and native file for every operation are under `native-runs/<case>/` and `snapshots/<case>.itl`.

DateAdded and ModificationDate were observed as read-only; they were not advertised as writable. Unrelated timestamps, indexes, caches, and derived values can change during a native save; one requested operation is not a promise of a one-byte-only diff.

## Independent writer acceptance

Hash-pinned codec handoff candidates passed two real native save/restart cycles each:

| Candidate | SHA-256 | Result |
| --- | --- | --- |
| `native-three-rebuild.itl` | `ebc9f56c353addc7341681a3840d9f9bca391f716e050aebce39bb2a4e1dec41` | Passed; `acceptance/050-codec-forced/result.json` |
| `native-three-modified.itl` | `bdf1ac5648bc958d29b530e524a961950f56e31dc5fa1acdc9fa211d8f664419` | Passed; `acceptance/051-codec-modified/result.json` |

The modified alpha track was observed with Name=`Codec 再構成 🎯`, Rating=60, PlayedCount=29, SkippedCount=11, Year=2031, TrackNumber=7 after both cycles. All three track IDs and the COM master playlist ID were retained. For these initial candidates, AlbumRating was excluded from the first expectation because it is derived; its actual value was included in the second-cycle full-state comparison. No requested changed field was excluded.

All five further hash-pinned codec playlist candidates passed **both real native save/restart cycles** (10 native launches, all native/worker exit codes 0). Full ordinary-playlist identity/name/membership/order gates were active regardless of the playlist name prefix.

| Case | Pinned independent candidate SHA-256 | Native result |
| --- | --- | --- |
| `070-codec-playlist-rename` | `5367f41b7e682e4028c76d4519c7000d820c651060fdd6791375a26e70fe491b` | ID `5F8F30E1ABE6E4A2`, name `Codec Playlist 日本語 🎼`, order beta,gamma |
| `071-codec-playlist-members` | `5da35436e948a5175b76335fe91a18bf57e48bb8fea78671fba792b74281b0a3` | Same ID, name `Synthetic 調査 🎼`, order gamma,alpha,beta |
| `072-codec-playlist-create` | `832cb809633d24606eb9a47e017d5f91fe52d0e79fe1185a742069f545f8db85` | New ID `C0DEC0DE00000001`, name `Codec Created 新規`, order alpha,gamma; original ordinary playlist retained |
| `073-codec-playlist-delete` | `e4ea3fa212b0e056e86470f998ea30b24904b886bf37a3d2c8e9dff74ae30902` | ID `5F8F30E1ABE6E4A2` absent; all three tracks retained |
| `074-codec-playlist-create-from-master` | `11273895ea35de2667c8a7bb53fdabcc19dfa6d324fbded89b0ead3c47876bb5` | New ID/name/order as above, built from native baseline 023 with no ordinary playlist template |

Evidence is `acceptance/<case>/result.json`, `native-runs/<case>-reload1,2/com.json`, and `044-codec-playlist-manifest.json`. The first four candidates derive from native baseline 037; the final candidate derives from 023. Serialized main-playlist record counts (14/15/16) are not COM-exposed playlist counts. These first seven independent writer candidates passed 14 native cycles. The later v3 results and separate dynamic-authored experiments are distinguished below.

## Late v3 validation and retained fresh-file failure

**Ten codec-produced candidates passed 20 native save/restart cycles. One additional codec candidate failed.** `056-all-candidate-audit.json` and `057-final-qa.json` independently recheck all ten positives, including both before/after snapshots, original requested values, native exits, and saved-file hash chains. The failed case is not counted as a pass.

| Case | Pinned codec candidate SHA-256 | Outcome |
| --- | --- | --- |
| `110-codec-track-restore` | `5fd1edeb1facff5aaa1a22ff432a450900ef7a1087e4189b4cf6afd7bb453ccd` | Two cycles passed: restore beta from same-lineage native WAV donor, alpha/beta count 2, no ordinary playlist |
| `111-codec-track-delete` | `97c1fc67d8aca300241d47b4c2b5ce00a0ddce6504c523ebc5c13074de54a864` | Two cycles passed: remove beta and references, alpha/gamma count 2, surviving ordinary playlist contains gamma |
| `112-codec-track-indexed` | `1a84651212b08f6b7aaf37b40764c195d827d95868d0b51950e1f035c2527721` | Two cycles passed: Artist=`Codec Artist Ω`, Album=`Codec Album 新規`, AlbumArtist=`Codec Album Artist 🎼`; all IDs and ordinary playlist order retained |
| `113-codec-fresh-modified` | `34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f` | FAILED: Unplayed mismatch, followed by observed Name reversion before Quit |

The fresh candidate derives from native 003 rather than an already manually edited/rated track. Its first read returned Name=`Codec Fresh 🧪`, Rating=80, PlayedCount=7, SkippedCount=2, Year=2032, TrackNumber=9, but Unplayed remained true. The false expectation was fixed **before** this test from the actual native 018 PlayedCount 0→7 operation, which also changed Unplayed true→false (`050-fresh-field-dependencies.log`). Only derived AlbumRating was excluded from that first expectation; requested fields were not dropped.

While the same native process remained open, a later read found Name=`alpha`. No setter had run since the failed gate. Both uncast and explicitly queried COM interfaces then reported `alpha`; their type information was IITFileOrCDTrack. Thus the initial Name read was not persistence evidence. The attempted observed-state recovery also correctly failed because its Name expectation no longer matched. Evidence: the original 113 COM/result/worker files, `053-fresh-observed-com.json`, `053-interface-observations.json`, and `054-fresh-state-evolution.log`.

The actual reverted state was subsequently recorded and gracefully saved (114), then reloaded (115). Separate native controls set Unplayed=false (116/117) and Name=`Codec Fresh 🧪` (118/119), each followed by a native restart. All six recovery/control native processes exited 0. `055-fresh-controls.json` preserves the distinction: these native setters did **not** turn the original independent candidate into an accepted one.

### Native controls and bounded byte experiments

Structural comparison of real native setter outputs (`058-native-control-differences.json`, 756-byte mith headers) found:

- Unplayed true→false: alpha mith byte +0xee changed **0→1**, with native bookkeeping changes at +0x270..273; no track metadata block changed.
- Name alpha→Codec Fresh: alpha byte +0x6d changed **1→0**, the title metadata block type 2 changed, and record length/index bookkeeping also changed. This is not evidence that +0x6d is a second byte of the numeric Rating value.

Two **new dynamic-authored experimental files**, not codec outputs, isolated the expanded-record-byte changes in the pinned failed candidate. Everything else in the expanded payload was byte-identical; the envelope was recompressed/re-encrypted with its declared size updated. Preparation is reproducible with `059-prepare-flag-experiments.py` and its manifest.

| Experiment | Expanded record changes | Pinned candidate SHA-256 | Native result |
| --- | --- | --- | --- |
| `120-hypothesis-name-flag` | +0x6d=0 only | `769a695174da20f16a8d37922a2527cbc750dc9f007c49e5402a7ced483d3989` | Two cycles passed; requested Name/scalars persisted, Unplayed deliberately remained true |
| `121-hypothesis-name-and-played-flags` | +0x6d=0 and +0xee=1 | `93fc81ab4078c3ee7d8bb2d9bc02dc08cf8a11e05147699669c52f1df6014088` | Two cycles passed with the original fresh candidate's full requested native-equivalent state, including Unplayed=false |

These four extra native cycles support a targeted correction for this observed WAV/profile state. They are **not** proof that the production codec has been corrected, or a rule for arbitrary flag values/media/versions. The original codec candidate remains failed. Codec integration and its own regression coverage belong to the parent/codec owner. `061-experiment-audit.json` checks all four cycles again.

### Harness hardening and rating provenance

The worker now captures RatingKind and AlbumRatingKind read-only. In the fresh/control cases alpha had Rating=80, RatingKind=0, AlbumRating=0, AlbumRatingKind=1; beta/gamma had Rating=0 and RatingKind=1. Raw codes are retained rather than inferred from adjacent binary bytes.

Snapshot-only operations now recheck the full state **again after observation and before Quit**, rejecting within-read changes rather than adopting them as the next cycle's expectation. Existing ten positive candidates were also audited retrospectively for before/after stability. This is bounded observation, not a guarantee against all later background behavior. The offline suite now has **18 passing tests**, including a mocked regression proving that a reverted Name prevents Quit, a stable positive control, and read-only rating-kind checks. `057-final-qa.json` also records compileall, JavaScript syntax, CLI smoke checks, and the 20-cycle codec audit.

## Real process trace correlation

The owned Frida hook observes zlib and selected file API calls without patching application logic. Windows x64 uses the LLP64 `z_stream` offsets next_in=0, avail_in=8, total_in=12, next_out=16, avail_out=24, total_out=28. Captures are bounded (4 MiB per blob, 128 MiB per collection), hashed, and tied to module-relative caller addresses.

### Read/inflate

`trace-empty-load` captured native inflate consuming 3865 bytes and producing 98375 bytes, returning Z_STREAM_END. Both are byte-for-byte equal to independent AES/zlib decoding of `000-empty.itl`:

- compressed SHA-256: `7ef5db41ed4ce1dd77660f5629a42979627ca82b3265e1ac641269715b3a3977`
- expanded SHA-256: `283e7b84177030bf1a287e72c84365d287b51aab3843df9c8e017de30c0cf800`
- caller return RVAs include `0x1084367`, `0x108560e`, `0x52f681`, `0x5310a3` in the pinned iTunes.exe.

`024-empty-trace-correlation.json` is the reproducible correlation. A separate three-track load also matched: 5359 compressed / 110084 expanded bytes (`038-spawn-inflate-only-correlation.json`). Its subsequent save experiment failed and must not be counted as a successful write.

### Write/deflate

Ordinary startup followed by attach-after-initialization succeeded in `traced-runs/060-attached-native-save`. Both native iTunes and collector exited 0. Native deflate input/output exactly match the independently decoded saved ITL:

- saved ITL: 5245 bytes, SHA-256 `b0b984b0a1493ae40f9f78903547ae6cd5c91f4238d01aac23dc3d6806fc0ca1`
- compressed: 5101 bytes, SHA-256 `3a1f58cea12d81c7309e07e208e163a59580941b7ede96beea50da2ac652ddd9`
- expanded: 103659 bytes, SHA-256 `06225e21b863de60f45454fe90bdd673fcad4262ff1546c959d27161e635c867`
- caller return RVAs `0x1075757`, final-flush `0x10757aa`, parent `0x1076865`.

See `041-native-deflate-correlation.json`. The native Comment change (`Traced native write ✓`) survived the next normal native restart in `native-runs/061-traced-save-reloaded`.

### Encryption observations and limits

The observed native profile has a 0x90-byte hdfm header, AES-128 ECB with the format key `BHUILuilfghuila3`, and a zlib body. In the empty file, the first 3856 body bytes are encrypted and the final 9 bytes are clear. The native header declares a 102400-byte encrypted-prefix cap. The analysis helper uses `min(cap, body_length) & ~15`, leaving the remainder clear. These statements are directly supported for the captured small native files. A large random offline self-test checks the helper across the 100 KiB boundary; **that offline unit test is not a large native iTunes boundary test**.

An additional real native attempt set Comment to 240033 deterministic ASCII characters. iTunes immediately returned only the first **255 characters**, so the exact-value gate correctly failed (`traced-runs/090-native-size-boundary/after.json`). This was not an accepted large-value write. The actual truncated state was then recorded, gracefully saved, and verified through another native restart; IDs/counts/other tested state remained unchanged. Evidence: `048-comment-truncation.json` and `native-runs/092-comment-truncation-reloaded`. The resulting ITL was only 5680 bytes. Thus a native compressed body greater than 102400 bytes was **not** achieved; its boundary remains unverified dynamically. This observation applies to the tested COM Comment setter/profile, not universally to every string field or direct-file codec operation.

A failed COM operation is not a rollback: the partial Comment change was auto-saved before Quit. Inspect the live state and preserve prior immutable fixtures before recovery; never treat an exception as proof that the library is unchanged.

The helper `analyze_trace.py` is a narrow research correlation tool for this observed profile, not the general codec. Static findings about other flags/versions are separate evidence. File API traces also contain incidental `.itdb`/XML activity; not every zlib call is an ITL. Raw ITL ReadFile interception is not claimed. The strong binding is the exact hash match of real zlib buffers to the actual preserved native ITL.

## Reproduction and scripts

Run only in a dedicated synthetic iTunes profile, with exclusive UI/COM ownership. Set ROOT to your orchestration root and work in its dynamic worktree. Do not run `--initial` against an already populated library or overwrite existing evidence paths. The driver rejects existing case directories and the acceptance harness backs up the previous live ITL before staging a pinned candidate; it refuses replacement while an iTunes process is running.

- `desktop_probe.py`: visible windows, authorized first-launch/Shift chooser and button evidence.
- `com_probe.py`: initial COM/type-library inventory; unavailable XML export is not required.
- `native_worker.py`: one bounded-by-supervisor COM operation, synthetic Location guard, persistent IDs, expected-state gate, before/after evidence, native Quit on success only.
- `native_driver.py`: serial normal startup, known audio-warning handling, worker timeout, native process exit check, immutable fixtures.
- `native_acceptance.py`: hash-pinned candidate staging plus two native cycles; manifest contains candidate path/hash and explicit expected COM state.
- `native_traced_save.py`: ordinary startup then attach, one controlled native mutation/save and bounded collector cleanup. Prefer this over spawn-at-entry tracing.
- `trace_itunes.py` / `.js`: bounded Frida buffer/caller capture. Attach only to the process owned for this experiment.
- `analyze_trace.py`: stream assembly, blob integrity, independent native-profile envelope decoding, exact compressed/expanded correlation.
- `verify_native_matrix.py`: validates saved-file chain, persistent IDs, fields, ordinary playlist state/order across actual restarts.
- `harness_selftest.py`: offline negative-gate and trace-integrity tests; never launches iTunes.

Example validation commands (use new output filenames when rerunning):

```powershell
$PY = "$ROOT\tools\py\Scripts\python.exe"
$FX = "$ROOT\fixtures\dynamic"
$R = "$ROOT\reports\dynamic"
& $PY -m compileall scripts/windows
& $PY scripts/windows/harness_selftest.py --scratch "$R\selftest-temp" -v
& $PY scripts/windows/verify_native_matrix.py --report $R --plan "$R\initial-recovery-plan.json" --plan "$R\metadata-plan.json" --baseline "$R\021-one-track-recovery.json" --out "$R\matrix-new.json"
& $PY scripts/windows/native_acceptance.py --root $FX --report $R --manifest "$R\037-codec-acceptance-manifest.json"
& $PY scripts/windows/analyze_trace.py --trace "$R\traced-runs\060-attached-native-save\trace" --itl "$FX\snapshots\060-attached-native-save.itl" --out "$R\deflate-correlation-new.json"
```

The acceptance example refuses reuse of the existing case names: duplicate a manifest with new names for a deliberate new trial. It never silently repeats a mutation after a timeout.

## Failures retained, not hidden

- Initial AddFile(alpha) succeeded but a pywin32 custom-interface wrapping error occurred afterward. Recovery read the existing one-track state and saved it; alpha was not added twice. Fix: request the custom IID with `pythoncom.IID_IDispatch` as the wrapper interface.
- `GetActiveObject` was unavailable; `dynamic.Dispatch('iTunes.Application')` works. LibraryXMLPath throws when unavailable and is not an acceptance dependency.
- Cross-process edit text verification needed WM_GETTEXT rather than GetWindowText. Non-ASCII JSON reads explicitly use UTF-8.
- Frida spawn-before-startup loaded the three-track library but native Quit did not save/exit. WM_CLOSE removed the UI but left the process. The owned supervisor timed out; only the verified owned orphan was terminated. The previous verified ITL stayed byte-exact, and the attempted album change was never counted as persisted. Evidence: `036-aborted-spawn.json`. Attach-after-normal-startup then succeeded with a real native save.
- Only the observed audio-configuration warning was dismissed using its message/OK button; playback/audio-output correctness is not claimed.
- All errors and recovered command exits remain in the orchestration report/command ledger. Native successes are distinct from offline checks, unsupported features, pending tests, and aborted experiments.

No binaries, fixtures, original media, or private reference libraries are committed by this worktree. The commit owns only `scripts/windows/**` and this document. Runtime artifacts stay in the assigned external evidence/fixture trees. No environment lifecycle, other-worktree edits, shared venv changes, git config, push, PR, or child-agent delegation was performed.
