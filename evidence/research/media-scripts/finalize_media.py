import hashlib, json, os
from datetime import datetime, timezone
from pathlib import Path

owned = Path(__file__).resolve().parent.parent
root = owned.parent.parent

def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def write_new(p, data):
    p = Path(p)
    p.resolve().relative_to(owned)
    with p.open('xb') as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())

def save(p, data):
    write_new(p,(json.dumps(data,ensure_ascii=False,indent=2)+'\n').encode('utf-8'))

qa = json.loads((owned/'final-qa.json').read_text(encoding='utf-8'))
assert qa['status'] == 'passed' and qa['test_count'] == 11
manifest = json.loads((owned/'pcm-v1'/'media-manifest.json').read_text(encoding='utf-8'))
assert len(manifest['media']) == 2 and len(manifest['blocked']) == 3
for m in manifest['media']:
    assert Path(m['path']).stat().st_size == m['size_bytes'] and digest(m['path']) == m['sha256']
for filename in ('media-manifest.json','native-requests.json'):
    write_new(owned/filename,(owned/'pcm-v1'/filename).read_bytes())

base = '56309a258d7b1aadea72738561d1d9fae2e30bc0'
checks = [
 dict(command='Read phase2-plan.md and plan.md in full',command_id='a6b96096c2db4976',state='exited',exit_code=0,eof=True,next_byte=14220,runtime_ms=627,log='input-source-hashes.json',log_kind='source_hashes_and_tool_receipt'),
 dict(command='Verify branch/base/clean worktree; Get-Command encoder discovery; Python version; format/interface reads',command_id='5e66bfc8fc624e4e',state='exited',exit_code=0,eof=True,next_byte=48735,runtime_ms=2525,log='encoder-discovery.json',log_kind='discovery_reconfirmed_and_tool_receipt'),
 dict(command='Read static phase2/phase3 findings and hash-pinned dynamic phase2 report/donor manifest',command_id='70036b956b2b41c1',state='exited',exit_code=0,eof=True,next_byte=84762,runtime_ms=1142,log='input-source-hashes.json',log_kind='source_hashes_and_tool_receipt'),
 dict(command='Initial compressed source transport; malformed client-supplied Base64 rejected before source/output creation',command_id='62f6e2e7ea9f48bd',state='exited',exit_code=1,eof=True,next_byte=485,runtime_ms=3726,log='logs/transport-failure.json',recovered=True,reads=[dict(from_byte=485,next_byte=485,eof=True)]),
 dict(command='Hash-verified plain source transfer then generate fresh WAV/AIFF with Python -B',command_id='e71fed91b19d4c65',state='exited',exit_code=0,eof=True,next_byte=654,runtime_ms=841,log='logs/01-generate-pcm.log'),
 dict(command='Read-only regeneration/hash/stdlib validation; rediscover tools; hash input documentation; confirm clean worktree',command_id='db5bf5f4d0984d49',state='exited',exit_code=0,eof=True,next_byte=2273,runtime_ms=2507,log='logs/02-verify-pcm.log'),
 dict(command='Run 11 format, identity, no-overwrite, malformed-input and own-process resource checks with Python -B',command_id='0ef92e4b39d44617',state='exited',exit_code=0,eof=True,next_byte=1467,runtime_ms=4202,log='logs/03-final-qa.log',reads=[dict(from_byte=1467,next_byte=1467,eof=True)])
]
save(owned/'logs'/'transport-failure.json',dict(status='recovered',classification='client_source_transcription_error_not_encoder_or_GHA_execution_defect',observed_error='FromBase64String: input is not valid Base-64',source_written=False,media_written=False,verified_recovery='Plain-source UTF-8 bytes matched SHA256 53eb3ad20194743804c88601060fd4dc85b7e7869d0f0a7af48f30d44cc383a9 before exclusive publication.'))
save(owned/'execution-ledger.json',dict(schema='itl.media.execution-ledger.v1',cwd=str(root/'wt'/'media'),shell='pwsh',base_sha=base,checks=checks,disclosure='Internal execution receipts. Parent must sanitize command identifiers/control-plane paths before external publication.'))

reproduction = r'''# Media handoff and reproduction

All binary files below pcm-v1/media are newly synthesized tones. Do not edit these frozen originals. Dynamic should import writable, hash-verified copies inside its own directory. WAV uses RIFF LIST/INFO metadata; AIFF uses NAME/AUTH and ID3v2.3. Automatic iTunes tag recognition is untested and must be captured separately from any explicit donor metadata setters.

Known generated files are 1.5 seconds, 44100 Hz, mono, signed PCM16. WAV is little-endian (440 Hz); AIFF is big-endian (550 Hz). Each has distinct title, artist, album and ASCII filename/path. There is no native ITL candidate here and no native identity has been guessed.

From the assigned media worktree, with pwsh and PYTHONDONTWRITEBYTECODE=1:

    & "<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl\tools\py\Scripts\python.exe" -B "<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl\reports\media\scripts\generate_media.py" --set-name pcm-v1 --verify

For byte-reproduction, use a new ASCII set name, for example --set-name pcm-repro. Existing sets are refused; do not delete the accepted originals to rerun generation. The two resulting audio SHA256s should match the frozen manifest.

If the parent provides existing ffmpeg.exe and ffprobe.exe absolute paths, a NEW set may be generated using --set-name full-v2 --ffmpeg <absolute path> --ffprobe <absolute path>. Optional encoding is sequential, threads=1, timeout=40s per command. MP3 uses libmp3lame/64 kbps/ID3v2.3, AAC uses AAC-LC/64 kbps/M4A, ALAC uses ALAC/s16p/M4A. These optional encoder branches were not exercised on this runner because the tools were not found; no compressed files or ffprobe evidence are claimed.

No package manager, environment lifecycle operation, production edit, commit/push, iTunes/COM/UI/Frida activity or other-worker process control occurred. This is media preparation only. The native request file is descriptive and requires the dynamic owner to bind baseline/donor/media-copy paths and hashes, serialized file/master identities and complete expected native track/membership state.
'''
write_new(owned/'REPRODUCE.md',reproduction.encode('utf-8'))

