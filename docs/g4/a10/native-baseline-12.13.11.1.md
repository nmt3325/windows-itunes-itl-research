# G4-B / a10 - Native Windows iTunes 12.13.11.1 baseline characterization

Status: baseline characterization complete. No candidate was generated or executed.
Native acceptance is NOT claimed anywhere in this document.

## 0. Version pin (read this first)

- Every native observation below was produced by **iTunes 12.13.11.1**.
- Installer: 202,759,648 bytes, SHA-256 `25B28905A81406A5EDBF482F7F3EE4831A8641D32D29DCEDA5D1EB3E8D534C08`,
  Authenticode Valid, signer `CN=Apple Inc., O=Apple Inc., L=Cupertino, S=California, C=US`,
  FileVersion and ProductVersion 12.13.11.1.
- Installed binary: `C:\Program Files\iTunes\iTunes.exe`, 38,952,912 bytes,
  SHA-256 `C69E719CD3F2F9374E71C954A6DE87002B6988AF65129943983A2F17490DD73C`, Authenticode Valid.
- The historical native results in this repository came from 12.13.10.3
  (installer `cea2a74c...`, binary `30d91209...`). The installed binary hash here is different.
  No comparison against historical native results may be made without flagging the version difference.
- The container records its writer: offset `0x10` holds length prefix `0x0a` followed by ASCII `12.13.11.1`.

## 1. Environment and isolation

- Disposable GitHub Actions Windows runner, Windows_NT 10.0.26100, pwsh 7.6.5,
  user `<CI_USER>`, elevated, interactive session 2. There is no real user library on this host.
- Everything was confined to the a10 native scratch area using two directory junctions:
  - `C:\Users\<CI_USER>\Music\iTunes` -> `native\libs\lib01`
  - `C:\Users\<CI_USER>\AppData\Roaming\Apple Computer` -> `native\profile\AppleComputer`
  Both were verified as reparse points and round-tripped back into the scratch area.
- Independent confirmation that the intended library was the one actually opened: the preference
  domain reports `Database Location = file://localhost/C:/Users/<CI_USER>/Music/iTunes/iTunes%20Library.itl`,
  which resolves through the junction, and every `.itl` write landed in `native\libs\lib01`.
- Component inventory: 12.13.11.1 is self-contained under `C:\Program Files\iTunes`.
  There is no `Common Files\Apple` tree, no Bonjour, and no Apple services.
  The contract fallback of installing AppleApplicationSupport, AppleMobileDeviceSupport and Bonjour
  from extracted MSIs is moot for this build; the bundle installed silently with exit code 0.

## 2. First-run gate: the SLA modal blocks COM, not just the UI

- A COM probe on a clean profile fails: `New-Object -ComObject iTunes.Application` returns
  `0x80080005 CO_E_SERVER_EXEC_FAILURE` after roughly two minutes of activation timeout.
- Root cause: iTunes launches with a modal first-run license dialog and never registers its
  COM class factory while that dialog is up.
  - SLA dialog: class `iTunesCustomModalDialog`, title `iTunes Software License Agreement`.
  - Controls: `id=1` Button `&Agree`, `id=2` Button `&Decline`, `id=103` Button `&Save...`,
    `id=105` `RichEdit20W`, `id=107` Static `Safety Info:`.
  - The application shell window `iTunesApp` exists but is hidden at this point.
- Remediation actually used: a single allowlisted `BM_CLICK` (`0x00F5`) delivered only to a visible,
  enabled Button whose text, with `&` removed and trimmed, equals `Agree`, and only inside a window
  whose title matches `License`. No other control was ever clicked.
- A second modal follows acceptance and gates initialization the same way:
  class `iTunesCustomModalDialog`, title `iTunes`, Static `id=101`:
  `iTunes has detected a problem with your audio configuration.` /
  `Audio/Video playback may not operate properly.`, visible OK Button `id=1`.
  Until it is dismissed there is no application window and COM stays unavailable.
  It reappears on every launch on this hardware-less runner.
- Window identification rule: the real application window has class `iTunes`.
  Both modals are class `iTunesCustomModalDialog` and the audio modal is also titled `iTunes`,
  so a title-equality test matches the modal. Detect the main window by class, never by title.

