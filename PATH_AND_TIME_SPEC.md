# Windows path and time specification

## 1. Status, target, and claim boundary

This is an **evidence-bounded specification for one target pair**, not a declaration that every Windows iTunes/ITL combination is solved.

| Item | Target |
|---|---|
| iTunes | 12.13.10.3, Apple standalone desktop distribution, x64 |
| Executable | `C:\Program Files\iTunes\iTunes.exe`, SHA-256 `30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d` |
| ITL | native empty seed whose container version decodes as 12.13.10.3; SHA-256 `503736e6cf40bf5cea572595c63387db94fbaec3732016df6443b7549a8c7cf4` |
| Windows | Windows Server/NT 10.0 build 26100, x64, `en-US` culture/system locale |
| Time zones exercised | `UTC`; Windows `Eastern Standard Time` including 2026 fold/gap |
| Library lineage | target-version native empty library, not an upgraded old-version library |

The installer and executable are pinned in `evidence/path-time/installer-provenance.json` and `evidence/path-time/environment.json`. The original native summary truthfully retains a failed, incorrectly quoted Authenticode subcommand; a separate post-run attestation is valid, and the reproduced harness fixes that command without rewriting the recorded run. The exact evidence-producing harness is preserved as `evidence/path-time/native/path_time_matrix-evidence.py` (SHA-256 `0c75bddf12d181229f4feebb0ba1a4d77304157229e7ce61f02a2653ef2d0bb7`); the corrected current harness is SHA-256 `5b640cd956a5ea6ee3db575049e82aec2a7c31d475aed4b7d467d97c61362a2b`.

This matrix confirms specific import/save/reopen observations. It does **not** establish a universal writer, actual removable-media behavior, a remote network server, drive-letter reassignment after import, or all date fields.

## 2. Evidence classes

| Class | Meaning | Primary artifact |
|---|---|---|
| Offline lexical | Pure path spelling/URL codec and `zoneinfo` calculation. It does not prove iTunes acceptance. | `evidence/path-time/offline-matrix.json` |
| Windows-only | NTFS/link/share/mapping facts observed without promoting them to ITL semantics. | `native/input-manifest-final.json` |
| Native UI/COM | iTunes 12.13.10.3 launched against an isolated profile; COM action, returned object, and guarded modal inventory were recorded. | `native/native-summary.json`, `native/runs/*/com.json` |
| Serialized ITL | iTunes-saved snapshot decoded by `itlkit`, byte-diffed, hashed, then reopened by later native cases. | `native/snapshots/*.itl`, `native/runs/*/summary.json` |

A success below requires a returned COM track, expected persistent-ID delta, native save, parseable snapshot, and survival into later reopen/save cycles. `rejected_or_failed` is deliberately not upgraded to “format rejection”: it records only that this exact COM invocation added no track.

## 3. Path representation

### 3.1 Logical value and serialized value

For observed local absolute paths, iTunes stores a URL-like UTF-8 string using forward slashes and percent encoding, normally with `file://localhost/` before the drive. The parser exposes both the serialized URL and a Windows-facing path.

| COM-visible/input spelling | Serialized decoded URL |
|---|---|
| `D:\...\drive-absolute.wav` | `file://localhost/D:/.../drive-absolute.wav` |
| `d:\...\drive-letter-case.wav` | `file://localhost/d:/.../drive-letter-case.wav` |
| `media\relative.wav` | `media/relative.wav` |
| `D:/.../forward-slash.wav` | `D:%2Fa%2F...%2Fforward-slash.wav` |
| NFC `café-NFC.wav` | `.../caf%C3%A9-NFC.wav` |
| NFD `cafe◌́-NFD.wav` | `.../cafe%CC%81-NFD.wav` |
| `emoji-🚒-🎶.wav` | `.../emoji-%F0%9F%9A%92-%F0%9F%8E%B6.wav` |
| `\\localhost\PTM_…$\unc.wav` | `file://localhost//localhost/PTM_…$/unc.wav` |
| `N:\mapped-network.wav` | `file://localhost/N:/mapped-network.wav` |
| `P:\external.wav` | `file://localhost/P:/external.wav` |

