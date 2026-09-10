# Experimental identity/graph v2

This additive implementation does not change legacy core, provide native qualification, or reinterpret diagnostic data as write authority. Graph structure and reservations are real bounded implementations. The supplied real codec now supports the exercised target-local COW prepare/apply path; broader common-ledger provenance transport remains a separate protocol dependency, not a stubbed success.

## Exact early API
```python
from itlkit.graph import build_graph, stable_graph, revalidate_graph
from itlkit.identity import (SnapshotKey, ScopedID, SourceBinding,
                             source_binding, ReservationAllocator, AllocationLedger)
graph = build_graph(data: bytes, *, limits=None)  # ReferenceGraph
stable_graph(graph)                              # immutable persistent projection
source_binding(graph, owner: str, type_code: int)  # SourceBinding
allocator = ReservationAllocator(
    graph, *, sources=(), seed=None, journal=None,
    max_dense_id=65535, max_local_id=1000000, max_probes=4096,
    max_reservations=10000, max_scan_bytes=64*1024*1024)
allocator.local(kind)                           # ScopedID, width is bytes
allocator.token(playlist_scope: ScopedID)        # separate per-playlist order token
allocator.persistent(kind, requested=None)       # ScopedID; requested int or source ScopedID
allocator.atom(pool, source_binding, value)       # ScopedID; binding may be None
allocator.retire(identity: ScopedID)             # exclusion only, never deletes a record
allocator.freeze()                              # immutable AllocationLedger; idempotent
```

`local` kinds: `track.common`, `track.file`, `album`, `artist`, `playlist`, `item`. PID kinds: `track`, `album`, `artist`, `playlist`, `item`. Item locals use a snapshot-wide fresh-write exclusion policy until assigned; order-token scope requires an existing or newly reserved target `playlist.pid`. Returned `ScopedID.value` is the number to encode, not the record itself. File/master PIDs are preserved, never new allocation kinds. Sort/cache ranks are not identifiers.

`SnapshotKey(digest, file_pid, plain_digest)` pins the exact immutable input image. Snapshot SHA is provenance/concurrency, never a fixture allowlist. `SourceBinding(snapshot, pool, wire_id, value_digest)` identifies an actual decoded source binding; use `source_binding(...)` rather than guessing it. Owner strings are e.g. `track:16-UPPERCASE-HEX-PID`. Pool names are exact static domains (`L+0x178` Name, `L+0x1c0` Album, `L+0x208` Artist/AlbumArtist/Composer plus aux consumers, `L+0x400` Comment, and the other inventoried pools). Equal text under different source IDs remains distinct. An empty value is not reference-only and this allocator refuses it.

Reservations and retirement exclusions survive a journal within the same file lineage, including subsequent snapshots. A journal can only remove IDs from consideration, never grant a coverage certificate or authorize mutation. Seeded PID generation is deterministic for the same image/call sequence; an omitted seed creates randomness once at construction. All allocated values are frozen before any later application. Every reservation failure poisons the transaction: discard it; no partial ledger may be published. Frozen ledger reports have no executable deserializer.

## Bounds and dependencies
`limits=None` enforces the adopted defaults:16MiB file/plain,100000 frames, depth32,4MiB aggregate decoded text,64MiB graph JSON,512MiB declared process budget. A seven-field object/protocol or exact seven-key dict is accepted and defensively copied. The real codec ReadLimits is accepted by this strict protocol adapter; common graph/ledger record conversion is separate. Input is bytes, not a pathname: upstream must stat and use a limited file read. The legacy Container's512MiB default is not changed. New calls always supply a bounded cap. Frame count/depth, text aggregation, JSON size and a conservative accounting estimate are checked independently; none alone proves a resident-memory ceiling.

Existing source/target local/token/pool values must satisfy the allocator's explicit policies as well as planned results. Positive dense pool IDs never exceed65535. Native process-global counters/header high-water fields are not guessed. LE/BE/ASCII persistent and LE/BE local-byte occurrences conservatively exclude candidates, with cumulative probe-byte and reservation budgets.

## Admission boundaries
Graph and ledger objects are immutable/defensive. Consumers revalidate raw bounded bytes instead of accepting caller-written graph JSON as authority. Unknown sections4/23 and unknown keyed-owner/secondary consumers currently block pool allocation pending precise static pool-disjointness proof. This is a concrete blocker, not permission to remove old guards or use fixture hashes. Complete semantic/native admission is always false at this layer.

The graph includes known track/aux/playlist/item/pool edges and an opaque-span inventory. GC of zero-known-inbound objects is NOT authorized; retain unresolved orphans. COW must additionally validate owner-local shapes, flags, retained state, all affected pool consumers, ordinary ordering and the complete peer/opaque preservation closure. Name refresh byte6d is not Unplayed byteee or a sort rank.

## Evidence and tests
Known pool dispatch is grounded in archived static phase3 pool-map; typed constructors/renumbering in phase4. New mixed donor metadata must come from raw/COM: WAV embedded tags were not recognized, while AIFF/MP3/AAC/ALAC provide observed shared groups. Unit controls are generated independently, not fixture SHA admission. Live/native acceptance remains dynamic-only after full input-derived old/new expectations and passive45s/30s cycles.