## 3. Reusable headless enablement recipe

- Acceptance is recorded in the preference domain `com.apple.iTunes` as:

```
license-agreements = {
    EA1827 = 1;
};
```

- A `reg.exe export` of `HKCU\Software\Apple Computer, Inc.` was byte-identical before and after
  acceptance (1,032 bytes, SHA-256 `CE5457885C1121C5B543A91FC7CE79124E6668952BACD5C91846EF7A208E30FA`),
  so acceptance is not stored in the registry.
- Therefore the headless recipe is: pre-seed `license-agreements` with `EA1827 = 1` in the
  `com.apple.iTunes` domain before first launch, and still handle the audio-configuration modal.
  `EA1827` is the agreement identifier observed for this build and must be treated as version-specific.
- Once the key existed, no further launch showed the SLA dialog: `sla_dialog_seen=False` on the
  import cycle and on both restart cycles.

## 4. Baseline captures

All four files are the live `iTunes Library.itl` copied after a normal COM `Quit()` and process exit.

| snapshot | bytes | SHA-256 |
| --- | --- | --- |
| empty baseline | 4,007 | `291EC968AC90E56CB8D0F7606977A966618015FA5EA33A8209CD8AB6FBE69F6B` |
| after one COM import | 4,516 | `7305AE1DE4B54F1975D48745FEE8D78D6DC82977010F9F6CAE688BFCA5DE7FF7` |
| after restart cycle 1 | 4,523 | `5F93C86AF87D7B687AF9C1BBC3D8768B2DB17C56FEA2DFF8C0CAF108C932F294` |
| after restart cycle 2 | 4,524 | `19D088455F692CC86F3D4F70C5FC74FD039D1EFCA0CE22F80F25547B8B876DCB` |

Sidecar files in `research/g4/a10/captures/` hold the exact itlkit `inspect` output for each snapshot.
The imported media is a generated 440 Hz 2 s WAV, 176,444 bytes,
SHA-256 `13075BD45479716E787E078B7043C9BF83366BEE8AE0756520E379CDE96CA151`.

Container notes: magic `hdfm`; a 144-byte (`0x90`) outer header; bytes 8..11 carry the total file
length big-endian (`0x0FA7`, `0x11A4`, `0x11AB`, `0x11AC` for the four snapshots); then `00 43 00 01`;
then the writer version string. The decompressed payload of a one-track library is about 100 KB across
11 sections of types 16, 12, 9, 11, 1, 13, 23 (opaque), 2, 14, 21 and 4 (opaque).

## 5. COM-visible state

- `com_create=ok` on the first attempt once a window of class `iTunes` exists; version `12.13.11.1`.
- Sources: `Library` (kind 1), `Internet Radio` (kind 6), `iTunes Store` (kind 0).
- `LibraryXMLPath` is empty, so there is no XML sidecar to cross-check in this configuration.
- COM enumerates 7 playlists (Library, Music, Movies, TV Shows, Podcasts, Audiobooks, Genius)
  while the file contains 14. The extra file-level playlists are Downloaded (three separate ones),
  Music Videos, TV & Movies, Rentals, Home Videos, Movies and TV Shows.
  COM enumeration is therefore not a complete view of playlist state.
- The master playlist is stored in the file under the name `####!####` while COM reports `Library`.

## 6. Preservation and semantics across save and restart

| quantity | at import | restart 1 | restart 2 |
| --- | --- | --- | --- |
| COM track count | 1 | 1 | 1 |
| track persistent id | `C54F0D3E83DBDA0F` | same | same |
| master item persistent id | `5167CE30B1D56179` | same | same |
| file / library persistent id | `90A10F416B212186` / `5EE1AA7E252C2FB3` | same | same |
| track_id | 139 | 71 | 71 |
| album_id / artist_id | 141 / 142 | 69 / 70 | 69 / 70 |
| date_added / date_modified | 3871932741 / 3871931495 | same | same |
| file_size / total_time / bit_rate | 176444 / 2000 / 705 | same | same |

