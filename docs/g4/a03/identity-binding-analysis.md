# a03 - Constructor / planning identity and SourceBinding integration

Scope: `itlkit/construct.py` and `itlkit/planning.py` only. Line references are
against base commit `1bb05edc2494abc9aa9b59cd2392026f830615a2`; construct.py line
numbers for code below `prepare()` refer to the pre-change file.

All evidence below is static reading plus synthetic-fixture tests executed on the
Linux runner. No iTunes, COM or UI observation was performed, and none is implied.

## 1. The blocking path, precisely

1. `construct.prepare()` (construct.py:393-413) is the only whole-library
   constructor entry. Its docstring (line 394) states the media-resource facade is
   "always explicitly blocked before any candidate". It wires
   `build=partial(_constructor_blocked_build, admission=admission)` (line 412).
2. `_constructor_blocked_build` (construct.py:352-381) **always** returns a
   `ProfileReport` and never a `MutationDraft`. Three blockers are appended
   unconditionally (lines 367-371): `identity_pool_master_closure_pending`,
   `constructor_candidate_unavailable`, `candidate_accounting_pending`. A fourth,
   `retained_profile_or_pools`, is added (lines 362-366) when `trackops._profile`
   or `atoms.assert_pool_bindings` raises.
3. `planning.prepare_mutation` (planning.py:556-559) sees `type(draft) is
   ProfileReport`, requires `draft.blocked`, and returns the report. With no
   draft there is no `PreparedMutation`, so `planning.apply` (planning.py:597) is
   unreachable.
4. `_constructor_reject_candidate` (construct.py:384-390) returns `False`
   unconditionally, so even an externally supplied candidate is refused at
   validation.
5. Even with a candidate, `planning.py:564` runs `_check_ledger_inputs` on
   `draft.allocation_ledger`, whose default is an empty `schema.AllocationLedger`
   (planning.py:96). `_check_ledger_inputs` (planning.py:290-325) tolerates
   `snapshot is None` only when no entry carries SourceBinding/target/source
   provenance, so a real new-track ledger must be fully canonical.

**The missing integration.** `construct.py` never imports `itlkit.identity` and
never calls `planning.adapt_identity_ledger` (planning.py:328-433) or
`planning.adapt_identity_graph` (planning.py:436-477). `WaveRecordBindings`
(construct.py:33-51) is a seven-integer DTO whose `validate()` only checks ranges
and local distinctness: no `ScopedID`, no `SourceBinding`, no snapshot scope, no
pool membership, no reverse-reference closure. Identity evidence and wire slots
were never connected in either direction.

## 2. Complete identity set for one new PCM track

Each wire slot the admitted recipe writes, with the identity-v2 namespace that
must own it and the allocator operation that produces it
(`itlkit.identity.ReservationAllocator`). Widths are `schema.IDENTITY_V2_WIDTHS`;
pool names are `schema.importer_pool_domain(...)`, not guessed offsets.

| Slot | Binding field | Namespace | Width | Allocator call |
| --- | --- | --- | --- | --- |
| header 0x10 | `track_local` | `track.common_local` | 4 | `local('track.common')` |
| header 0x1f4 | `secondary_local` | `track.file_local` | 4 | `local('track.file')` |
| header 0xdc | `album_local` | `album.local` | 4 | `local('album')` |
| header 0x1e0 | `artist_local` | `artist.local` | 4 | `local('artist')` |
| header 0x80 | `track_pid` | `track.pid` | 8 | `persistent('track')` |
| mhoh mith 2 | `name_atom` | `pool:L+0x178` | 4 | `atom('L+0x178', binding_or_None, name)` |
| mhoh mith 6 | `kind_atom` | `pool:L+0x370` | 4 | `atom('L+0x370', binding_or_None, kind)` |

Self-consistency requirements, all enforced by the new code:

- Exactly one reservation per namespace, and no reservation outside this set.
- Every reserved identity is scoped to the ledger's target snapshot
  (`identity_snapshot_digest(..., identity_v2=True) == ledger.snapshot.digest`).
- Locals come from the single canonical local counter, so the four locals are
  mutually distinct (`_validate_ledger_report`, identity.py:687-707).
