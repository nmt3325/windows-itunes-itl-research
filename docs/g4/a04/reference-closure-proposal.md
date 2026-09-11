# Whole-reference closure — proposal (G4-B, subagent a04)

**Status: PROPOSAL, not an implemented guarantee and not a proof.**
Nothing in this document authorizes a write, a deletion, a garbage collection,
a native action, or a semantic modification. No existing production file was
modified by this task. The artifacts are task-local:
`research/g4/a04/closure_prototype.py` (prototype predicate),
`tests/test_g4_a04_reference_closure.py` (controls), and the probes
`research/g4/a04/probe_01.py` / `probe_02.py`.

## 0. Scope, baseline and provenance

- Branch `g4/a04`, base commit `1bb05edc2494abc9aa9b59cd2392026f830615a2`.
- Executed on GHA runner env `linux-xm801aqb` (linux, bash), pytest 9.1.1.
- Verification executed: `python3 -m pytest -q -k a04` → `19 passed, 1969 deselected`
  (command_id `c5abc0f7d12c4944`, state exited, exit_code 0).
  This is a **selection-scoped** result. It is not a full-suite run and must not
  be compared against either the fresh G4-B baseline
  (`1919 passed, 50 skipped, 26 subtests passed`, JUnit `tests=1995`) or the
  historical G2/G3 baseline (`2125 passed, 6 skipped, 36 subtests`). The G4-B
  baseline discrepancy is unresolved and is not papered over here.
- Sources read, never edited: `itlkit/graph.py` (`a9b457f8a1bb4491`),
  `itlkit/references.py` (`f39d6416bd194dd8`), `itlkit/cow.py` (`15a4a44424154850`),
  `itlkit/identity.py` (`c652b2b3210e4670`), `itlkit/admission.py` (`8cb4709938c94998`).
- Observed behaviour comes from probe command_ids `a75bf056e6b4429e` and
  `ab2bc3ce92f64978`; all fixtures are the existing synthetic harness
  (`tests/test_core_support.py`, `tests/test_graph_v2.py`). No original library
  bytes are reproduced anywhere in this task.

## 1. Why the opt-in auxiliary-identity master predicate is not closure

`admission.require_complete_master` (GATE01) is deliberately narrow. It is a
point-in-time predicate over the **primary** sections only: main `16/mfdh`,
tracks `1/mlth→mith/756`, playlists `2/mlph→miph/3500`, and the opt-in
auxiliary identities `9/mlah→miah/88` and `11/mlih→miih/100`. Within that scope
it checks self-identity uniqueness, album/artist reference resolution, playlist
item→track resolution, and exactly-once master membership.

It deliberately does **not**:

- read any string payload, external ID, or pool;
- inspect sections outside `{16, 1, 2, 9, 11}`, including secondary consumer
  scopes `13/mlth` and `14/mlph` and any unmapped section;
- treat a **zero** reference slot as an edge (`if value and value not in local`);
- compare the outer `hdfm` file identity with the inner `mfdh` copy;
- claim anything about opaque bytes.

That is a correct design for what a02 is re-deriving. It is also exactly why it
is not whole-reference closure: closure is a statement about *every* reference
class in the retained byte set, not about the primary object graph.

## 2. Reference-class inventory

