"""CLI for independent structural/reference validation."""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

from .validator import validate


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="itl-reference-validate",
        description="Validate ITL framing, counts, identities, and known references.",
    )
    parser.add_argument("input", type=Path)
    parser.add_argument("--output", type=Path)
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        report = validate(args.input)
        text = json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        if args.output:
            args.output.write_text(text, encoding="utf-8", newline="\n")
        else:
            sys.stdout.write(text)
        return 0 if report["valid"] else 2
    except (OSError, ValueError) as exc:
        print(f"itl-reference-validate: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
