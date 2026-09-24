# Windows iTunes ITL format specification

**Status:** canonical, evidence-bounded specification for this repository. It is **not** a claim of complete or universal ITL support.

**Audit basis:** repository commit `82c10a7ada3e4ee829f222e22d0c2848d9179d79`. Claims are limited by [SCOPE.md](SCOPE.md), version qualification by [VERSION_MATRIX.md](VERSION_MATRIX.md), implementation model by [ITL_DATA_MODEL.md](ITL_DATA_MODEL.md), record catalog by [ITL_RECORD_TYPES.md](ITL_RECORD_TYPES.md), evidence traceability by [EVIDENCE.md](EVIDENCE.md), and open work by [UNRESOLVED.md](UNRESOLVED.md).

## Normative status vocabulary

- **Native-qualified:** an exact, hash-pinned candidate passed the stated real-iTunes gate. Qualification does not generalize to other files.
- **Offline-verified:** implementation and fixtures passed repeatable tests without launching iTunes.
- **Implemented, guarded:** code exists only for the named profile and refuses unknown dependencies.
- **Observed:** evidence supports a bounded description, but the repository does not offer a general semantic writer.
- **Opaque/preserved:** bytes are retained without claiming their meaning.
- **Unresolved:** evidence or implementation is insufficient; no behavior should be inferred.

The words **MUST**, **MUST NOT**, **SHOULD**, and **MAY** below describe this implementation's supported profile, not Apple's complete private format.

## Scope and evidence levels

This implementation is independent Python code. Its target is the observed standalone Windows iTunes 12.13.9.1 and 12.13.10.3 envelope, not Apple Music's other databases, Store-specific behavior, or every historical ITL version. Original samples are never included in the source or modified by tests. Native fixtures and application-level acceptance evidence live in the dynamic report.

Three different claims must not be confused:

1. **Byte preservation:** every input byte (including opaque data) is retained, and an unchanged object returns the original file exactly.
2. **Structural reconstruction:** fresh encoding is performed according to the compression/encryption flags; a separately decoded result has the intended decompressed bytes, lengths, counts and known references.
3. **Native/semantic acceptance:** actual iTunes loads the result without a silent new-library fallback, reports the expected persistent identities/values, and preserves them after save/reload. This requires the dynamic harness, not `itlkit check`.

Neither opaque-byte preservation nor selected-fixture success means that every field is understood. **Full semantic support is not claimed.**

## Container (`hdfm`)

All offsets below are relative to the specified record, not absolute file offsets.

| Offset | Width | Meaning |
| --- | --- | --- |
| 0x00 | 4 | ASCII `hdfm` |
| 0x04 | u32 BE | outer header size (observed 144) |
| 0x08 | u32 BE | complete compressed/encrypted file size |
| 0x10 | u8 + bytes | Pascal version string: length byte followed by ASCII; not a C string starting at 0x10 |
| 0x30 | u32 BE | section count |
| 0x34 | u64 BE | file/header persistent ID, distinct from COM LibraryPlaylist identity |
| 0x41 | u8 | encryption enum: 0 none, 1 full body, 2 capped prefix; other values rejected |
| 0x43 | u8 | compression Boolean: 0 raw, any nonzero value zlib |
| 0x44 | u32 BE | main track count |
| 0x48 | u32 BE | main playlist count |
| 0x4c | u32 BE | album count |
| 0x52 | u8 | payload byte order: 0 big-endian, any nonzero value little-endian |
| 0x54 | u32 BE | artist count |
| 0x5c | u32 BE | cap for encryption flag 2 only; cap 0 selects no encrypted bytes |

Other header bytes are copied, not zero-filled. A valid supported header must be at least 0x60 bytes and contained in the input. Strict reads reject a mismatched outer size. The lower-level container reader has an explicit `strict_size=False` forensic option; it does not repair data silently.

The actual iTunes 12.13.10.3 reader/AES instruction audit corrects the earlier cap-only hypothesis. Let B be the stored body after optional compression (including any zlib trailer). The selected interval is 0 for encryption flag 0, len(B) for flag 1 (ignoring cap), and min(len(B), cap) for flag 2. **Only after selection** is the encrypted size rounded down to a complete 16-byte boundary: `E = interval // 16 * 16`. Thus flag 2/cap 0 encrypts zero bytes; cap 17 encrypts up to 16 bytes. A nonaligned cap is valid. `crypt_length(body_length, limit, encryption_flag=2)` implements this rule in both directions. Unknown encryption flags fail with UnsupportedError, including during raw JSON import and reconstruction.

