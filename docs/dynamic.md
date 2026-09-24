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

The initial empty library was created by this run, copied to `fixtures/dynamic/live/iTunes Library.itl`, and selected using the real Shift-start library picker. Subsequent phase1 tests stayed on that isolated path. Phase2 additionally created a genuinely independent native library; see its separate identity and fixture manifest below.

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

The fresh candidate derives from native 003 rather than an already manually edited/rated track. Its first read returned Name=`Codec Fresh 🧪`, Rating=80, PlayedCount=7, SkippedCount=2, Year=2032, TrackNumber=9, but Unplayed remained true. The Unplayed=false check was an **extra dynamic-authored COM-equivalence expectation**, fixed before this test from the native 018 PlayedCount 0→7 operation, which also changed Unplayed true→false (`050-fresh-field-dependencies.log`). Unplayed was **not one of the six codec-requested changes**, and false must not be inferred from PlayedCount. The historical extra gate is retained as such; the later Name reversion is an independent requested-field failure. Only derived AlbumRating was excluded from the historical first expectation.

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
| `121-hypothesis-name-and-played-flags` | +0x6d=0 and +0xee=1 | `93fc81ab4078c3ee7d8bb2d9bc02dc08cf8a11e05147699669c52f1df6014088` | Two cycles passed with the dynamic-defined native-equivalence state: six codec-requested fields plus the extra Unplayed=false expectation |

These four extra native cycles support a targeted correction for this observed WAV/profile state. They are **not** proof that the production codec has been corrected, or a rule for arbitrary flag values/media/versions. The original codec candidate remains failed. Codec integration and its own regression coverage belong to the parent/codec owner. `061-experiment-audit.json` checks all four cycles again.

### Harness hardening and rating provenance

The worker now captures RatingKind and AlbumRatingKind read-only. In the fresh/control cases alpha had Rating=80, RatingKind=0, AlbumRating=0, AlbumRatingKind=1; beta/gamma had Rating=0 and RatingKind=1. Raw codes are retained rather than inferred from adjacent binary bytes.

Snapshot-only operations now recheck the full state **again after observation and before Quit**, rejecting within-read changes rather than adopting them as the next cycle's expectation. Existing ten positive candidates were also audited retrospectively for before/after stability. This is bounded observation, not a guarantee against all later background behavior. The phase1 offline suite had **18 passing tests**, including a mocked regression proving that a reverted Name prevents Quit, a stable positive control, and read-only rating-kind checks. `057-final-qa.json` also records compileall, JavaScript syntax, CLI smoke checks, and the 20-cycle codec audit.

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

An additional real native attempt set Comment to 240033 deterministic ASCII characters. iTunes immediately returned only the first **255 characters**, so the exact-value gate correctly failed (`traced-runs/090-native-size-boundary/after.json`). This was not an accepted large-value write. The actual truncated state was then recorded, gracefully saved, and verified through another native restart; IDs/counts/other tested state remained unchanged. Evidence: `048-comment-truncation.json` and `native-runs/092-comment-truncation-reloaded`. The resulting ITL was only 5680 bytes. This phase1 COM-setter attempt did **not** produce a native compressed body greater than 102400 bytes and did not verify that boundary. The later phase2 direct-file test is reported separately below. This observation applies to the tested COM Comment setter/profile, not universally to every string field or direct-file codec operation.

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


## Additional bounded native phase (2026-09-09)

The dynamic branch continued from `5d679e303c6243db7f3fec1a0610b1be95952a3f` after exclusive native ownership was returned. Producer request revision: `276efca9e86e5710c639ee7ea840a67f906e90fc`. Dynamic changed no production codec. Claims refer to hash-pinned inputs, not an unspecified current codec. Evidence is in `reports/dynamic/phase2/`; phase1's report and ledger remain preserved.

### Passive protocol and v4

