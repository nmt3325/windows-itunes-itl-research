# Experimental cross-library importer v2 — bounded structural components

This additive module is **not yet a generalized importer**. It does not change the
legacy same-lineage API, CLI, vendor or core. `prepare` currently returns a concrete
blocked profile; it never returns a fake PreparedMutation or publishes a candidate.
Native acceptance is not claimed.

## Entry and exact intent

```python
from itlkit.importer import prepare
result = prepare(target_bytes, {
    "operation": "cross_import",
    "source": "donor",
    "track_pids": ["0123456789ABCDEF0"],
}, {"donor": donor_bytes}, limits=None, seed="reproducible-seed")
```

Exactly these intent keys and one matching immutable source byte string are accepted.
Selection has 1–128 unique, nonzero, 16-hex PIDs. Extra keys, guard overrides, callbacks,
implicit rebinds and raw fallback are refused. Seed is None or a nonempty string of at
most 128 characters; this checkpoint performs no allocation. A blocked diagnostic is
not an executable capability and cannot be submitted for apply.

`limits=None` uses the stage2 defaults: 16MiB input/decoded, 100000 model nodes,
depth32, 4MiB aggregate mhoh payload, 64MiB generated JSON, 512MiB declared research
process budget. Explicit limits require the canonical parent-integrated ReadLimits;
no substitute/stub type is implemented here. Limits can only reduce these initial
engine caps. Decoded-byte limits are not a resident-memory guarantee. Legacy limits
are unchanged. Normal Python is required because existing core dependencies use
assertions; `-O`/`-OO` are refused.

## Reusable pure helpers

- `inspect_pair(target_bytes, donor_bytes, selected, *, limits=None)`: decoded
  profile, owner-qualified pool census, selected closure, role matching and complete
  known-wire preimage expectations. Digests pin provenance/concurrency, not admission.
- `role_catalog(lib, *, target=False)`: master flag/special kind/ordered metadata,
  role-specific flags, membership closure. No localized names, fixed track count or
  fixture PID. Existing ordinary order is never changed. Empty builtin Podcasts is
  identified without flattening its mhoh103 definition.
- `selected_wav_profile(track)`: positive 756-byte local WAVE record kind at +8c;
  requires materialized Name/Kind/path13/URL11, but not English Kind display text.
  No media is opened. Type1/unknown selected children remain blocked.
- `selected_closure(donor, selected)`: immutable bytes for selected tracks and only
  their unique typed album/artist objects. Shared selected closure is included once.
  Distinct blank index objects are not merged by their empty labels.
- `decode_msph800(node)`: bounded boundary-aware mhoh800 XML dictionary inspection,
  duplicate/entity/unknown-field refusal. Empty podcast/settings collections and the
  observed MostRecent dictionary layout are identified. Title/date vary structurally.
  Business-semantic independence is explicitly **not proven** and remains a blocker.
- `transform_record(node, values, atom_ids=None)`: clone-only typed-slot changes.
  Exact reservation keys are required: track(local,album,artist,secondary),
  album/artist(local), membership(local,track,token,pid). atom_ids keys are child
  ordinals in known pools, not global integer replacements. It returns the clone and
  frozen TypedPatch tuple after exhaustive preimage/delta comparison. No allocator,
  ownership/admission authority or publication is hidden in this function.

The selected positive media profile does not force unselected donor media to WAV or
copy them. Initial target shape requires full master/music/downloaded coverage and
empty other builtin roles. Unsupported target grouped/smart configurations block.
Pool-scoped IDs remain compact (<=65535); local reservations are <=1000000. These
are operation caps, not inferred native high-water fields. PIDs, local IDs, secondary
IDs, pool IDs, order tokens and cache/rank slots remain distinct. All old tracks,
indexes, ordinary lists, system metadata/children and opaque sections are recorded
for exact preservation; record transforms cannot touch cache ranks/flags/text/paths.

## What remains blocked

1. The canonical identity/graph source-scope and frozen allocator bridge. Codec
   schema/planning/bounded framing are now integrated at the authorized pin.
   No other worktree/dependency implementation is copied or stubbed.
2. msph800/global/role semantic dependency proof. An XML dictionary parse and byte
   preservation alone are not proof that an arbitrary import leaves runtime meaning
   unchanged. Hash-whitelist removal alone does not authorize writes.
3. Admission of the private whole-image assembler through a real typed allocator
   ledger and canonical sealed PreparedMutation/apply adapter. Structural byte proof
   is implemented; source-derived native getter expectations still require external
   independent oracles, not a conversion from the raw wire view.
4. Native 45s/30s passive two-save qualification, full visible/hidden playlists,
   media identity preservation and separate allocation follow-up by the native owner.

The new five-format native donor showed why metadata must come from native/source
oracles, not assumed embedded tags: WAV imported filename-fallback Name and blank
Artist/Album even with embedded tags. Known raw `Track.to_dict()` is a wire view,
not a complete native COM getter decoder. Native scalar expectations are frozen
separately before any candidate; session/local IDs are not restart invariants.

## Reproduce

```text
python -B -m unittest discover -s tests -p test_importer_v2.py -v
```

Pure helper tests need no native fixture. To include read-only fresh-native tests,
set `ITLKIT_FRESH_SNAPSHOT_DIR` per process to the closed snapshot directory containing
`fresh-004-three-reopened.itl` and `donor-v1-twenty-reopen2.itl`, then run the same
command. Those tests inspect native-created input files; they do not execute iTunes
or establish writer acceptance. Synthetic dictionary/shared-closure variants are
explicit offline models, not new native fixtures. No generated files or media IO
occur in this test module.