The prefix is AES-128-ECB with `BHUILuilfghuila3`; the rest is unchanged clear data. No PKCS padding is added or removed. For the normal flag-2/cap-102400 profile, all bytes after 102400 stay clear, even for large bodies. Flag 1 instead encrypts all full blocks. Boolean compression/endian bytes use the native zero/nonzero rule, not an invented closed enum.

When compression is nonzero, the decrypted stream is zlib/DEFLATE with checksum and end marker validation. Compression 0 means the decrypted bytes themselves are the payload; a valid-looking nested zlib stream is not implicitly inflated. Both branches enforce the configurable plaintext budget (default 512 MiB). Bytes after a compressed stream are preserved as an opaque trailer; semantic writes with an unknown trailer are refused. An uncompressed body has no identifiable trailer boundary: raw reconstruction rejects a separate nonempty trailer rather than silently reclassifying it. A caller may explicitly merge such bytes into payload when doing low-level research.

`Container` exposes encryption_flag, compression_flag, payload_byteorder and validate_header(). Raw Container read/rebuild/JSON can preserve big-endian payload bytes opaquely. **Library is LE-only:** a zero +0x52 byte is refused before section parsing, at semantic edit guards, and at reconstruction, including contradictory files with an LE body but a BE flag. Node/parse_sections are explicitly LE record primitives, not an auto-endian parser. This separation does not claim decoded BE semantics. Compression level remains 6 by default; native level 1 is an observed writer choice, not a read-compatibility requirement.

## Sections and record model

The observed decompressed payload is a sequence of `msdh` sections. `msdh+4` is its LE header length (observed 96), `+8` is total section size, `+12` is section type. The parser advances by validated section sizes. It never searches the payload for strings such as `mith` or `miph`.

| Section type | Known root / interpretation |
| --- | --- |
| 16 | `mfdh`, fixed main header |
| 12 | `mhgh`, global metadata header followed by data objects |
| 9 | `mlah` album list, `miah` album records |
| 11 | `mlih` artist list, `miih` artist records |
| 1 | `mlth` main track list, `mith` records |
| 13 | second `mlth` list, kept separate; not reported as main tracks |
| 2 | `mlph` main playlist list, `miph` records |
| 14 | second `mlph` list, kept separate |
| 20 | `mlqh` with separate metadata and `miqh` counts; queue/history semantics unresolved |
| 21 | `mlsh`, framed `msph` records (payload opaque) |
| 15 | `mlrh`, fixed-size `mprh` records (`+8` is NOT their byte length) |
| 4 | opaque location bytes |
| 22 | opaque bytes |
| 23 | opaque `stsh` section, index semantics unresolved |
| any other type | complete opaque body retained inside a validated `msdh` boundary |

**Important corrections to earlier hypotheses:** `mlih` is not the track list. For list roots and `mhgh`, the u32 at `+8` is a **count**, not a total byte length. In `mith`, `+0x0c` is the child object count, not an arbitrary flags word. `mfdh+8` is the logical uncompressed length **including the outer header** (`len(payload) + outer_header_size`), not the length of just its section or children.

Most item/data records use `(fourcc, header_length u32 LE, total_length u32 LE)`. Known container records expose child records; unknown framed items keep an opaque body and are never recursively scanned. `miph+12` counts mhoh objects and `+16` counts mtph items. `mlqh+12` and `+16` count mhoh and miqh respectively. Header extension bytes and opaque record/section contents survive serialization.

The `Node` model stores the full raw header, either child nodes or an opaque payload, the framing kind, and the original byte offset (informational, not a mutable pointer). Serialization recalculates the known lengths/counts. Record nesting is bounded. Unknown section internals are intentionally not validated as records. A structurally malformed supplied file remains available through `Container` but is rejected by `Library`; no `.find`-based salvage is presented as a valid parse.

## Track values (`mith`, observed header length 756)

All values here are unsigned LE integers. Values not covered by this table remain raw bytes. Semantic writes require the observed 756-byte profile; shorter/other versions can be preserved but are not guessed.