`passive_native.py` uses bounded workers, PID-only target lookup, an initial target read, repeated full snapshots and fresh target reads, and a final fresh Name before Quit. The original expected state remains fixed across both cycles. No setters or UpdateInfoFromFile are called. Identity, count, synthetic locations and ordinary playlists remain hard gates. Scoped metadata-negative observations can save/quit normally for diagnosis, without converting accepted=false to a pass. Unplayed, RatingKind, AlbumRatingKind and derived AlbumRating are explicitly observe-only for these requests; Unplayed=false is never inferred from PlayedCount.

Nine new v4 candidates completed 18 native cycles. Seven encryption/compression variants passed both cycles: encryption flags 0/1/2, flag-1 ignoring a nominal cap of 17, flag-2 caps 0/17, and three uncompressed-body variants. This is logical native acceptance, not preservation of the input envelope flags by iTunes. Old successful candidate hashes were not retested.

Both text cases failed Name persistence. Initial Names decoded correctly as Cafe-acute/y-diaeresis and the same text plus Japanese/music emoji (exact Unicode values are in the manifest). At the first full snapshot/fresh lookup, about 0.343/0.359 seconds later, both were already alpha. Reversion remained through 45-second dwell and the second 30-second cycle. The persisted record changed later, by the 45-second observation. No particular getter or encoding failure is established. See `v4-name-reversion-audit.json` and `v4-native-audit.json`.

### Fresh factorials and single-field controls

Each case completed two native cycles with 60-second then 30-second dwell and normal native/worker exits. A means mith +0x6d:1 to 0; B means Name external ID:1 to 4; C means mith +0x290 DWORD:1000 to 0. All eight kept +0xee=0.

| A | B | C | Requested Name after both cycles |
| --- | --- | --- | --- |
| 0 | 0 | 0 | Failed: alpha |
| 0 | 0 | 1 | Failed: alpha |
| 0 | 1 | 0 | Failed: alpha |
| 0 | 1 | 1 | Failed: alpha |
| 1 | 0 | 0 | Passed: Codec Fresh (exact non-BMP Name in manifest) |
| 1 | 0 | 1 | Passed |
| 1 | 1 | 0 | Passed |
| 1 | 1 | 1 | Passed |

Name-only also reverted; PlayedCount-only retained 7 with Unplayed observed true. Ten cases/20 cycles thus contain five positives and five semantic negatives. Within this exact family A was necessary and sufficient for Name retention; B/C neither substituted nor were required. This establishes no universal meaning/policy for 0x6d, ranks, IDs, unknown values, other media or versions.

A0B0C0 retains the original failed SHA `34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f` and fails Name even with corrected Unplayed policy. New A-only wire SHA: `bcb6d06f8c83a9f2f6cd7e03a5a427dfdc81e40e1a6bc48fa4350afd9cb3cc4b`. Its provenance is distinct from dynamic 120/121. Existing native PlayedCount, Name and Unplayed setters plus the 0x6d/0xee experiment remain historical controls; 121 was not rerun with extended dwell. See `factorial-manifest.json` and `factorial-native-audit.json`.

Across all 40 passive cycles, media prelaunch-to-final SHA, bytes, mtime and attributes were unchanged by normalized path. No in-memory iTunes dirty/modified flag was captured. Persisted raw 0x6d, COM ModificationDate and filesystem attributes are separate observations, not substitutes for that flag.

### Independent shared-group donor

Native Shift-start Create Library created `fixtures/dynamic/phase2/independent/NativeBulk/iTunes Library.itl`, not a copied empty ITL or invented IDs. Outer file PID: `533551EBA255E616`; native COM master PID: `48DA29E706F4922A`. Both differ from the original fixture.

All 768 parent-generated WAVs were copied/hash-verified into `fixtures/dynamic/phase2/bulk768/media/`. The first 32 were imported into the genuinely new library; manifest Name, Artist, Album, AlbumArtist and 240-character Comment were applied and checked twice, then after save/restart. Every real PID, count and location was checked. These 32 contain 8 artists, 16 albums and 4 album artists with repeated groups. Empty creation, import/save and restart each ended with native exit 0. Reloaded compressed body: 19014 bytes, below the cap.

