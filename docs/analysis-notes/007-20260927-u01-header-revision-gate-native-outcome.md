# 007 — U-01 outer-header revision gate and bounded native outcome

## Objective and boundary

Analysis note 006 recovered a concrete non-version-label feature-to-resource chain for outer-header encryption mode `>=3`, but that candidate class could not pass independent-parser preflight. This continuation examined the other exact parser producer of status `-876`: normalized parsed-header u16 `+0x0c > 0x43`. The goals were to bound the field's meaning through reader/normalizer/writer code, construct an exact supported-domain candidate, complete structural and semantic preflight, lock a full two-attempt plan before outcome, and execute only those two attempts if every prelaunch gate passed.

The work remained pinned to signed standalone Windows x64 iTunes 12.12.10.1, 39,260,512 bytes, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, Authenticode `Valid`, Apple Inc. certificate thumbprint `67A9953123BD5F01B1BC0BB98A950D9CA869CD02`. No Apple binary/resource, Ghidra project/log, broad decompiler output, or raw binary dump was committed.

## Static reader, normalizer, gate, and writer chain

The bounded deterministic Ghidra report establishes the following exact-build chain:

- exact parser `FUN_1410ad0b0` at RVA `0x10ad0b0` calls header reader `FUN_1410ace80` at RVA `0x10ad216`;
- the reader zeroes exactly `0x90` destination bytes, reads exactly `0x90` bytes at RVA `0x10acfed`, and calls endian helper `FUN_14108de90` at `0x10acff8`;
- the helper independently swaps parsed-header u16 fields `+0x0c` and `+0x0e` at RVAs `0x108dee1`–`0x108def5`;
- raw bytes `00 43 00 01` normalize to `(67,1)`, while `00 44 00 01` normalize to `(68,1)`;
- the parser reads normalized `+0x0c` at `0x10ad257`, compares it unsigned with `0x43` at `0x10ad25c`, and assigns `-876` at `0x10ad262` when the major value is above 67;
- its current-tuple path separately checks major 67 at `0x10ad2c6` and minor 1 at `0x10ad2cc`;
- alternate parser `FUN_1410f4b90` repeats the major ceiling at `0x10f4d21` and assigns `-876` at `0x10f4d28`;
- writer constructor `FUN_1410917e0` stores dword `0x00010043` at object offset `+0x0c` at RVA `0x1091888`, directly constructing normalized tuple `(67,1)`;
- serializer `FUN_141094c80` copies all `0x90` header bytes, invokes the same endian helper when required, and writes exactly `0x90` bytes; writer pipeline `FUN_14109eaf0` calls the constructor and serializer.

Together, those reader and writer sites bound `+0x0c/+0x0e` as an outer-header format-compatibility major/minor revision tuple. No native symbol was recovered, so this is a bounded semantic description rather than a claimed authoritative field name.

The already recovered status bridge remains unchanged: direct caller RVA `0x53d500` compares the parser result with `-876` at `0x53db8d`, sends group `0x1f43` and the status into the descriptor path, and maps the `-876` entry to resource `0x1f420003`, previously identified as the exact-build newer-version message. Thus the pre-outcome prediction was:

`raw revision 00 44 00 01` → normalized tuple `(68,1)` → parser major ceiling failure → `-876` → group `0x1f43` → resource `0x1f420003` → newer-version product message.

The Ghidra 12.1.3 post-script `scripts/ghidra/U01HeaderRevisionGate.java` hashes to `c23f9b48ecd6b5c5121d8c5c0b166c0a2bbf41055b84fc84ae23de7b84b8b5dc`. Two `-noanalysis` runs against the saved 62,218-function project produced the same 83,065-byte report, SHA-256 `2242e7fe1db95d95bb412df594143c2783eb84683e56188fd361b2e3276923c2`.

## Candidate construction and independent preflight

The source was the exact clean 12.12.10.1 cycle-2 native save, 4,904 bytes, SHA-256 `9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772`. The candidate changes only file offset `0x0d` from `0x43` to `0x44`:

- candidate SHA-256: `287a9b91315be1a4917cc1a2530013c076bab824e2099885ac89d8e7ccebe59a`;
- raw revision tuple: `00440001`;
- normalized tuple: `(68,1)`;
- version-label bytes and decoded payload: unchanged.

The independent parser accepts both source and candidate. Both have encryption mode 2, compression mode 1, version `12.12.10.1`, actual and declared size 4,904, payload length 106,776, payload SHA-256 `826863edfd2c6f44c7835b0cfebf7aa821e364490090bcdf49d82f29f458e4e9`, file persistent ID `C4CF98746C40D802`, 11 sections, one track, 15 playlists, one album, and one artist. Full semantic summaries are equal after excluding only their top-level file SHA; the normalized semantic hash is `4b6264d499b8b3380ec53008cdf2e5144f17852f2e79e1743c343b2d36026e57`.

An exhaustive census of the 431 ITLs tracked by baseline commit `e0e715c7ce994beae25e023f7600bdeaef46b576` found raw revision tuple `00430001` in all 431. This is a complete census of that pinned baseline tree, not a representative population claim.

Deterministic generator `scripts/research/build_u01_header_revision_candidate_20260927.py` hashes to `6418daa2dfe9c268e75c1dfff2f30869439ad9e89d467b660a087a936559d067`; `--write` and `--check` reproduce the candidate, manifest, and preflight byte-exactly.

## Pre-outcome plan and fail-closed correction

The plan locked candidate/source/executable identities, static prediction, all offline gates, and exactly two fresh-copy attempts. Each attempt required:

