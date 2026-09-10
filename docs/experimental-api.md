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
limits=None, seed=None, build, validate, resources=None, validate_resources=None)` is the adapter for **reviewed in-process
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

`apply(target_library, prepared, *, sources=None, resources=None) -> MutationReceipt` validates
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

## Explicit raw research schema and coverage

Import from `itlkit.raw`:

```python
export_raw_tree(container_or_bytes, *, limits=None) -> dict
import_raw_tree(document, *, research_only=False, limits=None,
                expected_baseline_digest=None) -> Container
inspect_coverage(library_or_container_or_bytes, limits=None) -> CoverageReport
```

`itlkit.raw-tree.v1` has exactly schema, policy, original_file_b64,
original_sha256, header_hex, trailer_hex and sections. Nodes have tag, kind,
header_hex, offset and either children or payload_hex. Export requires immutable
bytes or an unchanged Container with a verifiable original baseline. Re-read an
explicitly serialized current Container before making it a new export baseline;
export never silently normalizes or repairs a live Library.

Import requires the literal boolean `research_only=True`. It accepts a dict or
UTF-8 JSON text/bytes, rejects duplicate/extra/missing keys and checks lexical
resource limits before JSON object allocation. The only editable values are
same-sized **generic-tree opaque leaf payload_hex** strings. Here opaque means
Node.children is None; it does NOT say that every contained byte is semantically
unknown. Even a named metadata text leaf edited this way has no semantic/native
assurance. Header, kind, tag, offset, child/section shape, resizing and trailer
edits refuse. No engine routes refused semantic operations to this raw path.
No-op returns exact original bytes; a changed payload may change compression and
the serializer's derived outer physical-size word, never user-edited headers.

The original digest in unsigned JSON is only a self-consistency check. Pass a
separately trusted `expected_baseline_digest` to enforce a provenance/CAS pin and
reject a paired replacement of baseline bytes and digest. No authenticity or
admission is inferred from an unsigned self-declared digest.

Coverage includes every bounded current record and source-defined field site.
It distinguishes unmapped header intervals, raw slots, partial-bit masks, named
accessors and prefix-decodable yet semantically unverified payloads (e.g. type
508). Raw/count/fixed/mixed header words are not confused with total lengths;
unused Pascal version padding remains unmapped. Alias names do not add bit
knowledge. Levels describe guarded existing code, NOT automatic write authority
or percentages of full semantic understanding. A blocked ProfileReport remains
explicit because unknown coverage is not resolved by byte preservation.

Coverage of a Library reads current raw fields without to_bytes/_sync; offsets
may be historical after edits, so paths and header-relative intervals identify
diagnostics. Big-endian Container coverage stays a single opaque payload and
never invents a little-endian record tree. The new raw importer returns Container,
not a semantic PreparedMutation. Legacy library.v1 rejects its raw tree edits.

Nested parser-copy pressure, raw-document expansion and current-model text/plain
budgets are checked separately. Estimates remain conservative admission heuristics
rather than OS memory guarantees; measured test/corpus process peaks belong in
the execution report. All public snapshot paths are read-only; no private originals
or native operations are required by these modules or their synthetic tests.

## Cross-snapshot identity evidence (S2-API-01)

This additive contract targets the identity/graph owner at
`8bd62dd03891eabb99797b20dd86969eceeaba7a` and importer at
`c5d9918c821b0b7f58d2bb39bb0a8b5c553f7cc8`. These are reproducibility pins,
**not hashes used to decide which user libraries are eligible**. No dependency
files are merged or vendored by this codec change.

### Exact records and retention rules

- `SnapshotKey(digest, file_pid, plain_digest)` uses lower-case 64-hex SHA256 of
  exact wire bytes and decrypted payload, plus the positive uint64 file PID.
  `snapshot_key(data, *, limits=None)` reads immutable bytes without serializing
  or normalizing a Library. A wire hash is provenance/CAS, not a semantic profile.
- `SourceBinding(snapshot, pool, wire_id, value_digest)` retains the *source*
  SnapshotKey, exact pool spelling, positive signed32 ID and SHA256 of decoded
  source text encoded UTF-16-LE. Existence, registration, alias closure and the
  source value must be independently rechecked. Empty/unregistered source rows
  do not become allocatable merely by supplying this record.
- `AllocationReservation` keeps the first six constructor positions. Optional
  `source_snapshot` and `target_snapshot` follow them. `old_identity` is now
  canonical `ScopedID | SourceBinding | None`. A ScopedID old/new pair must have
  the **same namespace and byte width, but may have different scopes**. Known
  identity-v2 namespaces also require their registered width. The outer scope
  belongs to the reserved target, not the source. Never overwrite an old scope,
  convert a source binding into a target-scoped ID, or replace foreign provenance
  with None. A binding's pool must equal the target's `pool:<exact-domain>` and
  width is four bytes. Optional SnapshotKeys must agree with their full scopes.
- `AllocationLedger(reservations=(), snapshot=None, sources={}, retired=(),
  seed_commitment=None, history=())` preserves original iteration and positional
  construction. Extended evidence contains the current target SnapshotKey, a
  complete name-to-source-SnapshotKey map, exact typed retirements, current seed
  commitment and complete earlier **canonical** ledgers. Nested lists, mappings
  and even frozen dataclasses with mutable members are detached/frozen. No
  mutable nested aliases are retained. `to_dict()` is a detached report only.
- Identity-v2 scopes are `<snapshot-digest>` or, only for item namespaces,
  `<snapshot-digest>/playlist:<16-UPPERCASE-HEX-PID>`. Order tokens require the
  playlist suffix. The source and target playlist suffixes must also be retained.
  PIDs use eight bytes; local IDs, pool IDs and order tokens use four. Generic
  evidence-only ScopedIDs from the first checkpoint remain available.
- Historical reservations/retirements form an exclusion union. Keep earlier
  target scopes and seed commitments; do not relabel old entries to the current
  digest or silently drop entries. History is same-file-lineage evidence, never
  allocation, deletion, garbage-collection or native permission. Untrusted
  history can only add exclusions; the engine must not let it grant permission.

A bare six-argument cross-snapshot reservation can represent evidence. It cannot
enter prepared use without complete matching input provenance. Same-scope legacy
record construction remains compatible; it still depends on engine validation.

### Explicit adapter, never unchecked report adoption

```python
from itlkit import planning

