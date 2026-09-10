# Read-only diagnostic commands

The experimental readers are available without importing Python APIs:

```text
python -B -m itlkit inspect-coverage "iTunes Library.itl" --output coverage.json
python -B -m itlkit inspect-playlists "iTunes Library.itl" --output playlists.json
python -B -m itlkit inspect-playlists "iTunes Library.itl" --include-raw --output playlists-with-raw.json
```

The input should be a closed snapshot, not a library actively being saved by iTunes.
These commands do not modify the input or call the legacy semantic reader/rebuilder.
`--output` must be a new path; existing files and the input itself are never replaced.
Without `--output`, one ASCII-safe JSON document is written to stdout.

- `inspect-coverage`: header fields, partial bits, opaque ranges and explicit remaining
  semantic blockers. Addressed bytes are not a semantic coverage percentage.
- `inspect-playlists`: ordered primary/secondary playlist occurrences, duplicate
  metadata, raw entry-parent relationships, SLst wire trees and local diagnostics.
  Unknown title encodings remain local diagnostics. Folder parents, opaque smart
  leaves and unimplemented semantics are not fabricated.
- `--include-raw` includes one decompressed payload as hex, rather than duplicating
  every record's bytes. This report is not a raw-tree import document or write plan.
- Big-endian payloads stay explicitly opaque where no decoder is implemented.

Input defaults are 16 MiB encoded and 16 MiB decoded; JSON is limited to 64 MiB,
including the final newline. `--max-file-bytes`, `--max-plain-bytes` and
`--max-json-bytes` can only reduce those caps. Existing shared node/depth/text and
conservative memory-accounting limits also apply; they are not an OS RSS guarantee.
File-size admission is performed before opening the input, and opened-handle
identity/size/mtime and bounded length are checked by the shared reader.
Global failures return exit code 2 without a partial report file.

Exit code 0 means a diagnostic report was produced. It does **not** mean that every
field is decoded, that the library is semantically valid, or that iTunes has accepted
an independent write. The new commands add no mutation, repair, media import,
playback, smart-rule evaluation or native-process capability. Existing commands and
refusal rules retain their previous behavior.
