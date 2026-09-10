# Experimental constructor v2: first additive implementation

This checkpoint provides real, bounded pure helpers and a PCM mith record emitter. It does **not** yet provide a complete new-library constructor, a validated PreparedMutation, or native writer acceptance. Existing core, CLI, library.v1 and historical same-lineage guards are unchanged. The parent-authorized codec revision is now integrated; identities/importer remain read-only until a new parent pin.

## Surfaces

- `media.probe_bytes(data: bytes, *, limits=None) -> MediaFacts`: strict length-driven RIFF/PCM and AIFF chunk analysis with exact frames and rational millisecond flooring. Optional mutagen performs MP3/MP4 AAC/ALAC read-only probing. `probe_file` checks pre-read size plus before/after file identity, size, mtime and optional supplied pins. It never saves tags. Facts are frozen; embedded tags never override explicit metadata. Optional mutagen is not installed or added to package dependencies by this change; non-PCM probing fails clearly when it is absent.
- `location.plan_location(path, *, type1_payload=None, limits=None) -> LocationBundle`: drive-absolute Windows, no type1, strict Unicode and one UTF8 percent-encoding pass. No normalization between NFC/NFD, no unquote_plus. UNC/device/ADS/traversal/reserved/trailing-dot/long-path aliases refuse. `location_records` emits canonical mhoh13/11 with file-local IDs1/2; `inspect_location_records` verifies exactly that representation and refuses unknown prefixes/suffixes. Encoding3 is ASCII in this initial canonical profile; non-ASCII output uses UTF16LE1. URI/text roundtrip is not native path acceptance.
- `construct.materialize_pcm_wave_record(media_bytes, metadata, location, bindings, *, date_added, date_modified, sort_ranks, limits=None) -> WaveRecord`: re-probes immutable media bytes and emits one complete756-byte-header mith plus Name/Kind/path/URL children. It neither allocates graph identities nor modifies/adopts/publishes a library. Typed `WaveRecordBindings` and explicit seven ranks are data, never a caller-issued allocation/coverage certificate. The future full engine must independently reserve and verify them.
- `construct.declare_intent(media_bytes, metadata, location, *, date_added, date_modified, limits=None)`: independent, detached JSON expectations from actual media bytes and explicit metadata, without reading a candidate. It normalizes aware wall datetimes to ISO strings and includes exact media SHA/size/dimensions.
- `construct.prepare(target_bytes, intent, sources=None, *, limits=None, seed=None)`: validates exact intent/media agreement, uses the real shared bounded target reader and returns the actual immutable shared `ProfileReport` with typed blockers. There is no executable plan or fallback while the source adapter and identity integration gates remain unresolved.

Exact intent keys are `op`, `location`, `metadata`, `date_added`, `date_modified`, `media`; `op` is `append_pcm_wave`; sources is exactly `{"media": bytes}`. The declaration helper accepts aware datetimes or aware ISO strings; the engine JSON intent uses ISO strings only. Displayed wall components are encoded without an implicit UTC shift. The media object has exactly format, sha256, size_bytes, sample_rate_hz, channels, bits_per_sample, pcm_source_frames, duration_ms and bitrate_kbps; claims are checked against a fresh bounded probe, including exact numeric types. Inputs/reports containing caller ledgers, IDs, byte patches or other extras are not accepted as authority. A serialization/replay format is not promised at this checkpoint.

## Bounded first PCM recipe

Only canonical16-byte fmt PCM WAV, mono16-bit,44100 or48000Hz. The parser reads more PCM dimensions but the emitter refuses unqualified channels/bits/rates. Full record emission is initially limited to nonempty ASCII explicit Name, ASCII unescaped drive paths, blank album/artist/album-artist/genre/composer/comment. Typed scalar rating/year/track/disc numbers and Unplayed are represented. Based on the independent reader/writer width evidence, Year is restricted to0..32767 and track number/count to0..65535; storage width32 is not mistaken for a native32-bit value domain. These representational limits are not blanket native setter acceptance. Shared grouping/text COW is a later gate.

The emitter computes total media size at+24/+144, exact PCM milliseconds at+28, floor(bits*channels*Hz/1000) at+38, float32 Hz at+98 and uint64 PCM frame count at+f4. The last rule is ONLY for the named mono-PCM profile: +f4 is not sample rate and is not a generally decoded exact frame count for compressed formats. Name sets6d/0 clear; Unplayed uses inverse ee/0 and does not modify rating. Dates require explicit nonzero HFS-range aware values. Identity/auxiliary references and Name/Kind atoms are separate typed inputs. Supplied ranks are not regenerated or blindly zeroed.

Other default bytes are a narrowly named native initialization recipe, not individually understood semantic setters: +14=1,+50=70,+5c=ffffffff,+c8=256,+104=1,+128=258,+14c=80808080,+150=8080,+1dc=256,+208=65536,+274=1. Unlisted new-header state is zero in this observed recipe. These values are not transplanted to MP3/AAC/ALAC/AIFF or unknown PCM configurations. Emitted records always retain `native_accepted=False`.

