"""CLI for deterministic semantic comparison."""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

from REFERENCE_PARSER.core import ReferenceError
from .diff import semantic_diff


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="itl-semantic-diff",
        description="Compare selected ITL semantics and report unmodeled section digests.",
    )
    parser.add_argument("before", type=Path)
    parser.add_argument("after", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--fail-on-change", action="store_true")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        report = semantic_diff(args.before, args.after)
        text = json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
        if args.output:
            args.output.write_text(text, encoding="utf-8", newline="\n")
        else:
            sys.stdout.write(text)
        return 1 if args.fail_on_change and report["has_differences"] else 0
    except (ReferenceError, OSError, ValueError) as exc:
        print(f"itl-semantic-diff: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
