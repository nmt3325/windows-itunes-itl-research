"""Deterministic synthetic PCM fixtures for G4-B task a09.

Pure standard library, integer arithmetic only. No randomness, no wall-clock
values, no third-party packages, no native APIs, no private media, artwork or
original archive content. Every byte of every fixture is a pure function of a
spec committed in this file, so anyone can reproduce the exact bytes from this
source alone.

CLI
---
  python3 research/g4/a09/fixtures.py --out DIR
  python3 research/g4/a09/fixtures.py --write-registry research/g4/a09/fixture-registry.json
  python3 research/g4/a09/fixtures.py --check-registry research/g4/a09/fixture-registry.json
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import struct
from dataclasses import dataclass, field
from pathlib import Path

REGISTRY_SCHEMA = "itlkit.g4.a09.fixture-registry.v1"
GENERATOR_PATH = "research/g4/a09/fixtures.py"
REPO_ROOT = Path(__file__).resolve().parents[3]

# Reference fixture identity. These values are QUOTED from the G2 evidence
# record; a09 did not observe them at authoring time. Regeneration below is
# compared against them and any mismatch is reported, never edited away.
REFERENCE_ID = "ITL-G2-PCM-48000-001"
REFERENCE_ARTIFACT = "evidence/20260910/g2-new-media/ITL-G2-PCM-48000-001.wav"
REFERENCE_QUOTED = {
    "source_record": "evidence/20260910/g2-final-hardening.json#new_pcm",
    "file": "ITL-G2-PCM-48000-001.wav",
    "bytes": 144044,
    "sha256": "87e45bff7acf44a05a818fa0f33edec429d6648751bcd8aa91ccf91a764b2e05",
    "pcm_sha256": "fe61bf3cd0c6e2676070e044124ff9c06ba170fe61b9429e484511622a1ad46e",
    "sample_rate_hz": 48000,
    "channels": 1,
    "bits_per_sample": 16,
    "frames": 72000,
    "duration_ms": 1500,
    "mtime_ns": 1789026300000000000,
    "formula": (
        "sample[n]=(64*(48-abs((n%192)-96))*min(n,71999-n,480))//480, "
        "n=0..71999; signed little-endian int16"
    ),
}

# Fixed constant used for the new fixture family. It is a declared constant,
# not a clock reading, so regeneration is stable.
BASE_MTIME_NS = 1789084800000000000


# ---------------------------------------------------------------------------
# Waveforms
# ---------------------------------------------------------------------------
def triangle_fade(frames, *, period, peak_scale, fade, phase=0, invert=False):
    """Integer triangle with a linear fade in and out.

        tri(n) = period//4 - abs(((n + phase) %% period) - period//2)
        env(n) = min(n, frames - 1 - n, fade)
        value[n] = (peak_scale * tri(n) * env(n)) // fade

    The division is Python floor division applied to the whole product,
    including negative products, which is what makes the historical G2 record
    reproducible: with period=192, peak_scale=64, fade=480, phase=0 and
    frames=72000 this is exactly
    ``(64*(48-abs((n%%192)-96))*min(n,71999-n,480))//480``.

    ``invert`` negates the already floored value, giving an exact mirror.
    """
    if frames <= 0:
        raise ValueError("frames must be positive")
    if period <= 0 or period % 4:
        raise ValueError("period must be a positive multiple of 4")
    if fade <= 0:
        raise ValueError("fade must be positive")
    half = period // 2
    quarter = period // 4
    if peak_scale * quarter > 32767:
        raise ValueError("peak amplitude does not fit in signed 16-bit")
    sign = -1 if invert else 1
    out = []
    for n in range(frames):
        tri = quarter - abs(((n + phase) % period) - half)
        env = min(n, frames - 1 - n, fade)
        out.append(sign * ((peak_scale * tri * env) // fade))
    return out


def silence(frames):
    """Digital black. Negative control for peak and RMS based checks."""
    if frames <= 0:
        raise ValueError("frames must be positive")
    return [0] * frames


def pack_pcm16(channel_values):
    """Interleave per-channel integer lists into little-endian signed PCM16."""
    if not channel_values:
        raise ValueError("at least one channel is required")
    frames = len(channel_values[0])
    if any(len(c) != frames for c in channel_values):
        raise ValueError("all channels must have the same frame count")
    buf = bytearray(frames * len(channel_values) * 2)
    off = 0
    for n in range(frames):
        for chan in channel_values:
            value = chan[n]
            if not -32768 <= value <= 32767:
                raise ValueError("sample out of signed 16-bit range")
            struct.pack_into("<h", buf, off, value)
            off += 2
    return bytes(buf)


# ---------------------------------------------------------------------------
# RIFF construction
# ---------------------------------------------------------------------------
def riff_chunk(chunk_id, payload):
    """One RIFF chunk, including the RIFF pad byte for odd payload sizes."""
    if len(chunk_id) != 4:
        raise ValueError("chunk id must be four bytes")
    out = chunk_id + struct.pack("<I", len(payload)) + payload
    if len(payload) % 2:
        out += b"\x00"
    return out


def info_chunk(entries):
    """LIST/INFO chunk. Values are ASCII and NUL terminated."""
    payload = b"INFO"
    for key, text in entries:
        payload += riff_chunk(key.encode("ascii"), text.encode("ascii") + b"\x00")
    return (b"LIST", payload)


def syncsafe(size):
    return bytes(((size >> 21) & 0x7F, (size >> 14) & 0x7F, (size >> 7) & 0x7F, size & 0x7F))


def id3v23_tag(frame_specs):
    """Minimal ID3v2.3 tag: encoding 0 is latin-1, encoding 1 is UTF-16 LE+BOM."""
    body = b""
    for frame_id, text, encoding in frame_specs:
        if encoding == 0:
            payload = b"\x00" + text.encode("latin-1") + b"\x00"
        elif encoding == 1:
            payload = b"\x01" + b"\xff\xfe" + text.encode("utf-16-le") + b"\x00\x00"
        else:
            raise ValueError("unsupported ID3 text encoding")
        body += frame_id.encode("ascii") + struct.pack(">I", len(payload)) + b"\x00\x00" + payload
    return b"ID3" + bytes((3, 0)) + b"\x00" + syncsafe(len(body)) + body


def build_wav(pcm, *, sample_rate, channels, bits_per_sample, extra=(), placement="after_data"):
    block_align = channels * bits_per_sample // 8
    byte_rate = sample_rate * block_align
    fmt = struct.pack(
        "<HHIIHH", 1, channels, sample_rate, byte_rate, block_align, bits_per_sample
    )
    extras = b"".join(riff_chunk(cid, payload) for cid, payload in extra)
    data = riff_chunk(b"data", pcm)
    if placement == "after_data":
        body = riff_chunk(b"fmt ", fmt) + data + extras
    elif placement == "before_data":
        body = riff_chunk(b"fmt ", fmt) + extras + data
    else:
        raise ValueError("placement must be after_data or before_data")
    payload = b"WAVE" + body
    return b"RIFF" + struct.pack("<I", len(payload)) + payload


def parse_chunks(data):
    """Independent structural walk used by the registry and by the tests."""
    if len(data) < 12 or data[:4] != b"RIFF" or data[8:12] != b"WAVE":
        raise ValueError("not a RIFF/WAVE file")
    declared = struct.unpack_from("<I", data, 4)[0]
    if declared != len(data) - 8:
        raise ValueError("RIFF size field %d does not match file size %d" % (declared, len(data) - 8))
    chunks = []
    off = 12
    while off < len(data):
        if off + 8 > len(data):
            raise ValueError("truncated chunk header")
        cid = data[off:off + 4]
        size = struct.unpack_from("<I", data, off + 4)[0]
        start = off + 8
        end = start + size
        if end > len(data):
            raise ValueError("chunk overruns end of file")
        pad = size % 2
        chunks.append(
            {
                "id": cid.decode("latin-1"),
                "header_offset": off,
                "payload_offset": start,
                "payload_size": size,
                "pad_bytes": pad,
            }
        )
        off = end + pad
    return chunks


def parse_subchunks(data, payload_offset, payload_size):
    """Walk the subchunks inside a LIST payload, including their pad bytes."""
    end = payload_offset + payload_size
    form = data[payload_offset:payload_offset + 4].decode("latin-1")
    out = []
    off = payload_offset + 4
    while off < end:
        if off + 8 > end:
            raise ValueError("truncated subchunk header")
        chunk_id = data[off:off + 4].decode("latin-1")
        size = struct.unpack_from("<I", data, off + 4)[0]
        start = off + 8
        if start + size > end:
            raise ValueError("subchunk overruns its list")
        pad = size % 2
        out.append(
            {
                "id": chunk_id,
                "header_offset": off,
                "payload_offset": start,
                "payload_size": size,
                "pad_bytes": pad,
            }
        )
        off = start + size + pad
    return form, out


def chunk_map(data):
    """Top level chunks, with LIST payloads expanded into their subchunks."""
    chunks = parse_chunks(data)
    for chunk in chunks:
        if chunk["id"] == "LIST":
            form, subchunks = parse_subchunks(data, chunk["payload_offset"], chunk["payload_size"])
            chunk["list_form"] = form
            chunk["subchunks"] = subchunks
    return chunks


def data_payload(data):
    for chunk in parse_chunks(data):
        if chunk["id"] == "data":
            start = chunk["payload_offset"]
            return data[start:start + chunk["payload_size"]]
    raise ValueError("no data chunk")


def pcm_stats(pcm):
    count = len(pcm) // 2
    values = struct.unpack("<" + "h" * count, pcm)
    peak = max(abs(v) for v in values)
    total = sum(v * v for v in values)
    return {
        "samples": count,
        "peak_abs": peak,
        "rms": round((total / count) ** 0.5, 6),
        "nonzero_samples": sum(1 for v in values if v),
        "first_samples": list(values[:4]),
        "last_samples": list(values[-4:]),
    }


# ---------------------------------------------------------------------------
# Fixture specs
# ---------------------------------------------------------------------------
@dataclass(frozen=True)
class FixtureSpec:
    fixture_id: str
    filename: str
    role: str
    purpose: str
    sample_rate_hz: int
    channels: int
    frames: int
    waveform: str
    waveform_params: dict
    mtime_ns: int
    metadata_shape: str = "none"
    metadata: dict = field(default_factory=dict)
    metadata_placement: str = "after_data"
    bits_per_sample: int = 16


MONO = [{"phase": 0, "invert": False}]

SPECS = [
    FixtureSpec(
        fixture_id=REFERENCE_ID,
        filename="ITL-G2-PCM-48000-001.wav",
        role="historical-reference-regeneration",
        purpose="Bit-exact regeneration of the G2 reference fixture from its recorded formula.",
        sample_rate_hz=48000,
        channels=1,
        frames=72000,
        waveform="triangle",
        waveform_params={"period": 192, "peak_scale": 64, "fade": 480, "channel_offsets": MONO},
        mtime_ns=REFERENCE_QUOTED["mtime_ns"],
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-44100-MONO-1000",
        filename="ITL-G4-A09-PCM-44100-MONO-1000.wav",
        role="rate-variation",
        purpose="CD sample rate, one second exactly, no embedded metadata.",
        sample_rate_hz=44100,
        channels=1,
        frames=44100,
        waveform="triangle",
        waveform_params={"period": 300, "peak_scale": 48, "fade": 441, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 60 * 10 ** 9,
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-22050-MONO-0500",
        filename="ITL-G4-A09-PCM-22050-MONO-0500.wav",
        role="rate-and-duration-variation",
        purpose="Half CD rate, 500 ms, short-duration handling.",
        sample_rate_hz=22050,
        channels=1,
        frames=11025,
        waveform="triangle",
        waveform_params={"period": 196, "peak_scale": 56, "fade": 220, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 120 * 10 ** 9,
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-8000-MONO-3000",
        filename="ITL-G4-A09-PCM-8000-MONO-3000.wav",
        role="rate-and-duration-variation",
        purpose="Low sample rate with the longest duration in the family, 3000 ms.",
        sample_rate_hz=8000,
        channels=1,
        frames=24000,
        waveform="triangle",
        waveform_params={"period": 80, "peak_scale": 128, "fade": 80, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 180 * 10 ** 9,
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-48000-STEREO-1500",
        filename="ITL-G4-A09-PCM-48000-STEREO-1500.wav",
        role="channel-variation",
        purpose="Two channels that differ by phase and polarity, so channel order is observable.",
        sample_rate_hz=48000,
        channels=2,
        frames=72000,
        waveform="triangle",
        waveform_params={
            "period": 192,
            "peak_scale": 64,
            "fade": 480,
            "channel_offsets": [{"phase": 0, "invert": False}, {"phase": 96, "invert": True}],
        },
        mtime_ns=BASE_MTIME_NS + 240 * 10 ** 9,
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-48000-MONO-0010-SILENCE",
        filename="ITL-G4-A09-PCM-48000-MONO-0010-SILENCE.wav",
        role="negative-control",
        purpose="10 ms of digital silence. Peak and RMS are exactly zero by construction.",
        sample_rate_hz=48000,
        channels=1,
        frames=480,
        waveform="silence",
        waveform_params={},
        mtime_ns=BASE_MTIME_NS + 300 * 10 ** 9,
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-48000-MONO-1500-INFO",
        filename="ITL-G4-A09-PCM-48000-MONO-1500-INFO.wav",
        role="metadata-shape",
        purpose="Reference audio plus an ASCII LIST/INFO chunk placed after the data chunk.",
        sample_rate_hz=48000,
        channels=1,
        frames=72000,
        waveform="triangle",
        waveform_params={"period": 192, "peak_scale": 64, "fade": 480, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 360 * 10 ** 9,
        metadata_shape="riff-info-ascii",
        metadata={
            "info": [
                ["INAM", "A09 Synthetic Tone INFO"],
                ["IART", "A09 Synthetic Artist"],
                ["IPRD", "A09 Synthetic Album"],
                ["IGNR", "Synthetic Test Tone"],
                ["ICMT", "Deterministic a09 fixture, synthetic only"],
                ["ICRD", "2026-09-11"],
                ["ITRK", "7"],
                ["ISFT", "itl-g4-a09-fixtures"],
            ]
        },
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-48000-MONO-1500-INFO-ODD",
        filename="ITL-G4-A09-PCM-48000-MONO-1500-INFO-ODD.wav",
        role="metadata-shape",
        purpose=(
            "Odd length INFO value forcing a RIFF pad byte, with metadata before the "
            "data chunk so the audio does not start at byte 44."
        ),
        sample_rate_hz=48000,
        channels=1,
        frames=72000,
        waveform="triangle",
        waveform_params={"period": 192, "peak_scale": 64, "fade": 480, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 420 * 10 ** 9,
        metadata_shape="riff-info-odd",
        metadata={"info": [["INAM", "A09 ODDPAD"], ["ICMT", "odd length value forces a pad byte"]]},
        metadata_placement="before_data",
    ),
    FixtureSpec(
        fixture_id="ITL-G4-A09-PCM-48000-MONO-1500-ID3U",
        filename="ITL-G4-A09-PCM-48000-MONO-1500-ID3U.wav",
        role="metadata-shape",
        purpose="Reference audio plus an ID3v2.3 chunk with UTF-16 text including non-BMP.",
        sample_rate_hz=48000,
        channels=1,
        frames=72000,
        waveform="triangle",
        waveform_params={"period": 192, "peak_scale": 64, "fade": 480, "channel_offsets": MONO},
        mtime_ns=BASE_MTIME_NS + 480 * 10 ** 9,
        metadata_shape="id3v23-unicode",
        metadata={
            "id3": [
                ["TIT2", "A09 \u57cb\u8fbc\u30bf\u30a4\u30c8\u30eb \u03a9 \U0001f3b5", 1],
                ["TPE1", "A09 \u5171\u6709\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8", 1],
                ["TALB", "A09 \u5171\u901a\u30a2\u30eb\u30d0\u30e0", 1],
                ["TCON", "\u96fb\u5b50\u97f3 A09", 1],
                ["TRCK", "9/9", 0],
                ["TYER", "2026", 0],
            ]
        },
    ),
]


def spec_by_id(fixture_id):
    for spec in SPECS:
        if spec.fixture_id == fixture_id:
            return spec
    raise KeyError(fixture_id)


def render_channels(spec):
    if spec.waveform == "silence":
        return [silence(spec.frames) for _ in range(spec.channels)]
    if spec.waveform == "triangle":
        params = spec.waveform_params
        offsets = params.get("channel_offsets") or MONO
        if len(offsets) != spec.channels:
            raise ValueError("channel_offsets must match the channel count")
        return [
            triangle_fade(
                spec.frames,
                period=params["period"],
                peak_scale=params["peak_scale"],
                fade=params["fade"],
                phase=int(offset.get("phase", 0)),
                invert=bool(offset.get("invert", False)),
            )
            for offset in offsets
        ]
    raise ValueError("unknown waveform %r" % (spec.waveform,))


def extra_chunks(spec):
    if spec.metadata_shape == "none":
        return []
    if spec.metadata_shape in ("riff-info-ascii", "riff-info-odd"):
        return [info_chunk([tuple(entry) for entry in spec.metadata["info"]])]
    if spec.metadata_shape == "id3v23-unicode":
        return [(b"id3 ", id3v23_tag([tuple(entry) for entry in spec.metadata["id3"]]))]
    raise ValueError("unknown metadata shape %r" % (spec.metadata_shape,))


def build_fixture(spec):
    pcm = pack_pcm16(render_channels(spec))
    return build_wav(
        pcm,
        sample_rate=spec.sample_rate_hz,
        channels=spec.channels,
        bits_per_sample=spec.bits_per_sample,
        extra=extra_chunks(spec),
        placement=spec.metadata_placement,
    )


def describe(spec, data):
    pcm = data_payload(data)
    row = {
        "fixture_id": spec.fixture_id,
        "filename": spec.filename,
        "role": spec.role,
        "purpose": spec.purpose,
        "sample_rate_hz": spec.sample_rate_hz,
        "channels": spec.channels,
        "bits_per_sample": spec.bits_per_sample,
        "frames": spec.frames,
        "duration_ms": spec.frames * 1000 / spec.sample_rate_hz,
        "waveform": spec.waveform,
        "waveform_params": spec.waveform_params,
        "metadata_shape": spec.metadata_shape,
        "metadata": spec.metadata,
        "metadata_placement": spec.metadata_placement,
        "mtime_ns": spec.mtime_ns,
        "size_bytes": len(data),
        "sha256": hashlib.sha256(data).hexdigest(),
        "pcm_sha256": hashlib.sha256(pcm).hexdigest(),
        "chunks": chunk_map(data),
        "pcm": pcm_stats(pcm),
    }
    if spec.fixture_id == REFERENCE_ID:
        row["quoted_reference"] = dict(REFERENCE_QUOTED)
        row["matches_quoted_sha256"] = row["sha256"] == REFERENCE_QUOTED["sha256"]
        row["matches_quoted_pcm_sha256"] = row["pcm_sha256"] == REFERENCE_QUOTED["pcm_sha256"]
        row["matches_quoted_size"] = row["size_bytes"] == REFERENCE_QUOTED["bytes"]
    return row


def sha256_file(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as handle:
        for block in iter(lambda: handle.read(1 << 20), b""):
            digest.update(block)
    return digest.hexdigest()


def build_registry():
    return {
        "schema": REGISTRY_SCHEMA,
        "generator": GENERATOR_PATH,
        "generator_sha256": sha256_file(Path(__file__)),
        "authored_on": "gha",
        "determinism": [
            "integer arithmetic only, Python floor division",
            "no randomness, no clock reads, no locale or environment input",
            "file mtimes are declared constants applied with os.utime",
            "canonical 44 byte PCM header unless the spec declares extra chunks",
        ],
        "fixtures": [describe(spec, build_fixture(spec)) for spec in SPECS],
    }


def write_fixture(out_dir, spec, data, allow_in_repo=False):
    out_dir = Path(out_dir).resolve()
    if not allow_in_repo and out_dir.is_relative_to(REPO_ROOT):
        raise SystemExit(
            "refusing to materialise fixtures inside the repository; "
            "generators are committed, binaries are not"
        )
    out_dir.mkdir(parents=True, exist_ok=True)
    path = out_dir / spec.filename
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_bytes(data)
    tmp.replace(path)
    os.utime(path, ns=(spec.mtime_ns, spec.mtime_ns))
    return path


def check_registry(path):
    recorded = json.loads(Path(path).read_text(encoding="utf-8"))
    problems = []
    if recorded.get("schema") != REGISTRY_SCHEMA:
        problems.append("schema mismatch: %r" % (recorded.get("schema"),))
    rows = {row["fixture_id"]: row for row in recorded.get("fixtures", [])}
    for spec in SPECS:
        row = rows.pop(spec.fixture_id, None)
        if row is None:
            problems.append("%s: missing from registry" % spec.fixture_id)
            continue
        data = build_fixture(spec)
        observed = hashlib.sha256(data).hexdigest()
        if observed != row.get("sha256"):
            problems.append(
                "%s: sha256 recorded %s observed %s" % (spec.fixture_id, row.get("sha256"), observed)
            )
        if len(data) != row.get("size_bytes"):
            problems.append(
                "%s: size recorded %s observed %d" % (spec.fixture_id, row.get("size_bytes"), len(data))
            )
    for leftover in rows:
        problems.append("%s: registry row has no spec" % leftover)
    reference = build_fixture(spec_by_id(REFERENCE_ID))
    observed_reference = hashlib.sha256(reference).hexdigest()
    if observed_reference != REFERENCE_QUOTED["sha256"]:
        problems.append(
            "reference regeneration mismatch: quoted %s observed %s"
            % (REFERENCE_QUOTED["sha256"], observed_reference)
        )
    return problems


def main(argv=None):
    parser = argparse.ArgumentParser(description="Deterministic a09 synthetic fixtures")
    parser.add_argument("--out", type=Path, help="materialise every fixture into this directory")
    parser.add_argument("--write-registry", type=Path, help="write the recorded hash registry")
    parser.add_argument("--check-registry", type=Path, help="regenerate and compare against a registry")
    parser.add_argument("--allow-in-repo", action="store_true", help="permit --out inside the repo")
    args = parser.parse_args(argv)

    if args.check_registry:
        problems = check_registry(args.check_registry)
        for problem in problems:
            print("MISMATCH " + problem)
        print("checked %d fixtures, %d problems" % (len(SPECS), len(problems)))
        return 1 if problems else 0

    registry = build_registry()
    if args.out:
        for spec in SPECS:
            path = write_fixture(args.out, spec, build_fixture(spec), allow_in_repo=args.allow_in_repo)
            print("WROTE %s %s" % (spec.fixture_id, path))
    if args.write_registry:
        target = Path(args.write_registry)
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(json.dumps(registry, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        print("REGISTRY %s" % target)
    if not args.out and not args.write_registry:
        print(json.dumps(registry, indent=2, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
