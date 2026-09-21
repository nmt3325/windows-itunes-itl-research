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
GENERATOR_VERSION = 2
DEFAULT_VERSION = "12.13.10.3"
DEFAULT_FILE_PID = 0x5245464552454E43  # ASCII-ish deterministic "REFERENC"
DEFAULT_TRACK_PID = 0xA17E000000000001
DEFAULT_PLAYLIST_PID = 0xA17E000000000002
DEFAULT_ITEM_PID = 0xA17E000000000003
DEFAULT_ALBUM_PID = 0xA17E000000000004
DEFAULT_ARTIST_PID = 0xA17E000000000005
DEFAULT_MASTER_ITEM_PID = 0xA17E000000000006
DEFAULT_TIMESTAMP = 0xE65FD700
DEFAULT_MEDIA_FOLDER_URL = "file://localhost/C:/Users/runneradmin/Music/iTunes/iTunes%20Media/"
DEFAULT_SECTION_ORDER = (16, 12, 9, 11, 1, 13, 23, 2, 14, 4)
CURRENT_ENCRYPTION_CAP = 102400

# Qualification is exact-output evidence, not a claim about arbitrary values.
_NATIVE_QUALIFIED_OUTPUTS = {
    "c6c68171d57350ceb3cf379eee13a764ea199536ef18238fe4faf80583492d74": {
        "case": "reference-one-track-raw",
        "evidence": "evidence/native/reference-generated-20260922-passed/cases/reference-one-track-raw/result.json",
    },
    "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad": {
        "case": "reference-one-track-zlib",
        "evidence": "evidence/native/reference-generated-20260922-passed/cases/reference-one-track-zlib/result.json",
    },
}


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


def _playlist_item(item_pid: int) -> bytes:
    item = _header(b"mtph", 84)
    _put(item, 8, len(item))
    _put(item, 0x10, 1)  # item/local-track reference
    _put(item, 0x18, 1)  # order token
    _put(item, 0x20, 1, 8)  # observed 64-bit local-track reference
    _put(item, 0x44, item_pid, 8)
    return bytes(item)


def _track(name: str) -> bytes:
    name_object = _mhoh(2, name)
    header = _header(b"mith", 756)
    _put(header, 8, len(header) + len(name_object))
    _put(header, 12, 1)
    _put(header, 0x10, 1)
    _put(header, 0x14, 1)
    _put(header, 0x50, 2)
    _put(header, 0x78, DEFAULT_TIMESTAMP)
    _put(header, 0x80, DEFAULT_TRACK_PID, 8)
    _put(header, 0xDC, 3)
    _put(header, 0x14C, 0x80)
    _put(header, 0x1E0, 4)
    _put(header, 0x274, 1)
    for offset in range(0x290, 0x2AC, 4):
        _put(header, offset, 1000)
    return bytes(header) + name_object


def _indexed_entity(tag: bytes, header_size: int, local_id: int, persistent_id: int) -> bytes:
    header = _header(tag, header_size)
    _put(header, 8, header_size)
    _put(header, 0x10, local_id)
    _put(header, 0x14, persistent_id, 8)
    header[0x1C] = 2
    return bytes(header)


def _playlist(name: str, persistent_id: int, local_id: int, item_pid: int, *, master: bool) -> bytes:
    children = [_mhoh(100, name), _playlist_item(item_pid)]
    header = _header(b"miph", 3500)
    _put(header, 8, len(header) + sum(map(len, children)))
    _put(header, 12, 1)  # one metadata object; mtph count is separate
    _put(header, 0x10, 1)
    header[0x18] = 7
    header[0x1A] = 1
    if master:
        header[0x16] = 1
    _put(header, 0x1B8, persistent_id, 8)
    header[0x737] = 1
    _put(header, 0xD40, local_id)
    return bytes(header) + b"".join(children)


def _list_root(tag: bytes, header_size: int, children: list[bytes]) -> bytes:
    header = _header(tag, header_size)
    _put(header, 8, len(children))
    return bytes(header) + b"".join(children)


def _section(section_type: int, body: bytes) -> bytes:
    header = _header(b"msdh", 96)
    _put(header, 8, len(header) + len(body))
    _put(header, 12, section_type)
    return bytes(header) + body