| Field | Offset | Bytes | Write policy |
| --- | --- | --- | --- |
| track_id | 0x10 | 4 | identity; read only |
| record_kind_raw | 0x14 | 4 | unknown/record-kind candidate; NOT a confirmed artwork count |
| date_modified | 0x20 | 4 | raw HFS local wall-time value |
| file_size | 0x24 | 4 | uint32 only; no claim of >4 GiB size support |
| total_time | 0x28 | 4 | milliseconds |
| track_number / track_count | 0x2c / 0x30 | 4 each | uint32 |
| year / bit_rate | 0x34 / 0x38 | 4 each | uint32 |
| play_count | 0x4c | 4 | updates only this independently verified main counter |
| play_date | 0x64 | 4 | raw HFS local wall time |
| disc_number / disc_count | 0x68 / 0x6a | 2 each | uint16 |
| rating | 0x6c | 1 | integer 0..100; adjacent byte 0x6d is independent state, not rating bits |
| date_added | 0x78 | 4 | raw HFS local wall time |
| persistent_id | 0x80 | 8 | identity; read only |
| skip_count | 0xd8 | 4 | updates only this independently verified main counter |
| album_id | 0xdc | 4 | dependency; read only |
| skip_date | 0x11c | 4 | raw HFS local wall time |
| artist_id | 0x1e0 | 4 | dependency; read only |
| sample_rate | 0xf4 | 4 | read only; native WAV value agrees with the separate float at 0x98 |
| compilation | 0x50 | 4 | read only, bit 0x01000000; grouping side effects are not guessed |
| loved | 0x2bf | 1 | legacy API label; toggles bit 0x02 only; full UI semantics remain unverified |

Native counter differentials establish that 0x60 and 0x118 do **not** change when COM changes PlayedCount/SkippedCount. They are exposed read-only as `play_count_aux_raw`/`skip_count_aux_raw`, not overwritten as supposed mirrors. Native unrated WAV fixtures have bytes `00 01 00 00` at 0x6c, proving that a u32 rating getter would incorrectly return 256. The adjacent byte is exposed as `name_refresh_flag_raw`, with backward-compatible raw alias `rating_aux_raw`; it is not RatingKind or Unplayed. The verified Name-edit exception is described below. The 0x14 value is 1 even for synthetic WAV files with no embedded artwork; an artwork-count interpretation is not certified.

The native writer stores +0x2bc and +0x2bf as independent bytes. The previous u32 mask 0x02000000 did preserve adjacent bytes on LE; no corruption was reproduced for that mask. Access is now explicitly one-byte at +0x2bf with mask 0x02. The rest of that byte and +0x2bc/+0x2bd/+0x2be remain unchanged. The legacy loved name is not a claim that all loved/disliked state has been dynamically verified.

A [2026-09-25 bounded native ladder](evidence/research/20260925/native-rating-kind/README.md) confirms `mith+0x6c` as the exact one-byte Rating value for 20/40/60/80/100 in one pinned one-track profile. The native same-value save and following verification restart left the targeted 756-byte header unchanged even though whole encrypted ITL hashes changed. On this iTunes build, COM `RatingKind` was get-only and projected 1 for rating 0 and 0 after nonzero Rating setters; `AlbumRatingKind` remained 1. `Loved`/`Disliked` were unavailable through the inspected interface, while +0x2bf bit 0x02 remained clear. These facts do not identify an on-disk RatingKind field, certify Loved/Disliked UI semantics, or generalize beyond this profile.

Date helpers require explicit timezones. `hfs_from_datetime` requires an aware datetime and encodes the supplied local wall time; `hfs_to_datetime` requires a caller-specified UTC offset. Zero is treated as unset. Timezone and historical daylight-saving transitions are not inferred from the runner.

### String data objects (`mhoh`)

The type code is at header+12. Observed string headers are 24 bytes. Their body begins with `encoding u32 LE`, `byte_length u32 LE`, eight preserved bytes, then exactly byte_length bytes of string data. An optional suffix is preserved; resizing with an unknown suffix is refused. Encoding 1 is UTF-16LE within the LE-only model. **Encoding 3 is Latin-1-equivalent byte zero-extension, not UTF-8**: 43 61 66 e9 reads Café, ff reads ÿ, and c3 a9 reads U+00C3 U+00A9. Encoding 2 is provisionally interpreted only for type-11 ASCII URL objects; non-ASCII encoding-2 data and encoding 2 on other types remain opaque and semantic access is refused. This is not a global encoding-2 definition. Reads are strict: invalid text is reported, not replaced with U+FFFD or silently stripped of NULs. Text writes reject NULs. Non-ASCII display text is written as UTF-16LE; URLs must be ASCII with caller-supplied percent encoding. No normalization or character loss is applied.

