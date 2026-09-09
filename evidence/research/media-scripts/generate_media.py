#!/usr/bin/env python3
"""Fresh, bounded, deterministic ITL import media; no iTunes or third-party Python.
Run with Python -B. All writes stay below this script's parent report directory.
Existing outputs are never overwritten. Encoders are optional explicit paths.
"""
from __future__ import annotations
import argparse
import array
import hashlib
import io
import json
import math
import os
from pathlib import Path
import re
import struct
import subprocess
import sys
import warnings
import wave
from datetime import datetime, timezone

VERSION = "itl-media-generator-v1"
RATE = 44100
FRAMES = 66150
CHANNELS = 1
BITS = 16
AMPLITUDE = 1638
ROOT = Path(__file__).resolve().parent.parent
SPECS = [
    dict(id="media-wav-pcm16", filename="itl_media_01_wav_pcm16.wav", codec="pcm_s16le", format="wav", lossless=True, hz=440, number=1),
    dict(id="media-aiff-pcm16", filename="itl_media_02_aiff_pcm16.aiff", codec="pcm_s16be", format="aiff", lossless=True, hz=550, number=2),
    dict(id="media-mp3", filename="itl_media_03_mp3.mp3", codec="mp3", encoder="libmp3lame", format="mp3", lossless=False, hz=660, number=3),
    dict(id="media-aac-m4a", filename="itl_media_04_aac.m4a", codec="aac", encoder="aac", format="aac", lossless=False, hz=770, number=4),
    dict(id="media-alac-m4a", filename="itl_media_05_alac.m4a", codec="alac", encoder="alac", format="alac", lossless=True, hz=880, number=5),
]
for spec in SPECS:
    label = {"wav":"WAV PCM16", "aiff":"AIFF PCM16", "mp3":"MP3", "aac":"AAC M4A", "alac":"ALAC M4A"}[spec["format"]]
    spec["metadata"] = {"title":f"ITL Media {spec['number']:02d} {label}", "artist":f"ITL Synthetic Artist {spec['number']:02d}", "album":f"ITL Media Album {spec['number']:02d}"}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def write_new(path, data):
    path = Path(path)
    path.resolve().relative_to(ROOT)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())


def write_json(path, value):
    write_new(path, (json.dumps(value, ensure_ascii=False, indent=2) + "\n").encode("utf-8"))


def synth(spec):
    samples = array.array("h", (round(AMPLITUDE * math.sin(2 * math.pi * spec["hz"] * i / RATE)) for i in range(FRAMES)))
    if sys.byteorder != "little":
        samples.byteswap()
    return samples.tobytes()


def chunk(name, payload, order):
    assert len(name) == 4
    return name + struct.pack(order + "I", len(payload)) + payload + b"\0" * (len(payload) % 2)


def id3(meta):
    body = b""
    for frame, key in ((b"TIT2", "title"), (b"TPE1", "artist"), (b"TALB", "album")):
        value = b"\0" + meta[key].encode("latin-1")
        body += frame + struct.pack(">I", len(value)) + b"\0\0" + value
    n = len(body)
    return b"ID3\x03\0\0" + bytes(((n >> 21) & 127, (n >> 14) & 127, (n >> 7) & 127, n & 127)) + body


def pcm_file(spec, pcm):
    meta = spec["metadata"]
    if spec["format"] == "wav":
        fmt = struct.pack("<HHIIHH", 1, CHANNELS, RATE, RATE * CHANNELS * 2, CHANNELS * 2, BITS)
        info = b"INFO"
        for tag, value in ((b"INAM",meta["title"]),(b"IART",meta["artist"]),(b"IPRD",meta["album"]),(b"ISFT",VERSION)):
            info += chunk(tag, value.encode("ascii") + b"\0", "<")
        body = b"WAVE" + chunk(b"fmt ", fmt, "<") + chunk(b"LIST", info, "<") + chunk(b"data", pcm, "<")
        return b"RIFF" + struct.pack("<I", len(body)) + body
    assert spec["format"] == "aiff"
    exponent = RATE.bit_length() - 1
    rate80 = struct.pack(">HQ", 16383 + exponent, RATE << (63 - exponent))
    comm = struct.pack(">HIH", CHANNELS, FRAMES, BITS) + rate80
    big = bytearray(len(pcm))
    big[0::2], big[1::2] = pcm[1::2], pcm[0::2]
    body = b"AIFF" + chunk(b"COMM", comm, ">")
    body += chunk(b"NAME", meta["title"].encode("ascii"), ">")
    body += chunk(b"AUTH", meta["artist"].encode("ascii"), ">")
    body += chunk(b"ID3 ", id3(meta), ">")
    body += chunk(b"SSND", struct.pack(">II", 0, 0) + big, ">")
    return b"FORM" + struct.pack(">I", len(body)) + body


