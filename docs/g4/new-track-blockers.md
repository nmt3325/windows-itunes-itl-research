# Adding a genuinely new track: measured blockers, 2026-09-11 16:00 JST

Short answer: no, and this note records exactly where it stops.

Evidence class A - observed in this session on an independent verification
runner, from a clean clone of `integration/itl-20260911-g4` at `4d1925b1`.
Everything below describes itlkit behaviour. No iTunes process was started for
this note, so nothing here is a claim about native acceptance.

## Method

- Clean clone of the integration tip on a Linux verification runner, installed
  with `pip install -e ".[test]"`.
- Inputs: the 55 published snapshots in `evidence/native/snapshots`. All 55
  carry one library persistent ID (`15201368243917595394`) and container
  version `12.13.10.3`, so they are a single lineage.
- A mono 16-bit 44,100 Hz PCM WAV was synthesized as the new-media candidate:
  176,444 bytes, 88,200 frames, exactly 2.000 s, sha256
  `1c641a70274de87b52ca5c560d7a7dff78a87fe3160fb2c0e74dcce4e52a51e0`.

## Wall 1 - nothing in itlkit constructs a track

Every public callable in `itlkit` whose name matches
add/create/import/new/make/build/insert was enumerated. Twelve hits:

| callable | what it actually makes |
| --- | --- |
| `trackops.add_track_from(library, source, persistent_id)` | a copy of a record that already exists in another library |
| `operations.create_playlist(...)` | a playlist |
| `cow.build_graph`, `graph.build_graph` | a parse graph |
| `raw.import_raw_tree` | a container from a raw tree |
| `media.new_track_media_fields`, `media.unmet_new_media_conditions` | requirement reports, not records |
| `importer.ImportRefusal` | a refusal value |
| `io.write_new`, `__main__.write_new`, `__main__.build_parser` | file and CLI plumbing |
| `schema.importer_pool_domain` | a string-pool domain name |

None of these builds a `mith` track record from a media file. The only add is a
copy, and `trackops.py:4` says so: the record comes "from another snapshot of
the same library lineage, including its location blob."

## Wall 2 - the copy refuses across lineages

Patching the source library persistent_id so it differs from the candidate,
then calling `add_track_from`:

```
UnsupportedError: track restoration currently requires snapshots of the same library lineage
  raised at trackops.py:240
```

Asking for a persistent ID present in neither library:

```
ValueError: track selector matched 0 records
  raised at trackops.py:241 -> library.py:371
```

## Wall 3 - same lineage is not sufficient, which narrows EXP-06

Restoring track `10309274094617098295` out of `002-three-tracks.itl` into
`111-codec-track-delete-reload2.itl` - same lineage, and the track genuinely is
absent from the target - is refused:

```
UnsupportedError: conflicting text in a known string-pool identity
```

This narrows what EXP-06 demonstrated. EXP-06 built its candidate by deleting a
track from its own donor file and then restoring it, so the string pools agreed
by construction. Two independently saved snapshots of the same library do not
agree, and the restore is refused. Restoration is therefore verified only for a
candidate derived from its own donor, not for arbitrary same-lineage pairs.

## Wall 4 - the writable field surface is wider than this repo recorded, and it still does not help

**Correction.** Earlier notes recorded the accepted track-field set as `name
comment album artist album_artist genre composer sort_name year track_number
rating play_count unplayed`. That list is incomplete. Measured:

| field | result |
| --- | --- |
| `path`, `url` | accepted |
| `file_size`, `total_time`, `date_added` | accepted, unsigned 32-bit |
| `bit_rate`, `disc_number` | accepted |
| `sample_rate`, `kind` | refused, read-only (identity/derived/provenance) |
| `persistent_id`, `track_id` | refused, read-only |
| `location`, `file_path`, `size` | refused, unknown track field |

The field table lives in `library.py` as `NUMBER_FIELDS`, `FLOAT_FIELDS`,
`TEXT_FIELDS`, `READ_ONLY_FIELDS` and `INDEXED_TEXT_FIELDS`, not in
`trackops.py`. The three refusals are raised at `library.py:179`, `:202`, `:234`.

**Second correction, against my own first reading.** `Track.set` carries a
relocation guard:

```python
for name in ("url", "path"):
    if name in fields and fields[name] != self.get(name) and any(
            c.tag == b"mhoh" and c.type_code == 1 for c in self.node.children or ()):
        raise UnsupportedError("relocation requires updating the opaque file-location "
                               "object; refusing a URL/path-only change")
```

I first assumed a successful `path` write had slipped past this guard because I
called `trackops.set_indexed_fields` directly rather than `Track.set`. That was
wrong. `Track.set(path=...)` and `Track.set(url=...)` both succeed on these
records as well. The guard simply never applies: these tracks carry `mhoh`
children of type code 2, 6, 13 and 11, and none of type code 1, so the
condition is never true.

**Why it still does not help.** `path` and `url` are independent text nodes.
After writing `path` and round-tripping through `to_bytes()` then
`from_bytes()`, `path` reads back as the new value while `url` still reads the
original absolute media path inherited from an earlier CI machine. A record
edited this way is internally inconsistent, and no such record has ever been
shown to iTunes. Repointing an existing record at new media is not a supported
route to adding a song; it is an unvalidated way to build a contradictory
record.

## What itlkit says about itself

`media.unmet_new_media_conditions` exists for precisely this question.
`media.new_track_media_fields` returns 17 requirements for the synthesized WAV:

| status | count | fields |
| --- | --- | --- |
| `derived_exact` | 8 | `size_bytes`, `media_sha256`, `sample_rate_hz`, `channels`, `bits_per_sample`, `pcm_frames`, `duration_ms`, `bitrate_kbps` |
| `recipe_constant_unverified` | 2 | `format_code`, `kind_text` |
| `caller_supplied` | 3 | `date_modified`, `location_path`, `location_url` |
| `absent_from_itlkit` | 4 | `date_added`, `name`, `tag_metadata`, `artwork` |

Eight of the seventeen fields are derived exactly from the media bytes. The
other nine are the blockers, and with a full `FileObservation` supplied
`unmet_new_media_conditions` returns exactly those nine:

- `format_code` (`1463899680`) and `kind_text` (`WAV audio file`) are recipe
  constants that were never re-verified natively in this phase.
- `date_modified`, `location_path` and `location_url` are caller-supplied.
  They are filesystem facts rather than media facts, and the HFS/wall-clock
  mapping for `date_modified` is unverified.
- `date_added`, `name`, `tag_metadata` and `artwork` are absent from itlkit
  altogether. Bare PCM carries no name, tag values are never decoded, and
  artwork carriers are reported but never extracted.

Without a `FileObservation` a tenth condition appears: path, size and mtime are
unpinned.

The qualified media envelope is also narrow by construction: WAV PCM only, mono
only, 16-bit only, 44,100 or 48,000 Hz only.

## What this licenses

- Fair to say: playlists can be created, repopulated and deleted; an existing
  track indexed-field edit works; a deleted track can be restored from its own
  donor. All four were accepted by real iTunes across restarts (EXP-03, EXP-04,
  EXP-05B, EXP-06).
- Not fair to say a song can be added. There is no constructor, the copy
  refuses across lineages, it refuses across mismatched string pools inside one
  lineage, and itlkit reports nine unmet conditions in its own media-to-record
  mapping.

## Not done

- No iTunes process was started for this note.
- No attempt was made to widen `add_track_from`, and none should be made
  without pre-registration.