| Code | Field | Current high-level policy |
| --- | --- | --- |
| 2 | name | read/write |
| 3 | album | read/write with guarded local-WAV album/artist dependency maintenance |
| 4 | artist | read/write with guarded local-WAV album/artist dependency maintenance |
| 5 | genre | read/write; can create absent field |
| 6 | kind | derived; read only |
| 8 | comment | read/write; independently confirmed by native one-field fixture |
| 11 | url | provisional ASCII URL subset; changes refused when an opaque type-1 location object is present |
| 12 | composer | read/write |
| 13 | path | changes refused with an opaque type-1 location object; physical relocation is NOT performed |
| 27 | album_artist | read/write with guarded local-WAV album/artist dependency maintenance |
| 30,31,32,33 | sort_name, sort_album, sort_artist, sort_album_artist | read/write |
| 60 | purchaser_name | read only |

The native ordinary text writer can shrink short UTF-16 strings whose code units are all <=255 into encoding 3. Codec non-ASCII writes may instead retain valid UTF-16LE; native small-string optimization is not required for meaning preservation. Types 1, 0x13 and 0x42 use direct binary payloads rather than the text prefix and are rejected by the text helpers. Encoding 0 is an unimplemented legacy/codepage path, not guessed Unicode. Raw bytes for unsupported representations remain lossless.

The initial static phase-2 census found 131 URL occurrences across 46 repeated snapshots but only 3 distinct URL payloads: all local FILE/encoding-2 ASCII, without percent escapes or non-ASCII bytes. This corroborates that narrow reading subset, not every URL/media profile or the new-URL writer's full application semantics. Dedicated URL decoding and general string-ID allocation/shared-index COW remain incomplete. The phase-4 guards below reject detected unsafe aliases; they do not implement a general allocator or certify all pool consumers.

Absent text is `None`, not an empty string. Duplicate named string objects are ambiguous and refused by semantic getters/writers. Missing supported text can be added while updating mhoh length, mith length/child count, msdh size, mfdh logical size and hdfm compressed size.

## Playlists and guarded structural writes

Observed `miph` headers are 3500 bytes. Type-100 mhoh is the name. Persistent ID is at miph+0x1b8; current local ID at +0xd40. A playlist's mtph child sequence is **physical membership order**, not necessarily its displayed sort order. Native ordinary/manual playlists agree with this order; master/system playlists can auto-sort by title while their stored mtph sequence remains unchanged.

Native `mtph` records have header/total size 84. Offset +0x18 is the local track reference, +0x10 is the current local item ID, +0x20 is a persistent creation/order token, and +0x44 is the item persistent ID. Native reopen can renumber +0x10 while +0x20 remains unchanged. These fields must not be treated as unconditional mirrors. Unknown bytes in retained entries remain intact.

Ordinary playlist rename, create, delete and membership/order replacement are implemented. Smart/system/master playlists cannot be renamed or deleted by these APIs. A supported ordinary playlist has no master flag, smart-rule objects 101/102, special type-103 object, or nonzero special-kind word at +0x238. Structural writes additionally verify the observed ordinary header/nonzero-state profile, metadata [100,105,105,108] (view records 1244/1244/220 bytes), and item layout. Unsupported extensions fail closed.

`replace_playlist_members(pid, track_persistent_ids)` replaces the entries transactionally in the requested order, including duplicate track references when supplied. It intentionally creates fresh item IDs/PIDs/tokens (matching the observed native remove/re-add pattern), not a lossless in-place permutation of the old item identities. Old item IDs with possible outside references cause refusal. Track persistent identities do not change.

`create_playlist` copies native view objects from an ordinary template, or from the unique master if no ordinary playlist exists; it constructs the independently observed ordinary header, allocates new local/Persistent IDs, and updates enclosing counts and sizes. The optional `timestamp_hfs` is explicit. Without it, the template modification timestamp is reused; runner timezone/current time is not guessed. `delete_playlist` checks for possible external references before removing the record. Persistent-ID collision/reference byte checks are conservative safeguards, not tag-search parsing; false-positive refusals are possible.

All structural operations currently require version 12.13.10.3, the observed section set, empty secondary track/playlist lists, a 96-byte empty stsh profile, and only known global object types 503/508/517. Nonempty store indexes, history/queue sections, large type-514 settings, and other unknown dependency profiles are refused.

### Track restoration, deletion, and indexed text

