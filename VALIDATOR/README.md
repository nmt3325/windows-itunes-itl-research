# VALIDATOR

Checks the independent parser's section/record boundaries, outer and inner
counts, observed header profiles, nonzero/unique identities, playlist-to-track
references, and track-to-album/artist local references.

```powershell
python -m VALIDATOR evidence/native/snapshots/001-one-track.itl
```

The JSON report explicitly lists coverage. Opaque bytes are not searched for
integer patterns and are not claimed to be semantically validated. A passing
report is structural evidence, not native iTunes acceptance.
