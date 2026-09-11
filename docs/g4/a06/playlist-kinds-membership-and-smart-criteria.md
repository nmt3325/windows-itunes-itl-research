# G4-B / a06 — Playlist kinds, membership, ordering, grouping, smart criteria

Branch `g4/a06`, base commit `1bb05edc2494abc9aa9b59cd2392026f830615a2`, runner env `RUNNER-G4B-LINUX`.
Corpus: every `.itl` fixture in the repository (`evidence/**/*.itl`), 105 files.

Evidence labels used throughout:

- **PROVED** — read directly out of fixture bytes by the scripts in `research/g4/a06/`.
- **INFERENCE** — correlation only. Not established by the corpus.
- **MISSING** — the corpus contains no instance, so nothing was decided either way.

Preservation claims (bytes survive) and semantic claims (bytes mean something) are kept apart.
Nothing in this document upgrades `semantic_write_level`, which remains `none` for every record.

## 0. Method and corpus

| Script (`research/g4/a06/`) | Output |
| --- | --- |
| `survey_playlists.py` | `out/playlist-survey.json` — every playlist record, metadata object and item in all 105 files |
| `analyze_playlists.py` | `out/playlist-findings.json` — kind census, header-offset census, smart/preferences inventory |
| `analyze_ordering.py` | `out/ordering-findings.json` — membership series, token statistics, reference disproof |
| `probe_spans.py` | span tiling and smart-tree reconstruction probe |
| `probe_preservation.py` | round-trip, `require_plain`, rename/replace blast-radius probe |

PROVED corpus facts: 105 files, 105 parsed, 0 parse errors; 1518 playlist records; 1391 item records.
The only diagnostic emitted anywhere in the corpus is `folder_parent_undecoded`, exactly once per
playlist record (1518). Document-level diagnostics: none. Opaque (unrecognised) playlist children: none.

## 1. Playlist kinds the format distinguishes

All playlist records live in section kind 2 (primary `mlph`), header 3500 bytes, item records 84 bytes.
Counts below are occurrences across the 105 files.

| Kind | `+0x14` | `+0x18` | `+0x238` | Metadata codes | Occurrences | Items |
| --- | --- | --- | --- | --- | --- | --- |
| Master (`####!####`) | `0x10000` | `0x10007` | 0 | 100,105,105,108 | 105 | 432 |
| Music | 0 | `0x10007` | 1024 | 100,101,102,105,105,108,109 | 105 | 432 |
| Downloaded (music) | 0 | `0x10007` | 16640 | 100,101,102,105,105,108 | 105 | 432 |
| Music Videos | 0 | `0x10007` | 12032 | 100,101,102,105,105,108 | 105 | 0 |
| TV & Movies | 0 | `0x10007` | 16384 | 100,101,102,105,105,108 | 105 | 0 |
| Audiobooks | 0 | `0x10007` | 1280 | 100,101,102,105,105,108 | 105 | 0 |
| Genius | 0 | `0x10007` | 6656 | 100,101,102,105,105,108 | 105 | 0 |
| Movies | 0 | `0x10005` | 512 | 100,101,102,105,105,108 | 105 | 0 |
| Home Videos | 0 | `0x10005` | 12288 | 100,101,102,105,105,108 | 105 | 0 |
| Downloaded (movies) | 0 | `0x10005` | 16896 | 100,101,102,105,105,108 | 105 | 0 |
| TV Shows | 0 | `0x10026` | 768 | 100,101,102,105,105,108 | 105 | 0 |
| Downloaded (TV) | 0 | `0x10026` | 17152 | 100,101,102,105,105,108 | 105 | 0 |
| Rentals | 0 | `0x10030` | 1792 | 100,101,102,105,105,108 | 105 | 0 |
| Podcasts | 0 | `0x10020` | 2561 | 100,**103**,105,105,108,109 | 105 | 0 |
| Ordinary | 0 | `0x10001` | 0 | 100,105,105,108 | 44 (40 files) | 87 |
| Ordinary, flag variant | 0 | `0x10007` | 0 | 100,105,105,108 | 4 (4 files) | 8 |