Key semantic finding: the small numeric ids are session-scoped and are renumbered when the library is
reopened, while persistent ids, timestamps, metadata and playlist membership are preserved exactly.
Any oracle or diff that keys on `track_id`, `album_id` or `artist_id` will report spurious differences
across a restart; identity must be keyed on persistent ids.
The two restart snapshots differ by one byte in the container length field only and are semantically identical.

## 7. itlkit protocol exercised against real native output

`python -m itlkit check` and `inspect` were run on all four snapshots at base commit `1bb05ed`:

- 4 of 4: `ok: true`, `noop_bit_exact: true`, `rebuilt_payload_exact: true`.
- Track and playlist counts parsed as 0/1/1/1 tracks and 14/14/14/14 playlists.
- `inspect-coverage` completed on the one-track snapshot (267,073 bytes of field coverage report).
- Two fields are reported as version-gated `field_errors` on this output:
  `sample_rate` and `unplayed` are described as verified only for the 12.13.10.3 mith profile.
  So the codec parses 12.13.11.1 structurally but does not yet claim those two field semantics for it.

This exercises structural validity and round-trip fidelity of the codec against genuine native bytes.
It says nothing about whether iTunes would accept a file written by the codec.

## 8. Result classification

- Structural validity: PASS. All four native snapshots parse; no-op writes are bit-exact and forced
  container reconstruction preserves the payload.
- Preservation: PASS for the native chain (import, save, exit, two reopens) on persistent ids,
  metadata, locations and playlist membership. This is a statement about iTunes output, not about
  codec-written files.
- Semantics: PARTIAL. Numeric ids are renumbered on reopen; `sample_rate` and `unplayed` remain
  unverified for 12.13.11.1; COM exposes only 7 of the 14 stored playlists.
- Native acceptance: NOT TESTED and NOT CLAIMED. No candidate was produced, preflighted or scheduled,
  and iTunes was never asked to open a file written by anything other than itself.
- Persistence: PASS. Normal COM `Quit()` save and exit, then two full restart cycles, with raw on-disk
  and COM comparison at each step. No damaged-file dialog, no rebuild, no repair, no
  `Previous iTunes Libraries` directory, and the library file set stayed constant at five files.
- Playback: NOT TESTED, and constrained by the environment. The runner has no audio device and iTunes
  reports an audio configuration problem on every launch. Playback must be reported separately and
  must never be folded into acceptance.

## 9. Contract changes needed

1. Native bring-up must include the first-run SLA gate: a clean profile cannot reach COM at all.
   Document the `license-agreements` preseed and the allowlisted-click fallback.
2. Record that 12.13.11.1 is self-contained, so the AAS / AMDS / Bonjour MSI ordering fallback does not apply.
3. Version-gate the codec field profile explicitly so 12.13.11.1 output is not silently read with the
   12.13.10.3 profile.
4. Require main-window detection by window class `iTunes`, never by window title.
5. Record that COM playlist enumeration is incomplete relative to the file, so COM must not be used as
   the sole oracle for playlist state.

## 10. Method notes and deviations

- Isolation by junction rather than by a library switch, because no real user library exists on the runner.
- One UI interaction class was used, strictly allowlisted: the SLA `Agree` button and the audio-warning
  `OK` button, matched by normalized control text inside a matched dialog. Everything else was read-only
  window enumeration.
- Self-corrected defect in my own first SLA script: the main-window predicate tested window title
  equality and matched the audio modal, producing a false positive and sending `CloseMainWindow()` to the
  modal. That happened to dismiss it like an OK click, and the run was not compromised, but all later
  scripts identify the main window by class. This is the origin of the rule in section 2.
- Nothing outside the a10 native scratch area was written, and no vendor binary is committed.

## 11. Reproduction

```
iTunes64Setup.exe /quiet /norestart
# seed acceptance, then
pwsh -File a10-session.ps1 -Tag import -Import <synthetic.wav>
pwsh -File a10-session.ps1 -Tag restart1
pwsh -File a10-session.ps1 -Tag restart2
python -m itlkit check research/g4/a10/captures/lib01-import.itl
pytest tests/test_g4_a10_native_captures.py
```