`Library.add_track_from(donor, persistent_id)` restores a **complete existing native local WAV record** from another snapshot with the same hdfm file identity. It is not arbitrary media synthesis or a cross-library merge. The complete file-location object and URL are copied unchanged; no physical audio files are read, moved, or rewritten. Main/secondary local track IDs and album/artist local references are remapped. Associated index objects are copied with their Persistent IDs, or reused only when the same PID has equivalent content after ignoring its local ID. Conflicting same-PID records are refused.

Matching donor playlist definitions determine membership restoration. New entries are appended without reordering retained entries. Smart-rule byte differences, unmatched system/smart definitions, or unsupported item state cause refusal. New ordinary playlists absent from the donor are left untouched. Custom smart-playlist evaluation is not implemented.

`Library.delete_track(pid)` removes the track and all known mtph references. Only its now-orphaned album/artist objects are removed; unrelated preexisting orphan objects are not swept away. Remaining bytes are checked for possible references to the removed Persistent IDs. No partial transaction is committed on a refusal.

`Track.set(album=..., artist=..., album_artist=...)` now maintains dependencies within this same closed local-WAV profile. The local album/artist IDs are at mith+0xdc/+0x1e0; the secondary local track ID is at +0x1f4. Album miah headers are 88 bytes, artist miih headers 100 bytes; local IDs are at +16 and u64 Persistent IDs at +20. Album text objects 300/301/302 represent album/effective artist/explicit album artist, while artist text 400 holds the effective artist. The effective artist uses explicit album artist when present, otherwise track artist. Equal named objects can be reused; changed objects get fresh identities; old objects are removed only if unreferenced. Native blank objects are not indiscriminately deduplicated. Unknown index extensions, non-WAV media, and compilation grouping without explicit album artist are refused. Broad store/cloud/DRM/compilation semantics remain unsupported.

These writers and their structural roundtrips are implemented and tested; **application acceptance is per output case**, recorded separately by the dynamic harness. A header profile observed in native files does not alone certify every generated combination.

## API and CLI

```python
from itlkit import Library, Container
lib = Library.read('input.itl')
assert lib.to_bytes() == open('input.itl', 'rb').read()
rebuilt = lib.to_bytes(rebuild=True)  # actual new zlib + partial AES
lib.track(persistent_id='0123456789ABCDEF').set(name='New title', rating=80)
lib.write('new-output.itl')          # exclusive output creation
```

`Library.persistent_id` and summary `file_persistent_id` refer to the hdfm header identity. COM LibraryPlaylist identity is **different**: summary `library_persistent_id` is the master playlist persistent ID. Native validation must compare the right identity, not mistake that difference for fallback. Fresh `AddFile` libraries in the corrected media-backed follow-ups retained unequal, stable outer/master PIDs while the serialized master selected by COM PID held the exact track PID; equality remains only an exact-fixture construction rule.

Native `Lyrics` behavior is not currently an ITL-only write rule. Three exact WAV-backed setters failed, while 17 exact MP3-backed cases survived mutation and restart: the original short ASCII value, one 16-code-point Unicode value, and discrete tested ASCII lengths from 255 up to 16,777,209. A separate 14-case generated-ASCII ceiling cohort passed at 131,072, 1,048,576, 8,388,608, 16,777,208, and 16,777,209 characters, then produced nine qualified native non-exact immediate readbacks at 16,777,210–16,777,216, 17,000,000, and a repeated 16,777,210, with zero harness failures. Every non-exact setter rewrote its MP3 after successful initialization and baseline restart; verification restart was deliberately withheld by the failed exact readback gate, while normal exit, no-fallback, and cleanup gates still passed. Formal adjacent analyses found one encoding-0 ID3v2.2 `ULT` plus 10,240 zero-padding bytes and a complete byte-identical MPEG tail in both retained outputs. The 16,777,209-byte text makes a 16,777,215-byte payload stored conformingly as `0xFFFFFF`; the next 16,777,210-byte text makes a 16,777,216-byte payload stored nonconformantly as `0x000000` modulo 2^24, and the ordinary strict parser rejects it. In three reset-ITL probes on one retained track, stable COM Lyrics followed original, stripped, and equal-length conflicting `ULT` inputs. These are bounded media/tag/interface/build observations, not a universal `Lyrics` limit or authority rule. UI behavior, direct-file behavior, broader Unicode, other tag/media shapes, other versions, hidden caches, and independent reproduction remain unknown. The writer exposes no generic Lyrics mutation and must fail closed.

`python -m itlkit --help` documents `inspect`, `check`, `roundtrip`, `export-json`, `import-json`, `patch`, `import-track`, `decode`, and `encode`. The `itlkit.__main__.main(argv=None)` function returns 0 or 2. argparse usage/help retains standard SystemExit behavior. No command modifies an existing output: creation is exclusive, protecting original files and aliases/hard links. Parent directories must exist.

