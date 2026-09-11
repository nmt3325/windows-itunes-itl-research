# G4-B integration decisions (coordinator, 2026-09-11)

The integration branch merges every task branch and is then re-verified by the
coordinator, not by the task that produced the code. Four failures appeared on
the first integrated run. Each is resolved below. Nothing here was decided by
reading alone: the isolating experiment ran a11's probe file on base+a05+a11
(2 failures) and then on base+a05+a11+a02 (4 failures), which attributes every
failure to one branch.

## D1 - models_json object key order changed. Probe amended, behaviour kept.

a02's reconstruction routes export through the shared `schema.encode_json`
preflight, which emits object keys sorted. The base encoder emitted dataclass
field order, and a11 pinned `keys()[:3] == ["schema", "raw", "byteorder"]`
against the base. Sorted keys are a property of the shared encoder, no key was
added or removed, and object key order is not significant in JSON. The
substantive invariant, array order with duplicate occurrences preserved, still
holds and is still asserted. The probe now asserts sorted keys plus key
presence. This remains a real, published behaviour change of models_json output.

## D2 - the master predicate now refuses unqualified auxiliary widths. Probe amended.

`require_complete_master` raises `UnsupportedError('GATE01: unqualified direct
auxiliary album/artist shape')` when an auxiliary record header width is not a
qualified 88-byte `miah` or 100-byte `miih`. a11 pinned the base behaviour,
which admitted such a record. Admitting it is precisely the persistent-ID
validation bypass the G3 fix closes, so the old expectation pinned the
vulnerability. Scope confirmed empirically: the raise occurs inside
`admission._ids_and_refs`, reachable only from `require_complete_master`, while
`Library._validate_ids_and_refs` still accepts the same input unchanged, so the
opt-in-only property claimed for the G3 fix holds.

## D3 - a05 finding F1 fixed in production code.

`new_track_media_fields` reported `format_code` and `kind_text` with status
`recipe_constant_unverified` and value `None` for families with no recipe
constant, while `recipe_format_code` raised `MediaError` for the same facts. The
status is now `absent_from_itlkit` unless a constant exists for that family, and
the note says so. a11's counterexample is the regression test.

## D4 - a05 finding F2 fixed in production code.

Carriers were computed from fixed allowlists, so a WAV carrying an unlisted
chunk such as `XYZ `, `bext` or `iXML` was admitted with
`embedded_metadata_present == False`, inverting the rule that an undecoded
carrier disqualifies a bare-media candidate. `MediaFacts` now carries
`unknown_chunks`, populated with every chunk outside the decoded structural set
for that family and outside the carrier allowlists, and
`embedded_metadata_present` accounts for it. Payloads are still never decoded.

## Not changed

a11's F3 (the 32 versus 64 depth ceiling conflict) and F4 (chunk spans do not
tile a padded file) are documentation and API-design questions, not failures.
They stay open and are pinned by passing tests.

## D5 - a05's own parametrization contradicted D4, and was updated

`test_a05_carriers_are_reported_never_decoded_and_never_dropped[Zzz1]` pinned
`embedded_metadata_present is False` for an unlisted chunk, which is exactly the
behaviour D4 removes. Two subagents therefore asserted opposite rules about the
same fact. The coordinator kept a11's rule, because reporting an undecoded chunk
as bare media is the failure mode that would silently drop bytes from a
constructed record, and amended a05's parametrization to distinguish three
things: allowlisted carrier membership, unknown-chunk membership, and the
derived `embedded_metadata_present`. a05's inventory document was amended to
state the same rule.