| Class | Reference | Wire evidence | Closed by GATE01 | Closed by `build_graph` |
|---|---|---|---|---|
| R1 | track → album object | `mith@0xdc` → `miah@0x10` | yes, if nonzero | yes (`missing_object_reference`) |
| R2 | track → artist object | `mith@0x1e0` → `miih@0x10` | yes, if nonzero | yes (`missing_object_reference`) |
| R3 | playlist item → track | `mtph@24` → `mith@0x10` | yes (primary only) | yes (`missing_track_reference`) |
| R4 | master membership multiset | `miph@0x14 & 0x10000`, items | yes (primary only) | yes (`master_count`, `master_membership_not_exactly_once`) |
| R5 | self-identity uniqueness | `mith@0x10/@0x1f4/@0x80`, `miah@0x10/@20`, `miih@0x10/@20`, `miph@0xd40/@0x1b8`, `mtph@0x10/@68/@32` | yes (primary only) | yes (`zero_or_duplicate_identity`) |
| R6 | file identity coherence | outer `hdfm@0x34` BE vs inner `mfdh@0x34` LE | **no** | yes (`file_pid_header_mismatch`) |
| R7 | shared-string pool binding | `mhoh@12` type, `mhoh@16` wire id, payload text | **no** | partly (`pool_id_text_collision`, canonicality blockers) |
| R8 | name-kind derived keys | `miah` 300/301/302, `miih` 400 vs track 3/4/27 | **no** | yes (`resolving_but_wrong_album`, `resolving_but_wrong_artist`) |
| R9 | secondary consumer scopes | `mith`/`miah`/`miih` outside sections 1/9/11 | **no** | reported only (`secondary_identity_consumer_scope` → blocker) |
| R10 | opaque spans as possible carriers | unmapped sections, unmapped leaves, unmapped `mhoh` codes, compression trailer | **no** | reported only (`pool_blockers`, `opaque_spans`) |
| R11 | null-reference class | zero-valued `mith@0xdc` / `mith@0x1e0` | **no** (treated as unset) | yes, as *missing* |

R9 and R10 are the two classes nobody closes: both checkers can only *report*
them. R11 is the one class where the two existing checkers actively **disagree**.

## 3. Pools: which must be consistent

Two different things are called a pool.

**Shared-string pools** (`graph.POOLS`) are keyed by `(owner_tag, type_code)`
and map to a library-offset name such as `L+0x178` (track name), `L+0x1c0`
(album, incl. `miah` 300), `L+0x208` (artist / album-artist / composer, incl.
`miah` 301/302 and `miih` 400), `L+0x400`, `L+0x640`, `L+0x910`, `L+0x1768`,
`L+0x17b0`, `L+0x17f8`, `L+0x1840`, `L+0x328`, `L+0x370`. Consistency requires:

1. within a pool, `wire_id → text` is a function (no `pool_id_text_collision`);
2. every registered binding has `0 < wire_id < 2**31` and nonempty text
   (`registered_pool_binding`); a dispatch that supplies an external ID but an
   empty value is **not** a registration;
3. every keyed consumer record is canonical: `mhoh` header length 24, reserved
   word zero, no suffix bytes (otherwise `noncanonical-string-consumer`);
4. mixed keyed and unkeyed nonempty occurrences in one pool require an ordering
   proof that does not exist (`mixed_keyed_unkeyed_nonempty_requires_order_proof`);
5. the pool address space must be **disjoint** from every unparsed span. This is
   the unproved part, and it is what produces `pool-disjointness-unproved:*`.

**Name-kind pools** are the auxiliary identity records themselves: a `miah`
record is keyed by the tuple `(album, effective artist, album artist)` and a
`miih` record by `(effective artist,)`, where `effective = album_artist or artist`
(`cow._keys`). Consistency requires that the key stored on the auxiliary record
equals the key derived from every track that references it. A compilation track
without an explicit album-artist has no proved grouping key at all.

Closure therefore has to hold over **both** pool kinds simultaneously: a change
that keeps string pools consistent can still break a name-kind key, and vice versa.

## 4. What allocation must guarantee

Observed (`ab2bc3ce92f64978`): allocation gating today is **per class, not whole-reference**.

- `ReservationAllocator.atom(...)` refuses whenever `coverage.pool_blockers` is
  nonempty — confirmed `UnsupportedError: pool consumer coverage blocked: ...`
  for both the secondary-scope and unmapped-section fixtures.
- `ReservationAllocator.local(...)` and `.persistent(...)` **succeed** on those
  same non-closed inputs (e.g. `local('album') → 105`, `persistent('album') → 8-byte PID`).

