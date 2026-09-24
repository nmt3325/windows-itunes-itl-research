# ITL data model and invariants

This document describes the implemented model. Binary offsets and encoding rules are normative in [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md); the compact tag catalog is in [`ITL_RECORD_TYPES.md`](ITL_RECORD_TYPES.md).

## Layered model

```text
file bytes
  └─ Container (hdfm header + decoded payload + optional compressed-stream trailer)
       └─ msdh sections
            └─ Node tree (known framed records or one opaque payload span)
                 └─ Library semantic view
                      ├─ Track (main section 1 / mith)
                      ├─ Playlist (main section 2 / miph)
                      ├─ album objects (section 9 / miah)
                      └─ artist objects (section 11 / miih)
```

### `Container`

Source: [`itlkit/container.py`](itlkit/container.py).

- Owns the complete `hdfm` header, decrypted/decompressed payload, optional bytes after a valid zlib stream, and the original input bytes.
- Returns the original bytes on an unchanged non-forced round trip.
- Rebuilds the declared body using the header's encryption/compression flags.
- Does not claim that its payload is a valid library.
- Preserves raw big-endian payloads opaquely; semantic parsing belongs to `Library` and is little-endian only.

### `Node`

Source: [`itlkit/model.py`](itlkit/model.py).

A node contains:

- full raw header bytes;
- framing kind (`total`, `section`, `count`, `fixed`, or `mixed`);
- either child nodes or one opaque payload, never both;
- original byte offset for diagnostics.

Serialization recalculates only modeled lengths and counts. Unknown section bodies remain single opaque spans. The parser never scans arbitrary payload bytes for apparent tags.

### `Library`

Source: [`itlkit/library.py`](itlkit/library.py).

`Library` requires a little-endian payload, parses sections, and validates:

- outer and inner section counts;
- `mfdh` logical size;
- outer/inner track, playlist, album, and artist counts;
- nonzero/unique modeled identities;
- track-to-album/artist references;
- playlist-item-to-track references.

It exposes semantic operations only after profile guards pass. `Container` remains the lower-level forensic path for payloads that fail library semantics.

## Identity domains

Identity values are not interchangeable merely because they have the same width.

| Domain | Record/offset | Width/order | Invariant |
| --- | --- | --- | --- |
| File/header persistent ID | `hdfm+0x34` | u64 BE | File lineage identity domain. The four exact accepted from-scratch fixtures intentionally give it the same value as the master playlist PID; fresh native libraries need not. |
| Master playlist persistent ID | `miph+0x1b8` | u64 LE | Reported by COM for the library playlist. It is a distinct field/domain. Equality with the file PID is an exact generated-fixture construction choice, not a universal native invariant. |
| Track local ID | `mith+0x10` | u32 LE | Nonzero and unique among main tracks. |
| Track persistent ID | `mith+0x80` | u64 LE | Nonzero and unique among main tracks. |
| Secondary track local ID | `mith+0x1f4` | u32 LE | Nonzero values must be unique. Zero is preserved for read/no-op on the four exact native-qualified template-free fixtures, but semantic/structural writes require nonzero values. |
| Album local ID | `miah+0x10` | u32 LE | Referenced from `mith+0xdc`; independent namespace. |
| Album persistent ID | `miah+0x14` | u64 LE | Nonzero/unique for the observed 88-byte profile. |
| Artist local ID | `miih+0x10` | u32 LE | Referenced from `mith+0x1e0`; independent namespace. |
| Artist persistent ID | `miih+0x14` | u64 LE | Nonzero/unique for the observed 100-byte profile. |
| Playlist local ID | `miph+0xd40` | u32 LE | Nonzero/unique for the observed 3500-byte profile. |
| Playlist persistent ID | `miph+0x1b8` | u64 LE | Nonzero/unique for modeled primary playlists. |
| Playlist-item local ID | `mtph+0x10` | u32 LE | Nonzero/unique within its playlist. |
| Referenced track local ID | `mtph+0x18` | u32 LE | Must resolve to a main track. |
| Item creation/order token | `mtph+0x20` | u32 LE | Not assumed to mirror current local ID. |
| Playlist-item persistent ID | `mtph+0x44` | u64 LE | Nonzero/unique within its playlist. |

The corrected media-backed follow-up observed fresh native libraries whose nonzero outer file PID differed from the COM/master PID while the serialized master selected by the COM PID contained the exact track PID across restart. Validators must gate these domains independently rather than treating inequality as fallback.

The same short plain-ASCII `Lyrics` value was rejected through COM on deterministic WAV backing but accepted and restart-persisted on one deterministic MP3 backing. The accepted operation rewrote the MP3 from 8,777 to 19,066 bytes, and the rewritten media remained exact through verification. This establishes a media-file dependency for that exact operation but does not identify whether authoritative or cached state lives in the media, the ITL, or both. A generic ITL-only Lyrics mapping must therefore remain unresolved and fail closed.

Native reopen may renumber session/local values while persistent identities remain the acceptance anchor.

## Track semantic view

`Track` exposes:

- numeric header fields defined by `NUMBER_FIELDS` in [`itlkit/library.py`](itlkit/library.py);
- named `mhoh` text fields defined by `TEXT_FIELDS`;
- selected one-bit states (`compilation`, bounded legacy `loved`, and `unplayed` on the qualified 12.13.10.3/756-byte profile).

Identity, provenance, derived, and insufficiently understood fields are read-only. A text field with duplicate records or an unknown encoding is not silently collapsed.

Selected album/artist edits use the closed local-WAV dependency model in [`itlkit/trackops.py`](itlkit/trackops.py). It may reuse an exactly compatible object, create a fresh object and identity, or collect an orphan after checking retained references. It refuses general shared-object COW.

## Playlist semantic view

`Playlist` exposes its persistent/local IDs, name, physical item sequence, master/smart/plain classification, and item persistent IDs.

A writable ordinary playlist must match the admitted profile:

- 3500-byte `miph` header;
- not master, smart, or special/system;
- metadata type codes exactly `[100, 105, 105, 108]`;
- verified view-object sizes;
- flat 84-byte `mtph` items with only known nonzero state.

Physical `mtph` sequence is membership order. It is not asserted to equal every UI sort order for system/master playlists.

## Supported transactions

| Operation | Implementation | Admitted scope |
| --- | --- | --- |
| Set scalar/selected text | `Track.set` | Observed 756-byte track profile; field-specific guards. |
| Set album/artist/album artist | `set_indexed_fields` | Closed local-WAV profile; no general shared COW. |
| Rename playlist | `Playlist.rename` | Ordinary playlist only. |
| Replace members | `replace_playlist_members` | Ordinary flat playlist; creates fresh item identities. |
| Create playlist | `create_playlist` | Ordinary playlist using verified native view metadata. |
| Delete playlist | `delete_playlist` | Ordinary playlist with no detected external identity references. |
| Restore track | `add_track_from` | Complete native local-WAV record from the same file lineage. |
| Delete track | `delete_track` | Closed local-WAV profile; removes known memberships and only newly orphaned auxiliary objects. |
| JSON transaction | `Library.apply_operations` | Allowed operation objects only; raw tree edits are refused. |

All multi-record operations run on a deep-copied candidate, validate/rebuild it, and commit the candidate only after success. A refusal leaves the original object unchanged.

## Reference model

Source: [`itlkit/references.py`](itlkit/references.py), [`itlkit/atoms.py`](itlkit/atoms.py), [`itlkit/operations.py`](itlkit/operations.py), [`itlkit/trackops.py`](itlkit/trackops.py).

The implementation combines:

1. parsed, typed references for known records;
2. uniqueness and collision checks in modeled namespaces;
3. conservative scans for persistent-ID byte/text representations in retained unknown bytes;
4. known text-pool binding checks.

These guards intentionally permit false-positive refusal. They are not a complete decoder of all unknown references and do not establish a universal allocator.

## Text object model

Known `mhoh` text payloads use a 16-byte prefix followed by exactly the declared byte length and an optional retained suffix.

- encoding 1: UTF-16LE in the supported little-endian model;
- encoding 2: only the observed ASCII URL/type-11 subset;
- encoding 3: Latin-1-equivalent byte zero-extension;
- direct payload types 1, `0x13`, and `0x42`: not text-prefix objects.

Invalid encodings, malformed lengths, duplicate named fields, unknown suffix-resizing, embedded NULs, and non-ASCII URL writes are refused.

## Serialization and publication

`Library.to_bytes` serializes sections, updates modeled counts/logical size, rebuilds the envelope when needed, and reparses the result as a `Library` before returning it.

[`itlkit/io.py::write_new`](itlkit/io.py) publishes only to a new path using a sibling temporary file and an exclusive hard-link commit. It does not overwrite an existing destination. Unsupported hard-link filesystems fail closed; fsync does not claim universal power-loss durability for directory entries or network filesystems.

## JSON models

- `itlkit.container.v1` is the low-level reversible container representation. It can reconstruct raw payload edits but does not certify semantic safety.
- `itlkit.library.v1` requires an intact original baseline and rejects raw tree changes. Supported edits must be expressed in the `operations` array.

## Non-models

The following are deliberately not promoted into semantic entities:

- opaque sections and unknown framed records;
- arbitrary strings found by byte search;
- COM session IDs as persistent IDs;
- experimental cross-library/constructor transformations as production APIs;
- historical evidence status labels as current implementation behavior.

### Exact generated-library invariants

For the two 2026-09-22 template-free fixtures only, the logical model contains one track, one album object, one artist object, a master playlist, and an ordinary playlist. The master playlist PID equals the file PID and includes the track; omitting this master identity/membership pattern in earlier sparse candidates caused iTunes to expose a different library identity or an empty master track collection. The ordinary playlist has its own persistent ID and includes the same track.

Native iTunes preserves these persistent identities but allocates new local/database IDs and adds its normal system/smart playlists on first save. The reference model therefore treats generated local IDs as seed values, not stable interoperability identities. This model is qualified only for the exact two fixture hashes; arbitrary counts, duplicate membership, folders, smart rules, paths, and additional media records remain outside this generated profile.
