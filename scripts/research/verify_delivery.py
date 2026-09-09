"""Verify every distributed file against DELIVERY-MANIFEST.json."""
from pathlib import Path
import argparse
import hashlib
import json


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('root', nargs='?', type=Path, default=Path(__file__).resolve().parents[2])
    args = parser.parse_args()
    root = args.root.resolve()
    rows = json.loads((root / 'DELIVERY-MANIFEST.json').read_text(encoding='utf-8-sig'))
    seen = set()
    for row in rows:
        relative = Path(row['path'])
        path = root / relative
        if relative.is_absolute() or '..' in relative.parts or path.is_symlink() or not path.resolve().is_relative_to(root):
            raise SystemExit('Unsafe manifest path: ' + row['path'])
        if row['path'] in seen:
            raise SystemExit('Duplicate manifest path: ' + row['path'])
        seen.add(row['path'])
        data = path.read_bytes()
        if len(data) != row['bytes'] or hashlib.sha256(data).hexdigest() != row['sha256']:
            raise SystemExit('Checksum mismatch: ' + row['path'])
    print('Verified', len(rows), 'distributed files (the manifest excludes itself).')


if __name__ == '__main__':
    main()