def _mhgh() -> bytes:
    header = _header(b"mhgh", 280)
    _put(header, 8, 0)
    header[0x0E] = 0x2C
    header[0x2A] = 1
    header[0x32] = 1
    header[0x35] = 1
    header[0x37] = 3
    header[0x3F] = 1
    header[0x67] = 2
    header[0x96] = 1
    _put(header, 0xA8, 0x00015180)
    _put(header, 0xB4, DEFAULT_TIMESTAMP)
    header[0xD3:0xDE] = bytes.fromhex("06ffffffffffffffff0301")
    header[0xE4] = 2
    header[0xE6] = 2
    header[0xFA] = 1
    return bytes(header)


def _mfdh(
    counts: dict[str, int],
    *,
    file_persistent_id: int,
    encryption_flag: int,
    max_crypt_size: int,
    logical_size: int,
) -> bytes:
    header = _header(b"mfdh", 144)
    _put(header, 8, logical_size)
    header[0x0C] = 0x43
    header[0x0E] = 1
    version = DEFAULT_VERSION.encode("ascii")
    header[0x10] = len(version)
    header[0x11 : 0x11 + len(version)] = version
    _put(header, 0x30, counts["sections"])
    _put(header, 0x34, file_persistent_id, 8)
    header[0x3C] = 0x6F
    header[0x40] = 2
    header[0x41] = encryption_flag
    _put(header, 0x44, counts["tracks"])
    _put(header, 0x48, counts["playlists"])
    _put(header, 0x4C, counts["albums"])
    header[0x50] = 0x38
    header[0x52] = 1
    _put(header, 0x54, counts["artists"])
    header[0x58] = 0x64
    _put(header, 0x5C, max_crypt_size)
    _put(header, 0x70, DEFAULT_TIMESTAMP)
    return bytes(header)


def build_payload(
    track_name: str,
    playlist_name: str,
    *,
    file_persistent_id: int = DEFAULT_FILE_PID,
    encryption_flag: int = 0,
    max_crypt_size: int = 0,
    media_folder_url: str = DEFAULT_MEDIA_FOLDER_URL,
) -> tuple[bytes, dict[str, int]]:
    """Build the bounded current-profile payload entirely from declared constants."""
    try:
        media_folder = media_folder_url.encode("ascii", errors="strict")
    except UnicodeEncodeError as exc:
        raise ValueError("media_folder_url must be an ASCII file URL") from exc
    counts = {"sections": 10, "tracks": 1, "playlists": 2, "albums": 1, "artists": 1}
    album = _indexed_entity(b"miah", 88, 3, DEFAULT_ALBUM_PID)
    artist = _indexed_entity(b"miih", 100, 4, DEFAULT_ARTIST_PID)
    master = _playlist("####!####", file_persistent_id, 5, DEFAULT_MASTER_ITEM_PID, master=True)
    ordinary = _playlist(playlist_name, DEFAULT_PLAYLIST_PID, 6, DEFAULT_ITEM_PID, master=False)
    sections: list[bytes | None] = [
        None,
        _section(12, _mhgh()),
        _section(9, _list_root(b"mlah", 92, [album])),
        _section(11, _list_root(b"mlih", 100, [artist])),
        _section(1, _list_root(b"mlth", 92, [_track(track_name)])),
        _section(13, _list_root(b"mlth", 92, [])),
        _section(23, bytes(_header(b"stsh", 96))),
        _section(2, _list_root(b"mlph", 92, [master, ordinary])),
        _section(14, _list_root(b"mlph", 92, [])),
        _section(4, media_folder),
    ]
    sections[0] = _section(
        16,
        _mfdh(
            counts,
            file_persistent_id=file_persistent_id,
            encryption_flag=encryption_flag,
            max_crypt_size=max_crypt_size,
            logical_size=0,
        ),
    )
    provisional = b"".join(section for section in sections if section is not None)
    sections[0] = _section(
        16,
        _mfdh(
            counts,
            file_persistent_id=file_persistent_id,
            encryption_flag=encryption_flag,
            max_crypt_size=max_crypt_size,
            logical_size=144 + len(provisional),
        ),
    )
    payload = b"".join(section for section in sections if section is not None)
    return payload, counts