def walk_chunks(data, start, end, order):
    out = {}
    pos = start
    while pos < end:
        assert pos + 8 <= end, "partial chunk header"
        tag = data[pos:pos+4]
        size = struct.unpack_from(order + "I", data, pos+4)[0]
        a, b = pos + 8, pos + 8 + size
        assert b <= end, "chunk exceeds declared form"
        assert tag not in out, "duplicate chunk in controlled fixture"
        out[tag] = data[a:b]
        pos = b + size % 2
        assert pos <= end, "missing chunk pad"
        if size % 2:
            assert data[b] == 0
    assert pos == end
    return out


def read_id3(data):
    assert data[:6] == b"ID3\x03\0\0"
    assert all(x < 128 for x in data[6:10])
    size = sum(x << shift for x, shift in zip(data[6:10], (21,14,7,0)))
    assert size + 10 == len(data)
    values, pos = {}, 10
    while pos < len(data):
        assert pos + 10 <= len(data)
        key = data[pos:pos+4].decode("ascii")
        n = struct.unpack_from(">I", data, pos+4)[0]
        assert data[pos+8:pos+10] == b"\0\0"
        value = data[pos+10:pos+10+n]
        assert len(value) == n and value[0] == 0
        values[key] = value[1:].decode("latin-1")
        pos += 10 + n
    assert pos == len(data)
    return {"title":values["TIT2"], "artist":values["TPE1"], "album":values["TALB"]}


def stats(pcm):
    assert len(pcm) % 2 == 0
    values = [v[0] for v in struct.iter_unpack("<h", pcm)]
    return dict(decoded_frames=len(values), decoded_pcm_s16le_sha256=sha(pcm), peak_sample=max(abs(v) for v in values), rms_sample=round(math.sqrt(sum(v*v for v in values) / len(values)), 6))


def validate_pcm(path, spec):
    data = Path(path).read_bytes()
    assert len(data) < 1024 * 1024
    expected_pcm = synth(spec)
    fmt = spec["format"]
    readers = ["bounded_chunk_parser", "deterministic_regeneration"]
    if fmt == "wav":
        assert data[:4] == b"RIFF" and data[8:12] == b"WAVE"
        assert struct.unpack_from("<I", data, 4)[0] + 8 == len(data)
        chunks = walk_chunks(data, 12, len(data), "<")
        assert struct.unpack("<HHIIHH", chunks[b"fmt "]) == (1, CHANNELS, RATE, RATE*2, 2, BITS)
        assert chunks[b"LIST"][:4] == b"INFO"
        info = walk_chunks(chunks[b"LIST"], 4, len(chunks[b"LIST"]), "<")
        tags = {key:info[tag].rstrip(b"\0").decode("ascii") for key,tag in (("title",b"INAM"),("artist",b"IART"),("album",b"IPRD"))}
        pcm = chunks[b"data"]
        with wave.open(io.BytesIO(data), "rb") as reader:
            assert (reader.getnchannels(), reader.getsampwidth(), reader.getframerate(), reader.getnframes(), reader.getcomptype()) == (1,2,RATE,FRAMES,"NONE")
            assert reader.readframes(FRAMES + 1) == pcm
        readers.append("python_stdlib_wave")
        scheme = "RIFF LIST/INFO INAM IART IPRD"
    else:
        assert data[:4] == b"FORM" and data[8:12] == b"AIFF"
        assert struct.unpack_from(">I", data, 4)[0] + 8 == len(data)
        chunks = walk_chunks(data, 12, len(data), ">")
        assert len(chunks[b"COMM"]) == 18
        assert struct.unpack_from(">HIH", chunks[b"COMM"]) == (1,FRAMES,16)
        exp,mant = struct.unpack_from(">HQ", chunks[b"COMM"], 8)
        assert math.ldexp(mant, exp - 16383 - 63) == RATE
        assert chunks[b"SSND"][:8] == b"\0" * 8
        big = chunks[b"SSND"][8:]
        little = bytearray(len(big))
        little[0::2], little[1::2] = big[1::2], big[0::2]
        pcm = bytes(little)
        tags = read_id3(chunks[b"ID3 "])
        assert chunks[b"NAME"].decode("ascii") == tags["title"]
        assert chunks[b"AUTH"].decode("ascii") == tags["artist"]
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", DeprecationWarning)
            try:
                import aifc
            except ImportError:
                aifc = None
        if aifc is not None:
            with aifc.open(io.BytesIO(data), "rb") as reader:
                assert (reader.getnchannels(),reader.getsampwidth(),reader.getframerate(),reader.getnframes(),reader.getcomptype()) == (1,2,RATE,FRAMES,b"NONE")
                assert reader.readframes(FRAMES+1) == big
            readers.append("python_stdlib_aifc")
        scheme = "AIFF NAME/AUTH plus ID3v2.3 TIT2 TPE1 TALB"
    assert pcm == expected_pcm and len(pcm) == FRAMES * 2
    assert tags == spec["metadata"]
    assert data == pcm_file(spec, expected_pcm)
    return dict(status="passed", readers=readers, codec=spec["codec"], sample_rate=RATE, channels=1, bits_per_sample=16, duration_seconds=FRAMES/RATE, frames=FRAMES, embedded_metadata=tags, metadata_scheme=scheme, **stats(pcm))