def copy_with_provenance(journal, target_bytes, sources=None, *,
                         validate_evidence, history=(), limits=None):
    return planning.adapt_identity_ledger(
        journal, target_bytes, sources, history=history, limits=limits,
        validate=validate_evidence,
    )
```

This is a complete small wrapper an identities owner can add; it does not edit
or silently change the existing `identity.to_shared_ledger` helper. Do **not** use
that older helper for the foreign-source/history contract: it can drop typed old
identities and top-level retirement/seed history even when retaining an auxiliary
provenance dictionary. Migrate a caller explicitly, with its validator and inputs.

The public adapter signature is
`planning.adapt_identity_ledger(identity_ledger, target_bytes, sources=None, *,
history=(), limits=None, validate) -> schema.AllocationLedger`.
It requires the real identity dataclasses, not duck-typed objects or JSON. It
bounds the report, preflights every input's framing/node/depth/text limits before
the callback, checks exact source/target snapshots, copies every reservation,
consumer, retirement and seed commitment, and checks preserved history. Raw
allocator capacity facts are retained under `capacity_check['allocator_reported']`.
They are not converted into a success certificate by inserting an unchecked flag.
Memory checks remain admission estimates, not a promise about arbitrary callback
code or fixes to separately owned graph/importer resource handling.

The **mandatory reviewed code** callback is:

```python
validate(target_bytes, detached_named_sources, detached_identity_report,
         detached_canonical_history_reports, *, limits)
