# Write gates and the refusal surface

This note records which writes itlkit will perform, which it refuses, and why
the distinction matters for the library this phase has in front of it. It is
class A: every line below was read out of the source in the environment that
ran the tests, and the two behavioural claims were produced by calling the
functions rather than by reading them.

## The gate chain

There are two gates, and the second is stricter than the first.

1. `Library._require_semantic_profile` at `itlkit/library.py:464`. It accepts a
   container only when `container.version` is `12.13.9.1` or `12.13.10.3` and
   the container header is exactly 144 bytes. Otherwise it raises
   `writes require the observed Windows iTunes 12.13.9.1/12.13.10.3 profile`
   at line 468. A separate check at line 470 refuses semantic writes when the
   compression trailer is unknown.
2. `operations.require_simple_library` at `itlkit/operations.py:17`. It calls
   the first gate and then narrows further: the version must be exactly
   `12.13.10.3`, every section type must be in the allowlist
   `{1, 2, 4, 9, 11, 12, 13, 14, 16, 21, 23}`, secondary track and playlist
   lists must be empty, a section 23 must be a 96 byte `stsh`, and section 12
   children must be type 503, 508 or 517.

Track level edits add a third constraint: `library.py:195` requires the
observed 756 byte `mith` profile, and several fields are verified only for
`12.13.10.3` specifically.

## What that means for a library written by 12.13.11.1

The native library available to this phase was written by iTunes 12.13.11.1.
Every semantic write path therefore refuses it:

| Operation | Result on this library |
| --- | --- |
| `trackops.set_indexed_fields` (name, artist, album, genre, comment) | refused by gate 1 |
| `trackops.add_track_from`, `trackops.delete_track` | refused by gate 1 |
| `operations.create_playlist`, `replace_playlist_members`, `delete_playlist` | refused by gate 2 |
| container read, no-op serialise, forced rebuild | permitted |

So the only writing this phase can perform against a current library is at the
container level, not the semantic level. That boundary is the honest statement
of where the project stands: reading is broad, semantic writing is confined to
two historical writer versions that this machine cannot produce.

## A correction worth recording

An earlier check in this phase concluded that the playlist operations were not
version gated. That conclusion was wrong, and the way it was reached is the
interesting part: the check searched each function's own source text for the
version string and found nothing, because the guard lives one call deeper in
`require_simple_library`. A source text scan answers the question "does this
function mention the gate", which is not the question "is this function
gated". The corrected answer came from reading the callee, and would also have
come from simply calling the function. Static pattern matching over source is
evidence about text, not about behaviour.

## The refusal surface as a whole

itlkit raises 205 distinct refusal messages across its modules:

| Module | Distinct refusals |
| --- | --- |
| `identity.py` | 96 |
| `library.py` | 27 |
| `trackops.py` | 24 |
| `operations.py` | 22 |
| `cow.py` | 12 |
| `raw.py` | 10 |
| `atoms.py` | 6 |
| `planning.py` | 4 |
| `container.py` | 2 |
| `admission.py` | 1 |
| `schema.py` | 1 |

The shape of that table is itself a finding. Identity allocation carries by far
the largest share, which reflects a deliberate policy: the project refuses to
invent identities whose native derivation it has not proved. A tool that wanted
to look capable could replace most of these refusals with plausible guesses and
would appear to support construction. This one does not, and the count above is
the price of that choice.