now = datetime.now(timezone.utc).isoformat()
inputs = json.loads((owned/'input-source-hashes.json').read_text(encoding='utf-8-sig'))
files = sorted(str(p.relative_to(owned)).replace('\\','/') for p in owned.rglob('*') if p.is_file())
for name in ('report.json','artifact-manifest.json','MEDIA_DONE'):
    if name not in files:
        files.append(name)
report = dict(task='media',status='MEDIA_DONE',completion_scope='bounded_fallback_complete_two_formats_three_missing_encoders',completed_utc=now,base_sha=base,head_sha=base,branch='feat/itl-20260909/media',commits=[],production_files_changed=[],worktree_clean=True,owned_root=str(owned),files_changed=sorted(files),checks=checks,input_source_hashes=inputs,artifacts=dict(generator=str(owned/'scripts'/'generate_media.py'),qa_script=str(owned/'scripts'/'qa_media.py'),media_manifest=dict(path=str(owned/'media-manifest.json'),sha256=digest(owned/'media-manifest.json')),native_requests=dict(path=str(owned/'native-requests.json'),sha256=digest(owned/'native-requests.json')),qa=dict(path=str(owned/'final-qa.json'),sha256=digest(owned/'final-qa.json')),reproduction=str(owned/'REPRODUCE.md')),measured_facts=dict(generated_formats=['WAV PCM16','AIFF PCM16'],media_files=len(manifest['media']),media_bytes_total=sum(m['size_bytes'] for m in manifest['media']),duration_seconds_each=1.5,frames_each=66150,sample_rate_hz=44100,channels=1,bits_per_sample=16,unique_title_artist_album_per_file=True,ascii_paths=True,qa=qa),media=[dict(id=m['id'],path=m['path'],sha256=m['sha256'],size_bytes=m['size_bytes'],metadata=m['metadata'],codec=m['codec'],compression=m['compression']) for m in manifest['media']],native_acceptance='untested',findings=['Fresh WAV and AIFF are validated independently by stdlib readers, bounded chunk checks and byte-exact regeneration.','All required identity metadata is embedded and locally decoded; native iTunes recognition is not inferred.','The native request is for native donor creation and is not an independently constructed ITL acceptance request.','QA peak working set is below 512 MiB; all task payload processes were sequential.'],limitations=['MP3, AAC M4A and ALAC M4A were not generated because existing encoders were not found on PATH.','ffprobe was not found/provided, so per-file ffprobe status is explicitly not_run; no substituted/fictional ffprobe output.','Optional FFmpeg encoder branches exist for a new future output set but have not been exercised on this runner.','WAV INFO and AIFF ID3 native tag recognition remains untested; raw import evidence must precede any setters.','Native baseline/donor file/master/track IDs and complete membership state must be bound by dynamic before native validation.','No iTunes native load/save/restart or playback was performed by media.'],blockers=[dict(formats=['MP3','AAC M4A','ALAC M4A'],needed=['Existing ffmpeg.exe with libmp3lame, native AAC and ALAC encoders','Existing ffprobe.exe'],coordination='Parent may provide absolute tool paths or separately authorize acquisition; media did not install anything.')],contract_changes_needed=[],prior_outputs_untouched=True,publication_note='Only parent publishes. Exclude/sanitize internal command receipts and control-plane references; no original media/library/Apple binary is included.')
save(owned/'report.json',report)
artifacts=[]
for p in sorted(owned.rglob('*')):
    if p.is_file():
        artifacts.append(dict(path=str(p.relative_to(owned)).replace('\\','/'),size_bytes=p.stat().st_size,sha256=digest(p)))
save(owned/'artifact-manifest.json',dict(schema='itl.media.artifacts.v1',created_utc=now,files=artifacts,excluded_self_and_marker=True))
write_new(owned/'MEDIA_DONE',(now+' MEDIA_DONE: 2 validated PCM formats; 3 compressed formats blocked; native acceptance untested.\n').encode('utf-8'))
print(json.dumps(dict(status='MEDIA_DONE',scope=report['completion_scope'],report=str(owned/'report.json'),report_sha256=digest(owned/'report.json'),native_requests_sha256=digest(owned/'native-requests.json'),media_manifest_sha256=digest(owned/'media-manifest.json'),qa_tests_passed=qa['test_count'],qa_peak_working_set_bytes=qa['resources']['qa_python_peak_working_set_bytes'],media_bytes_total=report['measured_facts']['media_bytes_total']),indent=2))
