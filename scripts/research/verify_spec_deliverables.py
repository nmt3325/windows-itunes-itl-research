"""Validate the bounded specification deliverables without network access.

This deliberately checks repository-local consistency rather than claiming that
all binary-format statements are true. Evidence qualification remains a human
and native-test responsibility documented in EVIDENCE.md.
"""
from __future__ import annotations

import ast
import re
import sys
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parents[2]
REQUIRED = (
    "SCOPE.md",
    "ITL_FORMAT_SPEC.md",
    "ITL_DATA_MODEL.md",
    "ITL_RECORD_TYPES.md",
    "SMART_PLAYLIST_SPEC.md",
    "PATH_AND_TIME_SPEC.md",
    "VERSION_MATRIX.md",
    "corpus-manifest.json",
    "EVIDENCE.md",
    "UNRESOLVED.md",
    "completion-status.yaml",
)
REQUIRED_DIRS = ("REFERENCE_PARSER", "REFERENCE_WRITER", "VALIDATOR", "SEMANTIC_DIFF", "TEST_CORPUS")
MARKDOWN = tuple(Path(name) for name in REQUIRED if name.endswith(".md")) + (
    Path("README.md"),
    Path("docs/format.md"),
)
LINK_RE = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
CODE_RE = re.compile(r"`([^`\n]+)`")
PATH_PREFIXES = ("itlkit/", "tests/", "evidence/", "scripts/", "proposals/", "docs/")


def fail(message: str) -> None:
    raise AssertionError(message)


def local_target(doc: Path, raw: str) -> Path | None:
    target = unquote(raw.strip().split("#", 1)[0])
    if not target or "://" in target or target.startswith(("mailto:", "#")):
        return None
    target = target.split("::", 1)[0]
    return (ROOT / doc.parent / target).resolve()


def validate_required_files() -> None:
    for name in REQUIRED:
        path = ROOT / name
        if not path.is_file() or path.stat().st_size == 0:
            fail(f"missing or empty required deliverable: {name}")
    for name in REQUIRED_DIRS:
        path = ROOT / name
        if not path.is_dir() or not any(path.iterdir()):
            fail(f"missing or empty required deliverable directory: {name}")


def validate_links_and_selectors() -> None:
    for doc in MARKDOWN:
        path = ROOT / doc
        text = path.read_text(encoding="utf-8")
        for raw in LINK_RE.findall(text):
            target = local_target(doc, raw)
            if target is not None and not target.exists():
                fail(f"broken Markdown link in {doc}: {raw}")
        for token in CODE_RE.findall(text):
            candidate = token.split("::", 1)[0]
            if candidate in REQUIRED or candidate == "DELIVERY-MANIFEST.json" or candidate.startswith(PATH_PREFIXES):
                target = ROOT / candidate
                if not target.exists():
                    fail(f"missing referenced path in {doc}: {token}")
            if "::" in token and candidate.startswith("tests/"):
                selector = token.split("::", 1)[1]
                tree = ast.parse((ROOT / candidate).read_text(encoding="utf-8"), filename=candidate)
                names = {node.name for node in ast.walk(tree) if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef))}
                if selector not in names:
                    fail(f"missing test selector in {doc}: {token}")


def validate_canonicalization() -> None:
    canonical = (ROOT / "ITL_FORMAT_SPEC.md").read_text(encoding="utf-8")
    pointer = (ROOT / "docs/format.md").read_text(encoding="utf-8")
    if not canonical.startswith("# Windows iTunes ITL format specification\n"):
        fail("ITL_FORMAT_SPEC.md does not have the canonical title")
    if "../ITL_FORMAT_SPEC.md" not in pointer:
        fail("docs/format.md is not a compatibility pointer")
    if len(pointer.splitlines()) > 40:
        fail("docs/format.md appears to duplicate the canonical specification")


def validate_status_subset() -> None:
    path = ROOT / "completion-status.yaml"
    text = path.read_text(encoding="utf-8")
    required_fragments = (
        "deliverable_set: complete",
        "implementation: partial_guarded_research",
        "universal_itl_support: false",
        "percentage_complete: null",
        "disposition: research_checkpoint_not_universal_format_support",
        "branch: main",
        "full_analysis_specification_gate: false",
        "independent_reimplementation_passed: false",
    )
    for fragment in required_fragments:
        if fragment not in text:
            fail(f"completion-status.yaml is missing: {fragment}")
    if "pending_" in text or "status: pending" in text:
        fail("completion-status.yaml still contains a pending validation state")
    if "universal_itl_support: true" in text or re.search(r"percentage_complete:\s*100(?:\.0)?\s*$", text, re.MULTILINE):
        fail("completion-status.yaml overclaims completion")
    if "\t" in text:
        fail("completion-status.yaml contains tabs")
    for number, line in enumerate(text.splitlines(), 1):
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        indent = len(line) - len(line.lstrip(" "))
        if indent % 2:
            fail(f"completion-status.yaml has odd indentation on line {number}")
        item = line.strip()
        if item.startswith("- "):
            item = item[2:]
        if ":" not in item and not line.strip().startswith("- "):
            fail(f"completion-status.yaml has unsupported syntax on line {number}")


def main() -> int:
    validate_required_files()
    validate_links_and_selectors()
    validate_canonicalization()
    validate_status_subset()
    print("SPEC_DELIVERABLES_OK")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(f"SPEC_DELIVERABLES_ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
