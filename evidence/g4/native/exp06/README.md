# EXP-06: deleting a track with itlkit and restoring it from a donor snapshot

## What was asked

Every candidate iTunes had accepted so far kept each track's local numeric record ID
exactly where it found it. EXP-03 and EXP-04 changed playlist structure; EXP-05B changed
a track's text fields. None of them renumbered anything.

This experiment could not avoid it. `trackops.add_track_from` allocates a fresh local ID
for the restored record and fresh persistent IDs for its playlist memberships. So the
question was whether iTunes reconciles those identifiers against state it keeps outside
the `.itl` file, in particular the Extras and Genius sidecar databases that itlkit never
writes.

## How it was built

One donor: the library iTunes itself wrote when it quit at the end of the EXP-05B
restart-2 session. From it, on copies:

1. `trackops.delete_track` removed the only track, giving a zero-track library.
2. `trackops.add_track_from` restored that track from the donor.

A zero-track library is an intermediate here, never a result. An empty library is not a
pass under any reading of this experiment.

Both calls profile their inputs through `require_simple_library`, so the whole operation
ran under the wider EXP-05B relaxation rather than the narrow EXP-03 one. EXP-06
therefore licenses nothing new about which iTunes builds this writer may target. The
candidate was re-read after writing and still reports its true container version.

## How it was judged

The declaration was committed and pushed before the candidate existed, and the build step
recorded that the candidate file was absent at that moment. Judgement was: import, open,
save, quit, then restart twice, capturing the library after every quit, with every
criterion evaluated mechanically from the logs and from itlkit re-reads of all three
captures.

## Result

Accepted, in all three sessions. No modal dialog blocked startup, no `Damaged` file was
created, the library directory kept its four files, and the track was present after both
restarts with its persistent ID, name, artist and album intact and its master-playlist
membership held.

## The part that was not predicted

iTunes did not keep the local record ID itlkit chose. itlkit allocated 122; all three
captures came back carrying the donor's original value. The persistent ID is what
survived. That points at local record IDs being file-internal numbering that iTunes
reassigns on its own rewrite, rather than durable identity.

One run cannot separate "iTunes restored the previous numbering" from "iTunes renumbers
from its own counter, which produced the same value here". Both fit the data. The
experiment was not designed to tell them apart, so it does not claim to.

## What this still does not show

Genuinely new track construction remains blocked. Restoration needs a donor from the same
library lineage, and three refusals in `add_track_from` enforce that. Nothing here was
played, and nothing here generalises past a single-track WAV library on one Windows build.
