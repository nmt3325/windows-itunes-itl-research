#!/usr/bin/env python3
"""Deterministic, bounded, line-transition-guided parser campaign.

This is an offline robustness experiment.  It does not call iTunes, establish
native acceptance, or prove parser safety.  Queue admission requires at least
one previously unseen traced transition in the selected ``itlkit`` target.
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
from pathlib import Path
import platform
import struct
import sys
from typing import Callable
import zlib

import Crypto

ROOT = Path(__file__).resolve().parents[2]
TARGET_COMMIT = "7d2382cfba9c5093f3fd734f5ada1bf66cff2217"
SEED = 0x20260925C0F17E
DEFAULT_ITERATIONS = 20_000
MAX_INPUT_BYTES = 128 * 1024
MAX_PLAIN_BYTES = 128 * 1024
TARGET_ORDER = ("container", "model", "smart_rules", "smart_preferences")

sys.path.insert(0, str(ROOT))
from itlkit import (  # noqa: E402
    Container,
    ITLError,
    Library,
    Node,
    dump_preferences,
    dump_rules,
    parse_preferences,
    parse_rules,
    parse_sections,
    serialize_sections,
    validate_preferences,
    validate_rules,
)

SEED_FILES = (
    ("reference-one-track-zlib", "TEST_CORPUS/generated/reference-one-track-zlib.itl", "25f8aba00330caaa0ef4b529f67a203cd6da2b3d652923f7e44c7396f7bd13ad"),
    ("reference-three-track-raw", "TEST_CORPUS/generated/reference-three-track-raw.itl", "7d9b274765471d2d77440049273b210138e36b998d39d4790fe750d60c32406b"),
    ("native-empty", "evidence/native/snapshots/000-empty.itl", "503736e6cf40bf5cea572595c63387db94fbaec3732016df6443b7549a8c7cf4"),
    ("native-fresh-three-tracks", "evidence/native/fresh-20260921/snapshots/002-three-tracks.itl", "de9a338c81fcc160a6f62b99e29a08787bd6b52b744772e5065251702feba3dc"),
    ("native-path-emoji", "evidence/path-time/native/snapshots/010-010-emoji.itl", "d2be136baf3061d8018d8f7195720744a73e6a4a4d11d31a708cca43670bcd0a"),
    ("native-smart-v24", "evidence/native/smart-playlist-default-20260922-v24/final-live.itl", "58ad4d6fedc65f43e627b35075218c6c19b16d767570c41d6f8c2f2fe7376696"),
    ("external-itl-rs-roundtrip", "evidence/independent/itl-rs-20260922/candidate-zlib-roundtrip.itl", "2873104e2e8cfc97ac6434480328aed81996feb5c3bb2237cd598d9f8adcc642"),
    ("native-rating-100", "evidence/research/20260925/native-rating-kind/cases/rating-100/mutation/native-saved.itl", "6937ec8e828c255af870990f3934499c8e12cea3958c35b566f70fa3525da48c"),
)

EXPECTED_EXCEPTIONS = (ITLError,)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


class StableRng:
    """Tiny fixed xorshift64* stream, independent of ``random`` internals."""

    def __init__(self, seed: int) -> None:
        self.state = seed & ((1 << 64) - 1) or 1

    def next_u64(self) -> int:
        value = self.state
        value ^= value >> 12
        value ^= (value << 25) & ((1 << 64) - 1)
        value ^= value >> 27
        self.state = value & ((1 << 64) - 1)
        return (self.state * 0x2545F4914F6CDD1D) & ((1 << 64) - 1)

    def below(self, upper: int) -> int:
        if upper < 1:
            raise ValueError("upper bound must be positive")
        return self.next_u64() % upper

    def choose(self, values):
        return values[self.below(len(values))]

    def bytes(self, length: int) -> bytes:
        return bytes(self.below(256) for _ in range(length))


class ArcTracer:
    """Collect source-line transitions for frames under the production package."""

    def __init__(self) -> None:
        self.root = (ROOT / "itlkit").resolve()
        self.arcs: set[tuple[str, int, int]] = set()
        # Retaining the frame object until return (or run cleanup) prevents
        # CPython frame-id reuse from joining unrelated exceptional paths.
        self.last_line: dict[object, int] = {}
        self.path_cache: dict[object, str | None] = {}

    def _path(self, code) -> str | None:
        if code not in self.path_cache:
            path = Path(code.co_filename).resolve()
            try:
                relative = path.relative_to(ROOT.resolve()).as_posix()
            except ValueError:
                relative = None
            self.path_cache[code] = relative if relative and relative.startswith("itlkit/") else None
        return self.path_cache[code]

    def trace(self, frame, event, _arg):
        path = self._path(frame.f_code)
        key = frame
        if event == "call":
            if path is not None:
                self.last_line[key] = frame.f_code.co_firstlineno
            return self.trace
        if path is not None and event == "line":
            previous = self.last_line.get(key, frame.f_code.co_firstlineno)
            self.arcs.add((path, previous, frame.f_lineno))
            self.last_line[key] = frame.f_lineno
        elif event == "return":
            self.last_line.pop(key, None)
        return self.trace

    def run(self, action: Callable[[], dict]) -> tuple[dict, set[tuple[str, int, int]]]:
        self.arcs.clear()
        self.last_line.clear()
        sys.settrace(self.trace)
        try:
            result = action()
        finally:
            sys.settrace(None)
            # Exceptional unwinds are interpreter-version-sensitive.  Release
            # any retained frames explicitly instead of relying on a return event.
            self.last_line.clear()
        return result, set(self.arcs)


class QueueEntry:
    __slots__ = ("data", "digest", "label")

    def __init__(self, data: bytes, label: str) -> None:
        self.data = bytes(data)
        self.digest = sha256(self.data)
        self.label = label


TOKENS = (
    b"\x00", b"\x01", b"\xff", b"hdfm", b"msdh", b"mfdh", b"mhoh",
    b"mith", b"miph", b"mtph", b"SLst", b"x\x9c", b"\x78\xda",
    (0).to_bytes(4, "little"), (1).to_bytes(4, "little"),
    (16).to_bytes(4, "little"), (96).to_bytes(4, "little"),
    (0xFFFFFFFF).to_bytes(4, "little"), (0xFFFFFFFF).to_bytes(4, "big"),
)
BOUNDARY_VALUES = (0, 1, 2, 3, 4, 8, 11, 12, 15, 16, 20, 23, 24, 55, 56,
                   67, 68, 83, 84, 95, 96, 111, 112, 120, 135, 136, 143, 144,
                   255, 256, 4095, 4096, 0x7FFFFFFF, 0xFFFFFFFF)


def mutate(parent: bytes, donor: bytes, rng: StableRng) -> tuple[bytes, dict]:
    data = bytearray(parent)
    operation = rng.below(10)
    recipe: dict[str, object] = {"operation_index": operation}
    if operation == 0:
        if not data:
            data.append(1)
            recipe.update(operation="append_one")
        else:
            offset = rng.below(len(data)); mask = 1 << rng.below(8)
            data[offset] ^= mask
            recipe.update(operation="bit_flip", offset=offset, mask=mask)
    elif operation == 1:
        token = rng.choose(TOKENS)
        if not data:
            data.extend(token[:MAX_INPUT_BYTES])
            offset = 0
        else:
            offset = rng.below(len(data))
            end = min(len(data), offset + len(token))
            data[offset:end] = token[:end - offset]
        recipe.update(operation="token_overwrite", offset=offset, token_hex=token.hex())
    elif operation == 2:
        width = rng.choose((1, 2, 4, 8))
        value = rng.choose(BOUNDARY_VALUES + (len(data), max(0, len(data) - 1), len(data) + 1, MAX_INPUT_BYTES))
        endian = rng.choose(("little", "big"))
        encoded = (value & ((1 << (width * 8)) - 1)).to_bytes(width, endian)
        offset = rng.below(max(1, len(data) - width + 1)) if data else 0
        if offset + width <= len(data):
            data[offset:offset + width] = encoded
        else:
            data.extend(encoded[:MAX_INPUT_BYTES - len(data)])
        recipe.update(operation="integer_overwrite", offset=offset, width=width,
                      endian=endian, value=value)
    elif operation == 3:
        token = rng.choose(TOKENS + (rng.bytes(1 + rng.below(12)),))
        offset = rng.below(len(data) + 1)
        room = MAX_INPUT_BYTES - len(data)
        data[offset:offset] = token[:room]
        recipe.update(operation="insert", offset=offset, inserted_hex=token[:room].hex())
    elif operation == 4:
        if data:
            start = rng.below(len(data)); length = 1 + rng.below(min(64, len(data) - start))
            del data[start:start + length]
        else:
            start = length = 0
        recipe.update(operation="delete", offset=start, length=length)
    elif operation == 5:
        cut_parent = rng.below(len(data) + 1)
        cut_donor = rng.below(len(donor) + 1)
        candidate = bytes(data[:cut_parent]) + donor[cut_donor:]
        data = bytearray(candidate[:MAX_INPUT_BYTES])
        recipe.update(operation="splice", parent_cut=cut_parent, donor_cut=cut_donor,
                      donor_sha256=sha256(donor))
    elif operation == 6:
        new_length = rng.below(len(data) + 1)
        del data[new_length:]
        recipe.update(operation="truncate", length=new_length)
    elif operation == 7:
        if data and len(data) < MAX_INPUT_BYTES:
            start = rng.below(len(data)); length = 1 + rng.below(min(64, len(data) - start))
            offset = rng.below(len(data) + 1)
            chunk = bytes(data[start:start + length])[:MAX_INPUT_BYTES - len(data)]
            data[offset:offset] = chunk
        else:
            start = length = offset = 0
        recipe.update(operation="duplicate_slice", source_offset=start, length=length,
                      destination_offset=offset)
    elif operation == 8:
        if data:
            offset = rng.below(len(data)); delta = rng.choose((-2, -1, 1, 2, 16, -16))
            data[offset] = (data[offset] + delta) & 0xFF
        else:
            offset = delta = 0
        recipe.update(operation="byte_arithmetic", offset=offset, delta=delta)
    else:
        if len(data) >= 2:
            first = rng.below(len(data)); second = rng.below(len(data))
            data[first], data[second] = data[second], data[first]
        else:
            first = second = 0
        recipe.update(operation="swap_bytes", first=first, second=second)
    if len(data) > MAX_INPUT_BYTES:
        del data[MAX_INPUT_BYTES:]
    return bytes(data), recipe


def target_container(data: bytes) -> dict:
    container = Container.from_bytes(data, max_plain_bytes=MAX_PLAIN_BYTES)
    if container.to_bytes() != data:
        raise AssertionError("accepted container no-op was not byte-exact")
    rebuilt = container.to_bytes(rebuild=True, compression_level=1)
    reparsed = Container.from_bytes(rebuilt, max_plain_bytes=MAX_PLAIN_BYTES)
    if (reparsed.payload != container.payload or reparsed.trailer != container.trailer
            or reparsed.header[:8] + reparsed.header[12:] != container.header[:8] + container.header[12:]):
        raise AssertionError("forced envelope reconstruction changed decoded state")
    semantic = "not_attempted"
    projection = "not_attempted"
    try:
        library = Library(container)
        semantic = "accepted"
        if library.to_bytes() != data:
            raise AssertionError("accepted library no-op was not byte-exact")
        try:
            document = library.to_dict()
            restored = Library.from_dict(document, max_plain_bytes=MAX_PLAIN_BYTES)
            if restored.to_bytes() != data:
                raise AssertionError("library JSON no-op was not byte-exact")
            projection = "accepted_exact"
        except EXPECTED_EXCEPTIONS as exc:
            projection = f"refused:{type(exc).__name__}"
    except EXPECTED_EXCEPTIONS as exc:
        semantic = f"refused:{type(exc).__name__}"
    return {"envelope": "accepted_exact", "semantic": semantic, "json_projection": projection,
            "payload_bytes": len(container.payload), "trailer_bytes": len(container.trailer)}


def target_model(data: bytes) -> dict:
    sections = parse_sections(data)
    serialized = serialize_sections(sections)
    if serialized != data:
        raise AssertionError("accepted model did not serialize exactly")
    reconstructed = serialize_sections([Node.from_dict(section.to_dict()) for section in sections])
    if reconstructed != data:
        raise AssertionError("model JSON projection did not serialize exactly")
    return {"sections": len(sections), "nodes": sum(1 for section in sections for _ in section.walk())}


def target_smart_rules(data: bytes) -> dict:
    rules = parse_rules(data, max_rules=256, max_depth=16, max_data_length=MAX_INPUT_BYTES)
    if rules.to_bytes() != data:
        raise AssertionError("accepted smart rules did not serialize exactly")
    issues = validate_rules(rules)
    dumped = dump_rules(rules)
    if dumped["magic"] != "SLst":
        raise AssertionError("smart dump lost SLst identity")
    return {"rules": len(rules.rules), "issues": len(issues), "depth": rules.depth}


def target_smart_preferences(data: bytes) -> dict:
    prefs = parse_preferences(data)
    if prefs.to_bytes() != data:
        raise AssertionError("accepted smart preferences did not serialize exactly")
    issues = validate_preferences(prefs)
    dumped = dump_preferences(prefs)
    if dumped["length"] != len(data):
        raise AssertionError("preference dump length mismatch")
    return {"issues": len(issues), "bytes": len(data)}


TARGETS: dict[str, Callable[[bytes], dict]] = {
    "container": target_container,
    "model": target_model,
    "smart_rules": target_smart_rules,
    "smart_preferences": target_smart_preferences,
}


def synthetic_smart_seeds() -> tuple[list[QueueEntry], list[QueueEntry]]:
    numeric = struct.pack(">QqQQqQIIIII", 2024, -2, 604800, 2024, 0, 1, 1, 2, 3, 4, 5)
    string = "Alpha".encode("utf-16-be")

    def rule(field: int, action: int, body: bytes, opaque: bytes = bytes(44)) -> bytes:
        return struct.pack(">II", field, action) + opaque + len(body).to_bytes(4, "big") + body

    def slst(*rules: bytes, conjunction: int = 0, trailing: bytes = b"") -> bytes:
        return b"SLst" + struct.pack(">III", 0x00010001, len(rules), conjunction) + bytes(120) + b"".join(rules) + trailing

    nested = slst(rule(4, 0x01000002, string), conjunction=1)
    group_opaque = (0x01000000).to_bytes(4, "big") + bytes(40)
    rules = [
        QueueEntry(slst(), "synthetic-empty-slst"),
        QueueEntry(slst(rule(7, 1, numeric)), "synthetic-numeric-slst"),
        QueueEntry(slst(rule(4, 0x01000002, string), trailing=b"TAIL"), "synthetic-string-trailer-slst"),
        QueueEntry(slst(rule(0, 1, nested, group_opaque)), "synthetic-nested-slst"),
    ]
    preferences = [
        QueueEntry(bytes([1, 1, 0, 3]) + struct.pack(">IIII", 2, 25, 0, 7) + bytes(92),
                   "synthetic-native-shaped-preferences"),
        QueueEntry(bytes(range(20)), "synthetic-minimum-preferences"),
    ]
    return rules, preferences


def load_seeds() -> tuple[dict[str, list[QueueEntry]], list[dict]]:
    queues: dict[str, list[QueueEntry]] = {target: [] for target in TARGET_ORDER}
    manifest = []
    seen_model: set[str] = set()
    seen_rules: set[str] = set()
    seen_preferences: set[str] = set()
    for label, relative, expected_hash in SEED_FILES:
        path = ROOT / relative
        data = path.read_bytes()
        actual_hash = sha256(data)
        if actual_hash != expected_hash:
            raise RuntimeError(f"seed hash mismatch: {relative}: {actual_hash}")
        if len(data) > MAX_INPUT_BYTES:
            raise RuntimeError(f"seed exceeds campaign cap: {relative}")
        queues["container"].append(QueueEntry(data, label))
        container = Container.from_bytes(data, max_plain_bytes=MAX_PLAIN_BYTES)
        payload_hash = sha256(container.payload)
        if payload_hash not in seen_model:
            queues["model"].append(QueueEntry(container.payload, f"{label}:payload"))
            seen_model.add(payload_hash)
        smart_rules = 0
        smart_preferences = 0
        try:
            library = Library(container)
        except EXPECTED_EXCEPTIONS:
            library = None
        if library is not None:
            for playlist in library.playlists:
                for child in playlist.node.children or ():
                    if child.tag != b"mhoh":
                        continue
                    digest = sha256(child.payload)
                    if child.type_code == 101 and digest not in seen_rules:
                        queues["smart_rules"].append(QueueEntry(child.payload, f"{label}:type101"))
                        seen_rules.add(digest); smart_rules += 1
                    elif child.type_code == 102 and digest not in seen_preferences:
                        queues["smart_preferences"].append(QueueEntry(child.payload, f"{label}:type102"))
                        seen_preferences.add(digest); smart_preferences += 1
        manifest.append({"label": label, "path": relative, "bytes": len(data),
                         "sha256": actual_hash, "payload_bytes": len(container.payload),
                         "payload_sha256": payload_hash, "new_smart_rule_payloads": smart_rules,
                         "new_smart_preference_payloads": smart_preferences})
    synthetic_rules, synthetic_preferences = synthetic_smart_seeds()
    for entry in synthetic_rules:
        if entry.digest not in seen_rules:
            queues["smart_rules"].append(entry); seen_rules.add(entry.digest)
    for entry in synthetic_preferences:
        if entry.digest not in seen_preferences:
            queues["smart_preferences"].append(entry); seen_preferences.add(entry.digest)
    if any(not queues[target] for target in TARGET_ORDER):
        raise RuntimeError("every target needs at least one seed")
    return queues, manifest


def source_hashes() -> dict[str, str]:
    return {path.relative_to(ROOT).as_posix(): sha256(path.read_bytes())
            for path in sorted((ROOT / "itlkit").glob("*.py"))}


def execute_target(target: str, data: bytes, tracer: ArcTracer) -> tuple[str, dict, set[tuple[str, int, int]]]:
    detail: dict = {}

    def action() -> dict:
        return TARGETS[target](data)

    try:
        detail, arcs = tracer.run(action)
        return "accepted", detail, arcs
    except EXPECTED_EXCEPTIONS as exc:
        return "refused", {"exception": type(exc).__name__, "message": str(exc)[:240]}, set(tracer.arcs)
    except Exception as exc:  # retained as an anomaly, never counted as a pass
        return "anomaly", {"exception": type(exc).__name__, "message": str(exc)[:500]}, set(tracer.arcs)


def arc_text(arc: tuple[str, int, int]) -> str:
    return f"{arc[0]}:{arc[1]}->{arc[2]}"


def run_campaign(iterations: int) -> dict:
    if iterations < 0:
        raise ValueError("iterations must be non-negative")
    queues, seed_manifest = load_seeds()
    rng = StableRng(SEED)
    tracer = ArcTracer()
    coverage: dict[str, set[tuple[str, int, int]]] = {target: set() for target in TARGET_ORDER}
    seen: dict[str, set[str]] = {target: {entry.digest for entry in queues[target]} for target in TARGET_ORDER}
    stats = {
        target: {
            "seed_count": len(queues[target]),
            "controls": collections.Counter(),
            "mutations": collections.Counter(),
            "exceptions": collections.Counter(),
            "detail_states": collections.Counter(),
            "admissions": [],
            "initial_edges": 0,
        }
        for target in TARGET_ORDER
    }
    anomalies: list[dict] = []

    for target in TARGET_ORDER:
        for seed_index, entry in enumerate(tuple(queues[target])):
            outcome, detail, arcs = execute_target(target, entry.data, tracer)
            stats[target]["controls"][outcome] += 1
            if "exception" in detail:
                stats[target]["exceptions"][detail["exception"]] += 1
            coverage[target].update(arcs)
            if outcome == "anomaly":
                anomalies.append({"phase": "control", "target": target, "seed_index": seed_index,
                                  "label": entry.label, "sha256": entry.digest, "bytes": len(entry.data),
                                  "detail": detail})
        stats[target]["initial_edges"] = len(coverage[target])

    for iteration in range(iterations):
        target = TARGET_ORDER[iteration % len(TARGET_ORDER)]
        queue = queues[target]
        parent = queue[rng.below(len(queue))]
        donor = queue[rng.below(len(queue))]
        candidate, recipe = mutate(parent.data, donor.data, rng)
        outcome, detail, arcs = execute_target(target, candidate, tracer)
        stats[target]["mutations"][outcome] += 1
        if "exception" in detail:
            stats[target]["exceptions"][detail["exception"]] += 1
        for key, value in sorted(detail.items()):
            if key in ("semantic", "json_projection", "envelope"):
                stats[target]["detail_states"][f"{key}={value}"] += 1
        candidate_hash = sha256(candidate)
        novel = arcs - coverage[target]
        coverage[target].update(arcs)
        if novel and candidate_hash not in seen[target]:
            seen[target].add(candidate_hash)
            queue.append(QueueEntry(candidate, f"iteration-{iteration}"))
            stats[target]["admissions"].append({
                "iteration": iteration,
                "parent_sha256": parent.digest,
                "candidate_sha256": candidate_hash,
                "bytes": len(candidate),
                "outcome": outcome,
                "new_edge_count": len(novel),
                "new_edges": sorted(arc_text(arc) for arc in novel),
                "recipe": recipe,
            })
        if outcome == "anomaly":
            anomalies.append({"phase": "mutation", "iteration": iteration, "target": target,
                              "parent_sha256": parent.digest, "candidate_sha256": candidate_hash,
                              "bytes": len(candidate), "candidate_hex": candidate.hex(),
                              "recipe": recipe, "detail": detail,
                              "arcs": sorted(arc_text(arc) for arc in arcs)})

    target_reports = {}
    for target in TARGET_ORDER:
        edges = coverage[target]
        modules = collections.Counter(arc[0] for arc in edges)
        target_reports[target] = {
            "seed_count": stats[target]["seed_count"],
            "control_outcomes": dict(sorted(stats[target]["controls"].items())),
            "mutation_outcomes": dict(sorted(stats[target]["mutations"].items())),
            "exceptions": dict(sorted(stats[target]["exceptions"].items())),
            "detail_states": dict(sorted(stats[target]["detail_states"].items())),
            "initial_edge_count": stats[target]["initial_edges"],
            "final_edge_count": len(edges),
            "final_line_count": len({(path, line) for path, before, after in edges for line in (before, after)}),
            "edges_by_module": dict(sorted(modules.items())),
            "queue_final_count": len(queues[target]),
            "coverage_admission_count": len(stats[target]["admissions"]),
            "coverage_admissions": stats[target]["admissions"],
            "final_edges": sorted(arc_text(arc) for arc in edges),
        }

    return {
        "schema": "windows-itunes-itl.coverage-guided-fuzz.v1",
        "status": "completed_bounded_offline_campaign" if not anomalies else "completed_with_anomalies",
        "target_commit": TARGET_COMMIT,
        "generator": {
            "path": Path(__file__).resolve().relative_to(ROOT.resolve()).as_posix(),
            "sha256": sha256(Path(__file__).read_bytes()),
        },
        "runtime": {
            "python_implementation": platform.python_implementation(),
            "python_version": platform.python_version(),
            "pycryptodome_version": Crypto.__version__,
            "zlib_compile_version": zlib.ZLIB_VERSION,
            "zlib_runtime_version": zlib.ZLIB_RUNTIME_VERSION,
        },
        "algorithm": {
            "guidance": "per-target CPython traced source-line transitions under itlkit/",
            "queue_admission": "candidate has at least one previously unseen target transition and a new sha256",
            "prng": "xorshift64* with modulo selection",
            "seed": SEED,
            "seed_hex": hex(SEED),
            "target_schedule": list(TARGET_ORDER),
            "mutation_operators": 10,
        },
        "bounds": {
            "mutation_iterations": iterations,
            "max_input_bytes": MAX_INPUT_BYTES,
            "max_plain_bytes": MAX_PLAIN_BYTES,
            "processes": 1,
            "native_itunes_operations": 0,
            "filesystem_publication_operations": 0,
        },
        "seed_files": seed_manifest,
        "source_sha256": source_hashes(),
        "targets": target_reports,
        "summary": {
            "control_executions": sum(sum(report["control_outcomes"].values()) for report in target_reports.values()),
            "mutation_executions": iterations,
            "accepted_mutations": sum(report["mutation_outcomes"].get("accepted", 0) for report in target_reports.values()),
            "refused_mutations": sum(report["mutation_outcomes"].get("refused", 0) for report in target_reports.values()),
            "anomaly_count": len(anomalies),
            "coverage_admission_count": sum(report["coverage_admission_count"] for report in target_reports.values()),
            "final_edge_count_sum_not_union": sum(report["final_edge_count"] for report in target_reports.values()),
        },
        "anomalies": anomalies,
        "claim_boundaries": [
            "Line-transition guidance is not branch-complete or proof of parser safety.",
            "The campaign is deterministic, bounded, single-process, and offline; it does not test races, crashes, power loss, hostile directories, or native iTunes.",
            "Accepted structural/container inputs prove only the checked round-trip invariants, not semantic validity or native acceptance.",
            "The four targets have separate coverage sets; summed edge counts are not a union and are not a percentage metric.",
            "Smart-playlist names and evaluator meanings remain evidence-labelled prior art where the production parser says so.",
        ],
    }


def write_json(path: Path, value: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--iterations", type=int, default=DEFAULT_ITERATIONS)
    parser.add_argument("--output", type=Path,
                        default=ROOT / "evidence/research/20260925/coverage-guided-fuzz/report.json")
    args = parser.parse_args(argv)
    report = run_campaign(args.iterations)
    write_json(args.output, report)
    print(json.dumps({"status": report["status"], **report["summary"]}, sort_keys=True))
    return 1 if report["anomalies"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