`check` proves exact no-op and independently decoded forced reconstruction only. It explicitly reports native acceptance as untested. `decode` is the low-level escape hatch for structurally damaged files. `encode` packs a raw payload with the supplied template header and performs structural library validation; it does not certify arbitrary raw semantic edits.

### Lossless JSON

`itlkit.library.v1` contains a container record with complete header/payload/trailer bytes and original compressed bytes/digest, a readable raw section tree, and an `operations` array. The original baseline is required and checked; arbitrary raw JSON modifications are refused at this high level. `operations` may contain `set_track`, `rename_playlist`, `create_playlist`, `delete_playlist`, `replace_playlist_members`, or `delete_track` requests, for example:

```json
[{"op":"set_track","persistent_id":"0123456789ABCDEF","fields":{"name":"New title","rating":80}}]
```

An unmodified export/import roundtrip is bit-exact. Operation lists are transactional and unknown keys are rejected. Persistent IDs accept nonzero uint64 integers or exactly 16 hexadecimal digits (an optional 0x prefix is allowed). Local track selectors are strictly nonzero uint32, not booleans. After library-wide transactions, reselect Track/Playlist handles by Persistent ID; stale mutation handles are explicitly refused instead of silently losing edits. The separate `Container.to_dict/from_dict` low-level API permits raw reconstruction, but does not promise semantic safety or acceptance. Exporting a library can expose private metadata and opaque data; do not publish original-user JSON as a fixture.

## Known gaps and validation boundaries

- Original samples include malformed previously edited files. Their container encryption can be valid while their section framing is invalid. They are not silently repaired or counted as valid library roundtrips.
- No original copyrighted media, account information, library artwork or Apple binaries are embedded in tests.
- Unknown fields, smart rules, store/cloud state, queue/history, full album/artist relations, and all format generations are not fully decoded.
- Structural validation does not establish all text or application-level invariants. Summary extraction reports individual unrecognized/invalid fields explicitly.
- Native validation must compare library/track/playlist persistent IDs and values across two reopen/save cycles; an empty library with a new identity is failure, not success.

### Additional API examples (profile guards apply)

```python
p = lib.create_playlist('Manual 日本語', track_persistent_ids=[track_pid])
p.replace_members([track_pid, other_track_pid])
lib.delete_playlist(p.persistent_id)
lib.add_track_from(Library.read('earlier-snapshot.itl'), missing_track_pid)
lib.delete_track(unwanted_track_pid)
lib.track(persistent_id=track_pid).set(artist='Artist', album='Album', album_artist='Group')
lib.write('edited-copy.itl')
```

The equivalent restoration CLI is `python -m itlkit import-track INPUT DONOR HEX16 NEW_OUTPUT`. Other structural operations are available through the transactional `patch` operations array.

## Review hardening: validation, retained state and publication

`Library` verifies both outer hdfm+0x30 and inner mfdh+0x30 against the parsed section count. For the observed record sizes, secondary track IDs, album PIDs, artist PIDs and playlist local IDs must each be nonzero and unique within their own namespace. Item local IDs and PIDs must be nonzero and unique within each playlist. These are not a global string-atom namespace or a rule equating current item IDs with order tokens. Ambiguous same-PID auxiliary imports are refused before selecting any record, including equivalent-first/conflicting-later duplicates. The lower-level `Container` remains the opaque forensic route for invalid semantic identities.

Album/artist edits, reuse and orphan collection reject unknown text-header/prefix extensions or trailing suffixes, including on clear-to-empty. Equal text keys do not justify discarding distinct retained album-header state. Raw reads and no-op serialization still preserve these bytes. Stale Playlist.replace_members handles are rejected by current node identity, even after deleting and recreating a different playlist with the same PID.

Reference checks cover all retained bytes, including the outer header, playlist-section/list headers and metadata retained during membership replacement. They omit only removed record spans and known independent self-identity fields at verified header sizes. Same-kind identity aliases remain conservatively visible. Ignored spans are not concatenated, so the scan does not invent adjacent bytes. Matching opaque bytes remain a reason to refuse; these checks do not claim to decode all references.

HFS conversion uses arithmetic from the 1904 wall-time epoch, not platform C-runtime timestamps. Values 1 through uint32 maximum therefore decode on Windows, including early 1904 dates. Zero remains unset; an explicit offset is still required and historical timezone rules are not inferred.