Evidence basis: archived one-second44.1kHz PCM; new independent48kHz/60000frame native WAV; the stage2 parent raw census and constructor wire-census counterexample. The old integer-sample-rate getter must not be used as truth. In the new donor MP3 parser duration1296ms differs from raw/native1320ms; MP4 AAC parser1271.333ms differs from raw1250ms. Parser durations cannot be universally copied into ITL.

## Limits and tests

Helpers now consume the real shared ReadLimits implementation. Helper-only dictionaries are converted through its validator; engine/declaration limits require the actual ReadLimits type. Initial defaults include16MiB media files,100000 chunks/nodes and4MiB text. File pre-read, aggregate text and decoded/model limits are separate. A16MiB data cap does not guarantee512MiB RSS; process budget measurements and the shared bounded model parser remain separate integration obligations.

New portable tests generate their own media in memory or pytest-owned temporary files. They cover frame/rate separation, exact sizes, PCM/AIFF parsing, truncation/duplicate chunks, bounds, explicit metadata, typed-ID capacities,6d/ee/rating independence, strict path/URI/UTF16 behavior and preservation/metamorphisms. Identical physical audio facts with different PCM content can produce identical record bytes but different provenance hashes. Such tests do not constitute library-closure or native acceptance.

## Required integration before full candidates

Consume the actual parent-integrated shared PreparedMutation/apply implementation and identities allocator/graph; independently validate all retained/imported namespaces, compact atom bindings, auxiliary closure, system definitions/membership, ordinary order and opaque preservation. Freeze reservations and all randomness during prepare. Validate current input/candidate digests plus all postconditions before one adoption; use existing exclusive write_new for disk publication.

A native request must be built from predeclared source/intent/media expectations, not only from the resulting candidate. It requires genuinely new source media, complete old/new identities and metadata, every visible/hidden membership, exact Location and media pins,45s/30s passive reopens, normal saves/exits, no repairs or fallback, and separate playback/allocator-follow-up checks. No invalid standalone mith is handed to native as an ITL candidate.


## Current concrete integration blockers

The authorized `planning.prepare_mutation` parses **every** named source as an ITL before invoking an engine builder. A real PCM WAV is therefore rejected before construction. The source-hash/apply machinery is useful, but a bounded trusted-engine media/opaque-source classification or validation hook is required. Default ITL parsing should remain for existing engines; changed/missing/extra media sources must still be rejected on apply. Constructor does not hide media in a closure/JSON, masquerade it as a donor ITL, drop source pins, or alter codec-owned code.

Identities' read-only early interface uses pool-scoped source bindings and explicitly blocks unresolved sections4/23/keyed-owner pool consumers. Its pending shared adapters cannot be replaced by a caller-written AllocationLedger. Kind6/Name pools, blank album/artist ownership and item/system enrollment require the actual authorized allocator/closure proof. Existing guards remain intact. A diagnostic raw-record binding is not a reservation against a real target.

The new receipt separates `probe`, `recipe`, `built_itl`, and `accepted_native`. An isolated mith built from genuinely new media is only the recipe stage, never an ITL handoff. Existing exclusive media/output files are reused read-only, not regenerated.

File provenance pins now reject booleans/noncanonical SHA/incorrect numeric types, and compare the opened file as well as its pathname before/after the bounded read. HFS values flooring to reserved zero are refused. Independent raw/rate evidence remains in the dates sample-rate finding; AAC decoded60416 differs from raw60000, reinforcing that f4 is not a universal decoded-frame field.


## Stage2-02 helper review regression boundary

The pinned review tested constructor `10b228fecf03ecc5028a5343535762a7397714af`, not the later `cd7485813a9ef831cabe7f867255cbd6ec745209` checkpoint. Independent owned-file controls reproduce all three historical defects; no reviewer fixtures or media are modified.

- **MEDIA-01:** already fixed in cd748. One opened handle is checked against the pathname's pre-stat by device/inode/size/mtime before consuming bytes; handle state and exact read length are verified afterwards. The new tests use real deterministic A/B replacements, including equal size AND equal mtime with different identities, both with and without external pins. Normal reads, all three external provenance pins, and deliberately short real-handle reads remain covered. This is bounded snapshot checking, not a guarantee against every concurrent in-place writer without external provenance.
- **LOC-01:** classify every component's pre-extension stem with trailing ASCII spaces removed solely for reserved DOS-name detection. Never trim the returned pathname or silently redirect it. Path, URL, forged bundle and independently encoded 13/11 pairs refuse aliases, including aliases in intermediate components. Ordinary spaces remain literal. No device path is opened or stat'ed by these tests.
- **CONSTRUCT-01:** cd748 already refused the first positive subsecond. The helper now expresses both obligations explicitly: positive pre-quantization u32 time range, then nonzero encoded whole seconds. Both date slots refuse 1, 500000 and 999999 microseconds after the epoch; exact/ordinary positive dates remain valid. Negative, zero, naive and overflowing dates remain refused.

