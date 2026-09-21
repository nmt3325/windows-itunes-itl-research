"""CLI for version detection, bounded record dumps, and semantic summaries."""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

from .core import ReferenceError, ReferenceLibrary, detect


def _write_json(value: dict, output: Path | None) -> None:
    text = json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if output is None:
        sys.stdout.write(text)
    else:
        output.write_text(text, encoding="utf-8", newline="\n")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="itl-reference-parser",
        description="Independent, fail-closed reader for observed Windows iTunes ITL files.",
    )
    sub = parser.add_subparsers(dest="command", required=True)
    version = sub.add_parser("detect", help="detect the envelope version/profile")
    version.add_argument("input", type=Path)
    version.add_argument("--output", type=Path)
    dump = sub.add_parser("dump", help="emit a bounded record tree")
    dump.add_argument("input", type=Path)
    dump.add_argument("--output", type=Path)
    dump.add_argument("--include-header-hex", action="store_true")
    summary = sub.add_parser("summary", help="emit selected semantic fields")
    summary.add_argument("input", type=Path)
    summary.add_argument("--output", type=Path)
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        if args.command == "detect":
            value = detect(args.input)
            _write_json(value, args.output)
            return 0 if value["status"] == "recognized" else 2
        library = ReferenceLibrary.read(args.input)
        if args.command == "dump":
            value = library.record_dump(include_header_hex=args.include_header_hex)
        else:
            value = library.semantic_summary()
        _write_json(value, args.output)
        return 0
    except (ReferenceError, OSError, ValueError) as exc:
        print(f"itl-reference-parser: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