# -> list/tuple of one recomputed capacity-check mapping per ordered reservation
#    each has {'passed': True, ...independent facts...}
#    'allocator_reported' is reserved for the adapter, not callback output
```

It must re-decode/revalidate raw inputs, check current and historical namespace/
width ownership, real source membership and registered UTF-16 value/consumer
bindings, capacity/dense-map bounds, duplicate IDs, exclusion history/retirements
and the commitment to the exact seed bytes used by prepare. Historical checks
must retain the original evidence for unchanged historical entries. Do not use
`lambda ...: [{'passed': True}]` or trust a supplied capacity dictionary. The
independent **candidate validator** separately proves intent, actual field use,
complete affected reference closure and opaque/header/trailer preservation,
repeating these checks before apply. The bridge neither builds nor applies data.

For graph diagnostics use `planning.adapt_identity_graph(real_graph, *, limits=None)`.
It revalidates the byte-backed graph, maps owner locators to actual typed owners,
and retains each original owner locator, field, target, snapshot and evidence
level. Unmapped locators refuse. `transport_only` remains true; opaque issues and
partial coverage remain visible. The resulting canonical graph cannot be used
as a substitute for a raw revalidated graph by an allocator.

### Seed and namespace translation are explicit

The importer's public seed stays a nonempty string of at most 128 characters
(or None); the identity allocator accepts integer/bytes/None. Do not pass encoded
bytes back to the string-only importer entry. A reviewed engine can obtain the
allocator bytes once during prepare:

```python
import hashlib
import secrets
from itlkit.schema import encode_seed

def prepare_seed(user_seed):
    material = (secrets.token_bytes(32) if user_seed is None else
                encode_seed(user_seed, domain='cross_import.v2'))
    return material, hashlib.sha256(material).hexdigest()
