"""EXP-03 probe: what does native iTunes do if the writer-version gate is bypassed?

RESEARCH ONLY. NOT PART OF itlkit's SUPPORTED SURFACE. NON-AUTHORITATIVE.

itlkit refuses semantic writes unless the library was written by a profile it has
actually observed natively (12.13.9.1 or 12.13.10.3). The machine used for the G4
native work runs 12.13.11.1, so every semantic write is refused there. That refusal
is the conservative answer; it is not evidence that 12.13.11.1 would reject a
library built by itlkit. Nobody has tested that, which is the point of this probe.

This script does not edit itlkit and does not reimplement its checks. It relaxes
exactly one thing: it presents the string '12.13.10.3' to the real, unmodified
operations.require_simple_library in place of the library's true version, and
restores the true version immediately afterwards, before anything is serialized.
Everything else - identity and reference validation, the 144-byte header rule, the
compression-trailer rule, the section allowlist, the empty-grandchild rules, the
store-index shape and the global-metadata child codes - is still enforced by the
real code. The candidate this produces therefore still carries its true version
string; only the gate was lied to.

Anything produced here is a CANDIDATE, not a supported artifact. Whatever the
native application does with it is a probe result. Acceptance here must NOT be
used to widen itlkit's accepted-profile set: that would require its own declared
native experiment, with a negative control, on that version.
"""

from __future__ import annotations

import argparse
import contextlib
import hashlib
import json
import pathlib
import sys

from itlkit import operations
from itlkit.container import Container
from itlkit.library import Library

SPOOF_VERSION = "12.13.10.3"
_REAL_GATE = operations.require_simple_library


@contextlib.contextmanager
def _version_reported_as(version):
    """Make Container.version report `version` for the duration of the block.

    Container.version is a read-only property derived from the container header,
    so the value cannot simply be assigned; the first attempt at this probe failed
    with AttributeError and that refusal is recorded rather than hidden. The patch
    is installed on the class rather than on one instance because
    operations.create_playlist gates a deep copy of the library, not the object it
    was handed. It is removed again as soon as the gate returns, so nothing is ever
    serialized while it is in place and the candidate keeps its true version.
    """
    original = Container.version
    Container.version = property(lambda self: version)
    try:
        yield
    finally:
        Container.version = original


def relaxed_require_simple_library(library):
    """The real gate, run against a spoofed version string and nothing else."""
    with _version_reported_as(SPOOF_VERSION):
        _REAL_GATE(library)


@contextlib.contextmanager
def gate_bypassed():
    operations.require_simple_library = relaxed_require_simple_library
    try:
        yield
    finally:
        operations.require_simple_library = _REAL_GATE


def _playlist_facts(playlist):
    d = playlist.to_dict() if hasattr(playlist, "to_dict") else {}
    wanted = (
        "name", "persistent_id", "kind", "distinguished_kind", "special_kind",
        "is_plain", "folder", "smart", "track_count", "item_count",
    )
    return {k: d[k] for k in wanted if k in d}


def cmd_inspect(args):
    lib = Library.read(args.path)
    print("   version           :", lib.container.version)
    print("   header bytes      :", len(lib.container.header))
    print("   trailer present   :", bool(getattr(lib.container, "trailer", b"")))
    print("   tracks / playlists:", len(lib.tracks), "/", len(lib.playlists))
    if lib.playlists and hasattr(lib.playlists[0], "to_dict"):
        print("   playlist keys     :", ", ".join(sorted(lib.playlists[0].to_dict()))[:300])
    for playlist in lib.playlists[: args.limit]:
        print("      ", json.dumps(_playlist_facts(playlist), default=str)[:180])
    for label, gate in (("real gate", _REAL_GATE), ("relaxed gate", relaxed_require_simple_library)):
        try:
            gate(lib)
            print("   %-13s: PASS" % label)
        except Exception as exc:  # noqa: BLE001 - a refusal is a result here
            print("   %-13s: %s: %s" % (label, type(exc).__name__, str(exc)[:140]))
    return 0


def cmd_build(args):
    src = pathlib.Path(args.src)
    raw = src.read_bytes()
    lib = Library.read(src)
    true_version = lib.container.version
    before = [_playlist_facts(p).get("name") for p in lib.playlists]
    kwargs = {}
    if args.track_pid:
        kwargs["track_persistent_ids"] = tuple(args.track_pid)
    if args.template:
        kwargs["template_persistent_id"] = args.template
    if args.persistent_id:
        kwargs["persistent_id"] = args.persistent_id
    context = gate_bypassed() if args.bypass else contextlib.nullcontext()
    report = {
        "probe": "EXP-03",
        "authoritative": False,
        "bypass_used": bool(args.bypass),
        "bypass_description": "the real require_simple_library, shown a spoofed version string",
        "source": {"sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw), "version": true_version},
        "playlists_before": before,
        "requested": {"name": args.name, **{k: list(v) if isinstance(v, tuple) else v for k, v in kwargs.items()}},
    }
    try:
        with context:
            result = operations.create_playlist(lib, args.name, **kwargs)
    except Exception as exc:  # noqa: BLE001 - a refusal is a result here
        report["outcome"] = "REFUSED"
        report["error"] = {"type": type(exc).__name__, "message": str(exc)[:400]}
        print("   REFUSED %s: %s" % (type(exc).__name__, str(exc)[:200]))
    else:
        candidate = result if isinstance(result, Library) else lib
        data = candidate.to_bytes()
        report["outcome"] = "BUILT"
        report["candidate"] = {
            "sha256": hashlib.sha256(data).hexdigest(),
            "bytes": len(data),
            "version_after_build": candidate.container.version,
            "version_preserved": candidate.container.version == true_version,
            "playlists_after": [_playlist_facts(p).get("name") for p in candidate.playlists],
        }
        print("   BUILT %d bytes sha256=%s version=%s preserved=%s" % (
            len(data), hashlib.sha256(data).hexdigest()[:16],
            candidate.container.version, candidate.container.version == true_version))
        if args.out:
            out = pathlib.Path(args.out)
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_bytes(data)
            reread = Library.read(out)
            names = [_playlist_facts(p).get("name") for p in reread.playlists]
            report["reread"] = {"tracks": len(reread.tracks), "playlists": len(reread.playlists), "contains_new_name": args.name in names}
            print("   re-read: tracks=%d playlists=%d contains_new_playlist=%s" % (
                len(reread.tracks), len(reread.playlists), args.name in names))
    if args.report:
        pathlib.Path(args.report).write_text(json.dumps(report, indent=2), encoding="utf-8")
        print("   report ->", args.report)
    return 0 if report["outcome"] == "BUILT" else 3


def main(argv=None):
    parser = argparse.ArgumentParser(description="EXP-03 research probe (non-authoritative)")
    sub = parser.add_subparsers(dest="cmd", required=True)
    inspect = sub.add_parser("inspect", help="report a library's profile and how both gates react to it")
    inspect.add_argument("path")
    inspect.add_argument("--limit", type=int, default=20)
    inspect.set_defaults(func=cmd_inspect)
    build = sub.add_parser("build", help="attempt a semantic playlist write and record the outcome")
    build.add_argument("src")
    build.add_argument("--name", required=True)
    build.add_argument("--out")
    build.add_argument("--report")
    build.add_argument("--track-pid", action="append", default=[])
    build.add_argument("--template")
    build.add_argument("--persistent-id")
    build.add_argument("--bypass", action="store_true", help="show the gate a spoofed version string")
    build.set_defaults(func=cmd_build)
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
