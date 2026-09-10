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
    for name, label in (
        ('inspect-coverage', 'read-only field coverage; not semantic or native qualification'),
        ('inspect-playlists', 'read-only raw playlist and smart-rule diagnostics')):
        diagnostic = commands.add_parser(name, help=label)
        diagnostic.add_argument('input', type=Path)
        diagnostic.add_argument('--output', type=Path, help='new JSON file; default is stdout')
        diagnostic.add_argument('--max-file-bytes', type=int, default=16*1024**2,
                                help='reduce the 16 MiB encoded input cap')
        diagnostic.add_argument('--max-plain-bytes', type=int, default=16*1024**2,
                                help='reduce the 16 MiB decoded input cap')
        diagnostic.add_argument('--max-json-bytes', type=int, default=64*1024**2,
                                help='reduce the 64 MiB diagnostic output cap')
        if name == 'inspect-playlists':
            diagnostic.add_argument('--include-raw', action='store_true',
                                    help='include one exact decompressed payload as hex')
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


def _inspect_diagnostic(args) -> None:
    # Bounded read binds pathname stat to one opened handle. Outputs are reports,
    # not importable plans, semantic edits, or proof of native acceptance.
    from .schema import ReadLimits, read_bytes, encode_json
    defaults = ReadLimits()
    values = {name: getattr(args, name) for name in
              ('max_file_bytes', 'max_plain_bytes', 'max_json_bytes')}
    if any(type(value) is not int or not 0 < value <= getattr(defaults, name)
           for name, value in values.items()):
        raise ValueError('diagnostic byte limits may only reduce positive default caps')
    limits = ReadLimits(**values)
    raw = read_bytes(args.input, limits=limits)
    if args.command == 'inspect-coverage':
        from .raw import inspect_coverage
        data = encode_json(inspect_coverage(raw, limits=limits), limits=limits)
    else:
        from .playlist_models import inspect_playlists, models_json
        model = inspect_playlists(raw, limits=limits)
        data = models_json(model, limits=limits, include_raw=args.include_raw).encode('ascii')
    limits.check('json', len(data) + 1)
    data += b'\n'
    if args.output is not None:
        write_new(args.output, data)
    else:
        # Preserve the prechecked physical byte length on Windows: TextIOWrapper
        # would otherwise translate the final LF to CRLF. Text-only embeddings
        # remain supported without assuming a .buffer attribute.
        binary_stdout = getattr(sys.stdout, 'buffer', None)
        if binary_stdout is not None:
            sys.stdout.flush()
            binary_stdout.write(data)
            binary_stdout.flush()
        else:
            sys.stdout.write(data.decode('ascii'))


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        if args.command in ('inspect-coverage', 'inspect-playlists'):
            _inspect_diagnostic(args)
        elif args.command == 'decode':
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