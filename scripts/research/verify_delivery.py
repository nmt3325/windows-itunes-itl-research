"""Verify checksums and the exact delivered file set, excluding only .git and this manifest."""
from pathlib import Path, PurePosixPath, PureWindowsPath
import argparse
import hashlib
import json
import os
import re

MANIFEST = 'DELIVERY-MANIFEST.json'
RESERVED = {'CON', 'PRN', 'AUX', 'NUL'} | {f'{p}{i}' for p in ('COM', 'LPT') for i in range(1, 10)}


def safe_relative(value):
    if not isinstance(value, str) or not value or '\\' in value or ':' in value or any(ord(c) < 32 for c in value):
        raise ValueError('Unsafe manifest path')
    p = PurePosixPath(value)
    if p.is_absolute() or PureWindowsPath(value).drive or p.as_posix() != value:
        raise ValueError('Non-canonical manifest path: ' + value)
    if any(x in ('', '.', '..') or x.rstrip(' .') != x or x.split('.')[0].upper() in RESERVED for x in p.parts):
        raise ValueError('Unsafe path component: ' + value)
    if p.parts[0].casefold() == '.git' or value.casefold() == MANIFEST.casefold():
        raise ValueError('Excluded or self-referencing manifest path: ' + value)
    return p


def is_link(path):
    return path.is_symlink() or (hasattr(path, 'is_junction') and path.is_junction())


def actual_files(root):
    result = set()
    folded = set()
    for base, dirs, files in os.walk(root, followlinks=False):
        base = Path(base)
        if base == root:
            dirs[:] = [x for x in dirs if x != '.git']
        for name in dirs:
            p = base / name
            if is_link(p):
                raise ValueError('Linked directory is not allowed: ' + str(p.relative_to(root)))
        for name in files:
            p = base / name
            rel = p.relative_to(root).as_posix()
            if base == root and name == '.git':
                continue
            if rel == MANIFEST:
                continue
            safe_relative(rel)
            if is_link(p) or not p.is_file() or not p.resolve().is_relative_to(root):
                raise ValueError('Unsafe actual file: ' + rel)
            f = rel.casefold()
            if f in folded:
                raise ValueError('Case-insensitive file alias: ' + rel)
            folded.add(f)
            result.add(rel)
    return result


def verify(root):
    root = root.resolve(strict=True)
    manifest = root / MANIFEST
    if is_link(manifest) or not manifest.is_file():
        raise ValueError('Manifest must be a regular unlinked file')
    rows = json.loads(manifest.read_text(encoding='utf-8-sig'))
    if not isinstance(rows, list):
        raise ValueError('Manifest must contain a list')
    seen, folded = set(), set()
    for row in rows:
        if not isinstance(row, dict) or set(row) != {'path', 'bytes', 'sha256'}:
            raise ValueError('Invalid manifest entry')
        rel = safe_relative(row['path'])
        key = rel.as_posix()
        fold = key.casefold()
        if key in seen or fold in folded:
            raise ValueError('Duplicate or case-insensitive manifest alias: ' + key)
        if type(row['bytes']) is not int or row['bytes'] < 0:
            raise ValueError('Invalid byte count: ' + key)
        if not isinstance(row['sha256'], str) or re.fullmatch(r'[0-9a-f]{64}', row['sha256']) is None:
            raise ValueError('Invalid SHA-256: ' + key)
        seen.add(key)
        folded.add(fold)
        path = root.joinpath(*rel.parts)
        cursor = root
        for part in rel.parts:
            cursor /= part
            if is_link(cursor):
                raise ValueError('Linked manifest path: ' + key)
        if not path.is_file() or not path.resolve().is_relative_to(root):
            raise ValueError('Missing or unsafe manifest file: ' + key)
        if path.stat().st_size != row['bytes']:
            raise ValueError('Size mismatch: ' + key)
        digest = hashlib.sha256()
        with path.open('rb') as stream:
            for chunk in iter(lambda: stream.read(1024 * 1024), b''):
                digest.update(chunk)
        if digest.hexdigest() != row['sha256']:
            raise ValueError('Checksum mismatch: ' + key)
    actual = actual_files(root)
    if actual != seen:
        raise ValueError('File set mismatch; missing=' + repr(sorted(seen - actual)[:5]) + '; unlisted=' + repr(sorted(actual - seen)[:5]))
    return len(rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('root', nargs='?', type=Path, default=Path(__file__).resolve().parents[2])
    args = parser.parse_args()
    try:
        count = verify(args.root)
    except (OSError, ValueError, TypeError, KeyError) as exc:
        raise SystemExit('Verification failed: ' + str(exc)) from exc
    print(f'Verified {count} files, checksums and exact file set (manifest and .git excluded).')


if __name__ == '__main__':
    main()
