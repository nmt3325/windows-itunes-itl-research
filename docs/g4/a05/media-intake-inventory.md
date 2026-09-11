# a05 - media intake and genuinely new-media record construction

Phase G4-B, task a05. Sole owned production file: `itlkit/media.py`.
Authored on the GHA linux runner. Evidence class of everything below is
**structural / preservation / classification**. Nothing here is semantics,
native acceptance, persistence or playback.

The project has only ever passed native checks for fixed synthetic EDITS of
existing entries. No genuinely new track built independently has ever been
accepted, and this task did not change that.

## 1. Reference fixture

`evidence/20260910/g2-new-media/ITL-G2-PCM-48000-001.wav`, 144,044 bytes,
48,000 Hz mono 16-bit, 72,000 frames, 1500 ms, SHA-256
`87e45bff7acf44a05a818fa0f33edec429d6648751bcd8aa91ccf91a764b2e05`.
It was never imported into iTunes, and this task did not import it anywhere
native. It was only probed read-only with pinned size and hash by
`research/g4/a05/probe_reference_fixture.py`; the result is
`research/g4/a05/reference-fixture-probe.json`.
Fixture regeneration belongs to a09; nothing here duplicates it.

## 2. Field inventory for a genuinely new track record

The inventory is code, not prose: `itlkit.media.new_track_media_fields(facts,
observation=None)` returns one `MediaFieldRequirement` per field, so it cannot
quietly go stale. Statuses are exactly `FIELD_STATUSES`.

### 2.1 derived_exact - computed from the actual bytes

| field | record site | source |
| --- | --- | --- |
| size_bytes | mith 0x24 and 0x144 | probed byte length |
| media_sha256 | declaration provenance | SHA-256 of the exact bytes |
| sample_rate_hz | mith 0x98 float32 | WAVE fmt / AIFF COMM |
| channels | profile gate only | WAVE fmt / AIFF COMM |
| bits_per_sample | profile gate only | WAVE fmt / AIFF COMM |
| pcm_frames | mith 0xf4 uint64 | data/SSND length divided by block align |
| duration_ms | mith 0x28 | floor(frames * 1000 / rate) |
| bitrate_kbps | mith 0x38 | rate * channels * bits // 1000 |

Caveats that remain open even inside this group: the native rounding rule for
Total Time is unverified (the helper floors, and
`pcm_millisecond_remainder` now reports the truncation explicitly), the native
bitrate convention for PCM is unverified, and the 0xf4 frame-count rule is
mono PCM evidence only.

### 2.2 recipe_constant_unverified - written but not provable from media

| field | record site | constant |
| --- | --- | --- |
| format_code | mith 0x8c | 0x57415620 |
| kind_text | mhoh code 6 | `WAV audio file` |

These are constants of the existing admitted PCM recipe. Their native
provenance was not re-verified in this phase. `recipe_kind_text` and
`recipe_format_code` refuse every other family instead of letting a non-WAV
input borrow the WAV template.

### 2.3 caller_supplied and absent - still guessed or missing

| field | record site | status | why |
| --- | --- | --- | --- |
| date_modified | mith 0x20 | caller_supplied | filesystem mtime is observed by `probe_file`, but its HFS/wall-clock mapping is unverified |
| date_added | mith 0x78 | absent_from_itlkit | no media or filesystem source at all |
| location_path | mhoh code 13 | caller_supplied | filesystem identity, not media content |
| location_url | mhoh code 11 | caller_supplied | derived from the declared path, not from bytes |
| name | mhoh code 2 | absent_from_itlkit | tag values are never decoded; bare PCM carries no name |
| tag_metadata | album/artist/genre/year/track/disc | absent_from_itlkit | only tag key names are observed, never values |
| artwork | artwork records | absent_from_itlkit | artwork is never extracted, only its carriers reported |

## 3. Profile qualification limits that still apply

WAV PCM only; mono only; 16-bit only; 44,100 or 48,000 Hz only; canonical
16-byte fmt; no duplicate chunks; no trailer; drive-absolute ASCII Windows
Location with no percent escapes. AIFF is parsed but has no admitted record
recipe. Non-PCM families need optional mutagen and only ever produce a
parser-only duration, which is not a native wire duration.

## 4. What changed in itlkit/media.py this phase

Additive observation only. No writer, constructor or admission gate was
relaxed, no unknown field was dropped, and original bytes, unknown bytes and
artwork carriers are preserved.

