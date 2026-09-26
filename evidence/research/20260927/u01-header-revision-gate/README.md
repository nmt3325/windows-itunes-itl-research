# U-01 outer-header revision-major gate

This bundle records a concrete **non-version-label** incompatibility in the exact signed Apple standalone Windows x64 iTunes 12.12.10.1 executable, an independently parseable one-byte candidate selected before native outcome, and the complete preserved result of the two predeclared native attempts. The executable identity is 39,260,512 bytes, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, Authenticode `Valid`, signed by Apple Inc. with certificate thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`. No Apple installer, executable, DLL, MUI, resource, Ghidra project, log, broad decompiler dump, or raw binary dump is retained.

## Static causal result

The bounded Ghidra 12.1.3 report establishes this exact-build path:

1. Parser `FUN_1410ad0b0` allocates its parsed object and calls header reader `FUN_1410ace80` at RVA `0x10ad216`.
2. The reader zeroes and reads exactly `0x90` bytes, then invokes endian normalizer `FUN_14108de90` at RVA `0x10acff8` before validating the header.
3. The normalizer independently byte-swaps the 16-bit words at parsed-header offsets `+0x0c` and `+0x0e`. Raw `00 43 00 01` therefore becomes `(67,1)`, while raw `00 44 00 01` becomes `(68,1)`.
4. The exact parser reads normalized u16 `+0x0c` at RVA `0x10ad257`, compares it with `0x43` at `0x10ad25c`, and returns `-876` at `0x10ad262` when it is above the ceiling. Alternate parser `FUN_1410f4b90` corroborates the same ceiling at `0x10f4d21`/`0x10f4d28`.
5. The direct caller explicitly compares the parser status with `-876` at `0x53db8d`, routes it through group `0x1f43`, and selects descriptor resource `0x1f420003`, whose role is the newer-version message in prior exact-build localization evidence.
6. Writer constructor `FUN_1410917e0` directly stores dword `0x00010043` at object offset `+0x0c` (RVA `0x1091888`), establishing current normalized tuple `(67,1)`. Serializer `FUN_141094c80` copies the complete `0x90`-byte header, applies the same endian helper when required, and writes exactly `0x90` bytes. Writer pipeline `FUN_14109eaf0` calls the constructor and serializer.

The field is therefore bounded as an outer-header format-compatibility major/minor revision tuple. No native symbol name was recovered, so the repository does not claim an authoritative native field name. This gate does not inspect or mutate the embedded `12.12.10.1` version label.

The deterministic report is 83,065 bytes at SHA-256 `2242e7fe1db95d95bb412df594143c2783eb84683e56188fd361b2e3276923c2`. Hash-gated script `scripts/ghidra/U01HeaderRevisionGate.java` is SHA-256 `c23f9b48ecd6b5c5121d8c5c0b166c0a2bbf41055b84fc84ae23de7b84b8b5dc`. Two `-noanalysis` runs against the saved 62,218-function project produced byte-identical reports; only the bounded JSON is retained.

## Exact candidate and independent preflight

The candidate derives from exact clean native cycle-2 save `9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772` and changes exactly one byte:

- file offset `0x0d`: `0x43` → `0x44`;
- raw tuple: `00 43 00 01` → `00 44 00 01`;
- normalized tuple: `(67,1)` → `(68,1)`;
- candidate: 4,904 bytes, SHA-256 `287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a`.

`REFERENCE_PARSER/core.py::ReferenceLibrary.from_bytes` and envelope decoding both succeed on source and candidate. Both retain encryption mode 2, compression mode 1, version label `12.12.10.1`, persistent ID `C4CF98746C40D802`, declared/actual size 4,904, decoded payload length 106,776, payload SHA-256 `826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9`, one track, fifteen playlists, and equal full normalized semantic summaries after excluding only the top-level file SHA. The normalized semantic hash is `4b6264d499b8b3380ec53008cdf2e5144f17852f2e79e1743c343b2d36026e57`. The pinned baseline tree contains 431 tracked ITLs; an exhaustive baseline census found raw tuple `00430001` in all 431.

Generator `scripts/research/build_u01_header_revision_candidate_20260927.py` deterministically writes/checks the candidate, manifest, and preflight. Its SHA-256 is `6418daa2dfe9c268e75c1dfff2f30869439ad9e89d467b660a087a936559d067`.

## Pre-outcome boundary and correction

`native-two-attempt-plan.json` fixed the exact candidate/source/executable identities, static prediction, mandatory commit/push/remote gate, two sequential fresh-copy attempts, isolated profile junctions, 90-second observation limits, strict newer-version/invalid/ambiguous classification, one visible enabled OK dismissal, normal exit or bounded `WM_CLOSE`, **exit code zero**, zero remaining processes, input identity/semantic preservation, forbidden fallback audit, and cleanup. Timeout or forced cleanup was explicitly not modal success, and post-hoc candidate substitution was forbidden.

The locked native wrapper is `scripts/windows/u01_header_revision_gate_20260927.py`, SHA-256 `3d372cdd339d86ac05d0af8ef2f09935bbf6facd69bc923f1c33fd904c0e87a3`. Its first invocation failed closed while interpreting the bounded Authenticode helper response, before `subprocess.Popen`, profile/evidence-root creation, or any `iTunes.exe` start. The corrected wrapper parses and validates status, subject, and exact thumbprint. The plan records one prelaunch refusal, zero product processes from that refusal, zero candidate outcomes before amendment, and no candidate/theory change. The corrected bundle was recommitted, pushed, and remotely verified at commit `5987155aeb4702f751afe827f0f2fda8c337f298` before native execution.

## Native two-attempt outcome

Both declared fresh-copy attempts used the same exact candidate and independently produced the target product modal:

> The file “iTunes Library.itl” cannot be read because it was created by a newer version of iTunes.

For each attempt:

- classification was exactly `newer_version` in window class `iTunesCustomModalDialog`;
- exactly one visible, enabled `OK` button with control ID 1 was selected;
- the target modal was dismissed successfully;
- close method was `target_modal_ok_process_exit`;
- the product exited without forced termination;
- the observed exit code was **1**, not the plan-required 0;
- candidate SHA-256 remained `287a9b…be59a` before launch, while the modal was visible, after process exit, and in the retained copy;
- the retained copy independently reparsed to normalized semantic hash `4b6264d4…26e57`;
- no forbidden XML, backup, damaged-library replacement, or alternate-ITL fallback appeared;
- the profile junction was removed, the profile path was absent afterward, and process cleanup passed.

Thus the static prediction reached the exact product-facing newer-version modal twice on the pinned candidate and executable. However, the predeclared protocol required exit code zero. Both attempts exited 1, so raw status is `failed_with_preserved_evidence`, strict passed attempts are **0/2**, and full predeclared two-attempt success is **false**. The generic raw harness phrase `predeclared negative did not reproduce` is preserved unchanged in raw evidence; the deterministic derivative distinguishes the two successful modal observations from the sole strict gate failure, `itunes_exit_code_zero`.

No timeout, forced termination, static resource mapping alone, or post-hoc candidate is counted as modal success. No third attempt, retry, or candidate substitution is authorized.

## Deterministic outcome normalization

Raw evidence is retained under `native-outcome/`; its 54,091-byte `summary.json` hashes to `609a4a9dd2cdac1158b1c10f4735912856c2e68eddb5e253ef5256bb72b80942`. The raw files are not rewritten.

`scripts/research/summarize_u01_header_revision_gate_20260927.py` (SHA-256 `ea624d2b7c5b0bd22319fe5afbfa8f57dce95033c35697b229d98f679b9b1848`) validates the candidate, preflight, plan, executable/signature lock, embedded and standalone attempt JSON equality, modal text/control metadata, retained-file hashes, independent semantic summaries, forbidden fallback audit, and cleanup. It byte-exactly rebuilds `native-outcome-summary.json`, 11,518 bytes, SHA-256 `6e4c67c3bca6dbb32cdfe68715c2f1eb17282a4d214e94244f4290ec9c3b4056`.

## Claim boundary

Established for this exact candidate/executable pair:

- two product-facing newer-version modal observations and dismissals;
- no forced termination;
- candidate identity and normalized semantics preserved;
- bounded static gate → status/resource → product-modal causal confirmation.

Not established:

- strict two-attempt plan success or strict product-negative qualification, because both exit-zero gates failed;
- a 12.12.10.1 production parser/writer profile;
- arbitrary editing, universal compatibility, independently implemented native reproduction, or complete analysis;
- U-01 closure.

U-01 therefore remains **open** despite the repeated bounded modal observation.