def _apply_current_outer_defaults(raw: bytes) -> bytes:
    result = bytearray(raw)
    if len(result) < 144 or result[:4] != b"hdfm":
        raise ValueError("encoded envelope lacks the expected 144-byte hdfm header")
    result[0x0D] = 0x43
    result[0x0F] = 1
    result[0x3F] = 0x6F
    result[0x40] = 2
    result[0x51] = 0x38
    result[0x5B] = 0x64
    result[0x70:0x74] = DEFAULT_TIMESTAMP.to_bytes(4, "big")
    return bytes(result)


def _native_acceptance(digest: str, *, template_reused: bool) -> dict:
    qualification = None if template_reused else _NATIVE_QUALIFIED_OUTPUTS.get(digest)
    if qualification is None:
        return {
            "status": "unverified",
            "tested": False,
            "scope": "exact_output_sha256",
            "reason": "No retained iTunes launch/save/reload evidence matches this exact output hash.",
        }
    return {
        "status": "verified",
        "tested": True,
        "scope": "exact_output_sha256",
        "case": qualification["case"],
        "evidence": qualification["evidence"],
        "cycles": 2,
        "opened_without_repair": True,
        "opened_without_backup_restore": True,
        "opened_without_xml_rebuild": True,
    }


def generate_bytes(
    *,
    track_name: str = "Reference Track",
    playlist_name: str = "Reference Playlist",
    version: str = DEFAULT_VERSION,
    compressed: bool = False,
    template_bytes: bytes | None = None,
    media_folder_url: str = DEFAULT_MEDIA_FOLDER_URL,
) -> tuple[bytes, dict]:
    """Generate a bounded current-profile ITL and explicit native provenance."""
    if version != DEFAULT_VERSION:
        raise ValueError(f"from-scratch profile is defined only for {DEFAULT_VERSION}; refusing {version}")
    template_sha256 = None
    if template_bytes is not None:
        template = decode_envelope_bytes(template_bytes)
        if template.version != version:
            raise ValueError(f"template version {template.version} does not match requested {version}")
        template_sha256 = hashlib.sha256(template_bytes).hexdigest()
        compression_flag = template.compression_flag
        encryption_flag = template.encryption_flag
        max_crypt_size = template.max_crypt_size
        file_pid = template.file_persistent_id
        if len(template.header) != 144:
            raise ValueError("template generation currently requires a 144-byte header")
    else:
        compression_flag = 1 if compressed else 0
        encryption_flag = 2 if compressed else 0
        max_crypt_size = CURRENT_ENCRYPTION_CAP if compressed else 0
        file_pid = DEFAULT_FILE_PID
    payload, counts = build_payload(
        track_name,
        playlist_name,
        file_persistent_id=file_pid,
        encryption_flag=encryption_flag,
        max_crypt_size=max_crypt_size,
        media_folder_url=media_folder_url,
    )
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
    if template_bytes is None:
        raw = _apply_current_outer_defaults(raw)
    ReferenceLibrary.from_bytes(raw)
    validation = validate_bytes(raw)
    if not validation["valid"]:
        errors = [x for x in validation["issues"] if x["severity"] == "error"]
        raise ValueError(f"generated file failed independent validation: {errors}")
    digest = hashlib.sha256(raw).hexdigest()
    provenance = {
        "schema": "reference-itl.generation-provenance.v2",
        "generator": {"name": GENERATOR_NAME, "version": GENERATOR_VERSION},
        "generation_mode": "template-envelope" if template_bytes is not None else "from-scratch",
        "template_reused": template_bytes is not None,
        "template_sha256": template_sha256,
        "output_sha256": digest,
        "output_size": len(raw),
        "target_version": version,
        "profile": {
            "section_order": list(DEFAULT_SECTION_ORDER),
            "timestamp_fixture": DEFAULT_TIMESTAMP,
            "media_folder_url": media_folder_url,
            "master_playlist_included": True,
        },
        "inputs": {
            "track_name": track_name,
            "playlist_name": playlist_name,
            "compressed": bool(compression_flag),
            "encryption_flag": encryption_flag,
            "max_crypt_size": max_crypt_size,
        },
        "structural_validation": {
            "status": "passed",
            "validator_schema": validation["schema"],
            "opaque_bytes_semantically_validated": False,
        },
        "native_acceptance": _native_acceptance(digest, template_reused=template_bytes is not None),
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
    one.add_argument("--media-folder-url", default=DEFAULT_MEDIA_FOLDER_URL)
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
                media_folder_url=args.media_folder_url,
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
