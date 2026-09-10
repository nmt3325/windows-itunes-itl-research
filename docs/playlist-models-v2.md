# Read-only playlist models v2

Experimental, additive inspection API. No header/membership changes, writer,
smart evaluator, native actions, file I/O, CLI dispatch changes or mutation-plan
admission are provided. Existing core refusal paths remain authoritative.

## Pure functions available to a CLI

```python
from itlkit.playlist_models import (
    inspect_playlists, inspect_playlist_payload, parse_smart_rules, models_json,
)

# hdfm bytes -> immutable diagnostic document; bounded Container decode only.
model = inspect_playlists(input_bytes, limits=None)
# Already decompressed msdh bytes. Only the LE section profile is decoded.
model = inspect_playlist_payload(payload_bytes, byteorder="little", limits=None)
# One mhoh101 body; SLst is BE irrespective of the library byte order.
wire_tree = parse_smart_rules(mhoh101_body, limits=None)
# Diagnostic JSON, NOT library.v1, a raw import format, or an executable plan.
text = models_json(model, limits=None, include_raw=False)
```

Every input is bytes, bytearray, or memoryview. Mutable input is copied after
length and initial estimated-memory admission. No Library object is needed: grouped/unknown-title diagnostics
must not depend on high-level semantic admission. Limits are keyword-only;
unknown mapping keys, bool-as-int, nonpositive values and recursion ceilings above
64 are rejected. Do not silently change existing core defaults.

A parent-owned CLI can stat an approved closed file, reject an oversized stat,
read at most max_file_bytes+1, and call inspect_playlists. The bytes API separately
checks the actual bytes. File paths and publication are intentionally outside
this module. Do not read a live iTunes file to satisfy this example.

```python
for playlist in model.playlists:  # section order, including secondary list14
    print(playlist.section_index, playlist.section_kind,
          playlist.playlist_index, playlist.value("persistent_id"))
    for meta in playlist.metadata:  # duplicates and relative order remain
        print(meta.type_code, meta.occurrence_index, meta.text,
              meta.payload.offset, meta.payload.size)
    for entry in playlist.entries:  # immediate physical miph children only
        print(entry.value("local_id"), entry.value("parent_entry_id"),
              entry.value("track_id"), entry.value("order_token"),
              entry.value("persistent_id"))
    for edge in playlist.parent_edges:
        print(edge.child_index, edge.parent_local_id, edge.parent_index,
              edge.status, edge.level)
```

`RawSpan.read()` extracts exact bytes from immutable input. It does not rebuild,
normalize, dedupe, repack or authorize a write. Per-record `header`, `raw` and
metadata `payload` spans use absolute offsets in the decompressed input. Smart
standalone offsets start at zero. All model collections returned by these
functions are immutable tuples. `models_json(include_raw=True)` emits ONE root
payload_hex plus offset/size references, not a copy of every ancestor's bytes.
Consumers must not mutate a Library in order to obtain an inspection digest.

## What is actually extracted

- Ordered section observations and primary/secondary playlist occurrences. No
  PID-keyed dictionary discards two records with the same PID. Other section
  bodies remain accessible through the document/section raw spans.
- Available miph slots: raw flags+14/+18/+1b4, PID+1b8, kind+238, localID+d40.
  A 3500-byte header gives these the observed schema level; different shapes
  expose available offsets as wire observations with a local diagnostic. No
  flags-only folder classifier or parent-field guess is supplied.
- Immediate mtph occurrences, each localID+10, parent-entryID+14, associated
  trackID+18, group byte+1c, token+20 and PID+44. The 84-byte profile is separately
  identified. Physical nested mtph stay under `physical_children`; they are not
  flattened into native grouping. Metadata200/201 remain ordered group-label
  observations, not evidence of a native-accepted synthetic group fixture.
- Parent edges resolve only unique local IDs in the same playlist occurrence.
  Zero parent is an entry-graph sentinel, NOT a playlist-folder root assertion.
  Missing/ambiguous parents, non-group parents, forward edges, cycles, duplicate
  local/item persistent IDs, and unknown group flags produce local diagnostics.
  Cycle detection is iterative and linear. Optional group trackID0 is retained.
- Primary track-header IDs are read only from a complete single primary mlth
  with 756-byte mith headers and matching counts. This permits limited leaf
  reference diagnostics, not complete library reference closure. Secondary
  playlist references are NOT resolved against the primary namespace.
- Metadata keeps child_index (ordinal among ALL immediate children) and
  occurrence_index (ordinal within that type). `pool_slot_raw` is NOT a
  globally scoped atom ID. No duplicate100/105/other occurrence is discarded.
  Known text types100/200/201 expose strict UTF16LE(1) or Latin1(3) only;
  unknown encoding/invalid UTF16/invalid extent leaves text=None plus a
  diagnostic. No ACP, UTF8, ASCII, stripping or Unicode-normalization fallback.
  No convenience single title is selected from duplicate title occurrences.
- SLst root header136 bytes, version u16BE+4, secondary version+6, count u32BE+8,
  raw flag bytes+14/+15; rule header56 bytes, field/action BE+0/+4,
  nested/disabled bytes+8/+9, payload length BE+52, exact odd-byte padding.
  Nonzero nested flag permits a recursively bounded SLst wire tree; missing
  action bit0 is a separate schema diagnostic. Unflagged leaf bytes that happen
  to contain SLst are NOT searched or recursively parsed. Field codes and action
  bits are numbers, not invented UI labels or executable predicates. All leaves
  stay opaque: no alleged full evaluator from a Name-only helper.
