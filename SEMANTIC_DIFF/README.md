# SEMANTIC_DIFF

Compares selected track and playlist fields by Persistent ID, plus envelope
properties. Every changed section also gets a raw digest entry so an unmodeled or
opaque change cannot disappear behind the semantic projection.

```powershell
python -m SEMANTIC_DIFF before.itl after.itl --fail-on-change
```

Exit status is 0 by default after a successful comparison, 1 for differences
when `--fail-on-change` is supplied, and 2 for parse/I/O errors.
