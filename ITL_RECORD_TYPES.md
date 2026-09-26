# ITL section and record catalog

This catalog is compact and status-oriented. Detailed offsets and policies are in [`ITL_FORMAT_SPEC.md`](ITL_FORMAT_SPEC.md); object relationships are in [`ITL_DATA_MODEL.md`](ITL_DATA_MODEL.md).

## Status legend

- **Modeled:** parsed by boundaries and serialized with modeled counts/lengths.
- **Semantic subset:** selected fields/operations have explicit support.
- **Observed only:** evidence describes a shape, but no general semantic writer is offered.
- **Opaque:** complete bytes are retained without interpreting internals.
- **Unresolved:** meaning or dependency closure is insufficient.

## Generic framing

For most records in the supported little-endian payload model:

| Offset | Meaning |
| --- | --- |
| `+0x00` | 4-byte ASCII tag |
| `+0x04` | header length, u32 LE |
| `+0x08` | total record length, u32 LE, except count/fixed roots documented below |

`msdh` is the section envelope. Parsing advances only through validated lengths. Apparent tags inside opaque bytes are not records.

## Section types

| Section type | Root/contents | Implementation status | Key boundary |
| ---: | --- | --- | --- |
| 1 | `mlth` → main `mith` tracks | Modeled; semantic subset | Main tracks exposed by `Library.tracks`. |
| 2 | `mlph` → primary `miph` playlists | Modeled; semantic subset | Ordinary flat playlists writable under strict guards. |
| 4 | opaque location-related bytes | Opaque | Preserved; semantics unresolved. |
| 9 | `mlah` → `miah` album objects | Modeled; guarded local-WAV subset | 88-byte profile used by selected indexed edits. |
| 11 | `mlih` → `miih` artist objects | Modeled; guarded local-WAV subset | 100-byte profile used by selected indexed edits. |
| 12 | `mhgh` → global `mhoh` metadata | Modeled counts; limited types | Structural edits require only known 503/508/517 objects. |
| 13 | secondary `mlth` | Modeled list, no semantic tracks | Structural edits require it to be empty. |
| 14 | secondary `mlph` | Modeled list, no semantic playlists | Structural edits require it to be empty. |
| 15 | `mlrh` → fixed-size `mprh` records | Modeled framing | `mprh+8` is not treated as total length. Semantics unresolved. |
| 16 | `mfdh` main fixed header | Modeled/validated | Logical size, section count, and primary counts validated. |
| 20 | `mlqh` → metadata plus `miqh` | Modeled mixed counts | Queue/history semantics unresolved; structural profile excludes it. |
| 21 | `mlsh` → framed `msph` | Root/list modeled; payload opaque | Structural profile admits retained observed shape only. |
| 22 | opaque section | Opaque | Complete body retained. |
| 23 | `stsh` store/index section | Opaque/guarded | Structural edits require the observed empty 96-byte profile. |
| other | unknown body | Opaque | Preserved inside validated `msdh`; structural edits refuse it. |

## Record tags

| Tag | Role | Framing/model | Semantic status |
| --- | --- | --- | --- |
| `hdfm` | outer file container | Big-endian envelope fields | Modeled by `Container`; see encryption/compression rules. |
| `msdh` | section envelope | header + total + section type | Modeled. |
| `mfdh` | main library header | fixed root | Counts/logical size modeled. |
| `mhgh` | global metadata root | child count at `+0x08` | Modeled count; types limited for writes. |
| `mlth` | track-list root | child count at `+0x08` | Main and secondary lists kept distinct. |
| `mith` | track record | 756-byte observed write profile; child count at `+0x0c` | Selected scalar/text/indexed fields. Unknown header bytes retained. |
| `mlph` | playlist-list root | child count at `+0x08` | Main and secondary lists kept distinct. |
| `miph` | playlist record | `mhoh` count at `+0x0c`, `mtph` count at `+0x10` | Strict ordinary-playlist subset; system/smart retained/refused. |
| `mtph` | playlist item | observed 84-byte container/leaf | Track reference and item identities modeled for flat items. |
| `mlah` | album-list root | child count at `+0x08` | Modeled. |
| `miah` | album object | observed 88-byte container | Guarded codes 300/301/302 for local-WAV operations. |
| `mlih` | artist-list root | child count at `+0x08` | Modeled; not a track list. |
| `miih` | artist object | observed 100-byte container | Guarded code 400 for local-WAV operations. |
| `mhoh` | typed data object | type code at header `+0x0c` | Text subset plus opaque direct payloads. |
| `mlqh` | queue/history root | mixed metadata/`miqh` counts | Framing modeled; semantics unresolved. |
| `miqh` | queue/history item | child-count container | Framing modeled; semantics unresolved. |
| `mlsh` | section-21 root | child count at `+0x08` | Framing modeled. |
| `msph` | section-21 item | framed opaque payload | Opaque. |
| `mlrh` | section-15 root | child count at `+0x08` | Framing modeled. |
| `mprh` | section-15 fixed record | record length is its header length | Opaque semantics. |
| `stsh` | section-23 body | observed fixed empty profile | Opaque; nonempty/unrecognized profile blocks structural edits. |