`independent-donor32-manifest.json` contains every actual PID/metadata value/group/fixture hash. `bulk-copied-inputs.json` and `082-media-preservation-audit.json` verify all 768 parent inputs unchanged; copied WAV bytes, mtime and attributes were also unchanged despite native library metadata edits. Remaining 736 tracks were NOT imported. No 768-track native or cross-library merge/restore acceptance is claimed.

### Long Comment: serialized retention versus COM projection

Candidate SHA `625edbc39ff3173e454add0cdec0d490860ee8d8e421ede12f3e0c4a98370a16` contains 240034 characters; UTF-8 SHA `c9d3c0093096998296363ac36394c58312bf82e842cc1c220df6bc54a52305f6`. No COM setter was used.

Both native cycles completed normally. COM returned exactly the first 255 characters, so the original full-COM-value gate remained FALSE. Structural extraction of track `D018EAABC195E072` independently found the entire expected UTF-16 string in its type-8 mhoh in both native-saved ITLs. The 480108-byte Comment block was byte-identical to the input, SHA `a0cc2197fa53ab586d66a60dc826232dd980142b1799e452c924cf489fe40816`. The whole target track record was also unchanged. Conclusion: full serialized Comment retention, truncated COM projection; NOT serialized truncation, damaged fallback, or full COM-value acceptance.

Actual native-saved compressed bodies: 246133 / 246132 bytes; encrypted prefix: 102400 each; clear tails: 143733 / 143732. These actual native load/save/restarts cross the 100 KiB boundary, rather than inferring support from input size or an offline random test. No phase2 Frida trace was taken; phase1 zlib-buffer correlations remain separate. Evidence: `large-comment-native-audit.json`, `large-comment-observed.json`, `large-comment-disk-versus-com.json`.

### Scripts, retained failures and end state

- `passive_native.py`: hash-pinned two-cycle native observation, fixed expectations and preserved negative results. Use `batch --manifest MANIFEST` with fresh case names and exclusive ownership.
- `audit_passive.py`: offline recheck of gates, hashes, native exits, dwell and media; `--manifest MANIFEST --results RESULTS --out NEW_JSON`.
- `bulk_native.py`: manifest import/setters/readbacks and repeated snapshots. Run only with an external supervisor/timeout.
- `bulk_driver.py`: native identity/exit supervision and immutable donor snapshots; `--live ITL --root SYNTHETIC_ROOT --report REPORT --name NEW_CASE --spec SPEC`.
- `phase2_selftest.py`: eight mocked regressions for stale/fresh Name, uninferred Unplayed, immutable expectations, identity refusal and scoped negative observations. Combined with the original 18, there are 26 offline tests, not 26 additional native tests.

Preparation command 065 omitted required --scratch; its CLI error remains recorded and corrected tests passed. Reselection command 078's modal guard fired immediately after posting Open, before any COM worker or large-candidate staging. The exact transient modal at failure was not retained. Read-only 079 verified the same owned process and found the known audio warning, entry bytes intact. 080 handled only that warning, verified the original full native state, exited normally, then ran the direct Comment trial. No unexpected/damaged/cloud dialog was dismissed; no phase2 native process was force-stopped.

Native work ended with the original isolated path selected, entry bytes restored exactly to SHA `090eeaa4860f1f0909540596c5bd1f2338537b961355cfc2d362855593d5a4bb`, and iTunes stopped (`080-final-native-restoration.json`). The final report records QA, commit and explicit ownership handoff. Remaining limits include unimported 736 tracks, absent in-memory dirty flag, no generic unknown-flag policy, no arbitrary-media/cross-library acceptance, and no playback/other-version/Store/macOS validation.

## New-track native qualification (phase3, 2026-09-09)

