"""Deterministic synthetic ITL generator with machine-readable provenance."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys

from REFERENCE_PARSER.core import ReferenceLibrary, decode_envelope_bytes
from REFERENCE_WRITER.writer import atomic_write_new, encode_envelope
from VALIDATOR.validator import validate_bytes

GENERATOR_NAME = "independent-reference-test-generator"
GENERATOR_VERSION = 1
DEFAULT_VERSION = "12.13.10.3"
DEFAULT_FILE_PID = 0x5245464552454E43  # ASCII-ish deterministic "REFERENC"
DEFAULT_TRACK_PID = 0xA17E000000000001
DEFAULT_PLAYLIST_PID = 0xA17E000000000002
DEFAULT_ITEM_PID = 0xA17E000000000003


def _put(buffer: bytearray, offset: int, value: int, width: int = 4) -> None:
    if type(value) is not int or not 0 <= value < 1 << (8 * width):
        raise ValueError(f"value does not fit uint{width * 8}")
    if offset < 0 or offset + width > len(buffer):
        raise ValueError("field does not fit record header")
    buffer[offset : offset + width] = value.to_bytes(width, "little")


def _header(tag: bytes, size: int) -> bytearray:
    if len(tag) != 4 or size < 12:
        raise ValueError("invalid record header request")
    value = bytearray(size)
    value[:4] = tag
    _put(value, 4, size)
    return value


def _mhoh(type_code: int, text: str) -> bytes:
    encoded = text.encode("utf-16-le", errors="strict")
    payload = bytearray(16)
    _put(payload, 0, 1)
    _put(payload, 4, len(encoded))
    header = _header(b"mhoh", 24)
    _put(header, 8, len(header) + len(payload) + len(encoded))
    _put(header, 12, type_code)
    return bytes(header) + bytes(payload) + encoded


def _track(name: str) -> bytes:
    name_object = _mhoh(2, name)
    header = _header(b"mith", 756)
    _put(header, 8, len(header) + len(name_object))
    _put(header, 12, 1)  # one mhoh child
    _put(header, 0x10, 1)  # local track ID
    _put(header, 0x14, 1)  # observed record-kind raw value
    _put(header, 0x80, DEFAULT_TRACK_PID, 8)
    header[0x6D] = 0
    header[0xEE] = 0
    return bytes(header) + name_object


def _playlist(name: str) -> bytes:
    name_object = _mhoh(100, name)
    item = _header(b"mtph", 84)
    _put(item, 8, len(item))
    _put(item, 12, 0)
    _put(item, 0x10, 1)
    _put(item, 0x18, 1)
    _put(item, 0x20, 1, 8)
    _put(item, 0x44, DEFAULT_ITEM_PID, 8)
    header = _header(b"miph", 3500)
    _put(header, 8, len(header) + len(name_object) + len(item))
    _put(header, 12, 1)
    _put(header, 16, 1)
    _put(header, 0x1B8, DEFAULT_PLAYLIST_PID, 8)
    _put(header, 0xD40, 1)
    return bytes(header) + name_object + bytes(item)


def _list_root(tag: bytes, header_size: int, children: list[bytes]) -> bytes:
    header = _header(tag, header_size)
    _put(header, 8, len(children))  # count framing, not total length
    return bytes(header) + b"".join(children)


def _section(section_type: int, root: bytes) -> bytes:
    header = _header(b"msdh", 96)
    _put(header, 8, len(header) + len(root))
    _put(header, 12, section_type)
    return bytes(header) + root


def build_payload(track_name: str, playlist_name: str) -> tuple[bytes, dict[str, int]]:
    """Build one track/one playlist payload entirely from declared fields."""
    counts = {"sections": 5, "tracks": 1, "playlists": 1, "albums": 0, "artists": 0}
    track_section = _section(1, _list_root(b"mlth", 92, [_track(track_name)]))
    playlist_section = _section(2, _list_root(b"mlph", 92, [_playlist(playlist_name)]))
    album_section = _section(9, _list_root(b"mlah", 92, []))
    artist_section = _section(11, _list_root(b"mlih", 100, []))

    # mfdh is fixed framing: +8 is the logical uncompressed file length,
    # not a record total size. Its inner counts mirror the outer header.
    mfdh = _header(b"mfdh", 144)
    _put(mfdh, 0x30, counts["sections"])
    _put(mfdh, 0x44, counts["tracks"])
    _put(mfdh, 0x48, counts["playlists"])
    _put(mfdh, 0x4C, counts["albums"])
    _put(mfdh, 0x54, counts["artists"])
    placeholder_main = _section(16, bytes(mfdh))
    payload_size = sum(
        map(len, (placeholder_main, album_section, artist_section, track_section, playlist_section))
    )
    _put(mfdh, 8, 144 + payload_size)  # outer header is 144 in generated mode
    main_section = _section(16, bytes(mfdh))
    return (
        main_section + album_section + artist_section + track_section + playlist_section,
        counts,
    )


def generate_bytes(
    *,
    track_name: str = "Reference Track",
    playlist_name: str = "Reference Playlist",
    version: str = DEFAULT_VERSION,
    compressed: bool = False,
    template_bytes: bytes | None = None,
) -> tuple[bytes, dict]:
    """Generate bytes and provenance; native acceptance is always unverified."""
    payload, counts = build_payload(track_name, playlist_name)
    template_sha256 = None
    if template_bytes is not None:
        template = decode_envelope_bytes(template_bytes)
        if template.version != version:
            raise ValueError(
                f"template version {template.version} does not match requested {version}"
            )
        template_sha256 = hashlib.sha256(template_bytes).hexdigest()
        compression_flag = template.compression_flag
        encryption_flag = template.encryption_flag
        max_crypt_size = template.max_crypt_size
        file_pid = template.file_persistent_id
        # The generated mfdh logical size assumes the actual copied header size.
        if len(template.header) != 144:
            raise ValueError("template generation currently requires a 144-byte header")
    else:
        compression_flag = 1 if compressed else 0
        encryption_flag = 0
        max_crypt_size = 0
        file_pid = DEFAULT_FILE_PID
    raw = encode_envelope(
        payload,
        version=version,
        counts=counts,
        file_persistent_id=file_pid,
        compression_flag=compression_flag,
        encryption_flag=encryption_flag,
        max_crypt_size=max_crypt_size,
        template=template_bytes,
    )
    # Both checks are independent of itlkit and are part of generation.
    ReferenceLibrary.from_bytes(raw)
    validation = validate_bytes(raw)
    if not validation["valid"]:
        errors = [x for x in validation["issues"] if x["severity"] == "error"]
        raise ValueError(f"generated file failed independent validation: {errors}")
    digest = hashlib.sha256(raw).hexdigest()
    provenance = {
        "schema": "reference-itl.generation-provenance.v1",
        "generator": {"name": GENERATOR_NAME, "version": GENERATOR_VERSION},
        "generation_mode": "template-envelope" if template_bytes is not None else "from-scratch",
        "template_reused": template_bytes is not None,
        "template_sha256": template_sha256,
        "output_sha256": digest,
        "output_size": len(raw),
        "target_version": version,
        "inputs": {
            "track_name": track_name,
            "playlist_name": playlist_name,
            "compressed": bool(compression_flag),
            "encryption_flag": encryption_flag,
        },
        "structural_validation": {
            "status": "passed",
            "validator_schema": validation["schema"],
            "opaque_bytes_semantically_validated": False,
        },
        "native_acceptance": {
            "status": "unverified",
            "tested": False,
            "reason": "No iTunes launch/save/reload evidence is associated with this generated output.",
        },
    }
    return raw, provenance


def provenance_path(output: Path) -> Path:
    return output.with_name(output.name + ".provenance.json")


def write_generated(output: str | Path, **kwargs) -> dict:
    output = Path(output)
    sidecar = provenance_path(output)
    if output.exists() or sidecar.exists():
        raise FileExistsError("output or provenance sidecar already exists")
    raw, provenance = generate_bytes(**kwargs)
    text = (json.dumps(provenance, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode(
        "utf-8"
    )
    atomic_write_new(output, raw)
    try:
        atomic_write_new(sidecar, text)
    except Exception:
        output.unlink(missing_ok=True)
        raise
    return provenance


def build_manifest(root: str | Path) -> dict:
    root = Path(root)
    generated = root / "generated"
    files = []
    if generated.exists():
        for path in sorted(p for p in generated.rglob("*") if p.is_file()):
            raw = path.read_bytes()
            entry = {
                "path": path.relative_to(root).as_posix(),
                "bytes": len(raw),
                "sha256": hashlib.sha256(raw).hexdigest(),
            }
            if path.suffix.lower() == ".itl":
                sidecar = provenance_path(path)
                provenance = json.loads(sidecar.read_text(encoding="utf-8"))
                entry["template_reused"] = provenance["template_reused"]
                entry["native_acceptance"] = provenance["native_acceptance"]["status"]
                entry["version"] = provenance["target_version"]
            files.append(entry)
    return {
        "schema": "reference-itl.corpus-manifest.v1",
        "hash_algorithm": "sha256",
        "manifest_self_included": False,
        "files": files,
    }


def write_manifest(root: str | Path, *, replace: bool = False) -> dict:
    root = Path(root)
    manifest = build_manifest(root)
    destination = root / "corpus-manifest.json"
    data = (json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode(
        "utf-8"
    )
    if replace:
        destination.write_bytes(data)
    else:
        atomic_write_new(destination, data)
    return manifest


def check_manifest(root: str | Path) -> dict:
    root = Path(root)
    destination = root / "corpus-manifest.json"
    expected = json.loads(destination.read_text(encoding="utf-8"))
    actual = build_manifest(root)
    return {
        "ok": expected == actual,
        "expected": expected,
        "actual": actual,
    }


def generate_default_corpus(root: str | Path) -> dict:
    root = Path(root)
    generated = root / "generated"
    generated.mkdir(parents=True, exist_ok=True)
    write_generated(
        generated / "reference-one-track-raw.itl",
        track_name="Reference Track",
        playlist_name="Reference Playlist",
        compressed=False,
    )
    write_generated(
        generated / "reference-one-track-zlib.itl",
        track_name="Reference Track Zlib",
        playlist_name="Reference Playlist Zlib",
        compressed=True,
    )
    return write_manifest(root)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="itl-test-corpus",
        description="Generate deterministic synthetic ITLs with explicit provenance.",
    )
    sub = parser.add_subparsers(dest="command", required=True)
    one = sub.add_parser("generate")
    one.add_argument("output", type=Path)
    one.add_argument("--track-name", default="Reference Track")
    one.add_argument("--playlist-name", default="Reference Playlist")
    one.add_argument("--version", default=DEFAULT_VERSION)
    one.add_argument("--compressed", action="store_true")
    one.add_argument("--template", type=Path)
    corpus = sub.add_parser("generate-corpus")
    corpus.add_argument("--directory", type=Path, default=Path(__file__).resolve().parent)
    manifest = sub.add_parser("manifest")
    manifest.add_argument("--directory", type=Path, default=Path(__file__).resolve().parent)
    manifest.add_argument("--check", action="store_true")
    manifest.add_argument("--replace", action="store_true")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        if args.command == "generate":
            template = args.template.read_bytes() if args.template else None
            result = write_generated(
                args.output,
                track_name=args.track_name,
                playlist_name=args.playlist_name,
                version=args.version,
                compressed=args.compressed,
                template_bytes=template,
            )
        elif args.command == "generate-corpus":
            result = generate_default_corpus(args.directory)
        elif args.check:
            result = check_manifest(args.directory)
            print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))
            return 0 if result["ok"] else 2
        else:
            result = write_manifest(args.directory, replace=args.replace)
        print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))
        return 0
    except (OSError, ValueError) as exc:
        print(f"itl-test-corpus: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
