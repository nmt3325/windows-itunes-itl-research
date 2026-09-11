"""RESEARCH ONLY. Not part of itlkit's supported surface and not authoritative.

EXP-03 showed that real iTunes 12.13.11.1 accepted one playlist that itlkit created,
and kept it across two restarts. That is a single operation. This script exists to ask
the obvious follow-up honestly: does the acceptance generalise to the other playlist
operations itlkit refuses on this version, or was creation a lucky special case?

It changes nothing about itlkit. It reuses the EXP-03 bypass by importing it, so there
is exactly one implementation of the version spoof in the tree, and every other
precondition is still checked by the real, unmodified itlkit code.

The offline round trip here is a control for the tooling, not evidence about iTunes.
Only the native protocol - declare, install, open, quit, restart twice - can say
anything about what the application accepts.
"""

from __future__ import annotations

import argparse
import contextlib
import hashlib
import importlib.util
import pathlib
import sys

REPO = pathlib.Path(__file__).resolve().parents[3]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from itlkit import operations  # noqa: E402
from itlkit.library import Library  # noqa: E402

_EXP03 = pathlib.Path(__file__).resolve().parents[1] / "exp03" / "gate_bypass.py"
_spec = importlib.util.spec_from_file_location("exp03_gate_bypass", _EXP03)
_exp03 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_exp03)
gate_bypassed = _exp03.gate_bypassed


def _names(library):
    return [pl.to_dict().get("name") for pl in library.playlists]


def _pid_of(library, name):
    for pl in library.playlists:
        d = pl.to_dict()
        if d.get("name") == name:
            return d.get("persistent_id")
    return None


def _members_of(library, name):
    for pl in library.playlists:
        d = pl.to_dict()
        if d.get("name") == name:
            return list(d.get("item_persistent_ids") or d.get("track_ids") or [])
    return []


def _apply(library, bypass, fn, **kwargs):
    with (gate_bypassed() if bypass else contextlib.nullcontext()):
        out = fn(library, **kwargs)
    return out if isinstance(out, Library) else library


def _stage(label, library, name, out_dir):
    data = library.to_bytes()
    written = ""
    if out_dir is not None:
        out_dir.mkdir(parents=True, exist_ok=True)
        path = out_dir / (label + ".itl")
        path.write_bytes(data)
        written = " -> " + path.name
    back = Library.from_bytes(data)
    print(
        "   %-14s %6d %s version=%s playlists=%2d present=%-5s members=%d%s"
        % (
            label,
            len(data),
            hashlib.sha256(data).hexdigest()[:16],
            back.container.version,
            len(back.playlists),
            name in _names(back),
            len(_members_of(back, name)),
            written,
        )
    )
    return back


def cmd_roundtrip(args):
    out_dir = pathlib.Path(args.out_dir) if args.out_dir else None
    lib = Library.read(pathlib.Path(args.src))
    print(
        "   source         version=%s tracks=%d playlists=%d"
        % (lib.container.version, len(lib.tracks), len(lib.playlists))
    )

    create_kwargs = {"name": args.name, "track_persistent_ids": tuple(args.track_pid)}
    if args.persistent_id:
        create_kwargs["persistent_id"] = args.persistent_id
    if args.timestamp_hfs is not None:
        create_kwargs["timestamp_hfs"] = args.timestamp_hfs

    try:
        lib = _apply(lib, args.bypass, operations.create_playlist, **create_kwargs)
    except Exception as exc:
        print("   create REFUSED %s: %s" % (type(exc).__name__, exc))
        return 3
    lib = _stage("after-create", lib, args.name, out_dir)

    pid = _pid_of(lib, args.name)
    if pid is None:
        print("   the playlist has no persistent id after creation; stopping")
        return 4
    print("   playlist persistent id: %s" % pid)

    try:
        lib = _apply(
            lib,
            args.bypass,
            operations.replace_playlist_members,
            persistent_id=pid,
            track_persistent_ids=(),
        )
    except Exception as exc:
        print("   emptying REFUSED %s: %s" % (type(exc).__name__, exc))
        return 3
    lib = _stage("after-empty", lib, args.name, out_dir)

    try:
        lib = _apply(
            lib,
            args.bypass,
            operations.replace_playlist_members,
            persistent_id=pid,
            track_persistent_ids=tuple(args.track_pid),
        )
    except Exception as exc:
        print("   refilling REFUSED %s: %s" % (type(exc).__name__, exc))
        return 3
    lib = _stage("after-refill", lib, args.name, out_dir)

    try:
        lib = _apply(lib, args.bypass, operations.delete_playlist, persistent_id=pid)
    except Exception as exc:
        print("   deletion REFUSED %s: %s" % (type(exc).__name__, exc))
        return 3
    _stage("after-delete", lib, args.name, out_dir)
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    rt = sub.add_parser("roundtrip", help="create, empty, refill and delete one playlist")
    rt.add_argument("src")
    rt.add_argument("--name", default="exp04-itlkit-playlist")
    rt.add_argument("--track-pid", action="append", default=[])
    rt.add_argument("--persistent-id")
    rt.add_argument("--timestamp-hfs", type=int)
    rt.add_argument("--out-dir")
    rt.add_argument("--bypass", action="store_true")
    rt.set_defaults(func=cmd_roundtrip)
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
