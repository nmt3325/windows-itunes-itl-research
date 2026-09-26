"""Independent stdlib manifest + complete file-set verifier (no native actions)."""
import argparse
import hashlib
import json
import pathlib
import sys

MANIFEST = "DELIVERY-MANIFEST.json"
GENERATED_METADATA_DIR = "windows_itl_research.egg-info"
EXCLUDED_ROOT_DIRS = {".git", GENERATED_METADATA_DIR}
EXCLUDED_ROOT_DIRS_FOLDED = {name.casefold() for name in EXCLUDED_ROOT_DIRS}


def excluded_root(relative):
    return bool(relative.parts) and relative.parts[0].casefold() in EXCLUDED_ROOT_DIRS_FOLDED


def verify(root):
    root = root.resolve()
    rows = json.loads((root / MANIFEST).read_text(encoding="utf-8-sig"))
    seen = set()
    issues = []
    for row in rows:
        text = row["path"]
        relative = pathlib.PurePosixPath(text)
        path = root / text
        if (
            relative.is_absolute()
            or pathlib.PureWindowsPath(text).drive
            or ".." in relative.parts
            or "\\" in text
            or text == MANIFEST
            or excluded_root(relative)
            or path.is_symlink()
            or not path.resolve().is_relative_to(root)
        ):
            issues.append({"path": text, "issue": "unsafe_or_excluded_path"})
            continue
        if text.casefold() in seen:
            issues.append({"path": text, "issue": "duplicate_casefold_path"})
            continue
        seen.add(text.casefold())
        if not path.is_file():
            issues.append({"path": text, "issue": "missing_file"})
            continue
        digest = hashlib.sha256()
        size = 0
        with path.open("rb") as stream:
            while block := stream.read(65536):
                digest.update(block)
                size += len(block)
        if size != row["bytes"] or digest.hexdigest() != row["sha256"]:
            issues.append({"path": text, "issue": "digest_or_size_mismatch"})

    actual = set()
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        relative = pathlib.PurePosixPath(path.relative_to(root).as_posix())
        if excluded_root(relative):
            continue
        actual.add(relative.as_posix())
    expected = {row["path"] for row in rows} | {MANIFEST}
    issues.extend({"path": item, "issue": "unlisted_extra_file"} for item in sorted(actual - expected))
    issues.extend({"path": item, "issue": "listed_missing_file"} for item in sorted(expected - actual))
    manifest_paths = {row["path"] for row in rows}
    return {
        "ok": not issues,
        "manifest_entries": len(rows),
        "complete_file_count": len(actual),
        "manifest_self_excluded": MANIFEST not in manifest_paths,
        "generated_metadata_excluded": not any(
            pathlib.PurePosixPath(item).parts
            and pathlib.PurePosixPath(item).parts[0].casefold() == GENERATED_METADATA_DIR.casefold()
            for item in manifest_paths
        ),
        "issues": issues,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("root", type=pathlib.Path)
    parser.add_argument("--out", type=pathlib.Path)
    args = parser.parse_args()
    result = verify(args.root)
    text = json.dumps(result, indent=2) + "\n"
    if args.out:
        with args.out.open("x", encoding="utf-8") as stream:
            stream.write(text)
    print(text, end="")
    sys.exit(0 if result["ok"] else 1)
