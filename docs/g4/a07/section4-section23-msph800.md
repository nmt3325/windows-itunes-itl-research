# G4-B a07 — Static structure of section 4, section 23 and msph800

Static analysis only. The Linux research runner has no iTunes binary; no vendor
executable was downloaded, committed or executed, and no decompiled excerpt is
reproduced here. Native behaviour is cited only where an earlier phase already
recorded it, and is labelled as such.

## Method

Two independent passes over the 55 git-tracked snapshots in
`evidence/native/snapshots/`:

1. **Census** (`research/g4/a07/section_census.py`): decode every snapshot with
   `itlkit.container.Container` + `itlkit.model.parse_sections`, then record the
   shape of every section, ~25 named invariants, and digests of the three
   regions of interest. Output: `reports/a07/section-census.json`.
2. **Dependency closure** (`research/g4/a07/delta_closure.py`): apply single
   perturbations in memory and diff the re-serialized node tree against the
   original with a shift-invariant structural diff. No `.itl` file is ever
   written and iTunes is never invoked.

Every claim below is re-derived independently by `tests/test_g4_a07_sections.py`
(15 tests, all passing), so the findings are executable rather than narrative.

## What the repository asserted before this task

| Source | Prior statement | Status after a07 |
| --- | --- | --- |
| `docs/format.md:63` | section 4 is "opaque location bytes" | **Refuted as opaque.** It is unframed ASCII text: a media-folder URL. |
| `docs/format.md:65` | section 23 is an "opaque `stsh` section, index semantics unresolved" | **Shape fully specified** (below). Entry semantics still unresolved. |
| `docs/format.md:61` | section 21 holds "framed `msph` records (payload opaque)" | **Payload decoded**: `mhoh` type 800 header plus an ASCII XML plist dictionary. |
| `docs/format.md:144` | operations require "a 96-byte empty stsh profile" | **Imprecise**: the guard tests length and magic only, never the declared entry count. |
| `evidence/static/phase4/findings.md:65` | native differential: donor import leaves sections 4, 13, 14, 21, 23 byte-identical | **Consistent and extended**: across all 55 snapshots sections 21 and 23 are byte-identical, and section 4 takes only two values. |
| `evidence/research/cross-library/build_cross.py:92` | hard-codes `msph` header length 48 and total 967 | **Confirmed** on all 55 snapshots. |
| `docs/identities-v2.md:145`, `evidence/20260910/g2-source-checkpoint.json:407` | section4/23/msph are unproved gates | **Unchanged semantically.** Structure is now specified; business meaning is not. |

No file under `docs/` or `proposals/` previously recorded the `file://localhost`
form of section 4; the identification is new to this task.

## Corpus invariants (proved, 55 of 55 snapshots)

- All 55 decode, and `serialize_sections(parse_sections(payload)) == payload`
  for every one of them: the parser is lossless on this corpus.
- Container version is `12.13.10.3` everywhere; section order is always
  `[16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4]`.
- All 55 plaintext payloads have distinct digests, so the constant regions below
  are genuinely constant rather than an artefact of duplicate fixtures.

## Section 4 — the configured iTunes Media folder

### Proved statically

- The section body is **unframed ASCII text**, not a record: there is no tag,
  no length prefix, no NUL terminator, and a hypothetical header length at `+4`
  is out of range for the payload.
- Every value starts with `file://localhost/`, ends with `/`, and contains `%20`
  percent-escapes.
- `msdh` header length is 96 and `msdh +8 == 96 + len(payload)`.
- The corpus contains exactly **two** distinct values:
  - 95 bytes, 54 snapshots:
    `file://localhost/<CI_ROOT_WIN>/<CI_BROKER>/RUNNER-G4A2-WIN/work/itl/fixtures/dynamic/live/iTunes%20Media/`
  - 66 bytes, only `000-empty.itl`:
    `file://localhost/C:/Users/<CI_USER>/Music/iTunes/iTunes%20Media/`
- The string appears **exactly once** in the whole plaintext payload: no other
  consumer caches it.
- **No track URL is prefixed by it.** Track `mhoh` type 11 URLs in the corpus
  point at `.../fixtures/dynamic/media/*.wav`, while the section-4 value points
  at `.../fixtures/dynamic/live/iTunes%20Media/`. The two are siblings, not
  parent and child.
- All 55 snapshots share a single library persistent ID `D2F61BE0A69CA302`,
  with 0 to 3 tracks and 14 to 16 playlists, so the two values above are two
  states of one library lineage rather than two unrelated libraries.

### Inferred, not proved

That this is the *iTunes Media folder preference*. Three converging signals:
the `iTunes Media` leaf name, the fact that the value in the empty library is
exactly the Windows default for the fixture account, and its invariance under
every track and playlist change in the corpus. This is an inference from shape
and invariance, not an observation of iTunes writing the field; predictions P1
and P4 in `native-predictions.md` are designed to settle it.

The prefix result is worth stating carefully: it does **not** show that section 4
is unrelated to track locations. It shows that in this corpus the fixtures were
added without copying into the media folder, which is exactly what prediction P3
tests.

## Section 23 — an empty `stsh` store index

### Proved statically

Identical in all 55 snapshots (single digest), 96 bytes:

| Field | Value | Meaning |
| --- | --- | --- |
| `+0` | `stsh` | root tag |
| `+4` | 96 | header length, spanning the entire payload |
| `+8` | 0 | count-style field: zero entries |
| `+8` onward | all zero | no other state whatsoever |

The enclosing `msdh` has header length 96 and total 192, so the section is
nothing but its root header.

### Inferred, not proved

