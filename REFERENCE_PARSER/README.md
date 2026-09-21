# REFERENCE_PARSER

Small independent parser used as a second implementation for cross-checking the
main codec. It imports no `itlkit` modules. Parsing follows explicit hdfm/msdh
lengths and known record boundaries; opaque sections are never tag-scanned.

```powershell
python -m REFERENCE_PARSER detect evidence/native/snapshots/001-one-track.itl
python -m REFERENCE_PARSER dump evidence/native/snapshots/001-one-track.itl
python -m REFERENCE_PARSER summary evidence/native/snapshots/001-one-track.itl
```

A recognized version means the observed envelope label and bounded structure
match the allowlisted profile. It is not evidence that iTunes accepted a newly
written file.