def command(args, out, label, binary=False):
    env = os.environ.copy()
    for k in ("TMP", "TEMP", "TMPDIR"):
        env[k] = str(out / "tmp")
    env["OMP_NUM_THREADS"] = "1"
    env["PYTHONDONTWRITEBYTECODE"] = "1"
    result = subprocess.run([str(x) for x in args], stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=40, env=env)
    record = dict(argv=[str(x) for x in args], exit_code=result.returncode, stderr=result.stderr.decode("utf-8", "replace"), stdout_bytes=len(result.stdout), stdout_sha256=sha(result.stdout))
    if not binary:
        record["stdout"] = result.stdout.decode("utf-8", "replace")
    write_json(out / "logs" / (label + ".json"), record)
    if result.returncode:
        raise RuntimeError(f"{label} failed with {result.returncode}; see log")
    return result.stdout


def encode(path, spec, pcm, ffmpeg, out):
    source = out / "inputs" / (spec["id"] + "-source.wav")
    stream = io.BytesIO()
    with wave.open(stream, "wb") as writer:
        writer.setparams((1,2,RATE,0,"NONE","not compressed"))
        writer.writeframes(pcm)
    write_new(source, stream.getvalue())
    args = [ffmpeg,"-hide_banner","-loglevel","error","-nostdin","-n","-threads","1","-filter_threads","1","-filter_complex_threads","1","-i",source,"-map","0:a:0","-map_metadata","-1","-c:a",spec["encoder"],"-threads:a","1","-ar",str(RATE),"-ac","1"]
    if spec["format"] == "mp3":
        args += ["-b:a","64k","-id3v2_version","3","-write_id3v1","0","-write_xing","1"]
    elif spec["format"] == "aac":
        args += ["-b:a","64k","-profile:a","aac_low","-movflags","+faststart"]
    else:
        args += ["-sample_fmt","s16p","-movflags","+faststart"]
    for key, value in spec["metadata"].items():
        args += ["-metadata",f"{key}={value}"]
    args += [path]
    command(args,out,spec["id"]+"-encode")
    return dict(path=str(source),size_bytes=source.stat().st_size,sha256=sha(source.read_bytes()))


def probe(path, spec, ffprobe, out):
    if not ffprobe:
        value = dict(status="not_run", reason="ffprobe.exe not found/provided; no installation attempted", path=None)
        write_json(out / "logs" / (spec["id"] + "-ffprobe-unavailable.json"),value)
        return value
    raw = command([ffprobe,"-v","error","-show_format","-show_streams","-of","json",path],out,spec["id"]+"-ffprobe")
    value = json.loads(raw)
    streams = [s for s in value["streams"] if s["codec_type"] == "audio"]
    assert len(streams) == 1 and len(value["streams"]) == 1
    s = streams[0]
    assert s["codec_name"] == spec["codec"]
    assert int(s["sample_rate"]) == RATE and s["channels"] == CHANNELS
    assert int(value["format"]["size"]) == Path(path).stat().st_size
    assert 1 <= float(value["format"]["duration"]) <= 2.2
    tags = {k.lower():v for k,v in value["format"].get("tags",{}).items()}
    for k,v in spec["metadata"].items():
        assert tags.get(k) == v, (k,tags.get(k),v)
    return dict(status="passed", executable=str(ffprobe), evidence=str(out/"logs"/(spec["id"]+"-ffprobe.json")), data=value)