That `+4` is a header length and `+8` an entry count. Every other list root in
the format (`mlth`, `mlph`, `mlah`, `mlih`, `mhgh`, `mlsh`) follows exactly this
convention, and `itlkit.model` encodes it as the `count` kind. Section 23 is not
in `LIST_ROOTS`, so `parse_sections` deliberately keeps the body opaque and the
convention is never actually exercised here. Predictions P5 to P7 test it.

## Section 21 — exactly one msph800 podcast-settings record

### Proved statically

The chain is identical in all 55 snapshots:

`msdh(21)` total 1107 → `mlsh` header 44, `+8 = 1` (one child) → `msph` header
48, `+8 = 967`, `+12 = 1`, remainder of header zero → payload `mhoh` header 24,
`+8 = 919` (= payload length), `+12 = 800` (type code), bytes 16..24 zero →
895 bytes of ASCII XML plist.

The dictionary has exactly 11 keys — `containerOrder`, `defaultSettings`,
`includesAllPodcasts`, `podcasts`, `settings`, `sortOrder`, `syncedToCloud`,
`title`, `ungroupedList`, `updatedDate`, `uuid` — with `uuid` =
`PlaylistMostRecent`, `title` = `Most Recent`, empty `podcasts` and `settings`
arrays, and a `defaultSettings` sub-dictionary of four keys.

**The record is byte-identical across the entire corpus**, including reload
pairs and the empty library, while all 55 payloads differ. In this corpus iTunes
never rewrote the record, not even its `updatedDate`. That supports carrying the
record verbatim in any third-party writer, and it is the static half of the
evidence needed for prediction P8.

Also newly verified: the production decoder `itlkit.importer.decode_msph800`
returns the `empty-podcast-settings-dictionary.v1` profile with
`semantic_independence_proven = False` on all 55 **real** records. Until now the
decoder was exercised only against synthetic nodes in `tests/test_importer_v2.py`.

## Length-dependency closure (proved by construction)

Absolute offsets are into the decrypted plaintext payload of `001-one-track.itl`
(100057 bytes); they shift per file, the relationships do not.

| Perturbation | Fields that change | Fields that provably do not |
| --- | --- | --- |
| Section 4 URL grows by `d` | `msdh(4) +8` @ 99874, `mfdh +8` @ 104 | everything else in the tree |
| msph800 XML grows by `d` | `mhoh800 +8` @ 98955, `msph +8` @ 98907, `msdh(21) +8` @ 98767, `mfdh +8` @ 104 | `mlsh +8` @ 98863 stays 1; section 4 shifts by `d` but its bytes are identical |
| Same-length edit inside `stsh` payload (offset 2924) | that payload only | no length field anywhere |
| Same-length edit to the XML `<date>` @ 99761 | that payload only | no length field anywhere |

The record counts mirrored at `mfdh`/`hdfm` `+0x30`, `+0x44`, `+0x48`, `+0x4c`,
`+0x54` are untouched by all four, because no record is added or removed.

**Envelope caveat.** The `hdfm +8` big-endian file size in the container header
always changes, but it also changes when a rewriter merely recompresses at a
different zlib level than iTunes used. It is never evidence of a semantic
dependency and must be excluded when classifying a native diff.

## Guard gap found in production code (recommendation only)

`itlkit/operations.py:29` admits a library when
`len(section.payload) == 96 and section.payload[:4] == b'stsh'`. It never reads
`+8`, so a file that declares one store entry while carrying none is accepted as
"an empty store index". Four bytes at offset 2932 in `001-one-track.itl` are
enough to reach that state, and `require_simple_library` still returns cleanly;
`test_structural_guard_ignores_the_declared_stsh_entry_count` characterizes this.

Suggested hardening, which a07 must **not** apply because production files are
read-only for this task: additionally require `uint(payload, 4) == 96`,
`uint(payload, 8) == 0` and `not any(payload[8:])`. Filed under
`contract_changes_needed` in `reports/a07/report.json`.

## What remains unproved

- `MSPH800_BUSINESS_SEMANTICS_UNPROVEN` stands. A dictionary parse plus
  corpus-wide byte stability is not proof of what the record means to iTunes.
- `UNKNOWN_SECTION_PROFILE` stands for section 23: the entry layout is unknown
  because no snapshot has an entry.
- Whether iTunes reads section 4 rather than merely writing it is untested, as
  is whether it validates `stsh +8`.
- Everything above is static. None of it substitutes for native qualification;
  see `native-predictions.md` for the ten falsifiable checks that would.

## Reproduction

| Artifact | Command |
| --- | --- |
| `$REPORTS/section-census.json` | `python3 research/g4/a07/section_census.py --out $REPORTS/section-census.json` |
| `$REPORTS/census-query.log` | `python3 research/g4/a07/census_query.py $REPORTS/section-census.json` |
| `$REPORTS/delta-closure.json` | `python3 research/g4/a07/delta_closure.py --out $REPORTS/delta-closure.json` |
| Independent re-derivation | `python3 -m pytest tests/test_g4_a07_sections.py -q` |

`$REPORTS` is the external report directory for this task,
`<work>/itl-g4/reports/a07`. The three research scripts read the committed
snapshots and write only into that directory, never into the worktree, and
`census_query.py` prints to stdout rather than emitting a JSON document.
Recorded `command_id`s for every run are in `$REPORTS/report.json`.

> Publication note (coordinator, 2026-09-11). The CI runner identifier inside
> the quoted section 4 values is pseudonymised under
> `docs/g4/redaction-policy.md`. The byte lengths quoted above are those of the
> original unredacted values as they exist on disk, so a reader reproducing the
> census will see the same lengths and a different host component.
