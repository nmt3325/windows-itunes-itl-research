"""RESEARCH ONLY. Not part of itlkit's supported surface and not authoritative.

EXP-06 asks whether iTunes accepts a library whose track record itlkit removed and
then restored from a donor snapshot of the same library lineage.

Every candidate accepted so far (EXP-03, EXP-04, EXP-05B) preserved each track's local
numeric record ID. This one cannot: trackops.add_track_from allocates a fresh local ID
for the restored record and fresh persistent IDs for its playlist memberships. So this
is the first test of whether iTunes reconciles those identifiers against state it keeps
outside the .itl file, such as the Extras and Genius sidecar databases, which itlkit
never rewrites.

Both delete_track and add_track_from profile their inputs through require_simple_library,
so the whole operation needs the wider EXP-05B relaxation, not the narrow EXP-03 one.
The bypass is imported from EXP-03 rather than reimplemented, and nothing in itlkit
changes. The container header is never rewritten, so the candidate keeps its true
version; this script re-reads its own output and prints that version so the claim is
checkable rather than asserted.
"""

from __future__ import annotations

import argparse
import contextlib
import hashlib
import importlib.util
import json
import pathlib
import sys

REPO = pathlib.Path(__file__).resolve().parents[3]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from itlkit import trackops  # noqa: E402
from itlkit.library import Library  # noqa: E402

_EXP03 = pathlib.Path(__file__).resolve().parents[1] / "exp03" / "gate_bypass.py"
_spec = importlib.util.spec_from_file_location("exp03_gate_bypass", _EXP03)
_exp03 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_exp03)
operation_version_spoofed = _exp03.operation_version_spoofed


def _sha(data):
    return hashlib.sha256(data).hexdigest()


def _rows(lib):
    out = []
    for tr in lib.tracks:
        d = tr.to_dict()
        out.append({"persistent_id": d.get("persistent_id"), "name": d.get("name"), "track_id": tr.track_id})
    return out


def _master(lib):
    for p in lib.playlists:
        if p.is_master:
            return sorted(p.track_ids)
    return []


def _relax(bypass):
    return operation_version_spoofed() if bypass else contextlib.nullcontext()


def cmd_build(args):
    src = pathlib.Path(args.src)
    raw = src.read_bytes()
    donor = Library.read(src)
    work = Library.read(src)
    donor_rows = _rows(donor)
    donor_master = _master(donor)
    print("   donor     version=%s tracks=%d playlists=%d bytes=%d sha=%s" % (donor.container.version, len(donor.tracks), len(donor.playlists), len(raw), _sha(raw)[:16]))
    for r in donor_rows:
        print("   donor     track_id=%s pid=%s name=%r" % (r["track_id"], r["persistent_id"], r["name"]))
    print("   donor     master_members=%s" % donor_master)

    try:
        with _relax(args.bypass):
            trackops.delete_track(work, args.persistent_id)
    except Exception as exc:
        print("   REFUSED delete_track %s: %s" % (type(exc).__name__, exc))
        return 3
    reduced = work.to_bytes()
    print("   reduced   tracks=%d playlists=%d bytes=%d sha=%s" % (len(work.tracks), len(work.playlists), len(reduced), _sha(reduced)[:16]))

    try:
        with _relax(args.bypass):
            trackops.add_track_from(work, donor, args.persistent_id)
    except Exception as exc:
        print("   REFUSED add_track_from %s: %s" % (type(exc).__name__, exc))
        return 3

    data = work.to_bytes()
    back = Library.from_bytes(data)
    back_rows = _rows(back)
    back_master = _master(back)
    same = data == raw
    donor_tid = donor_rows[0]["track_id"] if donor_rows else None
    back_tid = back_rows[0]["track_id"] if back_rows else None
    print("   candidate version=%s tracks=%d playlists=%d bytes=%d sha=%s" % (back.container.version, len(back.tracks), len(back.playlists), len(data), _sha(data)[:16]))
    for r in back_rows:
        print("   candidate track_id=%s pid=%s name=%r" % (r["track_id"], r["persistent_id"], r["name"]))
    print("   candidate master_members=%s" % back_master)
    print("   local_id_changed=%s  (donor %s -> candidate %s)" % (donor_tid != back_tid, donor_tid, back_tid))
    print("   candidate_equals_donor=%s" % same)
    if same:
        print("   UNINFORMATIVE: the candidate is byte-identical to the donor")

    if args.out:
        pathlib.Path(args.out).write_bytes(data)
        print("   wrote    %s" % pathlib.Path(args.out).name)
    if args.report:
        report = {
            "authoritative": False,
            "experiment": "EXP-06",
            "operation": "trackops.delete_track then trackops.add_track_from (same-lineage restoration)",
            "bypass": bool(args.bypass),
            "relaxation": ("version reported as %s for the WHOLE operation, which is wider than EXP-03/EXP-04 used and the same width EXP-05B used" % _exp03.SPOOF_VERSION) if args.bypass else "none; the shipped gate decided",
            "donor": {"bytes": len(raw), "sha256": _sha(raw), "tracks": len(donor.tracks), "playlists": len(donor.playlists), "rows": donor_rows, "master_members": donor_master},
            "intermediate_reduced": {"bytes": len(reduced), "sha256": _sha(reduced), "tracks": 0, "note": "a zero-track library is an intermediate, never a result; an empty library is explicitly not a pass"},
            "candidate": {"bytes": len(data), "sha256": _sha(data), "tracks": len(back.tracks), "playlists": len(back.playlists), "rows": back_rows, "master_members": back_master, "container_version_after_write": back.container.version},
            "local_id_changed": donor_tid != back_tid,
            "candidate_equals_donor": same,
            "uninformative": same,
        }
        pathlib.Path(args.report).write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
        print("   report   %s" % pathlib.Path(args.report).name)
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    bd = sub.add_parser("build")
    bd.add_argument("src")
    bd.add_argument("--persistent-id", required=True)
    bd.add_argument("--out")
    bd.add_argument("--report")
    bd.add_argument("--bypass", action="store_true")
    bd.set_defaults(func=cmd_build)
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())