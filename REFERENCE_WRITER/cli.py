"""CLI for fail-closed version conversion."""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

from .writer import ConversionRefused, WriterError, convert_version


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="itl-reference-writer",
        description="Byte-exact identity conversion; unsupported migrations fail closed.",
    )
    sub = parser.add_subparsers(dest="command", required=True)
    convert = sub.add_parser("convert", help="convert only when the version mapping is qualified")
    convert.add_argument("input", type=Path)
    convert.add_argument("output", type=Path)
    convert.add_argument("--to-version", required=True)
    convert.add_argument("--report", type=Path)
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        report = convert_version(args.input, args.output, args.to_version)
        text = json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        if args.report:
            args.report.write_text(text, encoding="utf-8", newline="\n")
        else:
            sys.stdout.write(text)
        return 0
    except (ConversionRefused, WriterError, OSError, ValueError) as exc:
        print(f"itl-reference-writer: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