The 35 additive regression/normal cases preserve every existing test's bytes as a prefix. The red Location run is retained separately from the subsequent green run. See `reports/add-constructor/phase05/` for exact source pins, results and receipts.

This helper repair does not promote the diagnostic mith to a library-ready or native-accepted ITL. Aggregate-resource enforcement, media-source admission, complete-master checks, actual frozen reservations, auxiliary/item/unknown-pool closure and independent/native acceptance remain separate gates. No peer/core merge is implied.


## G2 resource admission (new work after exact recovery)

The immutable source recovery checkpoint is `f382a716793763b3e414f22776dcef8aa7558639`.
Its seven exact files and earlier reports/results remain historical evidence. This
new G2 change follows the parent-authorized read-only merge of codec
`66bdf7c9e9acad3158bbdd7096babde6ede23fd9` (four files). That recovery did not
recover three original codec test files and does not contain the new shared
`resources`/`validate_resources` extension. This helper change creates neither
that shared API nor a substitute allocation/resource reservation record.

### Admission estimates, not OS memory limits

The estimates below use lengths and bounded flat shapes **before** media parsing,
path open/read, URI conversion, metadata copying, JSON encoding, or record/header
construction. A fixed64KiB helper workspace ensures that a memory budget of1 is
refused immediately. The shared `ReadLimits.check('memory', amount)` performs the
actual comparison. The owned helper converts `LimitError` into `MediaError` with
the original memory-budget message; this remains a `ValueError`. Helper-only
limit dictionaries use the real `ReadLimits` constructor; unknown fields, bool,
float,0,negative or non-integer limits refuse. Declaration/engine boundaries still
require exact `ReadLimits` or None, rejecting dictionaries and subclasses.

For media length `N`, the probe policy is:

```
K = min(max_nodes, max(0, (N - 12) // 8))
P(N) = 65536 + 16*N + 1024*K
```

This reserves input/buffer/parser/hash copies and conservatively possible
8-byte-framed chunk bookkeeping. PCM still checks its actual chunk count before
adding entries. Optional parser tag keys must be strings, with bounded count and
aggregate characters before sorting/UTF8 copies; those copies add
`16*characters + 256*key_count` to the probe estimate. Valid large inputs can be
rejected even below max_file_bytes. This is a conservative admission heuristic,
not a sandbox or a proven upper bound on third-party parser/internal callbacks,
interpreter memory, arbitrary concurrent writers, or process/aggregate RSS.

`probe_file` checks the workspace before path conversion, then reserves
`65536 + 16*path_characters` before constructing Path. After a regular-file stat,
`P(stat_size + 1) + 16*path_characters` must fit **before opening**. It keeps all
MEDIA-01 device/inode/size/mtime checks on one actual handle. The read requests
only `opened.st_size + 1`, rather than max_file_bytes+1: the extra byte detects
growth without allocating a cap-sized read for a tiny file. Exact read length,
post-fstat, pathname identity and external SHA/size/mtime pins remain mandatory.

For a constructor description, let `T` be total key/string-value characters in
at most14 flat metadata fields, `L` raw Location characters, `D` the total input
ISO-date characters (or96 per datetime), and `S` Name characters:

```
M = 65536 + 256*metadata_fields + 32*T
B = 756 + 4*40 + 16 + 4*S + 16*L + 16
E = P(media_size) + M + 32*(16*L + 16 + D) + 8*B
```

M is also enforced by standalone validate_metadata before its copies. E covers
simultaneous media workspace, metadata/JSON, conservative UTF16/percent-URI
expansion and record-copy pressure before the first probe or Location builder.
The exact ASCII aggregate child-text budget is checked again before encoding
children; the original post-encoding check remains too. Prepare also reserves
12*target_wire_bytes and32*claimed-media-text characters before JSON copying,
and rejects oversized/nested/incorrectly typed claimed-media shapes first.
The real target reader retains its own separate model/decompression checks.

### New verification and still-blocked stages

New red precedes these production edits. New green, owned and full regression
runs use separate exclusive logs, temporary paths, exact source/dependency pins
and measured one-process peaks. The roots are explicitly
NativeROOT=`R2/baseline/evidence/native/snapshots`,
REPORTS=`R2/baseline/evidence/native/oracles`, and
FRESH=`R2/recovered/checkpoint-01/native-snapshots`.
Tests only read archived synthetic ITLs/oracles; they do not run native software
or create a native oracle. The fixed G2 recovery, all old tests, the new red and
prior failures are retained. G2 phase02 reports, not older stage reports, carry
the actual newly executed outcomes.

A successful helper budget check is not aggregate whole-engine resource
qualification or an OS RSS guarantee. Shared resources integration, media-source
and complete-master admission, actual frozen reservations, auxiliary/item and
unknown-pool closure, and independent/native acceptance remain real gates.
DOS space-alias classification and both HFS pre-quantization/encoded-nonzero
checks are unchanged. No template fallback, donor relabeling, unchecked ledger,
full candidate, apply, publication or native writer acceptance is introduced.
A media mith record remains diagnostic recipe data, never a complete ITL.
