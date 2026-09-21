# Version and profile support matrix

Support is profile-specific. “Readable” does not mean editable, and “native-qualified” applies only to exact tested candidates.

## Product/version matrix

| Product/profile | Envelope | Library parse | Scalar/text edits | Structural playlist/track edits | Native qualification | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Standalone Windows iTunes 12.13.10.3, x64, observed LE profile | Implemented and offline-tested; native flag variants observed | Implemented for modeled sections/records | Guarded 756-byte `mith` subset, including bounded Name/Unplayed behavior | Guarded ordinary playlists and closed local-WAV track operations | Extensive exact-candidate evidence; two exact template-free raw/zlib fixtures also pass two isolated cycles | **Primary supported research profile** |
| Standalone Windows iTunes 12.13.9.1, observed LE profile | Implemented for observed envelope | Parser/profile guard admits it | Selected generic scalar/text paths may run; 12.13.10.3-specific Name/Unplayed logic is not applied | Rejected: structural helpers require 12.13.10.3 | No equivalent packaged native qualification matrix | **Offline/observed only; not broadly qualified** |
| Standalone Windows iTunes, other 12.x releases | `Container` may parse if framing/flags are compatible | `Library` semantic-write guard rejects unknown version | Unsupported | Unsupported | None | **Unresolved** |
| Historical Windows iTunes ITL generations | Opaque preservation may be possible case-by-case | No general profile | Unsupported | Unsupported | None | **Out of supported scope** |
| Microsoft Store iTunes | Not qualified | Not qualified | Unsupported | Unsupported | None | **Out of scope** |
| Apple Music databases / macOS databases | Different product/database families | Not applicable | Unsupported | Unsupported | None | **Out of scope** |

## Envelope feature matrix

| Feature/profile | Read | Rebuild | Native evidence | Boundary |
| --- | --- | --- | --- | --- |
| Encryption flag 0 | Yes | Yes | Phase-2 v4 native acceptance in [`docs/dynamic.md`](docs/dynamic.md) | No AES bytes selected. |
| Encryption flag 1 | Yes | Yes | Phase-2 v4 native acceptance | Entire body interval selected; cap ignored; final partial block stays clear. |
| Encryption flag 2 | Yes | Yes | Native flag-2, cap 0/17, normal cap cases | Select `min(body, cap)`, then floor to 16-byte blocks. |
| Unknown encryption flag | Refused | Refused | Static/native-rule audit | No guessed fallback. |
| Compression byte 0 | Yes, raw body | Yes, raw body | Native uncompressed variants accepted in v4 | No implicit nested-zlib inflation. |
| Compression byte nonzero | Yes, zlib | Yes, zlib | Real inflate/deflate trace correlation and native variants | Checksum/end marker and plaintext budget enforced. |
| Payload byte-order byte nonzero (LE) | Yes | Yes | Primary native profile | Full `Library` semantics are LE-only. |
| Payload byte-order byte 0 (BE) | Opaque `Container` only | Raw container rebuild only | No semantic qualification | `Library` refuses before section parsing/editing. |
| Compressed-stream trailer | Preserved by `Container` | Rebuilt with zlib stream | No semantic qualification | Semantic `Library` writes refuse unknown trailer. |

## Operation matrix by profile

| Operation | 12.13.10.3 closed profile | 12.13.9.1 | Other versions |
| --- | --- | --- | --- |
| No-op byte-exact round trip | Offline verified on admitted fixtures | Offline/observed | Container-only case-by-case; no semantic claim |
| Forced envelope reconstruction | Offline verified; selected native candidates accepted | Offline/observed | No qualification |
| Track scalar/text edit | Guarded; field-specific evidence | Generic observed guard only; no 10.3-specific states | Refused by semantic profile |
| Name-refresh correction | Implemented only for changed nonempty Name on 10.3/756-byte record | Not applied | Unsupported |
| Explicit Unplayed edit | Implemented only for 10.3/756-byte record | Refused | Unsupported |
| Album/artist/album-artist maintenance | Closed local-WAV profile; native candidate 112 | Structural helper requires 10.3 | Unsupported |
| Ordinary playlist CRUD/order | Guarded; candidates 070–074 native-qualified | Refused | Unsupported |
| Same-lineage track restore/delete | Guarded native local-WAV profile; candidates 110–111 | Refused | Unsupported |
| Cross-library import/new-media construction | Research transformations and exact accepted candidates only; not public `Library` API | Unsupported | Unsupported |
| Smart/system playlist AST inspect/lossless serialize | Implemented for observed type 101/102/103 framing; semantic edit/evaluation refused | Observed/parser only | Unsupported |

## Native evidence generations

The repository contains several bounded cohorts. They are related but not interchangeable:

1. **26 native operations/restarts** in [`evidence/native/research/045-native-matrix-final-gates.json`](evidence/native/research/045-native-matrix-final-gates.json) cover isolated native-generated metadata and playlist changes.
2. **Ten codec writer candidates / 20 save-reload cycles** are rechecked in [`evidence/native/research/056-all-candidate-audit.json`](evidence/native/research/056-all-candidate-audit.json); one additional candidate is retained as a failure.
3. **Phase-2 flag/text/factorial cases** in [`docs/dynamic.md`](docs/dynamic.md) qualify exact envelope and Name-state combinations.
4. **Six phase-3 independent cases / 12 cycles** are summarized in [`evidence/native/phase3/parent-independent-audit.json`](evidence/native/phase3/parent-independent-audit.json). Cross-library/COW/constructor results are bounded research evidence, not an automatic expansion of the production API.
5. A native allocator control passed after one constructed candidate, while the silent-playback control did not establish playback.

## Interpretation rules

- A version string accepted by a header parser is not a claim that all records have the same layout.
- A byte-exact no-op is not semantic edit support.
- A successful offline rebuild is not native acceptance.
- A native pass for one hash does not qualify a new hash, a new field combination, another media kind, or another version.
- Historical “done” labels in evidence mean the named phase completed, not that universal ITL support is complete.

## Added bounded evidence cohorts

6. **Fresh-library sequence:** six native snapshots under [`evidence/native/fresh-20260921/`](evidence/native/fresh-20260921/) cover iTunes-created empty/one/three-track states and repeated saves. They do not qualify the reference writer.
7. **Smart-playlist census:** [`evidence/smart-playlist/corpus-census.json`](evidence/smart-playlist/corpus-census.json) covers 95 parseable retained ITLs and 1,235 built-in/system instances. It qualifies framing and lossless retention, not arbitrary rule semantics.
8. **Windows path/time sequence:** [`evidence/path-time/native/native-summary.json`](evidence/path-time/native/native-summary.json) covers one isolated 12.13.10.3 environment, 30 path cases, 8 date mutations, and 39 parseable native-saved states. It does not qualify other iTunes versions, physical external media, or remote SMB.

9. **Template-free reference fixtures:** [`evidence/native/reference-generated-20260922-passed/qualification-summary.json`](evidence/native/reference-generated-20260922-passed/qualification-summary.json) pins two exact generator hashes. Each passed two cycles with exact persistent identities, no fallback artifacts, normal exit, and independent parsing. This qualifies those hashes only and does not extend generation support to 12.13.9.1 or any other version/profile.
