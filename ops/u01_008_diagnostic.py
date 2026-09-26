from __future__ import annotations

from collections import Counter, defaultdict
from pathlib import Path
import hashlib
import json
import sys

import pefile
from capstone import Cs, CS_ARCH_X86, CS_MODE_64
from capstone.x86 import X86_OP_IMM, X86_OP_MEM, X86_REG_RIP

repo = Path(sys.argv[1]).resolve()
exe = Path(sys.argv[2]).resolve()
sys.path.insert(0, str(repo))
from REFERENCE_PARSER.core import ReferenceLibrary, decode_envelope_bytes


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def canonical_sha(value: object) -> str:
    return sha256(json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False).encode())


source_rel = Path("evidence/research/20260927/u01-distinct-build-12.12.10.1/positive-qualification/cases/native-authored-one-track-positive/cycle-2/native-saved.itl")
source = (repo / source_rel).read_bytes()
assert sha256(source) == "9034aa3e9e7ccc12390d0b44307d8ea10dd313fc424415050c8d5bf8ced0e772"
assert source[0x50:0x52] == bytes.fromhex("0038")
candidate_array = bytearray(source)
candidate_array[0x51] = 0x39
candidate = bytes(candidate_array)
source_env = decode_envelope_bytes(source)
candidate_env = decode_envelope_bytes(candidate)
source_sem = ReferenceLibrary.from_bytes(source).semantic_summary()
candidate_sem = ReferenceLibrary.from_bytes(candidate).semantic_summary()
source_sem.pop("sha256")
candidate_sem.pop("sha256")
assert source_env.payload == candidate_env.payload
assert source_sem == candidate_sem

manifest = json.loads((repo / "corpus-manifest.json").read_text(encoding="utf-8"))
manifest_rows = {row["path"]: row for row in manifest["itl_files"]}
itls = sorted(
    (p for p in repo.rglob("*.itl") if ".git" not in p.parts),
    key=lambda p: p.relative_to(repo).as_posix(),
)
assert len(itls) == len(manifest_rows) == 434
value_counts: Counter[str] = Counter()
by_version: dict[str, Counter[str]] = defaultdict(Counter)
parse_failures: list[dict] = []
for path in itls:
    rel = path.relative_to(repo).as_posix()
    data = path.read_bytes()
    row = manifest_rows[rel]
    assert len(data) == row["bytes"] and sha256(data) == row["sha256"]
    key = data[0x50:0x52].hex() if len(data) >= 0x52 else "short"
    value_counts[key] += 1
    try:
        version = decode_envelope_bytes(data).version
        by_version[version][key] += 1
    except Exception as exc:
        parse_failures.append({"path": rel, "type": type(exc).__name__, "error": str(exc), "offset_0x50_u16be": key})

pe = pefile.PE(str(exe), fast_load=False)
base = int(pe.OPTIONAL_HEADER.ImageBase)
assert base == 0x140000000
md = Cs(CS_ARCH_X86, CS_MODE_64)
md.detail = True


def disasm(start_rva: int, end_rva: int) -> list[dict]:
    data = pe.get_data(start_rva, end_rva - start_rva)
    rows = []
    for ins in md.disasm(data, base + start_rva):
        rva = ins.address - base
        if rva >= end_rva:
            break
        rows.append({"rva": f"0x{rva:x}", "mnemonic": ins.mnemonic.upper(), "operands": ins.op_str})
    return rows


def accesses(start_rva: int, end_rva: int, displacements: set[int]) -> list[dict]:
    data = pe.get_data(start_rva, end_rva - start_rva)
    rows = []
    for ins in md.disasm(data, base + start_rva):
        rva = ins.address - base
        if rva >= end_rva:
            break
        hits = []
        for op in ins.operands:
            if op.type == X86_OP_MEM and op.mem.disp in displacements:
                hits.append(op.mem.disp)
        if hits:
            rows.append({"rva": f"0x{rva:x}", "mnemonic": ins.mnemonic.upper(), "operands": ins.op_str, "displacements": [f"0x{x:x}" for x in hits]})
    return rows


def immediate_mem_matches(start_rva: int, end_rva: int, disp: int, imm: int) -> list[dict]:
    data = pe.get_data(start_rva, end_rva - start_rva)
    rows = []
    for ins in md.disasm(data, base + start_rva):
        rva = ins.address - base
        if rva >= end_rva:
            break
        has_mem = any(op.type == X86_OP_MEM and op.mem.disp == disp for op in ins.operands)
        has_imm = any(op.type == X86_OP_IMM and op.imm == imm for op in ins.operands)
        if has_mem and has_imm:
            rows.append({"rva": f"0x{rva:x}", "mnemonic": ins.mnemonic.upper(), "operands": ins.op_str})
    return rows


def section_for_rva(rva: int):
    for section in pe.sections:
        start = int(section.VirtualAddress)
        end = start + max(int(section.Misc_VirtualSize), int(section.SizeOfRawData))
        if start <= rva < end:
            return section
    return None