- `MediaFacts.chunk_spans`: every container chunk as `(tag, payload offset,
  payload length)`, including unknown chunks, so a round trip can be proved
  byte-exact instead of assumed.
- `MediaFacts.metadata_carriers` / `artwork_carriers` and the
  `embedded_metadata_present` / `artwork_possible` properties: embedded
  metadata and artwork carriers are now visible instead of invisible. Payloads
  are still never decoded or applied.
- `pcm_millisecond_remainder` / `pcm_milliseconds_are_exact`: the truncation
  hidden inside `exact_pcm_milliseconds` is now explicit. The existing value
  is unchanged, so no gate moved.
- `recipe_kind_text` / `recipe_format_code`: the two hardcoded recipe
  constants are named, and every unqualified family refuses instead of
  falling back to the WAV template.
- `new_track_media_fields` / `unmet_new_media_conditions` /
  `MediaFieldRequirement` / `FIELD_STATUSES`: the inventory and the unmet
  condition list as executable, tested data.

## 5. Unmet conditions for genuinely new-media construction

Media-side, produced by `unmet_new_media_conditions` for a qualified
fixture-shaped input with a file observation: `format_code`, `kind_text`,
`date_modified`, `date_added`, `location_path`, `location_url`, `name`,
`tag_metadata`, `artwork`. Without a `FileObservation` a tenth condition
reports that path, size and mtime pins are unobserved. Unqualified inputs add
family, channel, bit-depth, sample-rate, embedded-metadata, artwork and
duration-truncation conditions.

Outside media.py, and therefore outside this task, the record still cannot be
built for real:

1. Identity: local IDs, persistent ID, and pool/atom registration for Name and
   Kind are caller-supplied in `materialize_pcm_wave_record` and validated only
   for range and distinctness. No allocator proves they are free in a target.
2. Graph closure: SourceBinding, auxiliary/items/history, master and
   system-role/unknown-pool closure remain unimplemented; `construct.prepare`
   is explicitly blocked and returns those blockers.
3. Sort ranks: seven rank values are required from the caller with no derived
   or native-verified rule.
4. Playlist membership and ordering for the new track are not addressed here.
5. The 756-byte header still contains observed default slots that are not
   independently explained.

A change in `construct.py`, `planning.py` or `schema.py` would be needed to
consume `recipe_kind_text`, `recipe_format_code` and the inventory instead of
repeating the constants inline. That belongs to a03, is not required for this
task's deliverables, and was not attempted.

## 6. Candidate declaration requirements handed to a08 and a10

a05 executes nothing native. Before any independently generated candidate is
scheduled, the declaration must carry at least:

1. Media provenance: exact byte length, SHA-256, sample rate, channels, bit
   depth, frame count, and the floor-derived duration in milliseconds together
   with `pcm_millisecond_remainder`, so a native Total Time that differs by one
   millisecond is classified as a rounding-convention finding and not as a
   failure.
2. Container inventory: the full `chunk_spans` list plus `metadata_carriers`
   and `artwork_carriers`. If any carrier is present the candidate is not a
   bare-media candidate, because native may read fields itlkit never decoded.
3. The two recipe constants actually written, 0x8c = 0x57415620 and Kind text
   `WAV audio file`, declared as unverified constants to be confirmed or
   refuted against the native record.
4. Location: the exact drive-absolute destination path and the derived
   `file://localhost/` URL, plus a statement that the file exists at that path
   with the declared hash before the native step.
5. Dates: the exact wall-clock `date_added` and `date_modified` supplied to the
   constructor, the observed filesystem `mtime_ns`, and the runner time zone,
   since the HFS mapping is unverified.
6. Complete old and new identity values: local IDs, persistent ID, Name and
   Kind pool IDs, and the seven sort ranks.
7. Expected native-visible metadata: Name only, with every other text field
   empty, because nonempty grouping text is still refused by the constructor.
8. Negative controls a08 should run offline first: an unqualified family, a
   stereo or 24-bit input, a rate outside 44,100/48,000, and a WAV carrying a
   `LIST` or `ID3 ` chunk. Each must refuse rather than fall back.
9. Acceptance criteria for a10: intended library only, no damaged-file
   fallback or repair, normal save and exit, two restart cycles, and raw disk
   plus COM comparison. Playback stays a separate endpoint.
