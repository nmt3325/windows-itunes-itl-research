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

On comparing outputs: create_playlist is not byte-deterministic for repeated runs
with the same inputs, because it allocates a fresh persistent id and stamps a
timestamp. A byte comparison between a gated build and a bypassed build is only
meaningful when --persistent-id and --timestamp-hfs are both pinned; without that,
the two builds differ for reasons that have nothing to do with the bypass.
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
    """Rebind every live reference to the gate, not just the one in `operations`.

    The first version of this patched `operations.require_simple_library` alone, and
    that was not enough: `trackops` does `from .operations import require_simple_library`
    at import time, so it holds its own reference to the original function and never
    saw the replacement. EXP-05 found it the honest way - the playlist build succeeded
    and the track build refused with the version error, using the identical context
    manager, which is exactly the signature of a stale from-import binding rather than
    of a real refusal by the format code.

    So the patch walks the imported itlkit modules and replaces every attribute that is
    the real gate, recording what it touched so the same set can be restored. Modules
    that import the gate after this block starts are deliberately not chased; if one
    ever appears, the symptom will be a refusal, which is the safe direction.
    """
    import sys

    import itlkit.operations  # noqa: F401
    import itlkit.trackops  # noqa: F401

    patched = [
        module
        for module in list(sys.modules.values())
        if getattr(module, "__name__", "").startswith("itlkit")
        and getattr(module, "require_simple_library", None) is _REAL_GATE
    ]
    for module in patched:
        module.require_simple_library = relaxed_require_simple_library
    try:
        yield [module.__name__ for module in patched]
    finally:
        for module in patched:
            module.require_simple_library = _REAL_GATE


@contextlib.contextmanager
def operation_version_spoofed():
    """A deliberately LARGER relaxation than `gate_bypassed`, for the track path only.

    EXP-03 and EXP-04 spoofed the version for the duration of the gate call and no
    longer: every later check saw the library's true 12.13.11.1 and passed anyway. The
    track path is different, and that was measured rather than assumed. Under the narrow
    relaxation `trackops.set_indexed_fields` still refuses:

        trackops.py:156  set_indexed_fields        ->  track.set(**plain)
        library.py:184   set                       ->  _require_semantic_profile()
        library.py:468   _require_semantic_profile ->  UnsupportedError

    The identical simulation run against the playlist path succeeds, so the difference
    belongs to track edits and not to the probe.

    Holding the spoof across the whole operation means every check that consults the
    version during the edit - library.py:184, library.py:293, cow.py:110 - sees a false
    value. That is a strictly weaker experimental setup than EXP-03/EXP-04 used, and any
    result obtained under it has to say so rather than borrow their standing. The
    container header is never rewritten, so the candidate keeps its true version; the
    caller is expected to re-read the output outside this context and check.
    """
    with _version_reported_as(SPOOF_VERSION):
        with gate_bypassed() as patched:
            yield patched


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
    if args.timestamp_hfs is not None:
        kwargs["timestamp_hfs"] = args.timestamp_hfs
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
    build.add_argument("--timestamp-hfs", type=int)
    build.add_argument("--bypass", action="store_true", help="show the gate a spoofed version string")
    build.set_defaults(func=cmd_build)
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