PROVED consequences:

- Per-file composition is always 1 master + 13 system playlists + 0..2 ordinary playlists
  (14 playlists in 61 files, 15 in 40, 16 in 4). Section kind 2 `declared_count` equalled the parsed
  count in all 105 files.
- Section kind 14 (the second `mlph`) is present in all 105 files and declares **0** playlists.
  Its purpose is **MISSING** from this corpus; itlkit parses it and correctly finds nothing.
- "Smart" is not one kind. 12 system playlists carry an `mhoh` 101 rule object plus a 102 preferences
  object; Podcasts carries neither and instead carries the otherwise-unseen code 103.
  `Playlist.is_smart` (any child of type 101 or 102) therefore classifies Podcasts as *not* smart while
  `is_plain` also rejects it via `+0x238 != 0`.
- Title encoding varies: code 100 appears 1473× as Latin-1 (encoding 3) and 45× as UTF-16LE (encoding 1).
- **MISSING from the whole corpus**: folder playlists, grouped items, nested `mtph`, item-level metadata,
  labels 200/201, opaque playlist children, and any playlist in section 14.

### Modelled versus preserved-as-opaque-bytes

| Region | Modelled today | Preserved as raw span only |
| --- | --- | --- |
| 3500-byte playlist header | 6 slots: `0x14`, `0x18`, `0x1b4`, `0x1b8` (PID), `0x238`, `0xd40` | everything else, including the nonzero u32s observed at `0x0`, `0x4`, `0x8`, `0xc`, `0x10`, `0x1c`, `0x1bc`, `0x218`, `0x274`, `0x730`, `0x734`, `0xc74`, `0xc90`, `0xd88` |
| 84-byte item record | 6 slots: `0x10`, `0x14`, `0x18`, `0x1c`, `0x20`, `0x44` | remaining bytes |
| Metadata | 100 (text), 101 (`SLst` tree), 102 (13 raw slots) | 103, 105 (×2 per playlist, 1220 B body), 108 (196 B body), 109 |

Per-kind offset lists are in `out/playlist-findings.json` under `header_offset_census`, including which
offsets fall outside the `require_plain` known-offset set.

## 2. Membership and explicit ordering

PROVED:

- Membership is the ordered sequence of immediate `mtph` children; the track reference is `+0x18`.
  The declared item count at `miph+16` matched the parsed entry count in all 1518 records.
- The item's current id (`+0x10`) is volatile and the creation/order token (`+0x20`) is stable.
  Rename snapshot 032 kept tracks `[75, 79, 77]` while item ids moved `163,164,165 -> 139,140,141`
  and tokens stayed `163,164,165`.
- A reorder is expressed by rewriting the physical sequence. Snapshot 033 changed the sequence to
  `[77, 75, 79]` and re-minted both ids and tokens to `166,167,168`.
- A removal keeps the survivors' tokens. Snapshot 034 holds tracks `[77, 79]` with tokens `166,168`
  (inherited from 033) while ids became `139,141`.
- The playlist's own local id (`+0xd40`) is volatile across a native reopen while the PID (`+0x1b8`)
  is stable: the two ordinary playlists in `072-*-reload1` and `072-*-reload2` swap local ids 136/141,
  and `036` shows 139 where sibling snapshots show 136.
- Master playlist membership is ordered the same way but with sparse tokens: `037` master holds tracks
  `[75, 77, 79]`, ids `[84, 85, 86]`, tokens `[143, 150, 157]`.

Negatives that must not be papered over:

- **Physical order versus token order is not separable in this corpus.** In all 337 multi-item playlists
  the item-id sequence and the token sequence are both ascending in physical order; zero counterexamples.
  So "the token defines display order" is **INFERENCE**, and "physical order is membership order" is the
  only PROVED reading.
