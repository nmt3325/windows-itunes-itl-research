#!/usr/bin/env python3
"""Pinned portable FFmpeg acquisition verification and fresh media QA, Python -B."""
import array
import copy
from datetime import datetime, timezone
import hashlib
import importlib.util
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import struct
import subprocess
import sys
import zipfile

V2 = Path(__file__).resolve().parent.parent
OWNED = V2.parent
TOOLS = OWNED / "tools"
PIN = "db580001caa24ac104c8cb856cd113a87b0a443f7bdf47d8c12b1d740584a2ec"
DEADLINE = datetime(2026,9,9,15,30,tzinfo=timezone.utc)

def digest(p):
    h=hashlib.sha256()
    with Path(p).open("rb") as f:
        for b in iter(lambda:f.read(1024*1024),b""):
            h.update(b)
    return h.hexdigest()

def save(p,value):
    p=Path(p);p.resolve().relative_to(OWNED)
    p.parent.mkdir(parents=True,exist_ok=True)
    with p.open("x",encoding="utf-8",newline="\n") as f:
        json.dump(value,f,ensure_ascii=False,indent=2);f.write("\n")
        f.flush();os.fsync(f.fileno())

def time_gate():
    if datetime.now(timezone.utc)>=DEADLINE:
        raise RuntimeError("15:30Z deadline reached; preserve completed outputs and stop")

def run(args,label):
    time_gate()
    env=os.environ.copy()
    env.update(PYTHONDONTWRITEBYTECODE="1",PYTHONUTF8="1",PYTHONIOENCODING="utf-8",OMP_NUM_THREADS="1",TEMP=str(V2/"tmp"),TMP=str(V2/"tmp"))
    result=subprocess.run([str(a) for a in args],capture_output=True,timeout=40,env=env)
    r=dict(argv=[str(a) for a in args],exit_code=result.returncode,stdout=result.stdout.decode("utf-8","replace"),stderr=result.stderr.decode("utf-8","replace"))
    save(V2/"logs"/(label+".json"),r)
    if result.returncode: raise RuntimeError(f"{label} failed: {result.returncode}")
    return r["stdout"]

