# Opt-in complete-primary-master admission

## Scope and API

```python
from itlkit.admission import require_complete_master
from itlkit.schema import ReadLimits

master = require_complete_master(library, limits=ReadLimits())
```

The function inspects the **current Library model** without serializing it and
returns a `Playlist` view referring to the checked, existing primary master node.
It does not clone/adopt/repair that node or allocate identities. Python temporary
collections and the normal lightweight Playlist view are not ID allocation.
The result is **not permission, a certificate, a PreparedMutation, a sealed
snapshot, a full semantic read/write claim, or native writer acceptance**.
Callers must synchronize mutable models externally and recheck the relevant
state at their own engine boundaries. A later edit can invalidate the result.

The module is deliberately **not activated in Library, Track, Playlist, raw
transport, or generic planning**. Importing it does not monkey-patch those APIs.
Future v2 engines may call it explicitly where semantic mutation is intended;
activation and compatibility migration remain separate parent-owned work.

## Closed checks

- Exact `Library`, `Container`, `Node`, list and byte-storage types are checked
  before interpreting record accessors. Header/payload storage is exactly bytes
  or bytearray; arbitrary iterators, list/Node subclasses, and callback-like
  values are not coerced. Cyclic or shared Node graphs are rejected.
- Use the existing pure envelope validation, a 144-byte outer header, little-
  endian payload, `12.13.9.1` or `12.13.10.3`, and no unknown compression trailer.
  This version pair is the existing semantic-profile restriction, not a claim
  of new native testing for either version. Nonzero endian Boolean values keep
  their existing core meaning; no invented 1-only Boolean enum is imposed.
- Required direct sections: main section 16 (`mfdh`, fixed 144), tracks section 1
  (`mlth`, count 92), and playlists section 2 (`mlph`, count 92); these section
  headers are 96 bytes. Each selected section has exactly one direct root.
  Duplicate section numbers and contradictory root shapes fail closed.
- Every direct primary track is a 756-byte `mith` and every direct primary
  playlist is a 3500-byte `miph`, both normal container nodes. Unclassified
  primary records cannot disappear through tag filtering.
- There must be exactly one **primary** master, including an empty library.
  Master children are `mhoh` metadata or flat 84-byte `mtph` items. Nested items,
  opaque item payload, unclassified children, and nonzero words outside
  `{0, 4, 8, 12, 16, 24, 32, 68, 72}` fail closed. In particular, parent word 20,
  group word 28, and unknown word 36 must be zero. No group-flattening decoder
  or inferred group membership is introduced.
- Sorted master item track IDs must equal sorted primary track IDs exactly.
  Multiplicity is retained: equal cardinality, a set match, or an extra member
  in an ordinary playlist is not sufficient.
- Primary track local/PID/secondary IDs; primary playlist local/PIDs; scoped
  item local/PIDs; primary track album/artist references and identities; and
  direct primary-playlist track references retain the existing core predicates.
  Optional album/artist roots are shape-checked before their direct records are
  used. Persistent IDs on these objects use the core's observed-size conditions.
- Ordinary playlist duplicate memberships and ordinary group state are **not**
  promoted to master membership or subjected to the master-only flatness rule.
  Existing ordinary/reference guards still apply. Section 13 tracks and section
  14 shadow playlists do not enlarge the primary namespaces or master count.
  Their entire Node topology remains subject to resource/type/cycle checks.

This is a necessary master predicate, not exhaustive interpretation of unknown
sections, playlist metadata, folder/smart behavior, secondary state, references,
media bindings, or every field. Operation-specific guards remain necessary.

## Purity and existing validators

The pinned `itlkit/library.py` SHA256 is
`f70f5f51b534d08c6dd55c721e10732a0df5a49df88bf5442fbab1c0583899ba`.
Its `_validate_ids_and_refs` was inspected: it reads only, but reconstructs an
album/artist lookup set inside the per-track loop and uses instance accessors.
The new module implements the same identity/reference scope on already bounded
nodes with linear set construction. Tests compare its identity refusals with
the unchanged core method. No core method or default fixture was rewritten.
`Container.validate_header` and its `crypt_length` dependency were also inspected
and are pure; the existing envelope validation is called without serialization.