## Preallocation resource correction (S2-RESOURCE-01)

`None` and explicit limits both use the exact canonical `itlkit.schema.ReadLimits`.
The importer calls canonical `load_container` and boundary-only `preflight_payload`
for **all inputs before constructing any Library/Node**. It never reconstructs a
Node tree merely to count and then reject it. A memory budget of 1 refuses before
Container decoding; max_nodes=1 refuses with zero Node constructions.

File caps are per input. Plain bytes, model nodes and conservative mhoh payload
bytes are summed across target/source (and a future candidate validation input).
The memory admission estimate is `12*total_file + (max_depth+16)*total_plain +
6144*total_nodes + 8*total_mhoh_payload`. It reserves input buffers, nested parser
copies, model/diagnostic working space. Before each decode, the actual decompressor
ceiling is reduced to the remaining aggregate plain and memory allowance, including
its one-byte rejection sentinel. This is conservative admission accounting, not a
claim about OS RSS or all possible Python process allocations. JSON uses canonical
bounded encoding with the remaining memory budget; input/model and output estimates
coexist. No previous core or codec-owned implementation is modified.

No-op validation compares serialized section framing to the original decoded bytes;
`Library.to_bytes` is not called to hash, normalize or reparse inputs. The existing
semantic profile, exact master/role closure, file PID identity, unknown section,
selected-field and opaque-compression-trailer gates remain in force.

## Deterministic seed bytes, version 1

`encode_seed` returns exactly 32 bytes for the typed allocator interface, without
performing allocation. Domain is ASCII `itlkit.cross-import.seed.v1` followed by a
NUL byte. None hashes `domain || 00`. A string hashes `domain || 01 || uint32be(n) ||
utf8`, where n is the strict UTF-8 byte length (not character count). Both use
SHA-256. Strings remain 1–128 Unicode characters; isolated surrogates refuse.
There is no normalization, implicit repr(), Python hash(), locale encoding or
random default. None and the string "None" are distinct. Selection order and input
scope are still explicit intent/allocator facts, not silently erased by this seed.
A seed encoding does not authorize requested PIDs: collision/opaque occurrence and
poisoned-journal checks must still be recomputed by the adopted typed allocator.

## Private whole-image structural materializer

`_freeze_wire_layout` derives an immutable structural expectation from both bounded
inputs, the selected closure, exact proposed field values and exactly the three
resolved enrollment roles. Its private values-only arguments are NOT reservations,
a ledger bridge or write authority. Public `prepare` does not call this route while
any semantic/allocator dependency is unproved. There is no override flag, callback,
report deserializer, fallback allocator or successful fake draft.

Before whole-image assembly the layout freezes every old section/header byte;
source record preimages; exact per-record slot/pool changes; final known-wire track
metadata with proposed local/aux IDs; full old/new membership order and new item
identities; counts; and all unresolved blockers. The expected state is not read back
from the candidate. `Track.to_dict()` remains a known-wire view, including its raw
sample-rate interpretation, and is never substituted for independent native COM.

`_assemble_wire` concretely builds the full framed, compressed/encrypted byte image.
It appends only selected tracks/unique aux records and corresponding role items.
It changes only section spans, list counts, enrollment playlist spans/item counts,
outer/nested library track/album/artist counts and derived file/plain framing sizes.
It never calls the unbounded `Library.to_bytes` reparse path. Canonical boundary-only
preflight counts proposed frames/text before joining an image; conservative zlib
output bounds and input/layout/output coexistence are checked before encoding.
Conservative file bounds may reject an image whose actual compression would fit.

`_validate_wire_assembly` independently reconstructs expected records from source
bytes and frozen values without invoking the assembler, record transformer or
allocator. It checks exact closure and source/template provenance, mapped aux/item
references, old track/index bytes, ordinary playlist bytes and order, every old
system child byte/order, all untouched sections (including4/21/23), and exhaustive
outer/section/root/playlist header whitelists. All three byte inputs are bounded
before any model construction, reserving retained layout memory separately.
Its True means only this structural delta passed; it is NOT semantic/native
admission and is not accepted by the canonical `apply` API.

Numeric validation checks actual proposed collision/exclusion and pool alias facts,
including file/master/opaque byte occurrences. It does not pick IDs or replace the
real allocator's source scopes, conservative graph exclusions, retirement journal,
capacity evidence or poisoned-transaction semantics. A requested PID refusal must
end the allocator transaction: never retry with an alternate PID inside it, suppress
a collision, or publish its partial ledger. Unknown consumer/rule/msph blockers
remain intact regardless of byte preservation or diagnostic report contents.

Unit tests exercise one/four-track in-memory structural images and an explicitly
offline nonempty ordinary-playlist variant. Their fixed numeric vectors are test
inputs, not allocator implementations or native proposals. No candidate files,
PreparedMutation or ready native request are produced. The independently frozen
native/source expectations from the earlier checkpoint are not rewritten.

## Expectation projection correction (S2-EXPECTED-01)

The early known-wire playlist append projection compared transient Playlist wrapper
objects by Python identity. Library.playlists creates fresh wrappers, so that
comparison incorrectly yielded empty append lists. It now matches unique playlist
PIDs within the same pinned target snapshot and derives the appended PIDs solely
from explicit selection intent. Independent final-state tests check one/four and
reversed selection order plus an ordinary-playlist preservation counterexample.
Earlier frozen source/native files are not overwritten: their known-wire append
subprojection requires this documented erratum before any eventual native spec.
No native request or executable prepared mutation was produced using that defect.