So string-atom allocation is closure-gated while local-ID and PID allocation are
only *exclusion*-gated. The exclusion union is genuinely conservative — existing
owners, `extra_identities` from secondary scopes, playlist order tokens, prior
journal entries, retirements, plus a raw byte scan (`_occurs`) over header +
plaintext + trailer in little, big, and both hex spellings for 8-byte values.

A closure-grade allocator must additionally guarantee:

- **A1 total coverage**: every namespace that any reference class can name is in
  the exclusion union, including namespaces only reachable through unmapped
  sections. Today unmapped sections are not parsed, so their identities enter the
  union only if their bytes happen to match the probe patterns.
- **A2 scope soundness**: playlist-scoped namespaces (`item.local`, `item.pid`,
  `item.order_token`) are unique per playlist scope, and the scope string itself
  is derived from a PID that is proved unique.
- **A3 dense-pool monotonicity**: a new atom is exactly `max(used)+1`, bounded by
  65535 and by signed-32, and re-derivable by an independent validator without
  the allocator (this is what `_validate_ledger_report` recomputes).
- **A4 no reclamation**: retirement is exclusion only. No integer is ever reused,
  so closure never depends on proving an identity dead.
- **A5 evidence completeness**: the journal records, per reservation, the old
  identity or `SourceBinding`, the complete consumer alias list, and the capacity
  facts; a foreign source ID is never relabelled target-owned.

A1 is the gap. A2–A5 are already implemented and independently revalidated.

## 5. COW and preservation of unknown bytes

Observed on the closed fixture (`ab2bc3ce92f64978`), intent = change one track's
album text:

- `cow._prepare_candidate` produced a candidate of 723 bytes from a 632-byte
  baseline, with two text patches, both bound to a newly reserved atom in pool
  `L+0x1c0`, plus a fresh `album.local`/`album.pid` pair.
- The old `miah` record was **retained in full**; the new one was appended. Album
  count went 1 → 2. Nothing was deleted, and the unknown/opaque bytes, the other
  track, the trailer and every unselected record were reproduced exactly (this is
  what `cow._validate_candidate` recomputes byte-for-byte).
- The candidate re-passes GATE01 and has no graph issues.
- COW refused all three closure counterexamples with exactly the closure reason:
  `('unresolved:secondary_identity_consumer_scope',)`,
  `('pool-disjointness-unproved:section:250',)`, `('pool_id_text_collision',)`.

The interaction that matters for closure:

1. **Preservation and closure pull in opposite directions.** COW guarantees
   unknown bytes survive by never deleting. That means every copy-on-write grows
   the set of live-looking objects, and the old object keeps its identity in the
   retained byte set forever.
2. **The conservative scan cannot separate a self-slot from an alias unaided.**
   For the old album PID in the candidate, `possible_reference(...)` returns
   `True` by default but `False` with `identity_tag=b'mith'`, which suppresses
   the `miah` self-identity slot. The difference between those two answers is the
   only available discriminator, and it is a statement about retained bytes, not
   about semantics.
3. **`known_unreachable` is not unreachable.** `graph._census` labels an
   auxiliary object with no inbound known track edge as
   `retain_pending_opaque_dependency_proof`, never as collectable, and
   `coverage.opaque_gc_authorized` is hard-coded `False`. In the probed fixture
   the old album stayed `retain_live` anyway, because the *second* track still
   referenced it — the COW created a divergence, not an orphan.

So closure must be defined as a property of a snapshot **plus** its declared
opaque set, and it must explicitly carry a *retained-but-unreferenced* class
rather than implying collection.

## 6. The proposed closure predicate

For a snapshot `S` of retained bytes, `CLOSED(S)` holds iff all of:

- **C1** `require_complete_master(Library.from_bytes(S))` succeeds. Necessary, never sufficient.
- **C2** `build_graph(S).to_dict()['issues'] == []` — discharges R1–R6 and R8 over the primary scope.
- **C3** `build_graph(S).coverage['pool_blockers'] == []` — discharges R7 canonicality and asserts R9/R10 declarations are empty.
- **C4** `build_graph(S).to_dict()['unknown'] == []` — no secondary consumer scope, no unproved compilation grouping, no undecodable keyed text.
- **C5** every typed reference slot in R1/R2 is nonzero, or the null class is separately proved. GATE01 and the graph disagree here, so closure must pick, and the safe pick is to reject.
- **C6** the opaque residue is *declared*: `CLOSED` is only ever asserted modulo the exact `opaque_spans` set recorded in the report, which is carried in the result rather than discarded.