Observed spelling is not automatically canonicalized: drive-letter case, slash style, and NFC/NFD were retained. A reader must percent-decode UTF-8 without Unicode normalization and preserve unrecognized/noncanonical URLs losslessly. The forward-slash case serialized an unusual scheme-less value; a writer must not “improve” it without an explicit edit.

### 3.2 Native path matrix

| Cases | Input property | Native result | Persisted meaning | State |
|---|---|---|---|---|
| 001 | absolute `D:\...` | returned; +1 track | absolute spelling survived saves | iTunes interoperability confirmed for sample |
| 002 | lowercase `d:` | returned; +1 | lowercase drive retained | iTunes interoperability confirmed for sample |
| 003 | relative `media\relative.wav` | returned; +1 | relative location retained | iTunes interoperability confirmed for sample |
| 004 | `/` separators | returned; +1 | slash spelling retained; unusual encoded URL | iTunes interoperability confirmed for sample |
| 005–007 | `file:///`, `file://localhost/`, percent-encoded Japanese/emoji URL passed to `AddFile` | no returned operation/track | no track added | negative COM observation only |
| 008–010 | NFC, NFD, surrogate-pair emoji | returned; +1 each | code-point sequence retained and UTF-8 percent-encoded | iTunes interoperability confirmed for samples |
| 011 | read-only media file | returned; +1 | location retained | iTunes interoperability confirmed for sample |
| 012–013 | same NTFS file with case-only spelling change | second call returned existing track; +0 | original spelling retained | iTunes interoperability confirmed for sample |
| 014–016 | source, hard link, symlink to same file identity | returned; +1 each | three distinct track records/spellings | iTunes interoperability confirmed for samples |
| 017–018 | 281-character path and `\?\` spelling | COM `E_INVALIDARG`; +0 | no track added | negative COM observation only |
| 019 | nonexistent path | no returned operation/track; +0 | no track added | negative COM observation only |
| 020 | UNC path to local SMB share | returned; +1 | UNC spelling retained | iTunes interoperability confirmed for local-backed sample |
| 021 | mapped `N:` to same local SMB share | returned; +1 | mapped-drive spelling retained | iTunes interoperability confirmed for local-backed sample |
| 022 | `subst P:` fixed-volume equivalent | returned; +1 | `P:` spelling retained | iTunes interoperability confirmed for emulation only |

The final snapshot contains 23 tracks and remains parseable after all 38 native cases. All 39 seed/intermediate snapshots parse as version 12.13.10.3. Case 013 demonstrates case-insensitive duplicate recognition. Cases 014–016 show that iTunes did not deduplicate hard-link/symlink aliases by NTFS file identity in this workflow.

### 3.3 Explicitly unresolved path behavior

- A real remote SMB host, authentication loss, latency, and offline reconnect behavior.
- A physical removable/external drive. `P:` was `subst` and reported fixed drive type 3.
- Changing or removing a drive letter after import and observing relocation behavior.
- A direct Japanese filesystem-path import. Japanese occurred only in a percent-encoded `file:` input that failed at the COM call boundary.
- Paths longer than 281 characters, policy changes, other device paths, and short (8.3) names.
- Whether a raw ITL `file:` location rejected by `AddFile` would be accepted when authored by a proven writer.

## 4. Time representation

### 4.1 Serialized scalar

Observed track time fields are unsigned 32-bit counts of whole seconds from the HFS/Mac epoch `1904-01-01 00:00:00`. For fields tested here, the scalar represents a **wall-clock tuple**, not a self-describing UTC instant:

```text
stored = seconds(datetime_fields - 1904-01-01 00:00:00)
```

No offset, time-zone identifier, DST fold bit, or subsecond precision is carried. Zero is used as “unset” by the implementation and collides with the epoch. The reference codec rejects naive Python datetimes, validates/range-checks `0..2^32-1`, and returns `None` for zero.

### 4.2 Native `PlayedDate` matrix

| Case | Windows zone | COM input | COM readback | ITL `play_date` | Result |
|---|---|---|---|---:|---|
| 031 | UTC | naive `2026-01-15 12:34:56` | `12:34:56` | 3851325296 | accepted/persisted |
| 032 | UTC | aware `2026-01-15 12:34:56Z` | `12:34:56` | 3851325296 | accepted/persisted |
| 033 | Eastern | naive `2026-01-15 12:34:56` | `12:34:56` | 3851325296 | accepted/persisted |
| 034 | Eastern | aware `2026-01-15 17:34:56Z` | `12:34:56` | 3851325296 | accepted/persisted |
| 035 | Eastern fold | naive `2026-11-01 01:30:00` | `01:30:00` | 3876341400 | accepted; fold not representable |
| 036 | Eastern gap | naive `2026-03-08 02:30:00` | `03:30:00` | 3855785400 | accepted after normalization |
| 037 | Eastern | `1904-01-01 00:00:00` | none | unchanged | Python/COM boundary `OSError 22` |
| 038 | Eastern | `1904-01-01 00:00:01` | none | unchanged | Python/COM boundary `OSError 22` |

Although pywin32 rendered returned values with `+00:00`, case 034 proves the clock fields are local/display wall time after conversion, not the original UTC instant. Do not treat that attached offset as serialized ITL metadata.

When the zone changed from UTC to Eastern before case 033, decoded `date_modified` values for existing tracks shifted by exactly `-14,400` seconds. This is reproducible but does not identify whether iTunes re-derived them from NTFS timestamps or reinterpreted stored wall time, and must not be generalized to every date field.

The 1904 failures occurred before a successful COM assignment; they do not prove raw scalar 0/1 is rejected by the ITL parser. Direct-writer/native acceptance at both epoch values is unresolved.

## 5. Isolation and safety controls

- A disposable root under `RUNNER_TEMP` and isolated `Music\iTunes` junction were required.
- Seed, executable version/hash, and every generated WAV hash were pinned.
- COM-returned locations were accepted only when bytes matched the immutable inventory.
- UI automation was fail-closed: only the known audio warning was dismissed.
- Local share, mapped drive, `subst` drive, profile junction, and UTC zone were removed/restored in cleanup.
- `native/final-live-inventory.json` records no XML and no `Previous iTunes Libraries`.
- `native/post-run-state.json` records no profile junction and no running iTunes process.

No repair, rebuild, backup-restore, or XML-rebuild modal was observed. This applies only to this matrix.

## 6. Reproduction

```powershell
python scripts/windows/path_time_matrix.py offline --output evidence/path-time/offline-matrix.json
python -m pytest -q tests/test_path_time_matrix.py
```

Destructive native mode on a disposable Windows runner only:

```powershell
python -u scripts/windows/path_time_matrix.py native `
  --root "$env:RUNNER_TEMP\path-time-native" `
  --evidence evidence/path-time/native `
  --seed evidence/native/snapshots/000-empty.itl `
  --confirm-disposable
```

## 7. Evidence and tests

- Aggregate: `evidence/path-time/native/native-summary.json`
- Per-case input/COM/result: `evidence/path-time/native/runs/<case>/`
- Native sequence: `evidence/path-time/native/snapshots/`
- Media inventory: `evidence/path-time/native/input-manifest-final.json`
- QA: `evidence/path-time/qa-summary.json`
- Hashes: `evidence/path-time/manifest.json`
- Tests: `tests/test_path_time_matrix.py`

## 8. Completion assessment

Successful rows reach “iTunes interoperability confirmed” only for their exact samples and target pair. This portion is **not 100% complete** because remote networking, physical removable media, drive reassignment, direct Japanese paths, direct-writer `file:` values, additional date fields, epoch direct-write acceptance, and cross-version behavior remain open. Repository-wide “complete analysis/specification” gates therefore remain false.
