# 004 — U-01 structural candidate inventory and fail-closed no-launch decision

## Objective and causal boundary

This continuation sought a theory-backed, predeclared, structurally valid, product-facing negative on exact signed iTunes 12.12.10.1. The qualifying theory had to identify an actual record, feature, or layout that 12.12.10.1 plausibly cannot consume, independently of both Pascal version labels. Candidate and control hashes, expected product gate, dismissal/exit and cleanup procedures, forbidden-fallback checks, executable identity, outer/COM identities, and independent-parser semantic checks had to be committed and pushed before launch.

The available evidence did not pass that theory gate. This continuation therefore performed offline analysis only: **zero new iTunes launches, zero native candidate attempts, and no candidate outcome observed in iTunes**. The retained decision forbids launch rather than converting an under-theorized probe into post-hoc evidence.

## Exact-build localization evidence

Derived metadata from the installed 39,260,512-byte executable, SHA-256 `0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b`, confirms separate English resources for:

- ID `0x1f420003`: “The file ‘^FILENAME’ cannot be read because it was created by a newer version of iTunes.”
- ID `0x1f420004`: “The file ‘^FILENAME’ cannot be read because it does not appear to be a valid library file.”

The two IDs occur once each in `.rdata`, adjacent to family members `0x1f420001` and `0x1f420002`. The generated group-`0x1f42` wrapper is at VA `0x1401fb500`; its descriptor reference is the instruction at VA `0x1401fb52c` targeting `0x1419fd810`. This localizes the resource family and supports exact modal classification in the harness. It does **not** identify the parser branch selecting member 3 versus 4, a parser result comparison, or a semantic status code. No Apple executable or resource bytes were committed.

## Corrected structural census

The deterministic census locks eight retained native files and classifies their causal provenance. The clean 12.12.10.1 cycle-2 save is 4,904 bytes, SHA-256 `9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772`, has section sequence `(16,12,9,11,1,13,23,2,14,21,4)`, `mhgh+0xE5 = 4`, and one type-109 object. A force-terminated timeout survivor at SHA-256 `b92b3b62dd418a4010e14b2da2e4b92abe7268dcd0d54a560b1cd29a57cdef59` instead has `mhgh+0xE5 = 0`, lacks section 21, and remains observation-only.

Matched-lineage clean cycle-2 saves from 12.13.9.1 (`c60e1ac9…d48d4a7`), 12.13.11.1 (`744c3795…f009e89`), and the separate-runtime 12.13.11.1 repetition (`34401e8c…9d7562`) all have `mhgh+0xE5 = 4` and two type-109 objects. These comparisons correct three tempting but invalid theories:

- `mhgh+0xE5 = 4` is not newer-only because clean 12.12.10.1 emits it.
- Section 21 is not newer-only because clean 12.12.10.1 emits it while the matched newer files do not.
- Type 109 is not an unknown binary capability object. It is XML plist playlist-view state. The shared object records `lastViewedPlaylist=81`, `lastViewedPlaylistViewMode=7`, and `tabViewMode=4`; the extra newer object records optional Podcasts view state. Two such objects do not establish incompatibility.

## Reproducible derivative and no-launch decision

The inventory rebuilds a 3,006-byte derivative from the clean native 12.13.11.1 source, normalizing outer and inner labels to `12.12.10.1`. Its SHA-256 is `e9ea49521b72e8d166ec852531927069ca6fb8dc6a37ea9e59ae3bbda8916f47`. After restoring the inner source label solely for comparison, the decoded payload is otherwise byte-identical. File persistent ID, selected track semantics, playlist semantics, record topology, type census, and both type-109 plists remain unchanged.

This is an offline rebuilt derivative, never launched and not native-authored after normalization. Because its retained distinguishing state is optional UI state rather than a plausible rejection-causing feature, `predeclared-no-launch-plan.json` records `candidate_selected_for_native_execution: false`, `launch_authorized: false`, and `attempts_authorized: 0`. No native process may be started under that plan. A later candidate requires a new pre-outcome plan; the present derivative cannot be substituted post hoc.

## Harness, corpus, and validation

The Windows harness now classifies exact library-read modals as `newer_version`, `invalid_library`, or `ambiguous_library_error`; title-only matching remains forbidden. A recognized class that differs from the predeclared newer-version class fails immediately and is preserved instead of silently degrading into a timeout.

`inventory_u01_structural_candidates_20260927.py --check` rebuilds the derivative and normalized report byte-exactly. The focused structural-inventory, distinct-build, and version-split regressions pass 19 tests. The aggregate corpus now contains 431 ITLs: the previous five observed 12.12.10.1 files plus this one never-launched offline derivative. The regenerated trailer census verifies all 431 hashes; 430 files strictly parse and no-op round-trip byte-exactly, the sole expected parse failure remains the deliberately truncated U-01 input, and only the intentional 17-byte U-13 witness has a trailer.

The authoritative Linux suite passed 1,187 tests with 9 documented skips. The final strict delivery verifier covered all 3,015 manifested files, and its 13 proposal cases plus 27 production-QA cases passed. These results are recorded in `completion-status.yaml`; they do not alter the causal status of the derivative or close U-01.

## Boundaries and next work

- No product-facing native negative was established; no new native launch occurred.
- The derivative is not a 12.12.10.1 native-authored file, acceptance result, rejection result, parser/writer profile, or arbitrary-edit qualification.
- Static resource localization does not establish the parser decision path.
- 12.12.10.1 remains observation-only and outside the supported parser/writer profiles.
- Force-terminated timeout artifacts remain neither product rejection nor clean native cycles.
- U-01, universal ITL support, independent reproduction, and the complete-analysis/specification gate remain open/false.
- The next native attempt must first identify a concrete non-label record/feature/layout incompatibility, commit and push the complete plan and exact hashes, then use two fresh-copy attempts where feasible with exact modal classification, normal dismissal/exit, cleanup, identity, fallback, and independent-parser gates.
