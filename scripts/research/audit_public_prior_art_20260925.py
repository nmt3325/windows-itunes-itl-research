"""Audit pinned public ITL prior art without copying third-party fixture bytes.

The external repositories must already exist below ``--external-root``.  This
script records exact Git commits, source scope, and bounded interoperability of
this repository's parsers against the historical ``titl`` fixture cohort.
It performs no native iTunes actions and makes no Windows-acceptance claim.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
from pathlib import Path
from typing import Callable, TypeVar

from itlkit.container import Container
from itlkit.library import Library
from REFERENCE_PARSER.core import ReferenceLibrary, detect_bytes

T = TypeVar("T")

SOURCES = {
    "AppMusicLibParser": {
        "repository": "https://github.com/pitetb/AppMusicLibParser",
        "commit": "423b0a87dce9bda8950ba8fe48cc8e75396fad36",
        "scope": "macOS Apple Music Library.musicdb reader; not Windows iTunes ITL qualification",
    },
    "titl": {
        "repository": "https://github.com/josephw/titl",
        "commit": "e7060370973d624d5c7b18f82303407b76421501",
        "scope": "historical Java ITL reader and iTunes 8.0 through 11.1.5 test fixtures",
    },
    "libitlp": {
        "repository": "https://github.com/jeanthom/libitlp",
        "commit": "55174a0064fc299a5771b92ed6abcb746964cf7d",
        "scope": "incomplete read-only C ITL parser; explicitly not big-endian-host portable",
    },
    "smart-playlist-io": {
        "repository": "https://github.com/kynoptic/smart-playlist-io",
        "commit": "31acf7f058278f120b9d054459134416e76d1d8e",
        "scope": "2021 macOS Music.app XML Smart Criteria encoder/decoder; cross-format prior art",
    },
    "itunes_smartplaylist": {
        "repository": "https://github.com/cvzi/itunes_smartplaylist",
        "commit": "9a36e82d5bfaad9154b50166fee0489f5d9306e2",
        "scope": "iTunes XML Smart Info/Criteria parser; cross-format prior art",
    },
    "itl-rs": {
        "repository": "https://github.com/quinnjr/itl-rs",
        "commit": "49f3ad3beaf2cdd4af2b16ee2297ec22e939dbab",
        "scope": "external Rust ITL implementation already subjected to repository native gates",
    },
}


def _run(*args: str, cwd: Path) -> str:
    return subprocess.run(
        args,
        cwd=cwd,
        check=True,
        text=True,
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ).stdout.strip()


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _attempt(operation: Callable[[], T]) -> dict:
    try:
        return {"ok": True, "value": operation()}
    except Exception as exc:  # the type and message are part of the audit result
        return {"ok": False, "error_type": type(exc).__name__, "error": str(exc)}


def audit_itl(path: Path, *, display_path: str) -> dict:
    data = path.read_bytes()
    row: dict = {
        "path": display_path,
        "bytes": len(data),
        "sha256": _sha256(data),
    }

    container_result = _attempt(lambda: Container.from_bytes(data))
    if container_result["ok"]:
        container = container_result["value"]
        rebuilt_result = _attempt(lambda: container.to_bytes(rebuild=True))
        rebuilt: dict
        if rebuilt_result["ok"]:
            rebuilt_bytes = rebuilt_result["value"]
            reparsed_result = _attempt(lambda: Container.from_bytes(rebuilt_bytes))
            rebuilt = {
                "ok": reparsed_result["ok"],
                "bytes": len(rebuilt_bytes),
                "sha256": _sha256(rebuilt_bytes),
                "same_bytes": rebuilt_bytes == data,
            }
            if reparsed_result["ok"]:
                reparsed = reparsed_result["value"]
                rebuilt.update(
                    payload_equal=reparsed.payload == container.payload,
                    trailer_equal=reparsed.trailer == container.trailer,
                )
            else:
                rebuilt.update(
                    error_type=reparsed_result["error_type"],
                    error=reparsed_result["error"],
                )
        else:
            rebuilt = rebuilt_result
        row["container"] = {
            "ok": True,
            "version": container.version,
            "header_bytes": len(container.header),
            "payload_bytes": len(container.payload),
            "trailer_bytes": len(container.trailer),
            "encryption_flag": container.encryption_flag,
            "compression_flag": container.compression_flag,
            "payload_byteorder": container.payload_byteorder,
            "max_crypt_size": container.max_crypt_size,
            "exact_noop": container.to_bytes() == data,
            "forced_rebuild": rebuilt,
        }
    else:
        row["container"] = container_result

    library_result = _attempt(lambda: Library.from_bytes(data))
    if library_result["ok"]:
        library = library_result["value"]
        row["library"] = {
            "ok": True,
            "sections": len(library.sections),
            "tracks": len(library.tracks),
            "playlists": len(library.playlists),
        }
    else:
        row["library"] = library_result

    row["reference_detect"] = detect_bytes(data)
    reference_result = _attempt(lambda: ReferenceLibrary.from_bytes(data))
    if reference_result["ok"]:
        reference = reference_result["value"]
        row["reference_library"] = {
            "ok": True,
            "sections": len(reference.sections),
            "tracks": len(reference.track_records),
            "playlists": len(reference.playlist_records),
        }
    else:
        row["reference_library"] = reference_result
    return row


def audit_source(external_root: Path, name: str, expected: dict) -> dict:
    path = external_root / name
    if not (path / ".git").is_dir():
        raise FileNotFoundError(f"missing external Git checkout: {path}")
    head = _run("git", "rev-parse", "HEAD", cwd=path)
    remote = _run("git", "remote", "get-url", "origin", cwd=path)
    status = _run("git", "status", "--porcelain", "--untracked-files=no", cwd=path)
    licenses = sorted(
        item.name
        for item in path.iterdir()
        if item.is_file() and item.name.casefold().startswith(("license", "copying", "gpl", "lgpl"))
    )
    return {
        **expected,
        "checkout": name,
        "observed_remote": remote,
        "observed_commit": head,
        "pinned_commit_match": head == expected["commit"],
        "tracked_worktree_clean": not status,
        "tracked_files": int(_run("git", "ls-files", "-z", cwd=path).encode().count(b"\0")),
        "license_files": licenses,
    }


def build_report(external_root: Path) -> dict:
    sources = [audit_source(external_root, name, expected) for name, expected in SOURCES.items()]
    if not all(item["pinned_commit_match"] and item["tracked_worktree_clean"] for item in sources):
        raise RuntimeError("external source checkout is unpinned or dirty")
    titl_root = external_root / "titl"
    fixtures = [
        audit_itl(path, display_path=path.relative_to(titl_root).as_posix())
        for path in sorted(titl_root.rglob("*.itl"))
    ]
    summary = {
        "source_checkouts": len(sources),
        "titl_fixtures": len(fixtures),
        "container_decoded": sum(row["container"]["ok"] for row in fixtures),
        "container_exact_noop": sum(row["container"].get("exact_noop") is True for row in fixtures),
        "forced_rebuild_payload_equal": sum(
            row["container"].get("forced_rebuild", {}).get("payload_equal") is True
            for row in fixtures
        ),
        "forced_rebuild_trailer_equal": sum(
            row["container"].get("forced_rebuild", {}).get("trailer_equal") is True
            for row in fixtures
        ),
        "semantic_library_parsed": sum(row["library"]["ok"] for row in fixtures),
        "reference_library_parsed": sum(row["reference_library"]["ok"] for row in fixtures),
        "reference_recognized": sum(
            row["reference_detect"]["status"] == "recognized" for row in fixtures
        ),
        "reference_unsupported": sum(
            row["reference_detect"]["status"] == "unsupported" for row in fixtures
        ),
        "big_endian_payloads": sum(
            row["container"].get("payload_byteorder") == "big" for row in fixtures
        ),
        "little_endian_payloads": sum(
            row["container"].get("payload_byteorder") == "little" for row in fixtures
        ),
    }
    return {
        "schema": "windows-itunes-itl.public-prior-art-audit.20260925.v1",
        "native_actions": False,
        "third_party_fixture_bytes_copied": False,
        "claim_boundary": (
            "Public-source parsing, source tests, and structural envelope replay do not establish "
            "Windows iTunes native acceptance, semantic compatibility, or U-01/U-02 closure."
        ),
        "sources": sources,
        "summary": summary,
        "titl_fixture_audit": fixtures,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--external-root", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    report = build_report(args.external_root.resolve(strict=True))
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(report["summary"], indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