Phase3 continued from `3c5bc2bea355232fb59e6e14039c2cfbf818766d` under the additive orchestration contract, with dynamic as the sole native/COM/UI owner. The first partial handoff was recorded at 14:58 UTC without returning ownership. The unchanged 48-test harness was checkpointed as `a07ca6cdeb21a7b6959fa2a191020f64e242f46d` before further candidates were run. Phase3 evidence is in `reports/dynamic/phase3/` and fixtures in `fixtures/dynamic/phase3/`.

### Fixed expectations, complete identities, actual new tracks

`import_native.py` rejects duplicate/zero/missing track and playlist PIDs, wrong counts and master identity, incomplete master membership, out-of-root/missing/mismatched media, unclassified ordinary playlists, and incomplete old/new PID partitions. All COM-visible system/master playlists are compared by exact PID, name, classification and member multiset. All ordinary playlists are compared by exact PID/name and manual order. Session-local TrackID/TrackDatabaseID/PlayOrderIndex are not substituted for persistent identity. The original expected state remains fixed through both saves; no setter or UpdateInfoFromFile repairs a candidate during acceptance. Media SHA/size/mtime/attributes are observed and a media change prevents another cycle.

All six cases below passed two actual native cycles, including 45-second then 30-second dwell, late full snapshots/fresh target reads, normal Quit, native exit 0, and reopening the first native save. Candidate and baseline/donor/media hashes were checked before loading; complete requested old/new fields and system/ordinary playlist expectations are retained in `case-specs/`.

| Case | Independent candidate SHA-256 | Observed scope |
| --- | --- | --- |
| `p4-fresh-api` | `bcb6d06f8c83a9f2f6cd7e03a5a427dfdc81e40e1a6bc48fa4350afd9cb3cc4b` | Actual updated producer API replay from native003; 3 tracks, retained Name/scalars and explicit Unplayed=true. Same wire hash as earlier A-only; not a new-track addition. |
| `crud3-cross-one-003` | `60c5f1541981ddedd457f3e78ca07c63a8d71e3b8e42f3211b175aad2a8facaa` | Old 3 plus independent-donor PID `E95DD2B085330A12`; 4 tracks. |
| `crud3-cross-shared-two-037` | `2bf00425a238492c427e07108638fb7e6317ccdbbc62cadb6c4499b656c08ee1` | Old 3 plus donor PIDs `E95DD2B085330A12` and `0EA4623DE17EC6F6`; 5 tracks, shared metadata groups retained. |
| `crud3-cross-shared-COW-037` | `f6f2a221eacadffba1ae9180b877872a595736a47f92644b9a38e6173981bda3` | Same 5 PIDs; only target E95 AlbumArtist changed to `Synthetic Phase3 COW Ensemble`, while 0EA retained `Synthetic Ensemble 00`. |
| `fresh-constructed-wav-003-v2` | `41a6a073db030a9ceb9e1a690420a0fa28b73cb0c675af005653f732df6c4a84` | Old 3 plus newly constructed PID `62F368A925010BFC`; 4 tracks, new file/name/location. |
| `fresh-constructed-wav-037-v2` | `a813f8ad7d493214aaefc9f20d536fc86883e511dfeaf30dd8735baf5895dc39` | Old 3 plus newly constructed PID `412ABAD099FB1F36`; 4 tracks; ordinary `5F8F30E1ABE6E4A2` remained beta,gamma. |

These retain the original file PID `D2F61BE0A69CA302` and COM master `9751B29CECF5340B`. Cross-library donor lineage is the independently native-created phase2 donor (file `533551EBA255E616`, master `48DA29E706F4922A`), not same-lineage restoration. The historical phase1 same-lineage restore is a separate result.

