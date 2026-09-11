# a08 candidate declaration format (G4-B)

Schema id: `g4/a08/candidate-declaration/v1`.
a10 MUST submit this document BEFORE any native execution, and MUST NOT begin until
a08 and a11 have both approved it and the coordinator has scheduled it.
Validated offline by `validate_declaration()` in
`research/g4/a08/g4_a08_acceptance.py`; failures use the `D_*` codes below.

## Required fields

```json
{
  "schema": "g4/a08/candidate-declaration/v1",
  "declaration_id": "a10-cand-0001",
  "author": "a10",
  "created_at": "2026-09-11T12:00:00+09:00",
  "itunes_version_target": "12.13.11.1",
  "installer_sha256": "25b28905a81406a5edbf482f7f3ee4831a8641d32d29dceda5d1eb3e8d534c08",
  "input": {
    "library_path": "<LIB_DIR>/iTunes Library.itl",
    "library_sha256": "<sha256 of the exact input library>",
    "media_files": [{"path": "<MEDIA>/synthetic-0001.m4a", "sha256": "<sha256>"}]
  },
  "output": {
    "library_sha256_expected": null,
    "library_sha256_predicted": "<sha256 or null if not predictable>"
  },
  "ids": {
    "old": {"track_persistent_ids": ["..."], "playlist_persistent_ids": ["..."],
             "library_persistent_id": "..."},
    "new": {"track_persistent_ids": ["..."], "playlist_persistent_ids": [],
             "library_persistent_id": "..."}
  },
  "metadata": {"<new track id>": {"name": "...", "artist": "...", "album": "...",
                "total_time_ms": 1000, "size": 12345}},
  "locations": {"<new track id>": "<MEDIA>/synthetic-0001.m4a"},
  "playlists": [
    {"persistent_id": "...", "name": "Library",
     "member_ids_expected": ["id_a", "id_b", "id_new"],
     "order_expected": ["id_a", "id_b", "id_new"]}
  ],
  "permitted_native_changes": ["add_track", "add_to_playlist"],
  "forbidden": ["rebuild", "repair", "consolidate", "reorganize", "upgrade_library"],
  "rollback": {"input_copy_sha256": "<sha256>", "restore_procedure": "..."}
}
```

## Field rules

- **Hashes**: `input.library_sha256` and every `media_files[].sha256` are 64 hex
  chars, lowercase. `output.library_sha256_expected` may be null when the writer is
  not byte-deterministic, but then `output.library_sha256_predicted` must be null
  too and the capture must rely on structural comparison. Never invent a hash.
- **Complete old and new ids**: both `ids.old` and `ids.new` must enumerate the
  FULL id sets, not the delta. The delta is derived by the checker; a declaration
  that lists only new ids cannot be verified against the baseline and is rejected
  (`D_IDS_INCOMPLETE`).
- **library_persistent_id** must appear in both `ids.old` and `ids.new` and must be
  identical. A declaration that plans to change it is declaring a rebuild.
- **metadata / locations**: every id in `ids.new.track_persistent_ids` that is not in
  `ids.old` must have an entry in both `metadata` and `locations`
  (`D_METADATA_MISSING`, `D_LOCATION_MISSING`).
- **playlists**: every entry needs `member_ids_expected` and `order_expected`.
  `order_expected` must be a permutation of `member_ids_expected` with no
  duplicates (`D_ORDER_NOT_PERMUTATION`, `D_ORDER_DUPLICATE`).
- **permitted_native_changes** must be non-empty and drawn from the closed set:
  `add_track`, `remove_track`, `edit_metadata`, `add_to_playlist`,
  `remove_from_playlist`, `reorder_playlist`, `create_playlist`, `delete_playlist`.
  Anything observed outside this allow-list is a blocking acceptance failure
  (`G10_CHANGE_NOT_PERMITTED`).
- **itunes_version_target** must match the version actually installed, and
  `installer_sha256` must equal the authorized installer hash for this phase.
  A declaration written against 12.13.10.3 is not valid for this phase.

## Review and scheduling

The declaration is submitted as `reports/a10/declarations/<declaration_id>.json`.
Reviewers append their verdict to `reviews` as `approved` or `rejected` with
reasons. The capture bundle then references `declaration_id` plus the
`declaration_sha256` of the exact reviewed bytes, so a declaration edited after
approval no longer matches and the capture fails `G10`.