- mhoh102 exact112-byte body exposes raw bytes0..3,12..15,20..21 and BE32 slots
  4/8/16, without assigning semantic meanings. 103,105,108,109 and other payloads
  are independently preserved; 103 is not presumed XML or SLst.

## Evidence and diagnostics are separate levels

| Level | Meaning here | Does not imply |
| --- | --- | --- |
| wire | bounded spans, integers, framing, declared/observed counts | understood references or editable semantics |
| schema | observed profile offsets; static tree/entry relationships | complete business semantics |
| semantic | reports explicit unimplemented/opaque interpretation | predicate evaluation, folder/sort state, safe mutation |
| native | always not-qualified for these new models | a new iTunes save/reopen or writer acceptance |

`SmartTree.wire_complete` means exact rule extents/count/tail framing, including
all nested trees. It does NOT mean leaf interpretation, every schema condition,
or native acceptance: a nested action-bit diagnostic can coexist with complete
wire framing. Unknown SLst versions retain their body without parsing it.
Malformed children stop only the enclosing bounded region; no magic-tag resync
is performed, and later independent sections/playlists remain readable. Inspect
local diagnostics as well as document diagnostics. An unsupported BE library
returns its raw payload and an explicit diagnostic, not an asserted empty library.
Folder parent status is `undecoded-not-a-root-assertion` on every playlist.

Static references: standalone iTunes12.13.10.3 `bf0dd0` reader and `bf0a80`
writer (136/56-byte SLst framing, nested flag, padding); `1070770`/`107ee90`
(flat mtph entry-parent shape); `10710d0` (112-byte preferences). Static handoff
schema-final.json and original C hashes are pinned in the private operational
report, not admission constants or dependencies of this code. Existing frozen
snapshots exercise native-produced wire bytes; synthetic nested/group controls
are never presented as new native qualification.

## Limits and dependency protocol

No import of unintegrated shared codec code, merge, copy or fake shared stub is
required. `limits` accepts a mapping or an object with all ReadLimits attributes:
max_file_bytes=16MiB, max_plain_bytes=16MiB, max_nodes=100000, max_depth=32,
max_text_bytes=4MiB, max_json_bytes=64MiB, memory_budget_bytes=512MiB. Parent may
pass the pinned shared ReadLimits after integration without changing call sites.
Only a private validator/default mapping exists here, not an alternative public
ReadLimits implementation.

- File-size admission is separate from decoded-size admission. Bytes APIs cannot
  replace the caller's pre-read stat/bounded read. Existing Container's legacy
  512MiB default is not changed; the wrapper explicitly passes the new cap.
- Node count covers visited section/list/track headers, playlist/item/metadata
  models and SLst roots/rules. An uninspected opaque body is one span, not a
  claim that every hidden object inside it was counted. Tree depth, accumulated
  decoded text bytes and JSON byte output have independent limits. The document
  records max_observed_depth; JSON export also rejects a stricter depth cap below
  that observation, without conflating graph-edge depth with physical/tree depth.
- Global model/input/export resource exhaustion raises PlaylistLimitError, not a partial
  success or a local unsupported-field diagnostic. Existing Container format/explicit
  plain-size errors remain format errors. JSON uses escaped ASCII and measures
  every emitted byte, with one optional raw source. No JSON import exists.
- A conservative model/export memory estimate is checked against the declared
  process research budget. This is NOT an RSS guarantee: measured Python peaks
  for actual regression/stress runs belong in the report. Adversarial process
  memory still needs external containment/calibration beyond plaintext caps.


### Pre-inflate envelope memory admission (G2-RESOURCE-01)

For `inspect_playlists`, let W be the actual wire byte count (memoryview.nbytes,
not its element count), M be memory_budget_bytes, and R = M - 6*W. Six bytes per
wire byte conservatively cover the retained input/defensive copy and the
Container header/body/AES temporary buffers. This reservation precedes copying.
The decoder receives `min(max_plain_bytes, R//4 - 1)` as its plaintext cap. A cap
below 1 is refused before Container decoding or the payload-parser callback.
Four bytes per allowed plaintext byte align with the existing model estimate;
the additional byte accounts for Container's bounded overrun detector (cap+1).
Thus even its over-limit output obeys `4*(cap+1) <= R`.

After a successful decode, only R remains available to the existing payload,
node and text accounting (`4*plain + 2048*nodes + 4*decoded_text`). The wire
reservation cannot be spent again on model objects. Caller limits are not
mutated; file/plain/node/depth/text/JSON caps, local diagnostics and all evidence
levels are unchanged. The returned estimated_model_bytes remains the payload
model estimate; the temporary envelope buffers are not retained by that model.
The standalone payload/SLst APIs retain their existing four-byte input estimate.

A memory-derived Container size refusal is reported as PlaylistLimitError with
the original format error chained. An explicit max_plain_bytes refusal and
malformed/unsupported container errors retain their original types. No partial
model is returned. This is conservative byte accounting, NOT a promise that
Python, AES or zlib allocator/workspace overhead or process-wide RSS fits an
arbitrarily tiny declared budget; external containment/calibration is still needed.

The regression uses a genuinely compressed synthetic 512KiB opaque section,
plus zero/small remainder, exact-cap, uncompressed AES ordering, residual-model,
BE opaque, duplicate/order and unchanged-limit controls. These are allocation
boundary tests, not native writer/semantic qualification or an observed OOM.

Unresolved folder parents, full smart-leaf classes/evaluation/freshness, view and
sort semantics, second-list links, queue/history/cache dependencies and grouped
writers remain separate approval/evidence work. These observations never relax
existing F1/F2/title/structural refusal guards.