Constructor v2 was regenerated by its owner against existing dynamic-owned copies, rather than manually patching v1 URLs. Manifest SHA is `0a7aec91e754aada2d8d124be5d11b72baa070aeb744a2fa8b30451d2bc516da`. V1 inputs were retained and **never loaded natively**. The two new WAVs are distinct 88244-byte, one-second mono PCM16/44100 Hz files. The new constructed track is not an existing donor track/PID/path restored under a new label; it uses the exact pinned native003 WAV template/profile with new identities and local media binding. Unplayed=true, AlbumRating=0 and DateAdded/ModificationDate=2026-09-09T14:00:00Z are explicit constructor expectations, not inferred from a play count. Blank descriptive fields and the full media facts were also checked. These are bounded template-family proofs, not arbitrary new-media synthesis.

### Serialized reference closure and following native allocation

`native_saved_audit.py` performs a separate bounded, read-only record-boundary audit. For all five new-track cases, both native saves retained exactly the expected serialized playlist PID/name/member multisets: 14/15/15/14/15 playlists per case, including raw system playlists not exposed through COM. Identity keys were nonzero and unique within their checked namespaces; auxiliary album/artist and membership-to-track references resolved, and raw master membership exactly matched the full track set. Thus ten actual native saves, covering 146 serialized playlist instances, passed. Ordinary displayed order is established by the COM gate; raw physical order is not silently equated to that order. Unknown opaque reference semantics remain outside this audit. See `continue-005-raw-summary.json` and each `raw-audit-<case>.json`.

A subsequent native allocator control staged a **separate working copy of the original qualified constructor037-v2 candidate**, not a modification of the preserved accepted snapshots. Native AddFile added `allocator-followup.wav` as fresh PID `F20377F9F2DAF23E`, moving count 4 to 5. All four prior PIDs/metadata and ordinary playlists were conserved. Known raw identity/reference closure passed; two further 10-second native reloads preserved the five-track state. This checks a real next allocation after reading the independently constructed candidate, not a universal high-water/allocator policy. Its native-assigned new state is a native AddFile control, not an independent writer result. Evidence: `post-acceptance-allocation/result.json` and `runs/native-allocation-control-reload1,2/`.

### Playback negative, restoration and retained workflow errors

A separate candidate copy was used for a bounded silent playback attempt on the newly constructed synthetic track. `silent_playback.py` requires target COM Playing state plus position advance or target play-count increase; merely returning from Play/Quit or exiting 0 does not pass. The attempt **did not establish successful playback**. The known startup audio-configuration warning was retained, but its causal role is not inferred. SoundVolume was captured as 100, set to 0 for the attempt and restored to 100; media remained unchanged and native exit was 0. No audible-output or playback support is claimed. Evidence: `post-acceptance-silent-playback/`.

Native operations ended at 15:55:11 UTC. The real Shift-start picker reselected `fixtures/dynamic/live/iTunes Library.itl`; WM_GETTEXT verified that exact path and the Open dialog was observed closed before the COM gate. The original three-track/metadata state passed, native Quit/exit completed normally, the native save was preserved, and the entry bytes were restored exactly to `090eeaa4860f1f0909540596c5bd1f2338537b961355cfc2d362855593d5a4bb`. See `final-native-restoration/result.json`. Final reporting separately records the clean source commit, process check and explicit ownership return.

An assistant continuity mistake attempted a duplicate bootstrap guard after existing phase3 work. Its clean-worktree assertion failed before native/source changes, but the shell log sink overwrote the old bootstrap log. The earlier completed command output was recovered in full and restored; the 91-byte failure, failed transport attempt and repair receipts remain in `reentry-dcc2249d63504697/`. The old on-disk pre-overwrite hash/mtime was not independently recorded. The parent explicitly resolved the mistaken ownership blocker as the same session's work; no competing native executor was established, and the three completed native cases were not rerun. Incorrect manually transcribed compressed transport blobs were not executed; plain-text checked transfers succeeded. These are retained assistant workflow errors, not established MCP defects.

### Reproduction and limitations