def main():
    time_gate()
    record=json.loads((TOOLS/"provenance"/"archive-verification.json").read_text(encoding="utf-8-sig"))
    archive=Path(record["archive_path"])
    assert record["sha256_match"] and record["provided_sha256"]==PIN
    assert digest(archive)==PIN and archive.stat().st_size==record["archive_size_bytes"]
    bindir=TOOLS/"ffmpeg-8.1.2"/"bin"
    bindir.mkdir(parents=True,exist_ok=False)
    binaries=[]
    with zipfile.ZipFile(archive) as z:
        entries=z.infolist()
        assert len(entries)<2000
        selected={}
        for member in entries:
            n=member.filename
            assert "\\" not in n and ":" not in n
            path=PurePosixPath(n)
            assert not path.is_absolute() and ".." not in path.parts
            if n.endswith("/bin/ffmpeg.exe") or n.endswith("/bin/ffprobe.exe"):
                assert path.name not in selected
                assert ((member.external_attr>>16)&0o170000)!=0o120000
                assert 1000000<member.file_size<200*1024*1024
                selected[path.name]=member
        assert set(selected)=={"ffmpeg.exe","ffprobe.exe"}
        for name,member in sorted(selected.items()):
            dst=bindir/name
            with z.open(member) as src,dst.open("xb") as target:
                shutil.copyfileobj(src,target,1024*1024)
                target.flush();os.fsync(target.fileno())
            assert dst.stat().st_size==member.file_size
            binaries.append(dict(name=name,path=str(dst),archive_entry=member.filename,size_bytes=dst.stat().st_size,sha256=digest(dst),zip_crc32=f"{member.CRC:08x}"))
    ffmpeg=bindir/"ffmpeg.exe";ffprobe=bindir/"ffprobe.exe"
    for binary in binaries:
        version=run([binary["path"],"-version"],binary["name"]+"-version")
        assert "8.1.2" in version.splitlines()[0]
        binary["version"]=version
    encoders=run([ffmpeg,"-hide_banner","-encoders"],"encoders")
    for encoder in ("libmp3lame","aac","alac"):
        assert re.search(r"(?m)^\s*A\S*\s+"+re.escape(encoder)+r"\s",encoders),encoder
    provenance=dict(status="provider_sha256_verified_then_two_binaries_extracted_and_executed",archive=record,binaries=binaries,official_page_evidence=str(TOOLS/"provenance"/"official-download-links.json"),vendor_page_evidence=str(TOOLS/"provenance"/"gyan-builds-links.json"),no_global_path_registry_msi_or_shared_dependency_changes=True,exclude_from_repository=[str(archive),str(bindir)])
    save(TOOLS/"provenance"/"portable-tool-verification.json",provenance)
    print("PORTABLE_VERIFIED "+str(archive.stat().st_size),flush=True)
    generator=OWNED/"scripts"/"generate_media.py"
    assert digest(generator)=="53eb3ad20194743804c88601060fd4dc85b7e7869d0f0a7af48f30d44cc383a9"
    spec=importlib.util.spec_from_file_location("frozen_media_generator",generator)
    g=importlib.util.module_from_spec(spec);spec.loader.exec_module(g)
    all_specs=copy.deepcopy(g.SPECS)
    g.ROOT=V2
    original_command=g.command
    def single_thread_command(args,out,label,binary=False):
        argv=list(args)
        if str(argv[0])==str(ffmpeg) and "-filter_threads" not in argv:
            argv[1:1]=["-filter_threads","1","-filter_complex_threads","1"]
        if str(argv[0])==str(ffprobe) and "-threads" not in argv:
            argv[1:1]=["-threads","1"]
        return original_command(argv,out,label,binary)
    g.command=single_thread_command
    g.SPECS=all_specs[2:]
    for set_name in ("primary","reproduction"):
        time_gate()
        sys.argv=[str(generator),"--set-name",set_name,"--ffmpeg",str(ffmpeg),"--ffprobe",str(ffprobe)]
        g.main()
    a=json.loads((V2/"primary"/"media-manifest.json").read_text(encoding="utf-8"))
    b=json.loads((V2/"reproduction"/"media-manifest.json").read_text(encoding="utf-8"))
    assert a["status"]==b["status"]=="complete" and len(a["media"])==len(b["media"])==3
    reproduction=[]
    for original,repeat in zip(a["media"],b["media"]):
        assert original["id"]==repeat["id"]
        assert original["sha256"]==repeat["sha256"]==digest(original["path"])==digest(repeat["path"])
        assert original["validation"]["decoded_pcm_s16le_sha256"]==repeat["validation"]["decoded_pcm_s16le_sha256"]
        assert original["validation"]["peak_sample"]>0 and original["validation"]["peak_sample"]<32767
        reproduction.append(dict(id=original["id"],byte_exact_regeneration=True,encoded_sha256=original["sha256"],decoded_pcm_sha256=original["validation"]["decoded_pcm_s16le_sha256"]))
    before=json.loads((V2/"v1-preservation-before.json").read_text(encoding="utf-8-sig"))
    old=json.loads((OWNED/"media-manifest.json").read_text(encoding="utf-8"))
    updated=[]
    for m in old["media"]:
        s=next(s for s in all_specs if s["id"]==m["id"])
        item=copy.deepcopy(m)
        item["ffprobe"]=g.probe(Path(m["path"]),s,ffprobe,V2/"primary")
        raw=g.command([ffmpeg,"-hide_banner","-loglevel","error","-nostdin","-threads","1","-i",m["path"],"-map","0:a:0","-c:a","pcm_s16le","-threads:a","1","-ar","44100","-ac","1","-f","s16le","pipe:1"],V2/"primary",m["id"]+"-v2-decode",binary=True)
        assert raw==g.synth(s)
        item["v2_decoder_validation"]=dict(status="passed",source_pcm_equal=True,**g.stats(raw))
        updated.append(item)
    media=updated+a["media"]
    assert len(media)==5 and len({m["id"] for m in media})==5
    for m in media:
        assert m["ffprobe"]["status"]=="passed"
        assert digest(m["path"])==m["sha256"]
    preserved=[]
    for row in before:
        p=Path(row["path"])
        assert p.stat().st_size==row["size_bytes"] and digest(p)==row["sha256"],str(p)
        preserved.append(row)
    save(V2/"v1-preservation-after.json",dict(status="all_unchanged",files_checked=len(preserved),files=preserved))
    save(V2/"reproduction-qa.json",dict(status="passed",cases=reproduction))
    combined=dict(schema="itl.media.manifest.v2",status="all_five_generated_formats_verified_offline",created_utc=datetime.now(timezone.utc).isoformat(),base_commit="56309a258d7b1aadea72738561d1d9fae2e30bc0",generator=dict(frozen_script=str(generator),frozen_script_sha256=digest(generator),v2_wrapper=str(Path(__file__).resolve()),v2_wrapper_sha256=digest(__file__)),portable_tool_provenance=provenance,media=media,scope=dict(old_files_preserved=True,new_formats=["mp3","aac","alac"],all_five_formats_probed=True,three_new_formats_byte_exact_regenerated=True,all_five_formats_decoded_to_pcm=True,native_imports=0,native_acceptance="untested",encoder_threads=1),reproduction=reproduction)
    save(V2/"media-manifest-v2.json",combined)
    reqs=[g.request(m) for m in media]
    for req,m in zip(reqs,media):
        req["offline_observation"]=dict(ffprobe_status="passed",container_duration_seconds=float(m["ffprobe"]["data"]["format"]["duration"]),codec=m["codec"],source_duration_seconds=1.5,decoded_frames=m.get("v2_decoder_validation",m["validation"])["decoded_frames"])
        req["native_acceptance"]="untested"
        req["known_unknowns"]=[x for x in req["known_unknowns"] if not x.startswith("Non-WAV ITL")]+["Offline media decoding does not certify native iTunes tag recognition or independent ITL construction for any codec.","MP3/AAC packet delay and padding are recorded by ffprobe/PCM QA; native Duration/TotalTime must be observed, not copied blindly from source 1500 ms."]
    request_manifest=dict(schema="itl.media.native-requests.v2",descriptive_only=True,not_a_native_harness_api=True,not_an_independently_written_itl_candidate=True,status="requires_dynamic_native_identity_binding",media_manifest=dict(path=str(V2/"media-manifest-v2.json"),sha256=digest(V2/"media-manifest-v2.json")),requests=reqs,raw_native_observations=None,native_acceptance="untested",instructions="Dynamic imports hash-verified writable copies only. Capture raw metadata before any setters and bind exact copy locations and native IDs. v1 media and reports remain immutable.")
    save(V2/"native-requests-v2.json",request_manifest)
    for name in ("media-manifest-v2.json","native-requests-v2.json"):
        with (OWNED/name).open("xb") as f:
            f.write((V2/name).read_bytes());f.flush();os.fsync(f.fileno())
    report=dict(task="media-encoded-v2",status="MEDIA_ENCODED_V2_DONE",completed_utc=datetime.now(timezone.utc).isoformat(),native_acceptance="untested",base_sha="56309a258d7b1aadea72738561d1d9fae2e30bc0",production_changes=[],commits=[],new_media_files=[dict(id=m["id"],path=m["path"],size_bytes=m["size_bytes"],sha256=m["sha256"],codec=m["codec"],source_duration_seconds=m["source_duration_seconds"],container_duration_seconds=float(m["ffprobe"]["data"]["format"]["duration"]),decoded_frames=m["validation"]["decoded_frames"]) for m in a["media"]],old_files_preserved=len(preserved),offline_qa=dict(all_five_ffprobe=True,all_five_pcm_decode=True,three_new_byte_reproduction=True,alac_pcm_equals_source=True),manifest=dict(path=str(OWNED/"media-manifest-v2.json"),sha256=digest(OWNED/"media-manifest-v2.json")),native_requests=dict(path=str(OWNED/"native-requests-v2.json"),sha256=digest(OWNED/"native-requests-v2.json")),tool_provenance=str(TOOLS/"provenance"/"portable-tool-verification.json"),limitations=["Native import/metadata recognition/restart/playback is untested.","Source is 66150 frames (1.5s); encoded packet duration and decoded padding can differ for lossy formats.","Success applies only to these five synthesized fixtures, not general ITL format support."],publication_exclude=[str(TOOLS)])
    save(V2/"report.json",report)
    time_gate()
    (V2/"MEDIA_ENCODED_V2_DONE").write_text(report["completed_utc"]+"\n",encoding="utf-8")
    print(json.dumps(report,indent=2),flush=True)

if __name__=="__main__":
    try: main()
    except Exception as exc:
        p=V2/"failure.json"
        if not p.exists(): save(p,dict(status="blocked_or_partial",error_type=type(exc).__name__,error=str(exc),utc=datetime.now(timezone.utc).isoformat(),native_acceptance="untested"))
        raise