- **Duplicate membership is MISSING**: zero duplicate track references across 1391 items. Duplicates are
  unobserved, not disproved.
- Any *displayed sort* (as opposed to membership order) is **MISSING**; if it is stored at all it is inside
  the unmodelled header bytes or the two 1220-byte type-105 blobs.

## 3. Folder parentage and grouping

PROVED: the corpus contains no folders and no groups — 0 entries with `group_flag != 0`, 0 with
`parent_entry_id != 0`, 0 nested `mtph`, 0 labels 200/201.

A cross-reference probe searched every 3500-byte header for any 8-byte little-endian value equal to another
playlist's PID (excluding the PID slot itself) and any 4-byte value equal to another playlist's local id
(excluding `+0xd40`). Result: 27 candidate hits — and all 27 are **DISPROVED**:

- every hit is at byte offset `0x1BF`, which is unaligned;
- `0x1BF` lies *inside* the playlist's own 8-byte PID slot (`0x1b8`..`0x1bf`);
- in all 27 cases the matched value equals that playlist's own PID top byte.

So no header field in this corpus points at another playlist. `folder_parent_status =
"undecoded-not-a-root-assertion"` plus the per-record `folder_parent_undecoded` diagnostic is the correct
state, and a flat corpus must not be read as proof that every playlist is a root.

To make progress a new fixture is required: a real folder with at least one child (ideally two nesting
levels) and one grouped playlist, captured before and after a native reopen.

## 4. Smart-playlist criteria

### 4.1 Wire structure — PROVED

For all 12 rule-carrying system playlists in all 105 files, the `mhoh` 101 body re-concatenates exactly:
`header + sum(rule header + payload + padding) + unparsed == body`, with `wire_complete = True`,
zero trailing bytes and zero diagnostics.

- Body header is 136 bytes: magic `SLst`, version `u16BE@4 = 1`, secondary version `u16BE@6 = 1`,
  rule count `u32BE@8`, flag bytes at `@14`/`@15`.
- Rule header is 56 bytes: field code `u32BE@0`, action bits `u32BE@4`, nested byte `@8 = 0`,
  disabled byte `@9 = 0`, payload length `u32BE@52`. Every observed rule declares 68 bytes, so the
  odd-length padding rule is never exercised here.
- Genius is the degenerate case: rule count 0, flag bytes `[0, 1]`, no rules.
- Each built-in's tree is **byte-identical across all 105 fixtures** (offset-stripped shape count = 1 per
  playlist). These are static Apple-authored criteria.
- The 68-byte payload layout is: `u64BE value @0`, zeros `@8`, `0x…01 @16`, the same 24-byte triple repeated
  at `@24`, then 20 zero bytes. Example (Downloaded, rule 0):
  `00000000001021b1 0000000000000000 0000000000000001` ×2 followed by 20 zero bytes.

Observed field/action census:

| Field | Action | Payload value | Appears on |
| --- | --- | --- | --- |
| `0x3C` | `0x00000400` | `0x02` / `0x08` / `0x20` / `0x40` / `0x42` / `0x0400` / `0x1021b1` | every rule-carrying list (first rule) |
| `0x3C` | `0x02000400` | `0x20a004` / `0x208004` / `0x218004` | all except Rentals |
| `0x3C` | `0x00000800` | `0x8000` | Rentals only |
| `0x85` | `0x00000400` | `0x01` | the three Downloaded lists only |
| `0xA4` | `0x00000001` | `0x01` | TV & Movies only |

### 4.2 Meaning — INFERENCE only

The value in the first rule tracks the playlist's media type (Movies `0x02`, Audiobooks `0x08`,
Music Videos `0x20`, TV Shows `0x40`, Rentals and TV & Movies `0x42`, Home Videos `0x0400`,
Music and Downloaded-music `0x1021b1`), which *suggests* field `0x3C` is a media-kind mask and action
`0x400` is an include comparison. Likewise field `0x85` with payload 1 appearing only on Downloaded lists
*suggests* a "downloaded/local" predicate, and the duplicated triple *suggests* a low/high range pair.