- `import_native.py case --case NEW_CASE_JSON`: selected-fixture preflight and two strict native cycles. Descriptive producer manifests require deliberate adaptation; they are not this API. Use fresh evidence paths and verified selection evidence.
- `import_selftest.py`: 22 offline identity/system/ordinary/order/field regressions. Together with the original 18 and phase2 eight, the checkpoint has 48 tests.
- `native_saved_audit.py --case CASE --result RESULT --out NEW_JSON`: known-profile saved-reference audit, not a general writer or complete unknown-record validator.
- `saved_audit_selftest.py --scratch NEW_DIRECTORY`: 15 synthetic structural regressions, bringing the combined offline suite to 63 tests. These synthetic parser tests are not additional native trials.
- `silent_playback.py --selftest`: four playback-outcome predicate checks; the actual worker requires `--spec` and `--out` under an external timeout.

There was no new Frida collection in phase3. The real phase1 inflate/deflate correlations and the phase2 large-Comment/cap proof remain distinct retained evidence. Remaining 736 bulk imports, additional media formats and separate date cases were deferred in favor of the new-track priority and shutdown reserve. No original/private library/music, Apple ID/cloud/device operation, shared toolchain/config change, production codec edit, environment lifecycle action, peer worktree edit or publication was performed. Cross-library/COW/constructor research candidates being accepted does not by itself broaden the production API's advertised support. Complete/universal ITL read/write, arbitrary media/paths/flags/versions and successful playback remain unproven.


## 2026-09-22 isolated field, external, and Smart Playlist probes

### Complete-snapshot one-property field matrix

[`../evidence/native/field-matrix-20260922/README.md`](../evidence/native/field-matrix-20260922/README.md) records 29 fresh-profile cases against the exact raw reference fixture. Twenty-seven passed immediate projection, full expected state, native save/exit, complete restart, two stable reads, stable intended identities, no-fallback gates, and independent parse/validation. Lyrics failed with a COM exception; Enabled accepted the setter call but projected `true` after requesting `false`. Neither failure received a verification restart.

### Media-backed failure follow-up

The first run in [`../evidence/native/media-field-followup-20260922/README.md`](../evidence/native/media-field-followup-20260922/README.md) created and normally saved both fresh native WAV-backed tracks but failed before mutation because the harness incorrectly required the outer file PID to equal the COM/master-playlist PID. Those are distinct domains; this run is harness evidence only. The corrected [`../evidence/native/media-field-followup-20260922-v2/README.md`](../evidence/native/media-field-followup-20260922-v2/README.md) selected the serialized master by COM PID and checked exact track membership. Both initialization and baseline-restart sessions passed with stable media and identities. The exact Lyrics setter still raised COM error `-2147418113`; the `Enabled=false` setter returned but immediate readback remained `true`. Failed mutation workers were killed without `Quit`, neither case reached mutation save or verification restart, and the result does not generalize beyond these exact values and pinned native profile.

A later same-value media-kind pair narrowed the Lyrics behavior without generalizing it. [`../evidence/native/media-lyrics-ascii-20260922/README.md`](../evidence/native/media-lyrics-ascii-20260922/README.md) records the same nested HRESULT for short plain-ASCII Lyrics on a fresh deterministic WAV track after successful initialization and baseline restart; every WAV copy remained exact. [`../evidence/native/media-field-followup-20260922-mp3-ascii-v3/README.md`](../evidence/native/media-field-followup-20260922-mp3-ascii-v3/README.md) records the identical property/value passing all four sessions on one deterministic MP3 track. iTunes rewrote the MP3 from 8,777 bytes (`5033b6d0…dee12`) to 19,066 bytes (`d49051b7…b9535c`) during mutation; asynchronous `ModificationDate` settled on the first equal adjacent pair at reads 2–3, and restart verification preserved exact Lyrics and media bytes. This proves one media/interface-dependent positive case only. Unicode, long-string boundaries, UI behavior, storage authority, other media kinds, and cross-version behavior remain unresolved.