### Exclusive atomic output publication

All output commands use a new sibling temporary file. Bytes are written in full, flushed, fsynced and the stream closed **before** a hard-link publication step. The link operation cannot replace an existing destination, including a racing writer's file or an existing alias. A filesystem without the required hard-link support fails closed: there is no overwriting-rename fallback. Parent directories must exist and be trusted against hostile concurrent replacement.

Before publication, write/flush/sync/close/link failures leave the destination absent (or leave a preexisting/racing destination unchanged). Temporary-file cleanup is attempted. If cleanup also fails, the primary error records the temporary path. After the publication commit, a cleanup error explicitly says that a **complete output was published**; that destination is not deleted. Do not blindly retry or interpret every error as proof that no destination exists. A process crash can leave a temporary file or a complete published destination. File fsync is not a guarantee of power-loss durability for directory entries or every network filesystem. No partial file is intentionally exposed at the final output name.

### Native fixture coverage is not a single pass count

Structural byte-exact/forced-reconstruction tests and COM concordance tests are separate. A fixture without an after-state COM oracle is explicitly skipped only in the COM test; its structural test still runs. The frozen review cohort contains 55 structural fixtures and 50 COM after-states. The five structural-only fixtures are not called COM successes.

COM checks require complete, unique track enumeration matching both the declared count and file identity set, all selected captured fields, valid membership enumeration, and coverage of every modeled ordinary/master playlist. Extra ordinary playlists or empty/truncated oracle arrays cannot silently pass. Raw nonplain/system playlists that COM does not expose are reported as unrepresented scope, not falsely equated with the COM collection. In the frozen cohort seven such raw playlists per oracle are unrepresented; these bytes and all other unasserted fields are not certified by the selected-field comparison. Offline agreement still does not constitute a new native launch/save test.

## Phase 4: Name persistence, explicit Unplayed and scoped refusal

The exact Windows 12.13.10.3 reader/writer maps **mith+0x6d bit0 to common-track+0x9a bit4**. Missing-Name/path-derived fallback sets this state; a selected nonempty Name update clears it. Rating is separate at common-track+0x104. The narrowly supported interpretation is path/default-title refresh, not RatingKind or Unplayed. In the eight native A/B/C cases, all four A=0 candidates lost the edited Name and all four A=1 candidates retained it after two saved reloads. A changed only +0x6d; B changed the title atom ID and C cleared +0x290. B or C alone did not fix the rollback. No native application was launched by the codec implementer; saved artifacts and dynamic-owner COM results were independently hash-checked.

`Track.set(name=nonempty_new_text)` now clears only +0x6d bit0 for the observed 12.13.10.3/756-byte profile. Same-value and empty-name requests do not trigger this correction. Other bits, +0x290 and the remaining rank/cache words, rating, played state and unrelated objects remain untouched. Native canonical 0/1 cases are the dynamic evidence; preservation tests for other raw bit patterns are not native certifications. The older 12.13.9.1 profile does not receive this newly inferred state correction. Empty/missing Name fallback, complete metadata callback behavior, and general sort-rank regeneration remain unresolved.

**Unplayed is independent.** Wire +0xee bit0 maps to common-track+0x9e bit2. A second native control pair differed only at alpha mith+0xee, 0 versus 1; both had PlayedCount=7 and Name-refresh=0. In both saved cycles, COM Unplayed was respectively true and false. The explicit API is `track.get('unplayed')` and `track.set(unplayed=True/False)` for 12.13.10.3/756-byte records. The write toggles only the low bit of +0xee, preserving upper bits and all counters/dates. `played_flag_raw` is read-only. Values other than booleans are refused. Older profiles keep raw access but reject this semantic getter/setter.

Changing play_count remains a scalar edit, not a simulated playback event or a complete implementation of the COM PlayedCount setter. It never mechanically infers Unplayed, resets dates, or changes Name. A caller that wants both values must request both explicitly, for example `track.set(play_count=7, unplayed=False)`. The selected-field COM regression now also asserts Unplayed; raw 6d is never used as its oracle.

### Known pool guards, not COW support

The semantic writers distinguish qualified known pools: track Name; album plus miah-300; artist/composer/album-artist plus miah-301/302 and miih-400; genre; comment; sort Name; sort Album; and shared sort Artist/AlbumArtist/Composer plus miih-401. File-local URL/path and playlist-local names are not falsely grouped into these global domains. Equal integers in different pools are valid. The scanner follows parsed owner/child boundaries, not byte-tag searching.