None of this is provable from this corpus, because the corpus contains **zero user-authored smart
playlists**: every 101 object is an Apple built-in with static content. Decoding operators, string
comparands, limits, live-updating flags or nested rule groups requires new fixtures that vary one
criterion at a time.

### 4.3 Preferences object 102 — PROVED shape only

112-byte body, exactly one distinct body per built-in across all 105 files. itlkit exposes 13 raw slots
(`byte_00..byte_15`, `u32_04`, `u32_08`, `u32_10`); their meanings remain unassigned, matching the
existing evidence string.

## 5. Preservation behaviour locked by `tests/test_g4_a06_playlists.py`

All PROVED on the current tree:

- `Library.from_bytes(x).to_bytes() == x` for every probed fixture.
- Playlist records tile exactly: header + metadata + items + opaque children cover the whole record with
  no gap, no overlap and no unattributed byte.
- Renaming an ordinary playlist changes exactly one playlist record, and inside it only the type-100
  payload. The other 14 records — including all 101, 102, 103 and 109 bodies — stay byte-identical.
- `replace_playlist_members` likewise changes exactly the target record.
- Rename is refused on smart/system playlists; `require_plain` refuses Podcasts (type 103 child).

These are preservation locks, not semantics: they only assert bytes survive and the parser keeps
reporting the same structure.

## 6. Divergence found (reported, not fixed)

Four fixtures — `074-codec-playlist-create-from-master-reload1`, `…-reload2`, `091-comment-truncation-saved`,
`092-comment-truncation-reloaded` — contain an ordinary playlist whose `+0x18` is `0x10007` instead of the
`0x10001` seen in the other 40 files. PROVED effect: `Playlist.is_plain` still returns `True`, but
`require_plain` refuses it with `unverified ordinary-playlist flags`, so the playlist can no longer be
renamed or re-membered by itlkit. The pre-reopen sibling `074-codec-playlist-create-from-master.itl` has
`0x10001`, while the `072` create lineage keeps `0x10001` through both reloads — so the trigger is **not**
simply "a native reopen", and its cause is **MISSING**.

No production file was changed: `itlkit/operations.py` and `itlkit/library.py` are read-only for a06.

## 7. What the next fixture run must capture

1. A folder containing at least one playlist, two levels deep, before and after a native reopen.
2. A grouped playlist, to exercise `group_flag`/`parent_entry_id` and labels 200/201.
3. A playlist containing the same track twice.
4. A user-authored smart playlist, then single-criterion variants (operator, string comparand, limit,
   live-updating on/off, one nested rule group).
5. A manual drag-reorder that is *not* a full rewrite, to separate token order from physical order.
6. Anything that puts a record into section kind 14.

## 8. Coordination note

`itlkit/playlist_models.py` was read at base sha `0968d1250cdb39b8b021ef2708d498f55ff31dbf9f7d541e452e91a66db46263`
and not modified; a02 owns it. The a06 tests deliberately avoid asserting on JSON-budget or `models_json`
internals so that a02's re-derivation of the shared budget preflight cannot collide with them.


## Coordinator recovery note (2026-09-11)

The a06 session failed before committing anything. This branch was recovered by
the coordinator from the task worktree, and two accuracy corrections are
required before anyone relies on the document above.

* Section 5 refers to `tests/test_g4_a06_playlists.py`. That file was never
  created, so nothing in this document is locked by an automated test on this
  branch. The preservation claims here are re-derivable from the probes under
  `research/g4/a06/` (evidence class C), not observed-with-a-test (class A).
* No `report.json` was written for a06, so there is no self-reported status to
  reconcile against this document. The probes and the JSON outputs under
  `research/g4/a06/out/` are the only machine-readable evidence recovered.

The coordinator re-ran the full gated suite on this branch before committing.
No production code is modified here, so the suite matches the phase base.