```

`encode_seed(seed, *, domain)` computes SHA256 of:
`b'itlkit.seed.v1\0' + u32be(len(domain_ascii)) + domain_ascii +
u32be(len(seed_utf8)) + seed_utf8`. Domain is 1..64 ASCII letters/digits/`_.-`;
seed is strict UTF-8, without Unicode normalization. None is **not** an empty or
fixed seed. The allocator commitment is SHA256 of the returned material, not
SHA256 of the original string. Apply must never call this helper, the builder,
the allocator or randomness again.

`schema.importer_pool_domain(alias)` accepts only the exact pinned aliases:
name -> L+0x178; album -> L+0x1c0; artist -> L+0x208; genre -> L+0x328;
kind -> L+0x370; comment -> L+0x400; sort_name -> L+0x1768;
sort_album -> L+0x17b0; sort_artist -> L+0x17f8. Unknown or case-normalized
aliases refuse. The importer patch namespaces `local.track`, `local.secondary`,
`local.album`, `local.artist`, `local.item`, `token.playlist`, `pid.item` map
respectively to identity namespaces `track.common_local`, `track.file_local`,
`album.local`, `artist.local`, `item.local`, `item.order_token`, `item.pid`.
`ref.*` patch namespaces are references, not separate allocation namespaces.
The engine must supply real playlist context and exact metadata/pool dispatch;
string-prefix normalization cannot establish namespace equivalence.

### Concrete verification and remaining limits

The original G1 `tests/test_codec_planning.py` contained executable real-allocator controls for the
reviewer's generated foreign PID and SourceBinding paths, namespace/width/source/
capacity/seed failures, complete recompression/retirement/history retention,
source staleness, seal tampering and bounded preflight. Its test-only evidence
checker recomputes wire exclusions and refuses opaque trailers. A separate
**generated two-PID patch** demonstrates a real allocator through build, seal,
independent exact plaintext/header/trailer validation and repeatable apply with
allocator/randomness disabled. It is not an import/COW/native writer qualification.
These optional-owner tests skip in a standalone codec tree; run them with the
specified immutable identity/graph pins, or after the parent integrates owners.

The pinned importer remains blocked, including unproven MSPH800 business semantics,
system-rule evaluation and a missing full materializer. Adding this adapter does
not remove those blockers. The old graph JSON allocation-order and allocator
opaque-trailer findings are other-owner/engine concerns, not claimed repaired by
this transport API. No native actions, private inputs, shared-core changes,
fixture-hash eligibility gates or fallback raw editing are introduced.

### Corrected coverage label, not a legacy getter rewrite

The new coverage table labels `sample_rate` at **mith+0x98, little-endian IEEE-754
float32**, per the parent's independently confirmed mapping. It does not copy the
old incorrect `NUMBER_FIELDS['sample_rate'] == (0xf4,4)` claim. The full eight bytes
`header[0xf4:0xfc]` remain the offset-named `header_0xf4_8_raw` diagnostic, with no
sample-rate or other semantic interpretation. Both entries have no new write
permission. The parent owns the separate legacy core correction. Historical
checkpoint coverage reports are preserved, not rewritten or reinterpreted.


## G2 resource lane: new implementation, not recovered G1 bytes

The four b985 source/document files were recovered exactly, but its three full
original test revisions were not recovered. The raw test baseline was recovered
from earlier9db. The real-allocator checks described above are historical G1
checks, not a claim that those missing tests ran on G2. This resource extension
and its new tests are separately implemented and verified on G2; the old222
focused passes are not reused. Existing schema records, SourceBinding, complete
history/retirement/seed checks, and non-normalizing target CAS remain unchanged.

The shared adapter adds keyword-only `resources=None, validate_resources=None`.
`apply(..., resources=None)` requires a fresh explicit complete resource map for
nonempty-resource plans, just as sources require fresh named ITL snapshots.
None or an empty dict keeps legacy callback signatures and skips the resource
probe. A non-None noncallable validator is rejected as a configuration error.

Nonempty resources must be an exact dict:1..128-character strict-UTF8 names and
exact immutable bytes, at most128 entries and also within max_nodes. Names must
not overlap ITL sources. Names are opaque keys: no path access, case folding or
Unicode normalization. Every resource obeys max_file_bytes. Aggregate names,
wire storage, JSON pins/intent/source descriptions, parsed ITL inputs and model
budgets are admitted before any callback. Resources are never parsed as ITL.
Putting WAV in the default ITL `sources` lane still fails before build.

The reviewed trusted pure function
`validate_resources(resources, *, limits)` must return a mapping with exactly
the same names, containing finite JSON facts. Strings/keys, nesting, nodes, JSON
size and aggregate memory are bounded before copying/encoding and before build.
Bytes, dataclasses, callbacks, non-string keys, cycles and NaN/Infinity refuse.
The returned report is detached and frozen; there is no executable inverse.

With nonempty resources only, build and the ordinary candidate validator receive
an extra `resources=` keyword containing a fresh detached dictionary. Mutating
that dictionary is detected and refused. Build still runs only during prepare:
no supplied builder, allocator or RNG replay occurs during apply.

The seal binds resource names, byte sizes and SHA256s, immutable facts, exact
resource bytes, callback identity and admission estimates, in addition to the
existing target/source/candidate/ledger/intent evidence. Apply rejects missing,
extra, changed, wrong-type or colliding resource snapshots before adoption. It
re-probes and compares canonical JSON (so1, True and1.0 are different), then runs
the ordinary validator and final seal/model CAS before one target adoption.
Reports and caller-issued ledgers remain evidence, never write permission.

Admission reserves12 times aggregate wire bytes plus1024 per resource,8 times
ITL plaintext,512 per resource-JSON node/key and32 times encoded resource JSON.
Preparation reserves the retained facts and another probe; apply checks the
combined retention again. These are conservative admission estimates, not an
OS RSS guarantee or a sandbox for arbitrary callback code. Trusted callbacks
must themselves be pure and bounded, and the engine must prove its complete
candidate/closure/opaque preservation and independently declared source intent.

Media engines must use the reviewed physical `itlkit.media.probe_bytes` with
independent declared intent. The G2 stdlib PCM/scalar control demonstrates
transport, independent raw candidate verification and fail-closed wrong/fake
facts; it is not a media-engine replacement, new-track constructor, allocator,
pool qualification or native acceptance. The actual-owner integration test is
explicitly skipped when that module is absent. No missing dependency is replaced
with a fake production callback or ledger.

The legacy +f4 raw alias is represented by one canonical offset-named
`header_0xf4_8_raw` field of8 bytes, with no semantic interpretation or write
permission. Sample rate remains the separate float32 evidence entry at+0x98.
The core module and CLI are not changed.