- Pool atoms are sequential compact IDs bounded by 65535 (identity.py:664).
- A pool atom either carries no source (`old_identity is None`, consumers empty)
  or a complete `SourceBinding` whose pool matches the namespace and whose
  consumer aliases are exactly the registered source rows (identity.py:666-682).
  Source ownership is retained; nothing is relabeled.
- The PID is seed-derived and collision-free against existing PIDs and opaque
  occurrences (identity.py:722-734).

## 3. Implemented change (narrowest provable improvement)

`planning.identity_binding_index(ledger, *, limits=None)`
: Read-only index of a canonical `schema.AllocationLedger`'s **fresh**
  reservations by namespace. Refuses reports, mappings and snapshotless ledgers;
  refuses identities not scoped to the target snapshot; skips inherited history
  entries; returns a frozen `MappingProxyType`. This is the seam planning was
  missing: it could adapt a ledger but offered no way to consume one by namespace.

`construct.IDENTITY_REQUIREMENTS`, `construct.bindings_from_ledger(...)`,
`construct.unmet_construction_conditions()`
: The requirement table above as data, a converter that turns a canonical ledger
  into a validated `WaveRecordBindings` plus retained provenance, and the explicit
  unmet-conditions list. `bindings_from_ledger` cross-checks the table against
  `IDENTITY_V2_WIDTHS`, `IDENTITY_V2_POOLS` and `importer_pool_domain` on every
  call, so silent vocabulary drift fails closed.

`_constructor_blocked_build` gains one **additional** blocker,
`identity_binding_closure_unproved`, naming the remaining unmet conditions.

What did not change: `prepare()` still always returns a blocked `ProfileReport`;
`_constructor_reject_candidate` still returns `False`; no writer gate was
weakened, removed or bypassed; no allocator runs inside `prepare()`; no candidate
is ever constructed. Binding is evidence conversion, never a write permit.

## 4. Unmet conditions (still missing)

Machine-readable form: `construct.unmet_construction_conditions()`.

1. `kind_atom_outside_constructor_pool_guard` - `graph.POOLS` (graph.py:17) maps
   mith type 6 to `L+0x370` and `schema.IDENTITY_V2_POOLS` (schema.py:234) lists
   it, but `atoms._POOLS` (atoms.py:9-18) is keyed by alias names and has **no
   type 6 entry**. `assert_pool_bindings`, called at construct.py:364, therefore
   cannot see the Kind atom the recipe emits at construct.py:165. Fixing this
   requires editing `itlkit/atoms.py`, which a03 does not own.
2. `no_container_membership_patch` - a materialized record is standalone. Section
   and list record counts, header track counters, auxiliary album/artist rows and
   playlist item entries are not produced. Needs `itlkit/library.py` plus a
   reviewed candidate builder.
3. `no_reverse_reference_closure` - `adapt_identity_graph` can only re-validate an
   existing graph. No post-candidate `ReferenceGraph` proves that album, artist
   and item edges close onto the new identities. Needs `itlkit/graph.py`.
4. `no_allocator_inside_prepare` - `prepare()` forwards `seed` (construct.py:410)
   but never runs `ReservationAllocator`, and `schema.encode_seed` is unused by
   the constructor. Bindings must come from a ledger frozen outside this engine.
5. `no_candidate_accounting` - `_facade_admission` (construct.py:287-308) budgets
   only the blocked path, not candidate, allocator or history work.
6. `no_native_acceptance_evidence` - `WaveRecord.native_accepted` stays `False`
   (construct.py:64). Nothing here observes or implies iTunes acceptance.

## 5. Evidence classes

- **Structural validity**: proved for the binding seam by
  `tests/test_g4_a03_identity_binding.py` against real `build_graph`,
  `ReservationAllocator` and `to_canonical_ledger` output.
- **Preservation**: `SourceBinding` pool, wire id, value digest, snapshot and
  consumer aliases are carried through unchanged; asserted by test.
- **Semantics**: not proved. No candidate, no container patch, no reference
  closure.
- **Native acceptance / persistence / playback**: not proved and not attempted.