Before a text update, known nonempty positive-ID bindings must be consistent. If an unchanged known consumer shares the identity, replacements disagree, or an unkeyed addition would enter a populated explicit-ID domain, the operation refuses rather than zeroing, inventing huge IDs, or silently using the first string. Indexed edits also refuse changing an album/artist object used by another track. Same-lineage restoration checks known bindings after the candidate import and before committing it. Reusing the supported same-key index object is not general shared-object COW.

These are intentionally conservative guards. Some combinations of simultaneously changed shared fields can be refused even when a more complete native allocator might implement them. Unknown pools, complete callback/ownership semantics, reference-only encodings and general cross-library allocation remain unsupported. Raw Container/Node research access still preserves bytes and is not upgraded into a semantic-safety guarantee by these guards.


## Phase 5: fail-closed epoch and playlist boundaries

`hfs_from_datetime` keeps its aware, displayed-wall-time policy. It now checks the exact signed timedelta interval `[0, 2**32 seconds)` before quantization, then uses integer days/seconds instead of a float. Negative subsecond dates cannot become raw0. Nonnegative fractions still truncate to the earlier whole wall second; epoch/raw0 remains the existing unset ambiguity. No new timezone/DST/fold policy is implied.

Track structural/index operations preflight every primary playlist, including retained items unrelated to the selected track. Only the admitted 3500-byte playlist header and flat, recognized 84-byte item profile are accepted; grouped/nested, extended, opaque-payload or unknown-state item shapes are refused before changes. Raw parsing/no-op preservation and unrelated scalar editing are not promoted to recursive-semantic support.

Same-lineage restoration now requires the non-ordinary system/master definition PID sets to agree, and matches master/plain/smart classification, exact special-kind value and existing opaque 101/102/103 rule signatures before allocation. No unknown rule or kind is zeroed or interpreted. Unmatched ordinary definitions keep the earlier leave/ignore policy. Existing source/target transactions, same-lineage restriction, COW and reference guards remain in force. These are refusal fixes; they do not implement recursive playlists, arbitrary system rules or cross-library importing.

## 2026-09-22 exact from-scratch fixture profile

**Status:** native-qualified only for the two exact hashes below on standalone Windows x64 iTunes 12.13.10.3. This is not a general-format acceptance claim.

| Fixture | Bytes | Compression | Encryption | Cap | SHA-256 |
| --- | ---: | ---: | ---: | ---: | --- |
| raw | 10,566 | 0 | 0 | 0 | `c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74` |
| zlib | 775 | 1 | 2 | 102400 | `25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad` |

Both are built by [`TEST_CORPUS/generate.py`](TEST_CORPUS/generate.py) from explicit constants and logical values. No native ITL header, record blob, section, or template is read during construction. The admitted payload has section order `16, 12, 9, 11, 1, 13, 23, 2, 14, 4` and declared counts `(sections=10, tracks=1, playlists=2, albums=1, artists=1)`. Section 23 is a 96-byte `stsh` object; section 4 is the profile media-folder file URL. Section 21 was not required by these minimal accepted candidates.

The current construction uses a 144-byte outer `hdfm`, a 144-byte `mfdh`, a 280-byte `mhgh`, 88-byte `miah`, 100-byte `miih`, 756-byte `mith`, and 3500-byte `miph`. `miph+0x0c` is the count of metadata objects only; `mtph` items are counted separately at `+0x10`. The master `miph` and ordinary `miph` each contain one name object and one membership item. The generated master playlist PID equals the outer/file PID `5245464552454E43`, and both master and ordinary playlists reference track PID `A17E000000000001`.

The strict harness started each profile with only the candidate ITL, forbade XML, `Previous iTunes Libraries`, repair/rebuild/migration dialogs, identity fallback, and abnormal exit, and required two stable COM samples plus independent parsing after each save. Cycle 2 consumed the exact cycle-1 save. Results and hash chains are in [`evidence/native/reference-generated-20260922-passed/qualification-summary.json`](evidence/native/reference-generated-20260922-passed/qualification-summary.json).

Native save canonicalized both files, added system/smart playlists, and renumbered local/session IDs while retaining the tested library, track, custom-playlist, and membership persistent identities. Therefore only persistent identity and declared semantics are acceptance anchors; byte equality after native save is not expected. Constants whose user-visible semantics remain unknown are still unresolved, so this evidence closes the two-fixture generation gate but not the complete-analysis gate.
