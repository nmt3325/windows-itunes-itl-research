#!/usr/bin/env python3
"""Evidence-bounded U-02 audit of pinned historical iTunes Library fixtures.

The outer envelope is decoded with :class:`itlkit.container.Container`.  The
inner structural walker in this file is deliberately read-only and does not
import or call either semantic section parser.  Its claims stop at framing,
selected count bounds, conservative string-layout bounds, and a track-reference
census; they are not a claim of native iTunes acceptance or full semantics.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
from typing import Any, Callable, Iterable

from itlkit.container import Container
from itlkit.library import Library
from REFERENCE_PARSER import ReferenceLibrary


TITL_REPOSITORY = "https://github.com/josephw/titl.git"
TITL_COMMIT = "e7060370973d624d5c7b18f82303407b76421501"
EXPECTED_FIXTURE_COUNT = 14
FIXTURE_RELATIVE_DIRECTORY = Path("titl-core/src/test/resources")

SECTION_ROOT_TAGS = {
    1: "htlm",
    2: "hplm",
    4: None,
    9: "halm",
    11: "hilm",
    12: "hghm",
    13: "htlm",
    14: "hplm",
    16: "hdfm",
    21: "hslm",
}
ROOT_COUNT_CHILD_TAGS = {
    "hghm": "hohm",
    "halm": "haim",
    "hilm": "hiim",
    "htlm": "htim",
    "hplm": "hpim",
    "hslm": "hpsm",
}
OWNER_COUNT_RULES = {
    "haim": (12, "hohm"),
    "hiim": (12, "hohm"),
    "htim": (12, "hohm"),
    "hpsm": (12, "hohm"),
}

# Cases routed to readGenericHohm() by pinned ParseLibrary.java.  The walker
# checks only the primitive layout and never assigns field-level meaning.
GENERIC_HOHM_TYPES = {
    0x02, 0x03, 0x04, 0x05, 0x06, 0x08, 0x09, 0x0B, 0x0C, 0x0D, 0x0E,
    0x12, 0x14, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E,
    0x1F, 0x20, 0x21, 0x22, 0x23, 0x25, 0x2B, 0x2D, 0x2E, 0x2F,
    0x34, 0x64, 0xC8, 0xC9, 0x12C, 0x12D, 0x12E, 0x130, 0x131,
    0x132, 0x190, 0x191, 0x1F8, 0x1F9, 0x1FA, 0x1FC,
}
STRING_ENCODINGS = {
    0: "ascii",
    1: "utf-16-be",
    2: "utf-8",
    3: "cp1252",
}

LOCAL_SOURCE_FILES = (
    "itlkit/container.py",
    "itlkit/library.py",
    "REFERENCE_PARSER/core.py",
)
TITL_SOURCE_FILES = (
    "titl-core/src/main/java/org/kafsemo/titl/ParseLibrary.java",
    "titl-core/src/main/java/org/kafsemo/titl/Input.java",
    "titl-core/src/main/java/org/kafsemo/titl/InputImpl.java",
    "titl-core/src/main/java/org/kafsemo/titl/FlippedInputImpl.java",
    "titl-core/src/main/java/org/kafsemo/titl/Hdfm.java",
    "titl-core/src/test/java/org/kafsemo/titl/TestParseLibrary.java",
    "README.md",
    "BOILERPLATE",
    "LGPL-3",
)


class WalkError(ValueError):
    """A structural boundary rejected by the independent walker."""

    def __init__(self, code: str, message: str, offset: int | None = None):
        super().__init__(message)
        self.code = code
        self.offset = offset

    def to_dict(self) -> dict[str, Any]:
        return {
            "code": self.code,
            "message": str(self),
            "offset": self.offset,
        }


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _file_sha256(path: Path) -> str:
    return _sha256(path.read_bytes())


def _need(data: bytes, offset: int, size: int, code: str) -> None:
    if offset < 0 or size < 0 or offset + size > len(data):
        raise WalkError(
            code,
            f"need {size} bytes at 0x{offset:x}, only {max(0, len(data) - offset)} remain",
            offset,
        )


def _uint(data: bytes, offset: int, width: int, byteorder: str) -> int:
    _need(data, offset, width, "truncated_integer")
    return int.from_bytes(data[offset : offset + width], byteorder=byteorder)


def _logical_tag(data: bytes, offset: int, byteorder: str) -> tuple[str, str]:
    _need(data, offset, 4, "truncated_tag")
    raw = data[offset : offset + 4]
    logical = raw if byteorder == "big" else raw[::-1]
    try:
        return logical.decode("ascii"), raw.decode("ascii")
    except UnicodeDecodeError as exc:
        raise WalkError("non_ascii_tag", "record tag is not ASCII", offset) from exc


def _sorted_counter(counter: Counter[Any]) -> dict[str, int]:
    return {str(key): counter[key] for key in sorted(counter, key=lambda item: str(item))}


def _inspect_generic_string(
    payload: bytes,
    frame: dict[str, Any],
    byteorder: str,
) -> dict[str, Any] | None:
    if frame["tag"] != "hohm":
        return None
    offset = frame["offset"]
    record_length = frame["record_length"]
    hohm_type = _uint(payload, offset + 12, 4, byteorder)
    if hohm_type not in GENERIC_HOHM_TYPES:
        return None
    if record_length < 40:
        raise WalkError(
            "string_header_out_of_bounds",
            f"generic hohm type {hohm_type} is shorter than 40-byte primitive prefix",
            offset,
        )
    encoding_flag = payload[offset + 27]
    data_length = _uint(payload, offset + 28, 4, byteorder)
    zero_guard = payload[offset + 32 : offset + 40]
    if zero_guard != b"\x00" * 8:
        raise WalkError(
            "string_reserved_bytes_nonzero",
            f"generic hohm type {hohm_type} has nonzero reserved bytes",
            offset + 32,
        )
    if encoding_flag not in STRING_ENCODINGS:
        raise WalkError(
            "string_encoding_unknown",
            f"generic hohm type {hohm_type} has encoding flag {encoding_flag}",
            offset + 27,
        )
    available = record_length - 40
    if data_length > available:
        raise WalkError(
            "string_data_out_of_bounds",
            f"generic hohm type {hohm_type} declares {data_length} data bytes; {available} remain",
            offset + 28,
        )
    string_bytes = payload[offset + 40 : offset + 40 + data_length]
    try:
        string_bytes.decode(STRING_ENCODINGS[encoding_flag], errors="strict")
        decode_status = "valid"
    except UnicodeDecodeError:
        decode_status = "invalid_for_declared_encoding"
    return {
        "offset": offset,
        "hohm_type": hohm_type,
        "encoding_flag": encoding_flag,
        "encoding": STRING_ENCODINGS[encoding_flag],
        "data_length": data_length,
        "data_sha256": _sha256(string_bytes),
        "trailing_bytes": available - data_length,
        "decode_status": decode_status,
    }


def walk_payload(payload: bytes, byteorder: str) -> dict[str, Any]:
    """Walk historical records without calling either semantic parser.

    This checks framing and selected bounds only.  A successful return is not a
    claim that every field, record type, version, or native behavior is known.
    """
    payload = bytes(payload)
    if byteorder not in {"big", "little"}:
        raise ValueError("byteorder must be 'big' or 'little'")
    if not payload:
        raise WalkError("empty_payload", "payload is empty", 0)

    frames: list[dict[str, Any]] = []
    offset = 0
    terminal_seen = False
    while offset < len(payload):
        tag, physical_tag = _logical_tag(payload, offset, byteorder)
        _need(payload, offset, 8, "truncated_record_header")
        header_length = _uint(payload, offset + 4, 4, byteorder)
        if header_length < 8:
            raise WalkError(
                "invalid_header_length",
                f"{tag} header length {header_length} is below 8",
                offset + 4,
            )
        if offset + header_length > len(payload):
            raise WalkError(
                "header_out_of_bounds",
                f"{tag} header length {header_length} exceeds payload",
                offset + 4,
            )

        record_length = header_length
        if tag == "hohm":
            if header_length < 24:
                raise WalkError(
                    "short_hohm_header",
                    f"hohm header length {header_length} is below 24",
                    offset + 4,
                )
            record_length = _uint(payload, offset + 8, 4, byteorder)
            if record_length < header_length:
                raise WalkError(
                    "record_shorter_than_header",
                    f"hohm record length {record_length} is below header length {header_length}",
                    offset + 8,
                )
            if offset + record_length > len(payload):
                raise WalkError(
                    "record_out_of_bounds",
                    f"hohm record length {record_length} exceeds payload",
                    offset + 8,
                )
        elif tag == "hdsm" and header_length < 16:
            raise WalkError("short_section_header", "hdsm header is shorter than 16 bytes", offset)
        elif tag == "htim" and header_length < 20:
            raise WalkError("short_track_header", "htim header is shorter than 20 bytes", offset)
        elif tag == "hpim" and header_length < 20:
            raise WalkError("short_playlist_header", "hpim header is shorter than 20 bytes", offset)
        elif tag == "hptm" and header_length < 28:
            raise WalkError("short_reference_header", "hptm header is shorter than 28 bytes", offset)

        frame: dict[str, Any] = {
            "index": len(frames),
            "offset": offset,
            "tag": tag,
            "physical_tag": physical_tag,
            "header_length": header_length,
            "record_length": record_length,
        }
        if tag == "hdsm":
            frame["section_type"] = _uint(payload, offset + 12, 4, byteorder)
        elif tag == "hohm":
            frame["hohm_type"] = _uint(payload, offset + 12, 4, byteorder)
        elif tag == "htim":
            declared_record_length = _uint(payload, offset + 8, 4, byteorder)
            if declared_record_length < header_length or offset + declared_record_length > len(payload):
                raise WalkError(
                    "track_record_length_out_of_bounds",
                    f"htim declared record length {declared_record_length} is not bounded",
                    offset + 8,
                )
            frame["declared_record_length"] = declared_record_length
            frame["declared_child_count"] = _uint(payload, offset + 12, 4, byteorder)
            frame["track_id"] = _uint(payload, offset + 16, 4, byteorder)
        elif tag == "hpim":
            frame["declared_hohm_count"] = _uint(payload, offset + 12, 4, byteorder)
            frame["declared_item_count"] = _uint(payload, offset + 16, 4, byteorder)
        elif tag == "hptm":
            frame["track_reference"] = _uint(payload, offset + 24, 4, byteorder)

        frames.append(frame)
        offset += record_length
        if tag == "hdsm" and frame["section_type"] == 4:
            terminal_seen = True
            break

    if not terminal_seen:
        raise WalkError("missing_terminal_section", "no hdsm section type 4 terminator was found", offset)
    if not frames or frames[0]["tag"] != "hdsm":
        raise WalkError("missing_initial_section", "first framed record is not hdsm", 0)

    section_starts = [index for index, frame in enumerate(frames) if frame["tag"] == "hdsm"]
    sections: list[dict[str, Any]] = []
    root_count_checks: list[dict[str, Any]] = []
    owner_count_checks: list[dict[str, Any]] = []
    playlist_item_count_checks: list[dict[str, Any]] = []

    for section_position, start_index in enumerate(section_starts):
        end_index = (
            section_starts[section_position + 1]
            if section_position + 1 < len(section_starts)
            else len(frames)
        )
        section_header = frames[start_index]
        section_type = section_header["section_type"]
        body = frames[start_index + 1 : end_index]
        expected_root = SECTION_ROOT_TAGS.get(section_type)
        actual_root = body[0]["tag"] if body else None
        if expected_root is not None and actual_root != expected_root:
            raise WalkError(
                "section_root_mismatch",
                f"section type {section_type} expects {expected_root}, found {actual_root}",
                section_header["offset"],
            )
        if section_type == 4 and body:
            raise WalkError(
                "terminal_section_has_body",
                "terminal hdsm section unexpectedly contains framed records",
                section_header["offset"],
            )
        section: dict[str, Any] = {
            "section_type": section_type,
            "offset": section_header["offset"],
            "end_offset": (
                frames[end_index]["offset"] if end_index < len(frames) else offset
            ),
            "root_tag": actual_root,
            "expected_root_tag": expected_root,
            "record_count_excluding_hdsm": len(body),
            "record_census": _sorted_counter(Counter(frame["tag"] for frame in body)),
        }
        sections.append(section)

        if body and actual_root in ROOT_COUNT_CHILD_TAGS:
            child_tag = ROOT_COUNT_CHILD_TAGS[actual_root]
            declared = _uint(payload, body[0]["offset"] + 8, 4, byteorder)
            actual = sum(frame["tag"] == child_tag for frame in body[1:])
            check = {
                "section_type": section_type,
                "root_tag": actual_root,
                "child_tag": child_tag,
                "offset": body[0]["offset"],
                "declared": declared,
                "actual": actual,
                "matches": declared == actual,
            }
            root_count_checks.append(check)
            if declared != actual:
                raise WalkError(
                    "root_count_mismatch",
                    f"{actual_root} declares {declared} {child_tag} records; found {actual}",
                    body[0]["offset"] + 8,
                )

        for owner_tag, (count_offset, child_tag) in OWNER_COUNT_RULES.items():
            owner_positions = [
                index for index, frame in enumerate(body) if frame["tag"] == owner_tag
            ]
            for owner_position, body_index in enumerate(owner_positions):
                next_body_index = (
                    owner_positions[owner_position + 1]
                    if owner_position + 1 < len(owner_positions)
                    else len(body)
                )
                owner = body[body_index]
                owned = body[body_index + 1 : next_body_index]
                declared = _uint(payload, owner["offset"] + count_offset, 4, byteorder)
                actual = sum(frame["tag"] == child_tag for frame in owned)
                check = {
                    "section_type": section_type,
                    "owner_tag": owner_tag,
                    "child_tag": child_tag,
                    "offset": owner["offset"],
                    "declared": declared,
                    "actual": actual,
                    "matches": declared == actual,
                }
                owner_count_checks.append(check)
                if declared != actual:
                    raise WalkError(
                        "owner_count_mismatch",
                        f"{owner_tag} declares {declared} {child_tag} records; found {actual}",
                        owner["offset"] + count_offset,
                    )

        hpim_positions = [
            index for index, frame in enumerate(body) if frame["tag"] == "hpim"
        ]
        for playlist_position, body_index in enumerate(hpim_positions):
            next_body_index = (
                hpim_positions[playlist_position + 1]
                if playlist_position + 1 < len(hpim_positions)
                else len(body)
            )
            playlist = body[body_index]
            owned = body[body_index + 1 : next_body_index]
            actual_items = sum(frame["tag"] == "hptm" for frame in owned)
            actual_hohm = sum(frame["tag"] == "hohm" for frame in owned)
            declared_items = playlist["declared_item_count"]
            check = {
                "section_type": section_type,
                "offset": playlist["offset"],
                "declared_item_count": declared_items,
                "actual_hptm_count": actual_items,
                "item_count_matches": declared_items == actual_items,
                "declared_hohm_count": playlist["declared_hohm_count"],
                "observed_contiguous_hohm_count": actual_hohm,
                "hohm_count_enforced": False,
                "hohm_count_note": (
                    "field is recorded but not enforced because pinned prior-art code does not "
                    "use it as a complete bound and fixtures can contain additional hohm records"
                ),
            }
            playlist_item_count_checks.append(check)
            if declared_items != actual_items:
                raise WalkError(
                    "playlist_item_count_mismatch",
                    f"hpim declares {declared_items} hptm records; found {actual_items}",
                    playlist["offset"] + 16,
                )

    string_records: list[dict[str, Any]] = []
    for frame in frames:
        item = _inspect_generic_string(payload, frame, byteorder)
        if item is not None:
            string_records.append(item)

    track_ids = [frame["track_id"] for frame in frames if frame["tag"] == "htim"]
    track_id_set = set(track_ids)
    references = [
        {
            "offset": frame["offset"],
            "track_reference": frame["track_reference"],
            "matches_observed_htim_track_id": frame["track_reference"] in track_id_set,
        }
        for frame in frames
        if frame["tag"] == "hptm"
    ]

    header_lengths: defaultdict[str, set[int]] = defaultdict(set)
    record_lengths: defaultdict[str, set[int]] = defaultdict(set)
    for frame in frames:
        header_lengths[frame["tag"]].add(frame["header_length"])
        record_lengths[frame["tag"]].add(frame["record_length"])
    footer = payload[offset:]
    return {
        "status": "accepted",
        "claim_boundary": (
            "read-only framing/count/string/reference census only; not full semantic parsing, "
            "version support, or native iTunes acceptance"
        ),
        "byteorder": byteorder,
        "logical_first_tag": frames[0]["tag"],
        "physical_first_tag": frames[0]["physical_tag"],
        "framed_bytes": offset,
        "footer_bytes": len(footer),
        "footer_sha256": _sha256(footer),
        "footer_starts_with_file_uri": footer.startswith(b"file:"),
        "record_count_including_hdsm": len(frames),
        "record_census": _sorted_counter(Counter(frame["tag"] for frame in frames)),
        "header_lengths_by_tag": {
            tag: sorted(values) for tag, values in sorted(header_lengths.items())
        },
        "record_lengths_by_tag": {
            tag: sorted(values) for tag, values in sorted(record_lengths.items())
        },
        "sections": sections,
        "root_count_checks": root_count_checks,
        "owner_count_checks": owner_count_checks,
        "playlist_item_count_checks": playlist_item_count_checks,
        "string_primitives": {
            "layout": {
                "encoding_flag_offset_from_record": 27,
                "data_length_offset_from_record": 28,
                "data_offset_from_record": 40,
                "encoding_map": {str(key): value for key, value in STRING_ENCODINGS.items()},
            },
            "record_count": len(string_records),
            "encoding_flag_census": _sorted_counter(
                Counter(item["encoding_flag"] for item in string_records)
            ),
            "strict_decode_status_census": _sorted_counter(
                Counter(item["decode_status"] for item in string_records)
            ),
            "records": string_records,
        },
        "reference_primitives": {
            "htim_track_id_offset_from_record": 16,
            "hptm_track_reference_offset_from_record": 24,
            "observed_track_count": len(track_ids),
            "unique_track_id_count": len(track_id_set),
            "playlist_reference_count": len(references),
            "references_matching_observed_track_id": sum(
                item["matches_observed_htim_track_id"] for item in references
            ),
            "references": references,
        },
    }


def classify_parser_failure(parser: str, byteorder: str, exc: BaseException) -> str:
    """Map an observed exception to its first externally visible boundary."""
    message = str(exc)
    if byteorder == "big" and "little-endian payloads only" in message:
        return "payload_byte_order_gate"
    if parser == "itlkit.Library" and "mfdh logical size" in message:
        return "semantic_root_size_invariant"
    if "section" in message.lower() or "root" in message.lower():
        return "semantic_section_or_root_validation"
    return "semantic_parser_exception"


def _probe_parser(
    parser: str,
    byteorder: str,
    parse: Callable[[], Any],
) -> dict[str, Any]:
    try:
        result = parse()
    except Exception as exc:  # Audit must preserve the exact public boundary.
        return {
            "status": "rejected",
            "first_failure_stage": classify_parser_failure(parser, byteorder, exc),
            "exception_type": type(exc).__name__,
            "message": str(exc),
        }
    sections = getattr(result, "sections", None)
    return {
        "status": "accepted",
        "first_failure_stage": None,
        "section_count": len(sections) if sections is not None else None,
    }


TITL_HARNESS = r"""
import java.io.File;
import org.kafsemo.titl.Library;
import org.kafsemo.titl.ParseLibrary;
public final class AuditTitl {
  private static String clean(String value) {
    if (value == null) return "";
    return value.replace("\\", "\\\\").replace("\t", "\\t")
                .replace("\r", "\\r").replace("\n", "\\n");
  }
  public static void main(String[] args) {
    for (String arg : args) {
      File fixture = new File(arg);
      try {
        Library library = ParseLibrary.parse(fixture);
        System.out.println("AUDIT\t" + fixture.getName() + "\tOK\t" +
            clean(library.getVersion()) + "\t" + library.getTracks().size() +
            "\t" + library.getPlaylists().size());
      } catch (Throwable error) {
        System.out.println("AUDIT\t" + fixture.getName() + "\tFAIL\t" +
            error.getClass().getName() + "\t" + clean(error.getMessage()));
      }
    }
  }
}
""".strip() + "\n"


def run_pinned_titl_parser(titl_repo: Path, fixtures: Iterable[Path]) -> dict[str, dict[str, Any]]:
    """Compile and execute the pinned Java parser in a temporary directory."""
    javac = shutil.which("javac")
    java = shutil.which("java")
    if not javac or not java:
        raise RuntimeError("javac and java are required for the pinned titl parser probe")
    source_root = titl_repo / "titl-core/src/main/java"
    sources = sorted(source_root.rglob("*.java"))
    if not sources:
        raise RuntimeError("no pinned titl Java sources were found")
    fixtures = list(fixtures)
    with tempfile.TemporaryDirectory(prefix="itl-u02-titl-") as temporary:
        temporary_path = Path(temporary)
        classes = temporary_path / "classes"
        classes.mkdir()
        harness = temporary_path / "AuditTitl.java"
        harness.write_text(TITL_HARNESS, encoding="utf-8")
        compile_main = subprocess.run(
            [javac, "-encoding", "UTF-8", "-d", str(classes), *map(str, sources)],
            cwd=titl_repo,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if compile_main.returncode:
            raise RuntimeError(f"javac failed for pinned titl sources: {compile_main.stderr.strip()}")
        compile_harness = subprocess.run(
            [javac, "-encoding", "UTF-8", "-cp", str(classes), "-d", str(classes), str(harness)],
            cwd=titl_repo,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if compile_harness.returncode:
            raise RuntimeError(f"javac failed for audit harness: {compile_harness.stderr.strip()}")
        execution = subprocess.run(
            [java, "-cp", str(classes), "AuditTitl", *map(str, fixtures)],
            cwd=titl_repo,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        if execution.returncode:
            raise RuntimeError(f"pinned titl harness failed: {execution.stderr.strip()}")

    results: dict[str, dict[str, Any]] = {}
    for line in execution.stdout.splitlines():
        if not line.startswith("AUDIT\t"):
            continue
        parts = line.split("\t")
        if len(parts) < 4:
            raise RuntimeError(f"malformed pinned titl harness line: {line!r}")
        name, status = parts[1], parts[2]
        if status == "OK" and len(parts) == 6:
            results[name] = {
                "status": "accepted",
                "first_failure_stage": None,
                "version": parts[3],
                "track_count": int(parts[4]),
                "playlist_count": int(parts[5]),
            }
        elif status == "FAIL" and len(parts) >= 5:
            results[name] = {
                "status": "rejected",
                "first_failure_stage": "pinned_prior_art_parser_exception",
                "exception_type": parts[3],
                "message": "\t".join(parts[4:]),
            }
        else:
            raise RuntimeError(f"malformed pinned titl harness result: {line!r}")
    expected_names = {path.name for path in fixtures}
    if set(results) != expected_names:
        missing = sorted(expected_names - set(results))
        extra = sorted(set(results) - expected_names)
        raise RuntimeError(f"pinned titl harness result mismatch; missing={missing}, extra={extra}")
    return results


def _relative_fixture_path(path: Path) -> str:
    return (FIXTURE_RELATIVE_DIRECTORY / path.name).as_posix()


def _audit_fixture(path: Path, upstream: dict[str, Any]) -> dict[str, Any]:
    data = path.read_bytes()
    container = Container.from_bytes(data)
    no_op = container.to_bytes()
    rebuilt = container.to_bytes(rebuild=True)
    rebuilt_container = Container.from_bytes(rebuilt)
    rebuild_checks = {
        "reparse_succeeded": True,
        "payload_equal": rebuilt_container.payload == container.payload,
        "trailer_equal": rebuilt_container.trailer == container.trailer,
        "version_equal": rebuilt_container.version == container.version,
        "payload_byteorder_equal": (
            rebuilt_container.payload_byteorder == container.payload_byteorder
        ),
        "header_equal_except_file_size": (
            rebuilt_container.header[:8] + rebuilt_container.header[12:]
            == container.header[:8] + container.header[12:]
        ),
        "rebuilt_bytes_equal_input": rebuilt == data,
        "rebuilt_sha256": _sha256(rebuilt),
    }
    rebuild_checks["semantic_payload_preserved"] = all(
        rebuild_checks[key]
        for key in (
            "reparse_succeeded",
            "payload_equal",
            "trailer_equal",
            "version_equal",
            "payload_byteorder_equal",
            "header_equal_except_file_size",
        )
    )

    byteorder = container.payload_byteorder
    walk = walk_payload(container.payload, byteorder)
    local_library = _probe_parser(
        "itlkit.Library",
        byteorder,
        lambda: Library.from_bytes(data),
    )
    reference_library = _probe_parser(
        "ReferenceLibrary",
        byteorder,
        lambda: ReferenceLibrary.from_bytes(data),
    )
    raw_flag = container.header[0x52]
    return {
        "path": _relative_fixture_path(path),
        "name": path.name,
        "sha256": _sha256(data),
        "file_bytes": len(data),
        "outer_envelope": {
            "status": "accepted",
            "version": container.version,
            "header_bytes": len(container.header),
            "declared_file_bytes": int.from_bytes(container.header[8:12], "big"),
            "payload_bytes": len(container.payload),
            "trailer_bytes": len(container.trailer),
            "encryption_flag": container.encryption_flag,
            "compression_flag": container.compression_flag,
            "max_crypt_size": container.max_crypt_size,
            "declared_section_count_field": int.from_bytes(container.header[0x30:0x34], "big"),
        },
        "byte_order_evidence": {
            "outer_header_offset_hex": "0x52",
            "raw_value": raw_flag,
            "rule": "zero=big; nonzero=little",
            "classification": byteorder,
            "physical_first_tag": container.payload[:4].decode("ascii", errors="replace"),
            "logical_first_tag": walk["logical_first_tag"],
            "tag_transform": "identity" if byteorder == "big" else "reverse each four-byte tag",
        },
        "round_trip_boundaries": {
            "container_decode": "accepted",
            "no_op_exact_bytes": no_op == data,
            "forced_rebuild": rebuild_checks,
            "interpretation": (
                "container reversibility preserves an opaque payload; it is not semantic acceptance"
            ),
        },
        "semantic_parser_boundaries": {
            "itlkit.Library": local_library,
            "ReferenceLibrary": reference_library,
            "pinned_josephw_titl": upstream,
        },
        "structural_walker": walk,
    }


def _git_head(repo: Path) -> str:
    result = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=repo,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if result.returncode:
        raise RuntimeError(f"cannot resolve pinned titl HEAD: {result.stderr.strip()}")
    return result.stdout.strip()


def _source_hashes(root: Path, paths: Iterable[str]) -> list[dict[str, str]]:
    results = []
    for relative in paths:
        path = root / relative
        if not path.is_file():
            raise RuntimeError(f"required source file is missing: {relative}")
        results.append({"path": relative, "sha256": _file_sha256(path)})
    return results


def _stage_census(fixtures: list[dict[str, Any]], parser: str) -> dict[str, int]:
    stages: Counter[str] = Counter()
    for fixture in fixtures:
        result = fixture["semantic_parser_boundaries"][parser]
        stage = result["first_failure_stage"] or "accepted"
        stages[stage] += 1
    return _sorted_counter(stages)


def build_audit(
    titl_repo: Path,
    *,
    expected_commit: str = TITL_COMMIT,
    expected_fixture_count: int = EXPECTED_FIXTURE_COUNT,
    run_upstream_java: bool = True,
) -> dict[str, Any]:
    titl_repo = titl_repo.resolve()
    if _git_head(titl_repo) != expected_commit:
        raise RuntimeError(
            f"titl checkout is not pinned to {expected_commit}; found {_git_head(titl_repo)}"
        )
    fixture_directory = titl_repo / FIXTURE_RELATIVE_DIRECTORY
    fixtures = sorted(fixture_directory.glob("*.itl"), key=lambda path: path.name)
    if len(fixtures) != expected_fixture_count:
        raise RuntimeError(
            f"expected {expected_fixture_count} .itl fixtures, found {len(fixtures)}"
        )
    repo_root = Path(__file__).resolve().parents[2]
    upstream_results = (
        run_pinned_titl_parser(titl_repo, fixtures)
        if run_upstream_java
        else {
            path.name: {
                "status": "not_run",
                "first_failure_stage": "not_run",
                "reason": "run_upstream_java=False",
            }
            for path in fixtures
        }
    )
    fixture_results = [
        _audit_fixture(path, upstream_results[path.name]) for path in fixtures
    ]

    summary = {
        "fixture_count": len(fixture_results),
        "big_endian_fixture_count": sum(
            item["byte_order_evidence"]["classification"] == "big"
            for item in fixture_results
        ),
        "little_endian_fixture_count": sum(
            item["byte_order_evidence"]["classification"] == "little"
            for item in fixture_results
        ),
        "container_decode_accepted": sum(
            item["outer_envelope"]["status"] == "accepted" for item in fixture_results
        ),
        "container_no_op_exact": sum(
            item["round_trip_boundaries"]["no_op_exact_bytes"] for item in fixture_results
        ),
        "container_forced_rebuild_reparse_and_payload_preserved": sum(
            item["round_trip_boundaries"]["forced_rebuild"]["semantic_payload_preserved"]
            for item in fixture_results
        ),
        "itlkit_library_accepted": sum(
            item["semantic_parser_boundaries"]["itlkit.Library"]["status"] == "accepted"
            for item in fixture_results
        ),
        "reference_library_accepted": sum(
            item["semantic_parser_boundaries"]["ReferenceLibrary"]["status"] == "accepted"
            for item in fixture_results
        ),
        "pinned_josephw_titl_accepted": sum(
            item["semantic_parser_boundaries"]["pinned_josephw_titl"]["status"] == "accepted"
            for item in fixture_results
        ),
        "independent_structural_walker_accepted": sum(
            item["structural_walker"]["status"] == "accepted"
            for item in fixture_results
        ),
        "big_endian_structural_walker_accepted": sum(
            item["byte_order_evidence"]["classification"] == "big"
            and item["structural_walker"]["status"] == "accepted"
            for item in fixture_results
        ),
        "records_framed_including_hdsm": sum(
            item["structural_walker"]["record_count_including_hdsm"]
            for item in fixture_results
        ),
        "root_count_bounds_checked": sum(
            len(item["structural_walker"]["root_count_checks"])
            for item in fixture_results
        ),
        "owner_count_bounds_checked": sum(
            len(item["structural_walker"]["owner_count_checks"])
            for item in fixture_results
        ),
        "playlist_item_count_bounds_checked": sum(
            len(item["structural_walker"]["playlist_item_count_checks"])
            for item in fixture_results
        ),
        "generic_string_primitives_bounded": sum(
            item["structural_walker"]["string_primitives"]["record_count"]
            for item in fixture_results
        ),
        "playlist_track_references_censused": sum(
            item["structural_walker"]["reference_primitives"]["playlist_reference_count"]
            for item in fixture_results
        ),
        "first_boundary_census": {
            "itlkit.Library": _stage_census(fixture_results, "itlkit.Library"),
            "ReferenceLibrary": _stage_census(fixture_results, "ReferenceLibrary"),
            "pinned_josephw_titl": _stage_census(
                fixture_results, "pinned_josephw_titl"
            ),
        },
        "u02_status": "open",
    }

    return {
        "schema": "windows-itunes-itl-research.big-endian-prior-art.v1",
        "audit_id": "U-02-big-endian-semantic-payload-prior-art-20260925",
        "determinism": {
            "generated_timestamp_recorded": False,
            "fixture_order": "lexicographic relative path",
            "absolute_paths_recorded": False,
        },
        "claim_boundary": {
            "positive": (
                "pinned fixture hashes; envelope reversibility; parser return/rejection boundaries; "
                "read-only framing and selected primitive/count bounds"
            ),
            "not_claimed": [
                "native iTunes acceptance",
                "full big-endian semantic support in production Library",
                "meaning of every field or record type",
                "support for every iTunes version",
                "equivalence of parser return with native acceptance",
            ],
        },
        "source": {
            "repository": TITL_REPOSITORY,
            "commit": expected_commit,
            "fixture_directory": FIXTURE_RELATIVE_DIRECTORY.as_posix(),
            "fixture_count": len(fixtures),
            "fixture_bytes_copied_into_repository": False,
            "license_observation": "pinned repository states GNU LGPL v3 or later",
            "local_source_hashes": _source_hashes(repo_root, LOCAL_SOURCE_FILES),
            "pinned_titl_source_hashes": _source_hashes(titl_repo, TITL_SOURCE_FILES),
            "java_audit_harness_sha256": _sha256(TITL_HARNESS.encode("utf-8")),
        },
        "parser_code_evidence": [
            {
                "parser": "itlkit.Container",
                "path": "itlkit/container.py",
                "observation": (
                    "outer integers are big-endian; header[0x52] selects payload byte order; "
                    "unchanged serialization and forced reconstruction are separate paths"
                ),
            },
            {
                "parser": "itlkit.Library",
                "path": "itlkit/library.py",
                "observation": (
                    "the little-endian gate executes before semantic section parsing"
                ),
            },
            {
                "parser": "ReferenceLibrary",
                "path": "REFERENCE_PARSER/core.py",
                "observation": (
                    "the independent semantic parser rejects big-endian payloads before sections"
                ),
            },
            {
                "parser": "josephw/titl ParseLibrary",
                "path": "titl-core/src/main/java/org/kafsemo/titl/ParseLibrary.java",
                "observation": (
                    "logical hdsm/hohm/htim/hpim/hptm records expose header, count, string, "
                    "and playlist-reference primitives used by the audit walker"
                ),
            },
            {
                "parser": "josephw/titl FlippedInputImpl",
                "path": "titl-core/src/main/java/org/kafsemo/titl/FlippedInputImpl.java",
                "observation": (
                    "little-endian mode reverses readInt but does not override readShort; its "
                    "successful return is not evidence for every 16-bit field"
                ),
            },
        ],
        "failure_taxonomy": {
            "envelope_decode": "outer hdfm/AES/zlib framing rejected",
            "payload_byte_order_gate": "semantic parser explicitly rejects before sections",
            "semantic_root_size_invariant": "byte order accepted, first root-size invariant rejects",
            "semantic_section_or_root_validation": "section/root framing rejects after order gate",
            "semantic_parser_exception": "other first visible high-level parser exception",
            "accepted": "parser returned; does not imply native acceptance or complete semantics",
        },
        "summary": summary,
        "fixtures": fixture_results,
        "conclusion": {
            "bounded_finding": (
                "The pinned corpus contains 13 big-endian and one little-endian payload.  The "
                "independent walker can bound historical record framing and selected primitives, "
                "while both repository high-level semantic parsers reject big-endian payloads at "
                "their explicit byte-order gates."
            ),
            "u02_status": "open",
            "why_open": (
                "No native acceptance test, complete semantic field validation, or production "
                "big-endian Library implementation is established by this audit."
            ),
        },
    }


def _parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--titl-repo",
        type=Path,
        required=True,
        help="checkout pinned to josephw/titl commit e706037...",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("evidence/research/20260925/big-endian-prior-art/audit.json"),
    )
    parser.add_argument("--expected-commit", default=TITL_COMMIT)
    parser.add_argument("--expected-fixture-count", type=int, default=EXPECTED_FIXTURE_COUNT)
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = _parse_args(argv)
    audit = build_audit(
        args.titl_repo,
        expected_commit=args.expected_commit,
        expected_fixture_count=args.expected_fixture_count,
        run_upstream_java=True,
    )
    encoded = json.dumps(audit, indent=2, sort_keys=True, ensure_ascii=False) + "\n"
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(encoded, encoding="utf-8", newline="\n")
    print(
        f"wrote {args.output} ({audit['summary']['fixture_count']} fixtures; "
        f"{audit['summary']['big_endian_fixture_count']} big-endian)"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
