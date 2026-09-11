# G4-B a07 — Falsifiable native predictions for section 4, section 23 and msph800

Derived statically on Linux with no iTunes binary present. Nothing here has been
observed natively by a07; every entry is a prediction written so that a single
native run can refute it. The native operator (a10) owns execution.

**Baseline for every diff below:** the 55 committed snapshots in
`evidence/native/snapshots/`, reference file `001-one-track.itl` unless stated.
All 55 are container version `12.13.10.3` with section order
`[16, 12, 9, 11, 1, 13, 23, 2, 14, 21, 4]`.

**Comparison method.** Use a shift-invariant structural diff, not a raw byte
diff: any length change inside section 21 shifts section 4 wholesale, and a raw
diff would report thousands of "changed" bytes that are only relocated. The
helper `changed_nodes()` in `tests/test_g4_a07_sections.py` (also implemented in
`research/g4/a07/delta_closure.py`) walks the parsed node tree and reports
`(path, header|payload)` pairs, which is the right granularity for these checks.

**Note on the envelope.** The `hdfm +8` big-endian file size always changes when
anything changes, and it also changes when a rewriter merely recompresses at a
different zlib level. It is never evidence of a semantic dependency; ignore it
when classifying a result below.

---

## Group A — section 4 is the configured iTunes Media folder

### P1. Relocating the media folder rewrites section 4 and nothing else

- **Action:** Edit → Preferences → Advanced → change the iTunes Media folder
  location, then quit iTunes so the library is written.
- **Predicted bytes:** the section-4 payload becomes the new folder rendered as
  ASCII `file://localhost/<Drive>:/<path>/` with a trailing `/`;
  `msdh(type 4) +8` becomes `96 + len(new URL)`; `mfdh +8` moves by the same
  delta; `msdh(type 4) +4` stays `96`. No other node header or payload changes.
- **Observable consequence:** the structural diff contains exactly
  `msdh(type=4):header`, `msdh(type=4):payload` and `mfdh:header`.
- **Falsifier:** any track, playlist, album or global node also changes; or the
  new string is not the folder that was chosen; or a NUL terminator appears.