def request(item):
    return dict(case_id=item["id"], request_type="native_donor_creation_from_fresh_media", priority=1 if item["format"] == "wav" else 5, media=dict(path=item["path"],sha256=item["sha256"],size_bytes=item["size_bytes"]), candidate_itl=None, baseline_itl=None, donor_itl=None, serialized_file_pid=None, com_library_pid=None, track_pid=None, identity_binding_status="dynamic_must_capture_not_guessed", intended_operation="Import exactly this one newly generated synthetic audio file into an explicitly selected disposable native library; record raw tag recognition before any optional donor metadata setters.", expected=dict(track_count_delta=1, preserve_all_old_tracks=True, sample_rate=RATE, channels=1, content_duration_ms=1500, com_duration_integer_seconds_range=[1,2], media_file_size=item["size_bytes"], metadata_in_file=item["metadata"], desired_donor_com_fields={"Name":item["metadata"]["title"],"Artist":item["metadata"]["artist"],"Album":item["metadata"]["album"]}, location_policy="Exact absolute path of the hash-verified dynamic-owned copy; bind it in the native request. Do not silently accept the source or an unrelated file.", membership_change="One added track in native master/music collections as actually observed; old ordinary/manual memberships unchanged unless explicitly requested."), native_gates=["Verify media SHA256 before copying and again before import. Never edit the media-owned originals.","Select a disposable native baseline and capture its hash, distinct file/master PIDs, full track identities/fields and full playlist memberships before the import.","Import one file; require exactly one new unique nonzero track PID and intact old tracks. Capture raw Name/Artist/Album/Kind/Duration/Size/SampleRate/Location and initial media hash before any metadata setters.","Treat tag-recognition mismatch as a recorded negative tag result, not a codec/container failure or a successful metadata gate. If donor preparation needs explicit field setters, use a writable disposable media copy and retain separate pre-set/post-set evidence and hashes.","Require selected native library identity, complete enumeration, no damaged/empty fallback, existing exact file location and two completed save/restart cycles with passive re-observation.","Optional silent playback is dynamic-owner-only and must record any changed play counters/state independently.","A subsequently independently written ITL needs a separate candidate path/hash and complete bound baseline/donor identities, tracks and membership expectations; this media request alone does not satisfy that gate."], known_unknowns=["iTunes embedded-tag recognition is untested; WAV INFO in particular may be ignored.","No iTunes/COM/UI/Frida activity was performed by media.","Persistent IDs and library/playlist identities are native-assigned and must not be fabricated.","Non-WAV ITL structural/import support remains outside the pinned production codec's closed local-WAV profile."], native_acceptance="untested")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--set-name", default="pcm-v1")
    parser.add_argument("--ffmpeg", type=Path)
    parser.add_argument("--ffprobe", type=Path)
    parser.add_argument("--verify", action="store_true", help="Read-only SHA/PCM validation of an existing set")
    args = parser.parse_args()
    if not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9_-]{0,63}",args.set_name):
        parser.error("set name must be an ASCII leaf name")
    out = ROOT / args.set_name
    if args.verify:
        manifest = json.loads((out/"media-manifest.json").read_text(encoding="utf-8"))
        results=[]
        for item in manifest["media"]:
            path=Path(item["path"])
            path.resolve().relative_to(out.resolve())
            assert path.stat().st_size == item["size_bytes"]
            assert sha(path.read_bytes()) == item["sha256"]
            spec=next(s for s in SPECS if s["id"]==item["id"])
            detail=validate_pcm(path,spec) if spec["format"] in ("wav","aiff") else dict(status="hash_verified_only")
            results.append(dict(id=item["id"],sha256=item["sha256"],validation=detail))
        print(json.dumps(dict(status="passed",files=len(results),results=results),indent=2))
        return
    for tool in (args.ffmpeg,args.ffprobe):
        if tool and (not tool.is_absolute() or not tool.is_file()):
            parser.error("encoder/probe must be an existing absolute executable path")
    if out.exists():
        raise FileExistsError(f"Refusing existing output set: {out}")
    out.mkdir()
    for sub in ("media","inputs","logs","tmp"):
        (out/sub).mkdir()
    tool_info = {"python":sys.version,"generator_version":VERSION,"generator_sha256":sha(Path(__file__).read_bytes()),"ffmpeg":None,"ffprobe":None}
    for name,tool in (("ffmpeg",args.ffmpeg),("ffprobe",args.ffprobe)):
        if tool:
            version=command([tool,"-version"],out,name+"-version").decode("utf-8","replace")
            tool_info[name]=dict(path=str(tool),version=version,sha256=sha(tool.read_bytes()))
    media,blocked=[],[]
    for spec in SPECS:
        if spec["format"] not in ("wav","aiff") and (not args.ffmpeg or not args.ffprobe):
            blocked.append(dict(id=spec["id"],format=spec["format"],reason="Validated compressed output requires existing ffmpeg and ffprobe executables; neither is installed by this generator."))
            continue
        pcm=synth(spec)
        path=out/"media"/spec["filename"]
        path.as_posix().encode("ascii")
        source=None
        if spec["format"] in ("wav","aiff"):
            write_new(path,pcm_file(spec,pcm))
            validation=validate_pcm(path,spec)
        else:
            source=encode(path,spec,pcm,args.ffmpeg,out)
            decoded=command([args.ffmpeg,"-hide_banner","-loglevel","error","-nostdin","-threads","1","-i",path,"-map","0:a:0","-c:a","pcm_s16le","-threads:a","1","-ar",str(RATE),"-ac","1","-f","s16le","pipe:1"],out,spec["id"]+"-decode",binary=True)
            assert 2*RATE <= len(decoded) <= 2*RATE*2.2
            if spec["lossless"]:
                assert decoded == pcm, "ALAC lossless PCM mismatch"
            validation=dict(status="passed",readers=["ffmpeg_decode"],lossless_pcm_equal=(decoded==pcm) if spec["lossless"] else None,**stats(decoded))
        ffprobe=probe(path,spec,args.ffprobe,out)
        item=dict(**spec,path=str(path),size_bytes=path.stat().st_size,sha256=sha(path.read_bytes()),source_pcm_s16le_sha256=sha(pcm),source_frames=FRAMES,source_duration_seconds=FRAMES/RATE,sample_rate=RATE,channels=1,source_bits_per_sample=16,compression="lossless_uncompressed" if spec["format"] in ("wav","aiff") else ("lossless_compressed" if spec["lossless"] else "lossy"),source=source,validation=validation,ffprobe=ffprobe,native_acceptance="untested")
        media.append(item)
        print(f"VALIDATED {spec['id']} bytes={item['size_bytes']} sha256={item['sha256']}",flush=True)
    manifest=dict(schema="itl.media.manifest.v1",status="complete" if not blocked else "partial_missing_encoders",created_utc=datetime.now(timezone.utc).isoformat(),provenance="Every audio sample is generated from a sine formula; no existing audio/library is read, copied or changed.",base_commit="56309a258d7b1aadea72738561d1d9fae2e30bc0",tools=tool_info,resource_policy=dict(encoder_threads=1,max_concurrent_encoders=1,per_command_timeout_seconds=40,source_audio_bytes_per_file=FRAMES*2,max_fixture_bytes=1024*1024,memory_budget_bytes=512*1024*1024),media=media,blocked=blocked)
    write_json(out/"media-manifest.json",manifest)
    write_json(out/"native-requests.json",dict(schema="itl.media.native-requests.v1",descriptive_only=True,not_a_native_harness_api=True,not_an_independently_written_itl_candidate=True,status="requires_dynamic_native_identity_binding",media_manifest=dict(path=str(out/"media-manifest.json"),sha256=sha((out/"media-manifest.json").read_bytes())),requests=[request(m) for m in media],blocked_formats=blocked))
    write_json(out/"validation.json",dict(status="passed_for_generated_files",media_count=len(media),blocked_count=len(blocked),checks=[dict(id=m["id"],validation=m["validation"],ffprobe_status=m["ffprobe"]["status"]) for m in media],native_acceptance="untested"))
    print(json.dumps(dict(status=manifest["status"],generated=len(media),blocked=len(blocked),manifest=str(out/"media-manifest.json"),native_requests=str(out/"native-requests.json")),indent=2))

if __name__ == "__main__":
    main()
