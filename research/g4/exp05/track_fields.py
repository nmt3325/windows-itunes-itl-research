"""RESEARCH ONLY. Not part of itlkit's supported surface and not authoritative.

EXP-03 and EXP-04 covered playlist creation, member replacement and deletion: real
iTunes 12.13.11.1 accepted all three. Every one of those touches playlist structures.
This script asks the harder question - whether a change to a *track* record also
survives - because track edits are where the format's shared strings, album and artist
references and index structures actually live.

As before, only the version string presented to the gate is relaxed, the bypass is
imported from EXP-03 rather than reimplemented, and nothing in itlkit changes.

The key-probe subcommand exists because guessing which field names the implementation
accepts, and then writing a confident experiment on top of the guess, is how the earlier
"playlist writes are ungated" error happened. It asks the code instead.
"""

from __future__ import annotations

import argparse
import contextlib
import copy
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
gate_bypassed = _exp03.gate_bypassed

CANDIDATE_FIELDS = {
    "name": "exp05-renamed-by-itlkit",
    "comment": "exp05 comment",
    "album": "exp05 album",
    "artist": "exp05 artist",
    "album_artist": "exp05 album artist",
    "genre": "exp05 genre",
    "composer": "exp05 composer",
    "grouping": "exp05 grouping",
    "sort_name": "exp05 sort name",
    "year": 1999,
    "track_number": 3,
    "rating": 60,
    "play_count": 2,
    "played_count": 2,
    "unplayed": False,
}


def _sha(data):
    return hashlib.sha256(data).hexdigest()


def _track_row(library, persistent_id):
    for tr in library.tracks:
        d = tr.to_dict()
        if d.get("persistent_id") == persistent_id:
            return d
    return {}


def _interesting(row):
    keys = ("persistent_id", "name", "album", "artist", "comment", "genre", "year", "track_number")
    return {k: row.get(k) for k in keys if k in row}


def _apply(library, bypass, fields, persistent_id):
    with (gate_bypassed() if bypass else contextlib.nullcontext()):
        trackops.set_indexed_fields(library, persistent_id, fields)
    return library


def cmd_inspect(args):
    lib = Library.read(pathlib.Path(args.src))
    print("   version=%s tracks=%d playlists=%d" % (lib.container.version, len(lib.tracks), len(lib.playlists)))
    for tr in lib.tracks:
        d = tr.to_dict()
        print("   track pid=%s name=%r" % (d.get("persistent_id"), d.get("name")))
    return 0


def cmd_probe_keys(args):
    src = pathlib.Path(args.src)
    accepted, refused = [], []
    for key, value in CANDIDATE_FIELDS.items():
        lib = Library.read(src)
        try:
            _apply(lib, args.bypass, {key: value}, args.persistent_id)
            data = lib.to_bytes()
            back = Library.from_bytes(data)
            row = _track_row(back, args.persistent_id)
            got = row.get(key, "<absent from to_dict>")
            accepted.append(key)
            print("   ACCEPTED %-14s -> %-28r (%d bytes)" % (key, got, len(data)))
        except Exception as exc:
            refused.append(key)
            msg = str(exc)
            print("   refused  %-14s %s: %s" % (key, type(exc).__name__, msg[:90]))
    print("   %d accepted, %d refused" % (len(accepted), len(refused)))
    print("   accepted keys: %s" % ",".join(accepted))
    return 0


def cmd_set(args):
    src = pathlib.Path(args.src)
    lib = Library.read(src)
    before = _interesting(_track_row(lib, args.persistent_id))
    fields = {}
    for pair in args.set:
        key, _, raw = pair.partition("=")
        if raw.lower() in ("true", "false"):
            fields[key] = raw.lower() == "true"
        else:
            try:
                fields[key] = int(raw)
            except ValueError:
                fields[key] = raw
    print("   source   version=%s tracks=%d playlists=%d" % (lib.container.version, len(lib.tracks), len(lib.playlists)))
    print("   before   %s" % json.dumps(before, ensure_ascii=False))
    try:
        _apply(lib, args.bypass, fields, args.persistent_id)
    except Exception as exc:
        print("   REFUSED %s: %s" % (type(exc).__name__, exc))
        return 3
    data = lib.to_bytes()
    back = Library.from_bytes(data)
    after = _interesting(_track_row(back, args.persistent_id))
    print("   after    %s" % json.dumps(after, ensure_ascii=False))
    print("   built    %d bytes %s version=%s tracks=%d playlists=%d" % (len(data), _sha(data)[:16], back.container.version, len(back.tracks), len(back.playlists)))
    if args.out:
        pathlib.Path(args.out).write_bytes(data)
        print("   wrote    %s" % pathlib.Path(args.out).name)
    if args.report:
        pathlib.Path(args.report).write_text(json.dumps({
            "authoritative": False,
            "fields": fields,
            "bypass": bool(args.bypass),
            "before": before,
            "after": after,
            "output_bytes": len(data),
            "output_sha256": _sha(data),
        }, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        print("   report   %s" % pathlib.Path(args.report).name)
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    ins = sub.add_parser("inspect")
    ins.add_argument("src")
    ins.set_defaults(func=cmd_inspect)
    pk = sub.add_parser("probe-keys")
    pk.add_argument("src")
    pk.add_argument("--persistent-id", required=True)
    pk.add_argument("--bypass", action="store_true")
    pk.set_defaults(func=cmd_probe_keys)
    st = sub.add_parser("set")
    st.add_argument("src")
    st.add_argument("--persistent-id", required=True)
    st.add_argument("--set", action="append", default=[])
    st.add_argument("--out")
    st.add_argument("--report")
    st.add_argument("--bypass", action="store_true")
    st.set_defaults(func=cmd_set)
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