`CLOSED(S)` is monotone in nothing useful: it is not preserved by composition,
and it says nothing about `S'` produced from `S`. A mutation engine must
re-establish `CLOSED(S')` from the candidate bytes, which is what `cow` already
does for its own narrower gate.

The prototype `research/g4/a04/closure_prototype.py` implements exactly C1–C6 and
returns a `ClosureReport` whose `complete_semantic` field is permanently `False`.

## 7. Proof obligations

| # | Obligation | Status |
|---|---|---|
| PO1 | The reference-class inventory is exhaustive for the observed version profile | **unproved** — derived from static keyed dispatch plus the parsed record tree, not from an exhaustive consumer enumeration |
| PO2 | Opaque spans carry no reference into any closed namespace (R10) | **unproved**, and unprovable from bytes alone |
| PO3 | Pool address spaces are disjoint from unparsed sections | **unproved** — this is the literal text of `pool-disjointness-unproved:*` |
| PO4 | A zero reference slot means unset, not dangling (R11) | **unproved** |
| PO5 | Secondary consumer scopes never alias primary namespaces (R9) | **unproved**; the allocator conservatively excludes them anyway |
| PO6 | `possible_reference` negatives are sound over retained bytes | holds **by construction** for the retained set; says nothing about native behaviour |
| PO7 | Atom allocation is independently re-derivable | **discharged** by `identity._validate_ledger_report` |
| PO8 | COW preserves all unselected bytes exactly | **discharged** by `cow._validate_candidate` for its narrow intent shape only |
| PO9 | Closure implies native acceptance / persistence / playback | **out of scope and unproved** |

## 8. Counterexamples (executed)

All four are accepted by the opt-in predicate and rejected by the proposed
closure predicate. All use the existing fixture harness unmodified.

| Fixture | GATE01 | Closure violation |
|---|---|---|
| `sample(secondary=True)` | ACCEPT | R9 `unresolved:secondary_identity_consumer_scope` |
| `sample(opaque=True)` | ACCEPT | R10 `pool-disjointness-unproved:section:250` |
| `sample(alias=True)` | ACCEPT | R7 `pool_id_text_collision` |
| `library_bytes(...)` with a master playlist | ACCEPT | R11 null album/artist slots **and** R6 `file_pid_header_mismatch` |

The `secondary_consumer_scope` case is the sharpest: GATE01 lists the analogous
cases in its own GOOD set by design, while `extra_identities` shows the shadow
record republishing `track.common_local 101`, `track.file_local 102` and a
`track.pid` into a scope nothing arbitrates.

## 9. What remains unproved

1. **This is a proposal.** No production behaviour changed; no predicate was
   adopted; `closure_prototype` is task-local and is not wired into anything.
2. **PO2/PO3 are the blocking obligations.** Until opaque spans and pool address
   spaces are proved disjoint, closure can only ever be asserted *modulo a
   declared opaque set*, and any stronger phrasing would be false.
3. **PO4 (null class) is a genuine disagreement**, not an oversight, between the
   opt-in predicate and the graph. Resolving it needs evidence, not a vote.
4. **Reachability is not decidable here.** `known_unreachable` is a statement
   about known edges only; no GC is authorized, and this proposal does not
   authorize one.
5. **The probed COW divergence was not an orphan case.** A single-track fixture
   would be needed to exercise retained-but-unreferenced, and that was not run.
6. **No native evidence.** Nothing was executed against iTunes, COM, or any UI;
   no persistence or playback claim is made.
7. **Baseline caveat.** Only `-k a04` was run (19 selected). The full-suite
   baseline discrepancy recorded in the G4-B addendum is untouched by this task.