## `mith` field catalog

All offsets are relative to the observed 756-byte `mith` header and are little-endian unless noted.

| Field | Offset/width | Policy/status |
| --- | --- | --- |
| local track ID | `0x10` / 4 | Identity; read-only. |
| record-kind candidate | `0x14` / 4 | Raw/read-only; not certified as artwork count. |
| date modified | `0x20` / 4 | Raw HFS wall-time value. |
| file size | `0x24` / 4 | u32; no >4 GiB claim. |
| duration | `0x28` / 4 | milliseconds. |
| track number/count | `0x2c`, `0x30` / 4 | Writable uint32 under profile guard. |
| year / bit rate | `0x34`, `0x38` / 4 | Year writable; bit rate retained/read. |
| play count | `0x4c` / 4 | Selected main counter; does not imply complete playback event. |
| compilation bit | `0x50`, mask `0x01000000` | Read-only semantic view. |
| auxiliary play counter | `0x60` / 4 | Raw/read-only; not a forced mirror. |
| play date | `0x64` / 4 | Raw HFS wall-time value. |
| disc number/count | `0x68`, `0x6a` / 2 | Writable under profile guard. |
| rating | `0x6c` / 1 | Writable integer 0–100. |
| Name-refresh state | `0x6d` / 1 | Raw; bit 0 is cleared only for a selected nonempty changed Name on 12.13.10.3. |
| date added | `0x78` / 4 | Raw/read. |
| track persistent ID | `0x80` / 8 | Identity; read-only. |
| unplayed wire state | `0xee` / 1 | On 12.13.10.3, low bit 0 means Unplayed true and 1 means false. |
| sample rate | `0xf4` / 4 | Read-only. |
| skip count | `0xd8` / 4 | Selected main counter. |
| album local reference | `0xdc` / 4 | Dependency-managed; not directly writable. |
| auxiliary skip counter | `0x118` / 4 | Raw/read-only; not a forced mirror. |
| skip date | `0x11c` / 4 | Raw HFS wall-time value. |
| artist local reference | `0x1e0` / 4 | Dependency-managed; not directly writable. |
| secondary track ID | `0x1f4` / 4 | Nonzero values form an identity namespace; exact native-qualified template-free inputs may be zero on read/no-op, while semantic writes require nonzero. |
| bounded legacy `loved` bit | `0x2bf`, mask `0x02` | Bit-preserving API label; full UI semantics not certified. |

## `mhoh` type-code catalog

### Track-owned types

| Code | Name | Status |
| ---: | --- | --- |
| 1 | file-location binary object | Direct/opaque; blocks URL/path-only relocation. |
| 2 | name | Read/write; selected Name-refresh correction on 12.13.10.3. |
| 3 | album | Read/write only with guarded album/artist maintenance. |
| 4 | artist | Read/write only with guarded album/artist maintenance. |
| 5 | genre | Read/write; absent field may be created. |
| 6 | kind | Derived/read-only. |
| 8 | comment | Read/write; native COM may truncate long setter values. |
| 11 | URL | Provisional ASCII/percent-encoded subset. |
| 12 | composer | Read/write. |
| 13 | path | Read/write only when no opaque location dependency would be contradicted. |
| 27 | album artist | Guarded indexed edit. |
| 30–33 | sort name/album/artist/album artist | Read/write, with pool guards. |
| 60 | purchaser name | Read-only. |
| `0x13`, `0x42` | direct binary payloads | Not text-prefix records. |

### Playlist-owned types

| Code | Meaning/status |
| ---: | --- |
| 100 | playlist name; writable only on ordinary admitted profile. |
| 101, 102 | smart-rule objects; opaque signatures used for equality/refusal. |
| 103 | special/system marker; presence excludes ordinary writes. |
| 105 (two objects), 108 | native view metadata; exact admitted sizes 1244, 1244, and 220 bytes. |

### Album/artist/global types

| Owner | Codes | Meaning/status |
| --- | --- | --- |
| `miah` | 300, 301, 302 | album, effective artist, explicit album artist in the closed profile. |
| `miih` | 400 | effective artist in the closed profile. |
| `miih` and known pools | 401 | observed shared sort-related binding; guarded, not a universal pool definition. |
| `mhgh` | 503, 508, 517 | only global object types admitted by structural-edit guard. Semantics are not generalized here. |

## String payload prefix

For supported text-prefix `mhoh` objects, payload offsets are:

| Offset | Meaning |
| --- | --- |
| `+0x00` | encoding, u32 LE |
| `+0x04` | byte length, u32 LE |
| `+0x08..+0x0f` | preserved prefix bytes |
| `+0x10` | exact string bytes, followed by an optional preserved suffix |

Unknown encodings remain opaque. An unknown suffix may be retained at the same length; resizing it is refused.

## Confidence boundary

The catalog proves that the implementation has an explicit model or refusal policy for these entries. It does not prove that every unknown header byte, every type code, every section ordering, or every version shares these meanings. Consult [`EVIDENCE.md`](EVIDENCE.md) before upgrading an “observed” entry to a broader claim.