- **Why it matters:** promotes `docs/format.md` line 63 ("opaque location
  bytes") from opaque to a fully specified, writable field.

### P2. The URL is percent-encoded UTF-8, still ASCII on disk

- **Action:** point the media folder at a directory whose name contains a space
  and a non-ASCII character, for example `Media uber` written with the u-umlaut.
- **Predicted bytes:** the space appears as `%20` and the non-ASCII character as
  its UTF-8 percent escapes (`%C3%BC` for u-umlaut); every byte of the payload
  stays below `0x80`; the byte length grows by 2 per escaped character.
- **Observable consequence:** section 4 remains pure ASCII and decodes back to
  the chosen path after percent-decoding as UTF-8.
- **Falsifier:** raw high bytes, UTF-16, a different encoding of the space, or a
  length-prefixed/framed record instead of bare text.
- **Why it matters:** a third-party writer must know the exact escaping rule
  before it can ever write this field.

### P3. Section 4 is a setting, not a summary of where tracks live

- **Action:** with "Copy files to iTunes Media folder when adding to library"
  enabled, add one track that currently sits outside that folder.
- **Predicted bytes:** section 4 does not change at all; the new track's
  `mhoh` type 11 URL becomes a string that starts with the section-4 URL.
- **Observable consequence:** for the first time in this corpus, a track URL is
  prefixed by the section-4 URL. In all 55 existing snapshots no track URL is
  prefixed by it, because the fixtures point at `.../dynamic/media/` while the
  media folder points at `.../dynamic/live/iTunes%20Media/`.
- **Falsifier:** section 4 changes when only a track was added, which would mean
  it is derived from content rather than from preferences.

### P4. The default value is regenerated, not remembered

- **Action:** on a fresh profile, create an empty library, then point the media
  folder somewhere else and back to the default.
- **Predicted bytes:** section 4 returns byte-for-byte to
  `file://localhost/C:/Users/<user>/Music/iTunes/iTunes%20Media/`, the exact
  66-byte form observed in `000-empty.itl`, with no residue of the intermediate
  value anywhere in the payload.
- **Falsifier:** a second copy of the old URL survives elsewhere, which would
  mean some other consumer caches the media root. In the current corpus the
  section-4 string appears exactly once in the whole payload.

---

## Group B — section 23 is an empty `stsh` store index

### P5. Populating the store index makes `stsh +8` nonzero and grows the section

- **Action:** sign in to the Store, or import an item carrying store metadata,
  in a throwaway library; quit iTunes.
- **Predicted bytes:** `stsh +4` stays `96` (the root header still spans 96
  bytes); `stsh +8` becomes the entry count `N > 0`; the section payload grows
  past 96 bytes with `N` framed records after the root header; `msdh(type 23)
  +8` grows by the same amount; `mfdh +8` follows.
- **Observable consequence:** `itlkit.operations.require_simple_library` starts
  refusing the library with "nonempty store index has unresolved dependencies",
  which is the intended behaviour.
- **Falsifier:** the payload grows while `+8` stays `0`, which would mean `+8`
  is not the entry count and the 96-byte guard is resting on a wrong model.
- **Why it matters:** `docs/format.md` line 65 records "index semantics
  unresolved". Statically, `+8 = 0` on all 55 snapshots with every byte after
  offset 8 zero, which is consistent with an empty count-style list root but
  cannot distinguish "count" from "unused" without this test.

### P6. The 84 zero bytes are carried, not regenerated

- **Action:** in a throwaway library, set one byte inside the `stsh` payload
  after offset 16 to `0x01`, open iTunes, make an unrelated edit, quit.
- **Predicted bytes:** the flipped byte survives verbatim; no length field moves.
- **Observable consequence:** the structural diff shows the store-index payload
  either unchanged (carried) or fully zeroed (regenerated). Carried means a
  third-party writer must preserve the region; regenerated means it is free
  space.
- **Falsifier:** iTunes rejects or rebuilds the library, which would make the
  region validated rather than opaque.

### P7. The structural guard does not read the declared entry count

- **Action:** in a throwaway library, set `stsh +8 = 1` while leaving the
  payload at 96 bytes, so the file declares one store entry that is not present.
- **Predicted bytes:** exactly four bytes change; no length field moves.
- **Observable consequence:** `require_simple_library` still accepts the file,
  because it checks only `len(payload) != 96 or payload[:4] != b'stsh'`. This is
  verified statically by `test_structural_guard_ignores_the_declared_stsh_entry_count`.
  The open question is what iTunes does: silently reset the count, ignore it, or
  treat the index as truncated.
- **Why it matters:** if iTunes trusts the count, the guard has a real hole and
  should also require `uint(payload, 8) == 0`. a07 cannot make that change,
  since production files are read-only for this task; it is filed under
  `contract_changes_needed`.

---

## Group C — msph800 podcast-settings record

### P8. The record is stable across ordinary library edits

- **Action:** any track or playlist CRUD, then quit.
- **Predicted bytes:** the entire `msph` record, including the XML
  `updatedDate`, stays byte-identical.
- **Observable consequence:** none in section 21. This already holds statically
  across all 55 snapshots, which have 55 distinct payload digests but a single
  msph digest, including reload pairs and the empty library.
- **Falsifier:** any save rewrites `updatedDate` without podcast interaction,
  which would make the record a per-save timestamp and unsafe to carry verbatim.

### P9. Touching podcast settings rewrites only the date span

- **Action:** change a podcast preference that the dictionary models, for
  example the grouping or the played-episode setting, then quit.
- **Predicted bytes:** the 20-byte ISO-8601 value inside the `<date>` element
  changes in place; because the date length is fixed, no length field moves:
  `mhoh800 +8`, `msph +8`, `msdh(type 21) +8` and `mfdh +8` all keep their
  current values; `mlsh +8` stays `1`.
- **Observable consequence:** the structural diff contains exactly
  `msdh(type=21)/mlsh/msph:payload` and nothing else.
- **Falsifier:** other keys change, or a length field moves, or `uuid` stops
  being `PlaylistMostRecent`.

### P10. Subscribing to a podcast populates the empty collections

- **Action:** subscribe to one podcast, then quit.
- **Predicted bytes:** `podcasts` and `settings` stop being empty arrays, so the
  XML grows by `d` bytes and exactly four length fields move together:
  `mhoh800 +8` (`24 + len(xml)`), `msph +8` (`48 + 24 + len(xml)`),
  `msdh(type 21) +8` and `mfdh +8`, each by `d`. Section 4 shifts by `d` but its
  bytes stay identical.
- **Observable consequence:** `itlkit.importer.decode_msph800` stops returning
  the `empty-podcast-settings-dictionary.v1` profile and refuses the record,
  which is the intended behaviour.
- **Falsifier:** the key set changes beyond the 11 observed keys without the
  decoder refusing, or one of the four length fields fails to move.
- **Why it matters:** this is the only prediction that would reveal the business
  semantics behind `MSPH800_BUSINESS_SEMANTICS_UNPROVEN`. Until it runs, the
  record must keep being carried verbatim rather than synthesized.