- isolated profile junction and 90-second observation bound;
- exact `newer_version` message meaning, not title-only matching;
- exactly one visible enabled default `OK` dismissal;
- product exit after `BM_CLICK` or bounded `WM_CLOSE`;
- exit code **0**, zero remaining iTunes processes, no forced termination;
- unchanged candidate identity and normalized semantics;
- no XML, previous-library, damaged-library, or alternate-ITL fallback;
- profile-junction removal and clean process state.

One initial wrapper invocation failed closed before `subprocess.Popen` because the wrapper initially treated the Authenticode helper command record as if it were already the parsed signature. No profile/native evidence root was created and no iTunes product process started. The wrapper was corrected to parse and validate the bounded PowerShell JSON response, including status, subject, and exact certificate thumbprint. The plan transparently records one prelaunch refusal, zero product processes from that refusal, zero candidate outcomes before amendment, and no candidate/theory change.

The corrected plan/wrapper/candidate bundle was committed, pushed, and remotely verified at commit `5987155aeb4702f751afe827f0f2fda8c337f298` before either native attempt. Wrapper SHA-256 is `3d372cdd339d86ac05d0af8ef2f09935bbf6facd69bc923f1c33fd904c0e87a3`.

## Two native attempts

Exactly the two predeclared attempts were run; no retry or candidate substitution followed.

### Attempt 1

- exact newer-version modal observed: yes;
- window class: `iTunesCustomModalDialog`;
- visible message: `The file “iTunes Library.itl” cannot be read because it was created by a newer version of iTunes.`;
- exactly one visible enabled `OK`, control ID 1: yes;
- modal dismissal: yes;
- close method: `target_modal_ok_process_exit`;
- forced termination: no;
- iTunes exit code: **1**;
- candidate SHA before launch, during modal, after exit, and retained: `287a9b…be59a`;
- retained normalized semantic hash: `4b6264d4…26e57`;
- forbidden fallback: none;
- profile/process cleanup: passed.

### Attempt 2

Attempt 2 reproduced the same exact modal classification/message/control and dismissal path on a fresh copy. It also exited 1 without forced termination, retained exact candidate hash `287a9b…be59a` and semantic hash `4b6264d4…26e57`, created no forbidden fallback, removed the profile junction, and passed process cleanup.

## Strict interpretation

The static prediction reached the exact product-facing newer-version modal twice. This is bounded causal confirmation from the independently parseable revision-major mutation through the exact parser/status/resource path to product UI. It is stronger than the prior static-only mapping and distinct from the earlier main-window timeouts.

It is **not** full success under the predeclared protocol. The plan expressly required exit code zero. Both product processes self-exited with code 1 after normal `OK` dismissal. Consequently:

- exact modal observations/dismissals: **2/2**;
- forced terminations: **0**;
- candidate identity/semantic preservation: **2/2**;
- cleanup and forbidden-fallback gates: **2/2**;
- strict passed attempts: **0/2**;
- strict two-attempt success: **false**;
- sole strict per-attempt failure: `itunes_exit_code_zero`.

The raw harness's generic `predeclared negative did not reproduce` classification is retained as immutable evidence. It resulted from the nonzero-exit strict gate and must not be misread as absence of the two observed modals. Conversely, the modal observations must not be promoted to strict qualification by weakening the plan after outcome.

## Deterministic normalization and regression

Raw native evidence was preserved in commit `524b31de7889ed62f73834b8bbcfbcf8521bae46`. Raw `native-outcome/summary.json` is 54,091 bytes, SHA-256 `609a4a9dd2cdac1158b1c10f4735912856c2e68eddb5e253ef5256bb72b80942`.

`scripts/research/summarize_u01_header_revision_gate_20260927.py` validates all locked inputs, embedded/standalone raw attempt equality, modal metadata, exact retained ITLs, independent semantics, forbidden-fallback absence, and cleanup. It deterministically emits `native-outcome-summary.json`, 11,518 bytes, SHA-256 `6e4c67c3bca6dbb32cdfe68715c2f1eb17282a4d214e94244f4290ec9c3b4056`. Focused regression `tests/test_u01_header_revision_gate_20260927.py` locks the static chain, candidate/preflight/plan, raw outcome identities, normalized result, and byte-exact summary regeneration.

## Delivery validation

The exact candidate generator and outcome normalizer both passed byte-exact `--check`. The focused U-01 header-revision regression passed **7/7**, and the five stale-report/retained-census test groups passed **26/26** after current source-bound reports were regenerated and the dated 431-entry censuses were explicitly locked as historical snapshots rather than rewritten from the later 434-file corpus. The complete offline suite, with the pinned `titl` checkout supplied by absolute filesystem path, passed **1,204** tests with **9** documented skips and zero failures.

The specification verifier passed; the delivery verifier checked the exact **3,047-file** set and all hashes; the strict proposal verifier passed **13/13**; and production-verifier QA passed **27** checks with `native_actions: false`. The current root corpus manifest contains **434** ITLs, including exactly one predeclared header-revision candidate and two retained modal-outcome copies. These current counts do not rewrite the earlier 431-entry historical reports.

## Claim limits and next work

This note establishes repeated bounded product-modal observation for one exact candidate on one exact executable. It does not establish strict product-negative qualification, because the declared exit-zero gate failed. It does not admit a 12.12.10.1 parser/writer profile, arbitrary editing, universal version support, independently implemented native reproduction, or complete analysis. U-01 remains open.

Any future native follow-up requires a new candidate/theory/protocol committed and pushed before outcome; this turn authorizes no additional launch. Broader closure still requires additional version-pinned semantic-edit rows, independent harness/executable provenance, and a predeclared protocol that resolves expected negative-path exit semantics without retroactively changing this result.
