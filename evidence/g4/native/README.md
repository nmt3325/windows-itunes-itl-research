# Native session evidence

These are the machine-written logs and the up-front declarations for the native
iTunes experiments described in `docs/g4/native-experiments.md`. Nothing here
was edited after the fact except for one mechanical substitution: CI hostnames,
usernames and absolute paths were replaced with stable placeholders such as
`<CI_ROOT_WIN>` and `RUNNER-G4B-WIN`. Timestamps, digests, dialog text and
failure codes are untouched.

- `exp01/` accepted candidate: a container itlkit rebuilt from its own parse,
  opened and quit, then restarted twice.
- `exp02/` negative control: the same container with sixteen bytes corrupted,
  which iTunes refused.
- `ctrl/` baseline control: the untouched native original, run to find out what
  COM reports when nothing has been changed.

Each declaration was written to disk *before* the corresponding library was
installed, so the prediction cannot be adjusted after seeing the outcome.

The binary `.itl` captures are not published here. They carry absolute media
paths from the CI machine, and stripping bytes out of a binary artefact would
make it useless as evidence anyway. `capture-manifest.json` records their sizes
and sha256 digests instead.
