# Experimental additive APIs

These APIs do not claim complete ITL semantics or native qualification. All legacy
modules, guards, CLI, `itlkit.library.v1` and `itlkit.container.v1` are unchanged.

## Shared records (first implementation checkpoint)

Import from `itlkit.schema`: `ReadLimits`, `FieldSpec`, `ByteSpan`, `ProfileReport`,
`Blocker`, `ScopedID`, `ReferenceEdge`, `ReferenceGraph`, `AllocationReservation`,
`AllocationLedger`. Record descriptions defensively freeze nested mappings/lists;
`to_dict()` produces detached **reports, not permission certificates**.

`ReadLimits(max_file_bytes=16777216, max_plain_bytes=16777216, max_nodes=100000,
max_depth=32, max_text_bytes=4194304, max_json_bytes=67108864,
memory_budget_bytes=536870912)` separates storage, model and JSON limits. Values
are positive integers; the experimental absolute tree depth cannot exceed 32.
`check(kind, amount)` recognizes file/plain/nodes/depth/text/json/memory.
`load_container(bytes, *, limits=None)`, `load_library(bytes, *, limits=None)` and
`read_bytes(path, *, limits=None)` are bounded entry points. Preflight counts Nodes
before creating them, never scanning unknown sections for embedded tags. All mhoh
payload bytes count conservatively as text, even non-text/opaque metadata.
Memory formulas are admission estimates and **not an OS RSS guarantee**. Measure
process peak separately; the legacy 512 MiB decompression default is not changed.

`ScopedID(namespace, scope, value, width)` measures width in **bytes**. Namespace
and scope are required strings. `AllocationReservation(namespace, scope,
old_identity, reserved_identity, consumers, capacity_check)` contains typed IDs;
old identity may be None. `capacity_check` is an explicit mapping including
`passed: true` (evidence only, rechecked by engine code).
`AllocationLedger(reservations=())` is frozen, iterable and rejects duplicate
(namespace, scope, reserved value) reservations. It does not allocate or establish
native pool limits. The identities owner supplies the allocator/graph algorithms.

## Engine protocol and trusted preparation adapter

Concrete engines expose:

```python
prepare(target_bytes, intent, sources=None, *, limits=None, seed=None)
# -> PreparedMutation | blocked ProfileReport
```

All byte inputs are immutable snapshots. Sources map nonempty names to ITL bytes.
Malformed intents/limits raise ValueError/TypeError; unsupported capabilities can
return a ProfileReport containing typed Blockers. A profile alone cannot be applied.

`itlkit.planning.prepare_mutation(engine, target_bytes, intent, sources=None, *,
limits=None, seed=None, build, validate)` is the adapter for **reviewed in-process
engine code**, not a user-data candidate adoption API:

```python
build(target_bytes, detached_intent, detached_sources, *, limits, seed)
# -> MutationDraft(candidate_bytes, profile_report, allocation_ledger=...,
#                  typed_patches=(), opaque_preservation=(), postconditions=())
# or blocked ProfileReport

validate(target_bytes, detached_intent, detached_sources, candidate_bytes,
         detached_evidence_report, *, limits)
# -> exactly True; pure, bounded, checks ALL engine-specific postconditions,
#    intent, allocations, affected closure and preservation claims
```

Preparation parses bounded input/output, isolates caller descriptions, calls the
builder once, validates, and seals immutable candidate bytes with evidence and
exact input/model digests. Randomness is used only by the builder/allocator during
prepare. The engine validator must not allocate or replay random operations.
Reports/graphs/ledgers are **not** unchecked coverage certificates. Callbacks are
code supplied by the engine, never executable references decoded from JSON.

`apply(target_library, prepared, *, sources=None) -> MutationReceipt` validates
the in-memory seal, exact current model, source pins, candidate and postconditions
before a single dictionary adoption. For plans with sources, pass the current
named byte snapshots explicitly; missing/extra/changed sources refuse. No disk
writes; publication remains `itlkit.io.write_new`. Obtain bytes with the checked
read-only `prepared.candidate_bytes` property. Concurrent access to a Library must
be synchronized by its owner; no thread-safety claim is made.

Input hashing never invokes Library.to_bytes/_sync: `library_state_digest` reads
raw model fields, including stale derived headers, without normalization or
repair. A dirty target whose exact model differs from the prepared byte snapshot
refuses, even if serializing it could repair/mask the difference. Serialize edits
explicitly before preparation. Offsets are diagnostic, not part of wire identity.

`PreparedMutation.to_dict()` returns `itlkit.prepared-report.v1` with
`executable: false`. There is no from_dict, pickle, generic report replay, or
unsafe bypass. An in-process seal is not a security sandbox against arbitrary
Python code that can modify module globals or trusted validator closures.

## First concrete wrapper and explicit limits

`itlkit.planning.prepare` wraps only non-allocating legacy scalar `set_track`
operations (`intent` must be exactly `{"operations": [...]}`). It retains all
current Track.set guards and refuses unknown operation keys. Sources and seed
are unsupported for this wrapper. Allocating create/replace/import/COW/construct
operations must use their dedicated engine and frozen journal, not fallback raw
edits. Its deterministic scalar validator can safely replay scalar operations;
general engine apply never reexecutes the builder. Tests using the real existing
playlist allocator demonstrate once-prepared candidate reuse, not general/native
playlist or identity support. All MutationReceipts default native_qualified=false.

## Raw/coverage work

The next additive module will expose a separately versioned explicit research
raw tree with **same-sized opaque leaf replacements only**. Header edits,
structure changes, resizing and semantic admission are not part of that schema.
Coverage must separate unknown header ranges, partial bit knowledge and decoded
but semantically unverified payloads. No legacy JSON semantics are repurposed.