### External implementation

[`../evidence/independent/itl-rs-20260922/README.md`](../evidence/independent/itl-rs-20260922/README.md) pins external `itl-rs` source/toolchain provenance. Its compressed no-op output has a byte-identical expanded payload and passed two strict native cycles. Raw input failed, the external accessor returned a zero track PID, and mutation outputs failed logical-size or semantic identity preflight. The native pass therefore establishes structural preservation for one exact output only.

### Smart Playlist UI/native negative

[`../evidence/native/smart-playlist-default-20260922/README.md`](../evidence/native/smart-playlist-default-20260922/README.md) retains v1–v24. The canonical v24 run created a native playlist and exposed nested OR/AND wrapper framing plus an Artist/contains leaf. Despite the visible requested value, iTunes emitted the empty/conflict warning, serialized an empty operand, and returned no members. The process exited normally and cleanup completed, but positive semantic gates failed; no restart-positive editing claim is made.

## 2026-09-25 RatingKind/Loved/Disliked bounded replacement

The immutable [native evidence bundle](../evidence/research/20260925/native-rating-kind/README.md) records seven fresh-profile cases and 20 native sessions on signed standalone Windows iTunes 12.13.10.3. It used only the pinned one-track baseline (SHA-256 `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74`) under a disposable junction. All workers and iTunes processes exited 0 via normal Quit; stable-before/after, identity, unexpected-modal, and fallback gates passed, and user data was not touched. The complete machine-readable provenance, operations, readbacks, saved hashes, byte ranges, and gates are retained in `report.json`; `oracle.json` is a deterministic compact derivative.

### Static declarations and runtime capability are separate

Installed `IITFileOrCDTrack` typelib entries declare get/put for `Rating` and `AlbumRating`, get-only for `RatingKind` and `AlbumRatingKind`, and no `Loved` or `Disliked`. Runtime same-value probes matched those declarations: `Rating`/`AlbumRating` were writable; `RatingKind`/`AlbumRatingKind` getters returned 1 on the unrated baseline but setters raised `AttributeError`; and both get/put attempts for `Loved` and `Disliked` raised `AttributeError`. The Loved/Disliked interaction sequence was therefore **blocked**, not observed, because both members were not readable and writable.

### Rating persistence and targeted bytes

Each value 0/20/40/60/80/100 began from the exact baseline. A mutation save, restarted same-value setter/save, and second restart verification all returned the requested value (18/18 rating sessions). For values 20–100, immediate COM projection changed `Rating/RatingKind/AlbumRating/AlbumRatingKind` from `0/1/0/1` to `value/0/value/1` and preserved it through both restarts; value 0 remained `0/1/0/1`. Thus RatingKind is a read-only projection that changed under the writable Rating setter in this profile. AlbumRating's matching one-track projection and unchanged AlbumRatingKind=1 are bounded observations, not general album semantics.

At `mith+0x6c`, the five nonzero mutations changed `00` to `14`, `28`, `3c`, `50`, and `64`. The adjacent `mith+0x6d` value and bounded legacy `mith+0x2bf & 0x02` sentinel remained clear. Mutation-to-repeat and repeat-to-verification changed zero bytes in the targeted 756-byte `mith` header for all six values. Whole encrypted/container files still changed by thousands of byte positions and had distinct SHA-256 values at every save, so the result is semantic/target-record stability, not raw-file idempotence.

### Validation and claim boundary

Twenty-seven targeted analyses covered 21 unique snapshot hashes; primary low-level parsing, the independent reference parser, and VALIDATOR passed all 27. The high-level semantic `Library` path was blocked on the repeated raw baseline analyses (`zero or duplicate secondary track ID`) but observed on all 20 native-saved snapshots. That distinction is retained; structural success is not promoted to universal native acceptance. The evidence narrows U-14 but does not close UI Loved/Disliked transitions, album-derived factorials, other media/track shapes or versions, or independent reproduction.