Neither `_validate` nor `_require_semantic_profile` is invoked as a shortcut.
No `_sync`, `to_bytes`, `to_dict`, recursive `Node.walk`, normalization, repair,
engine builder, allocator, or adoption is performed by the helper. Raw derived
counts and total-length caches do not substitute for current Node children and
are not silently repaired. The helper therefore does **not** certify that a
stale current model is already a valid serialized candidate. The original wire
payload/baseline is not the membership authority after an in-memory edit.

## Shared limits

The function accepts only `None` or the real `itlkit.schema.ReadLimits` type.
It revalidates the frozen object's positive integer dimensions; there is no
replacement limits class, missing-dependency stub, or dictionary coercion.

- Every current Node is counted, including unrelated/secondary/unknown nodes.
- Actual Node depth starts at zero for top-level sections, matching current
  model digest traversal. The maximum permitted configured depth remains 32.
- Node count and logical memory are checked before expanding a wide frontier.
- All current header/payload bytes count toward the plain-model budget.
- All `mhoh` payload bytes count toward the conservative text budget, including
  metadata with unknown type/encoding. Text is not decoded for this predicate.
- Retained envelope/payload/trailer, optional original wire bytes and the three
  baseline buffers are type-checked and budgeted without copying them. The file
  budget applies to retained original wire bytes when present; no current wire
  size is invented by recompression when there is no original.
- Logical memory charging is four times retained/model bytes plus 2048 bytes
  per seen or scheduled Node. It is conservative bookkeeping, **not an OS RSS
  guarantee** and not a promise about arbitrary extra Python attributes.
- No JSON is constructed, so the JSON output budget is not used by this API.

Resource excess uses the shared `LimitError`. Unsupported profile/master
conditions raise `UnsupportedError`; malformed models/identities raise
`FormatError`; incorrect API object/limits types raise `TypeError` (invalid
mutated limit values raise `ValueError`). Refusal leaves the input unchanged.

## Compatibility and no-effect classification

The old recovered 5162-byte activation diff, its 81-case G2 projection, and the
27 unchanged legacy cases with **four activation-induced failures** remain
historical artifacts. This independent module is not that activated proposal;
new green legacy results must not overwrite or relabel those four failures.

The default `test_core_support.library_bytes()` remains ordinary/masterless.
Calling this new helper on it refuses, but the existing scalar setter and
legacy planning entrypoints can still mutate it. **That admission gap remains
open** until an explicitly authorized engine/compatibility migration is done.

New tests classify empty setters, same-value year/name setters (including the
name-refresh sentinel), same playlist rename, empty operations and nonempty
operations with empty fields, a legacy empty-operations plan, a test-only
identity builder with empty generic intent, raw byte no-ops, library.v1 JSON
no-ops and explicit raw JSON no-ops. Byte equality, exact model-value equality
and Python object-identity preservation are recorded separately; a byte no-op
is not automatically a pure object no-op. Test-only builder callbacks are not
production engines or substitutes for missing dependencies.

## Reproduction and evidence

This three-file change depends on the fixed parent integration
`47820efb5fd28001556b32fe21d76774dd987c39` for the actual shared schema/planning
modules. The dates branch may still be based on ef65: no dependency merge is
required or authorized. Test by extracting the exact parent source into an
owned composite and overlaying only these three files. Do not install stubs.

Set all three fixture variables explicitly for the closed, existing data:

```text
ITLKIT_NATIVE_ROOT=<existing evidence/native/snapshots directory>
ITLKIT_NATIVE_REPORTS=<existing evidence/native/oracles directory>
ITLKIT_FRESH_SNAPSHOT_DIR=<existing checkpoint-01/native-snapshots directory>
```

Use a fresh owned tmp directory and logs/JUnit XML, Python `-B`/UTF-8 and one
pytest worker. Compare SHA256, byte length and mtime for source/input files
before and after testing. The new module/tests/doc are authored on Computer,
then deployed byte-exactly with SHA guards to the owned dates worktree.

The 55 saved native fixtures are an **offline historical shape cohort**, not
55 new native executions. Their input bytes and saved COM observations are not
rebound to live Locations or assigned historical mtimes. Actual new run counts,
source/input pins, no-effect observations, compatibility residuals, measured
process memory and command exit/EOF receipts belong to the separate new phase
`reports/dates/g2-admission-01/`, not the sealed recovery report. No pushes,
new environments/sessions, native actions, or G1 executions are authorized.
