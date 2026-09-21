# Independence boundary

The reference toolchain is intentionally separate from the production codec:

- `REFERENCE_PARSER` contains its own hdfm/AES/zlib and bounded record parser.
- `REFERENCE_WRITER` only packs synthetic envelopes and performs byte-exact
  same-version copies; cross-version migration fails closed.
- `VALIDATOR` and `SEMANTIC_DIFF` consume only the independent model.
- `TEST_CORPUS` constructs records from constants and declared fields rather
  than serializing an `itlkit` object.

Tests reject imports whose module name begins with `itlkit` anywhere in these
five directories. Shared third-party AES and Python zlib implementations are
libraries, not copied application code.
