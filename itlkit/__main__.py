"""Non-destructive command-line interface: all output paths must be new."""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
import sys
from .container import Container
from .library import Library
from .errors import ITLError
from .io import write_new


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog='itlkit', description='Lossless Windows iTunes ITL research codec. Unknown semantics remain unsupported.')
    parser.add_argument('--version', action='version', version='itlkit 0.1.0')
    commands = parser.add_subparsers(dest='command', required=True)
    info = commands.add_parser('inspect', help='validate and print a semantic JSON summary')
    info.add_argument('input', type=Path)
    info.add_argument('--output', type=Path)
    check = commands.add_parser('check', help='validate, verify exact no-op and forced container reconstruction')
    check.add_argument('input', type=Path)
    rt = commands.add_parser('roundtrip', help='write an unchanged or forcibly reconstructed library')
    rt.add_argument('input', type=Path); rt.add_argument('output', type=Path)
    rt.add_argument('--rebuild', action='store_true', help='force fresh zlib compression and AES encryption')
    rt.add_argument('--compression-level', type=int, default=6)
    export = commands.add_parser('export-json', help='export the reversible raw model and an editable operations array')
    export.add_argument('input', type=Path); export.add_argument('output', type=Path)
    imp = commands.add_parser('import-json', help='import an unaltered raw model and apply supported operations')
    imp.add_argument('input', type=Path); imp.add_argument('output', type=Path)
    imp.add_argument('--rebuild', action='store_true')
    patch = commands.add_parser('patch', help='apply a JSON operation list transactionally to a new file')
    patch.add_argument('input', type=Path); patch.add_argument('operations', type=Path); patch.add_argument('output', type=Path)
    restore = commands.add_parser('import-track', help='restore a local WAV record from another snapshot of the same library')
    restore.add_argument('input', type=Path); restore.add_argument('donor', type=Path)
    restore.add_argument('persistent_id'); restore.add_argument('output', type=Path)
    dec = commands.add_parser('decode', help='export decompressed bytes (container only; can inspect damaged libraries)')
    dec.add_argument('input', type=Path); dec.add_argument('output', type=Path)
    enc = commands.add_parser('encode', help='pack raw decompressed bytes using an existing outer header; structural validation only')
    enc.add_argument('template', type=Path); enc.add_argument('payload', type=Path); enc.add_argument('output', type=Path)
    return parser


def _json(value) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode('utf-8')


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        if args.command == 'decode':
            write_new(args.output, Container.read(args.input).payload)
        elif args.command == 'encode':
            container = Container.read(args.template)
            container.payload = args.payload.read_bytes()
            data = container.to_bytes(rebuild=True)
            Library.from_bytes(data)
            write_new(args.output, data)
        elif args.command == 'import-json':
            value = json.loads(args.input.read_text(encoding='utf-8-sig'))
            Library.from_dict(value).write(args.output, rebuild=args.rebuild)
        else:
            library = Library.read(args.input)
            if args.command == 'inspect':
                data = _json(library.summary())
                if args.output:
                    write_new(args.output, data)
                else:
                    sys.stdout.write(data.decode('utf-8'))
            elif args.command == 'roundtrip':
                library.write(args.output, rebuild=args.rebuild, compression_level=args.compression_level)
            elif args.command == 'export-json':
                write_new(args.output, _json(library.to_dict()))
            elif args.command == 'patch':
                operations = json.loads(args.operations.read_text(encoding='utf-8-sig'))
                library.apply_operations(operations)
                library.write(args.output)
            elif args.command == 'import-track':
                library.add_track_from(Library.read(args.donor), args.persistent_id)
                library.write(args.output)
            elif args.command == 'check':
                raw = args.input.read_bytes()
                noop = library.to_bytes()
                rebuilt = library.to_bytes(rebuild=True)
                decoded = Library.from_bytes(rebuilt)
                assert noop == raw, 'no-op output differs from original'
                assert decoded.container.payload == library.container.payload, 'rebuilt payload differs'
                print(json.dumps({'ok': True, 'sha256': hashlib.sha256(raw).hexdigest(),
                                  'noop_bit_exact': True, 'rebuilt_payload_exact': True,
                                  'native_acceptance': 'not tested by this command',
                                  'tracks': len(library.tracks), 'playlists': len(library.playlists)}))
        return 0
    except (ITLError, ValueError, OSError, KeyError, TypeError) as exc:
        print(f'itlkit: {exc}', file=sys.stderr)
        return 2


if __name__ == '__main__':
    if hasattr(sys.stdout, 'reconfigure'):
        sys.stdout.reconfigure(encoding='utf-8')
        sys.stderr.reconfigure(encoding='utf-8')
    raise SystemExit(main())