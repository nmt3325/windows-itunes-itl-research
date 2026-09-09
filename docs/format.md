# Windows ITL format and supported codec behavior

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

Native counter differentials establish that 0x60 and 0x118 do **not** change when COM changes PlayedCount/SkippedCount. They are exposed read-only as `play_count_aux_raw`/`skip_count_aux_raw`, not overwritten as supposed mirrors. Native unrated WAV fixtures have bytes `00 01 00 00` at 0x6c, proving that a u32 rating getter would incorrectly return 256. The adjacent byte is exposed as `rating_aux_raw` and preserved. The 0x14 value is 1 even for synthetic WAV files with no embedded artwork; an artwork-count interpretation is not certified.

The native writer stores +0x2bc and +0x2bf as independent bytes. The previous u32 mask 0x02000000 did preserve adjacent bytes on LE; no corruption was reproduced for that mask. Access is now explicitly one-byte at +0x2bf with mask 0x02. The rest of that byte and +0x2bc/+0x2bd/+0x2be remain unchanged. The legacy loved name is not a claim that all loved/disliked state has been dynamically verified.

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

The initial static phase-2 census found 131 URL occurrences across 46 repeated snapshots but only 3 distinct URL payloads: all local FILE/encoding-2 ASCII, without percent escapes or non-ASCII bytes. This corroborates that narrow reading subset, not every URL/media profile or the new-URL writer's full application semantics. Dedicated URL decoding and global string-ID/shared-index alias behavior are under separate investigation; no new alias maintenance is claimed in the compatibility phase.

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

`Library.persistent_id` and summary `file_persistent_id` refer to the hdfm header identity. COM LibraryPlaylist identity is **different**: summary `library_persistent_id` is the master playlist persistent ID. Native validation must compare the right identity, not mistake that difference for fallback.

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