## COW checkpoint
`itlkit.cow.prepare(target_bytes, intent, sources=None, *, limits=None, seed=None)` uses exactly `{"track_pid":"16-UPPERCASE-HEX","fields":{...}}`. Allowed fields are name, album, artist, album_artist, comment, composer. No external sources, extra keys, NUL, non-string values or guessed PID strings. Nonempty changes only; an already-empty unchanged field is a byte-exact noop.

A private pure candidate builder is implemented and tested independently of codec integration. Changed shared text receives a fresh compact scoped binding. Album changes clone only the selected album; effective artist/AlbumArtist changes clone the selected album and artist. Existing aux objects, all peer records, unrelated unknown orphans and order are retained exactly; there is no GC or object deduplication. Blank auxiliary transitions and unknown compilation grouping block. The independent validator reconstructs every expected modified record and the complete plaintext/header closure with frozen IDs, without running the allocator or builder during apply.

The public entry uses the real codec `prepare_mutation` adapter when supplied by parent integration. Without it the result is `BlockedCOW`, not an executable plan. The initial `to_shared_ledger(identity_ledger)` converts the exercised target-local COW reservations to real codec records. The older common schema has no first-class foreign SourceBinding/retirement/seed fields: full owned journals remain private to COW validation and descriptive provenance is not a general interoperability proof. Do not use this initial bridge for cross-library import or retirement-bearing history; a separately pinned common-ledger protocol and validated adapter are required. No source may be relabeled with target scope to make conversion pass. No report deserialization is executable.

Opaque pool-disjointness and msph/custom-smart dependency gaps remain concrete blockers on the fresh native corpus. Unit candidate success is not native qualification. The genuine shared prepare/apply/stale-input/no-new-randomness control now executes. Only the missing-dependency diagnostic is inapplicable in an integrated checkout.

### Bounded journal refinements
Cached atom reuse remains idempotent at exact capacity; only a new reservation/retirement consumes a slot. An empty unregistered wire row cannot be a SourceBinding consumer. A supported empty text body can instead become a new explicit binding with source=None; noncanonical empty prefixes/headers cannot be promoted. Incoming journals validate nested immutable values, scope grammar, duplicate reservations, seed commitment and aggregate evidence estimates. Retained source graphs include decoded-report expansion in their64MiB cap; journal estimates are capped by max_json_bytes and memory_budget_bytes/8. Secondary imported IDs are subject to the same input bounds. These are conservative accounting limits, not an RSS guarantee.

`external_id_consumed` records the known reader dispatch passing an external-ID argument. It does not mean that a blank value registered it. `registered_pool_binding` is the separate nonempty positive-signed32 condition used for actual graph edges and typed source lookup. Raw empty occurrences remain in diagnostics, never reference-only bindings.

### Reviewer resource and trailer closure follow-up
The malformed mutable old_identity journal reproducer is already rejected by the earlier hardening. Its original dict-alias witness is retained as a regression rather than reapplying that fix.

Graph and intent JSON now pre-count the exact canonical ASCII JSON size (including UTF16 surrogate escapes, keys and delimiters) before invoking the output encoder. A streaming bytearray writer checks each chunk and the final size. Graph state, decoded strings, traversal elements and transient output buffers participate in a separate conservative memory estimate. No full JSON string is allocated before max_json admission.

Opaque compression trailers have their own address_space with relative offsets and digest, distinct from payload offsets. Their decoded bytes participate in target local/PID occurrence exclusion and immutable graph revalidation; they block pool consumer closure. Changed COW intents retain the existing trailer refusal; an exact no-op may retain all input bytes. Opaque occurrences remain possible references, never proof of native meaning.

An explicitly requested colliding PID poisons the transaction by design. Do not catch that refusal and attempt a fresh allocation on the same instance: choose policy before preparation or restart the whole transaction. Internally generated PID collisions consume bounded probes and can retry without a surfaced refusal; exhaustion poisons. No new randomness occurs during validation/apply.

The actual codec dependency has now been exercised by the shared COW prepare/apply/stale-state/no-new-randomness regression. Broader source-scope/SourceBinding/retirement/seed transport remains a separate reviewed common-ledger protocol dependency; passing the narrow target-local COW test does not qualify that bridge for cross-library import.

### Explicit text seeds and COW evidence checks
`seed_from_text(text)` returns `SHA256(b'itl.identity.text-seed.v1\0' + len(utf8).to_bytes(4,'big') + utf8).digest()`, using strict UTF8 and at most4096 encoded bytes. No locale or Unicode normalization is performed; empty text is deterministic. `ReservationAllocator(...,seed=text)` applies this same conversion. Existing None/integer/binary behavior and PID derivation remain unchanged. The ledger commitment remains SHA256 of the resulting seed bytes. This is not a promise that a PID will survive a different target snapshot.

The independent COW validator now checks immutable journal shape and bounds, canonical seed commitment format, complete original SourceBinding snapshot/pool/wire/value digest, all old consumers, exact dense-capacity evidence and sequential new pool IDs, and bounded local/PID capacity/probe fields. It verifies evidence against the original target graph and selected/auxiliary old owners without invoking an allocator or reconstructing a builder. This target-local engine rejects foreign/historical reservations and retirement rather than altering their scope. The seed preimage/probe RNG history is not reconstructed; the prepared capability remains sealed by the real planning layer. These checks do not supply missing native cache/opaque consumer closure or solve the pending common-ledger transport contract.