def read_c_string_rva(rva: int, wide: bool = False) -> str | None:
    section = section_for_rva(rva)
    if section is None:
        return None
    raw = pe.get_data(rva, 512)
    try:
        if wide:
            stop = next((i for i in range(0, len(raw) - 1, 2) if raw[i:i+2] == b"\0\0"), None)
            if stop is None or stop < 6:
                return None
            value = raw[:stop].decode("utf-16-le")
        else:
            stop = raw.find(b"\0")
            if stop < 3:
                return None
            value = raw[:stop].decode("utf-8")
    except (UnicodeDecodeError, ValueError):
        return None
    if not all(ch.isprintable() or ch in "\r\n\t" for ch in value):
        return None
    return value


def rip_strings(start_rva: int, end_rva: int) -> list[dict]:
    data = pe.get_data(start_rva, end_rva - start_rva)
    found = {}
    for ins in md.disasm(data, base + start_rva):
        rva = ins.address - base
        if rva >= end_rva:
            break
        for op in ins.operands:
            if op.type != X86_OP_MEM or op.mem.base != X86_REG_RIP:
                continue
            target_va = ins.address + ins.size + op.mem.disp
            target_rva = target_va - base
            for wide in (False, True):
                value = read_c_string_rva(target_rva, wide=wide)
                if value and len(value) >= 4:
                    found[(target_rva, wide, value)] = {"reference_rva": f"0x{rva:x}", "target_rva": f"0x{target_rva:x}", "encoding": "utf-16-le" if wide else "utf-8", "value": value}
    return list(found.values())

text = next(section for section in pe.sections if section.Name.rstrip(b"\0") == b".text")
text_start = int(text.VirtualAddress)
text_end = text_start + int(text.Misc_VirtualSize)
writer_matches = immediate_mem_matches(0x10917E0, 0x10918E0, 0x50, 0x38)

report = {
    "source": {
        "path": source_rel.as_posix(),
        "sha256": sha256(source),
        "bytes": len(source),
        "raw_0x50_0x51": source[0x50:0x52].hex(),
        "normalized_u16be_0x50": int.from_bytes(source[0x50:0x52], "big"),
    },
    "candidate": {
        "sha256": sha256(candidate),
        "bytes": len(candidate),
        "difference": {"offset": 0x51, "before": 0x38, "after": 0x39},
        "raw_0x50_0x51": candidate[0x50:0x52].hex(),
        "normalized_u16be_0x50": int.from_bytes(candidate[0x50:0x52], "big"),
        "payload_sha256": sha256(candidate_env.payload),
        "payload_identical": source_env.payload == candidate_env.payload,
        "semantic_identical_excluding_file_sha256": source_sem == candidate_sem,
        "normalized_semantic_sha256": canonical_sha(candidate_sem),
        "version": candidate_env.version,
        "encryption_mode": candidate_env.encryption_flag,
        "compression_mode": candidate_env.compression_flag,
    },
    "corpus": {
        "entries": len(itls),
        "manifest_hashes_verified": len(itls),
        "offset_0x50_u16be_counts": dict(sorted(value_counts.items())),
        "by_version": {key: dict(sorted(value.items())) for key, value in sorted(by_version.items())},
        "parse_failures": parse_failures,
    },
    "binary": {"sha256": sha256(exe.read_bytes()), "bytes": exe.stat().st_size, "image_base": hex(base)},
    "writer_constant_matches": writer_matches,
    "windows": {
        "constructor": disasm(0x1091838, 0x1091898),
        "normalizer_0x50_accesses": accesses(0x108DE90, 0x108E100, {0x50, 0x52}),
        "main_parser_0x50_accesses": accesses(0x10AD0B0, 0x10AE500, {0x50}),
        "alternate_parser_gate": disasm(0x10F4CF0, 0x10F4D60),
        "alternate_parser_0x50_accesses": accesses(0x10F4B90, 0x10F5400, {0x50}),
        "alternate_direct_caller": disasm(0xD3C9B0, 0xD3CA10),
        "plist_status_site": disasm(0x5AEF20, 0x5AEF58),
        "sqlite_status_site": disasm(0x108A3F0, 0x108A438),
        "group_retry_site": disasm(0x7E48B0, 0x7E4900),
    },
    "strings": {
        "plist_owner_near_site": [row for row in rip_strings(0x5AD780, 0x5AF200) if any(x in row["value"] for x in ("Compatible Version", "Disc Name", "Date Added", "External GUID", "Is Podcast"))],
        "sqlite_owner": [row for row in rip_strings(0x1089D40, 0x108C200) if any(x in row["value"] for x in ("version_info", "select major", "PRAGMA"))],
        "alternate_caller": [row for row in rip_strings(0xD3C7D0, 0xD3D500) if any(x in row["value"] for x in ("</dict>", "<plist", "</array>", "</plist>"))],
    },
}
assert report["binary"]["sha256"] == "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b"
assert writer_matches, "exact +0x50 writer constant not found"
print(json.dumps(report, indent=2, ensure_ascii=False))
