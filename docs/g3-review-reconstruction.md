# G3 review fixes - re-derived reconstruction (evidence class C)

**This branch is not the original G3 work.** The original fixes were written and
verified on 2026-09-10 inside a runner that expired before any commit was
created, so no original commit, blob, patch or diff survives anywhere. Every
source change on this branch was **re-derived on 2026-09-11** from the same
starting commit `dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3`, by an independent
worker task that had only the written description of the two fixes, and was
then re-verified by the coordinator. Treat this branch as *reconstructed*, not
recovered. Do not cite it as evidence of what the original bytes were.

Evidence classes used throughout this repository: **A** observed now with call
metadata, **B** historical and not re-observed, **C** reconstructed or
re-derived, **missing** not recoverable and never inferred. This branch is
class C; the original hashes below are class B.

## What was re-derived

1. `itlkit/admission.py` - auxiliary identity qualification. Unknown auxiliary
   header widths could previously bypass persistent-ID validation. The record
   is now rejected first on unqualified tag, kind, header size or absent
   children, and only qualified auxiliary headers (`miah` at 88 bytes, `miih`
   at 100 bytes) have all album and artist local IDs and persistent IDs
   validated. The predicate stays opt-in at master level.
2. `itlkit/playlist_models.py` - shared JSON export preflight. Post-encoding
   budget checks were replaced with a shared `schema.encode_json` preflight,
   retaining the physical-model and raw-budget checks, subtracting retained
   model memory, capping output with the remaining budget, preserving the `str`
   return and the `limits=` API, preserving array order and duplicates, omitting
   `RawSpan._buffer`, and counting JSON keys and `payload_hex` inside the shared
   text budget.
3. `tests/test_g4_a02_review_guards.py` - re-derived guard tests for both fixes.

## Verification on this branch (2026-09-11, class A)

- Ungated full suite: `1947 passed, 50 skipped, 26 subtests passed`.
- Gated full suite: `2153 passed, 6 skipped, 36 subtests passed in 22.67s`.
- Gate corpora: `evidence/native/snapshots` (55 `.itl` files),
  `evidence/native/oracles` (0 files),
  `evidence/20260910/checkpoint-01/native-snapshots` (10 files), supplied
  through `ITLKIT_NATIVE_ROOT`, `ITLKIT_NATIVE_REPORTS` and
  `ITLKIT_FRESH_SNAPSHOT_DIR` respectively.
- Working-tree SHA-256 of the reconstructed files, measured on Windows:
  - `itlkit/admission.py` `a3103a812be4f509870c9b60637e299c739a1a53e5bf6fa346369671e3f8efe8`
  - `itlkit/playlist_models.py` `9a391c33be54f3c1cb9a27bea7c9481c3ca4d3726873ab7e57f14cd98e05d771`
  - `tests/test_g4_a02_review_guards.py` `68d7025c689c78c6d5d0b1461f29c2661002c5ae8aa60470107763597c6556ff`

## Known differences from the original

- The original guard test file was `tests/test_g3_review_guards.py` and carried
  22 tests at the end of the G3 session. This branch carries
  `tests/test_g4_a02_review_guards.py` with 28 tests, a differently named
  superset. The file names and test counts do not match.
- The original final `itlkit/admission.py` was recorded as SHA-256
  `5d72aea15cbded646e62b33f050bfff7c3bc8fc67d00c223b6c57ede11bc06df` (class B).
  The reconstruction is not expected to match it byte for byte, and does not.
- For `itlkit/playlist_models.py` only a **pre-depth-fix** hash survives,
  `1e1211061e461551ba7765bf87725158b0360c47076595403b724e08058d5523`. The
  original post-fix hash is **missing** and must never be presented as known.

## Element accounting that reconciles the historical G3 numbers

The gated baseline at `dc4b1c7a` collects 2131 primary `testcase` elements and
reports 36 stdlib `subTest` outcomes. The historical G3 console and JUnit
numbers follow from that baseline plus the uncommitted guard file:

| historical stage | guard tests | elements | `tests=` | passed |
| --- | --- | --- | --- | --- |
| first full run | 19 | 2131 + 19 = 2150 | 2150 + 36 = 2186 | 2150 - 6 = 2144 |
| final full run | 22 | 2131 + 22 = 2153 | 2153 + 36 = 2189 | 2153 - 6 = 2147 |

All six historical figures reproduce exactly, so the previously open question
of the unreproducible 2153-element, `tests=2189` run is closed: it was the
gated baseline plus a 22-test guard file that was never committed. This is an
arithmetic reconciliation of class B records, not a re-observation of them.
