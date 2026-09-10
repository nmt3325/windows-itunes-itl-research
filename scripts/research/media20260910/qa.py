"""Read-only corpus audit and bounded refusal/metamorphic checks in owned reports."""

# Safety assertions must never be disabled, including when this module is imported.
if not __debug__:
    raise SystemExit("ITL4_OPTIMIZATION_UNSUPPORTED: use Python without -O/-OO/PYTHONOPTIMIZE")

import argparse, hashlib, json, os, struct, subprocess, sys, wave
from pathlib import Path
import corpus

def main():
    p=argparse.ArgumentParser();p.add_argument('--root',required=True);a=p.parse_args();root=Path(a.root).resolve()
    if Path.cwd().resolve()!=root/'wt/media':raise ValueError('Assigned cwd required')
    first=root/'fixtures/media4/initial-02';second=root/'reports/media/reproduction-01';out=root/'reports/media/phase02';out.mkdir(exist_ok=False)
    corpus.verify_seal(first);corpus.verify_seal(second)
    left=json.loads((first/'manifest.json').read_text(encoding='utf-8'));right=json.loads((second/'manifest.json').read_text(encoding='utf-8'))
    assert left['count']==right['count']==20
    pairs=[]
    for one,two in zip(left['media'],right['media']):
        for k in ['id','relative_path','format','profile','size_bytes','sha256','mtime_ns','seed','expected_embedded_tags']:assert one[k]==two[k],(k,one['id'])
        for k in ['decoded_pcm','source_pcm','ffprobe_normalized_tags']:assert one['observed'][k]==two['observed'][k],(k,one['id'])
        pairs.append({'id':one['id'],'media_sha256':one['sha256'],'decoded_pcm_sha256':one['observed']['decoded_pcm']['sha256'],'byte_exact':True,'metadata_exact':True,'mtime_exact':True})
    specs=corpus.case_specs();assert len({r['file_only_name'] for r in left['media']})==20
    assert len({r['sha256'] for r in left['media']})==20
    assert len({r['observed']['source_pcm']['sha256'] for r in left['media']})==20
    nonempty=[r for r in left['media'] if r['profile']!='absent']
    assert all(Path(r['file_only_name']).stem!=r['expected_embedded_tags']['title'] for r in nonempty)
    assert len({r['expected_embedded_tags']['title'] for r in nonempty})==15
    groups={}
    for profile in ['ascii','latin1','unicode']:
        members=[r for r in left['media'] if r['profile']==profile];assert len(members)==5
        for key in ['artist','album','album_artist','genre']:
            values={r['expected_embedded_tags'][key] for r in members};assert len(values)==1
            groups[profile+'/'+key]={'value':next(iter(values)),'members':[r['id'] for r in members],'native_pool_observed':False}
    assert len([r for r in left['media'] if all(v is None for v in r['expected_embedded_tags'].values())])==5
    assert sum(r['observed']['lossless'] for r in left['media'])==12
    assert all(r['observed']['pcm_exact_source_match'] for r in left['media'] if r['observed']['lossless'])
    for r in left['media']:
        with wave.open(str(first/'inputs'/(r['id']+'.wav')),'rb') as f:
            assert f.getparams()[:3]==(1,2,48000);raw=f.readframes(f.getnframes())
        assert hashlib.sha256(raw).hexdigest()==r['observed']['source_pcm']['sha256']
    total_bytes=sum(r['size_bytes'] for r in left['media']);thread_ops=0;max_memory=0
    for directory in [first,second]:
        for p in (directory/'qa').glob('*.command.json'):
            row=json.loads(p.read_text(encoding='utf-8'));assert row['exit_code']==0 and row['failure'] is None
            argv=row['argv'];assert Path(argv[0]).is_absolute();assert argv[argv.index('-threads')+1]=='1'
            if Path(argv[0]).name=='ffmpeg.exe':
                for flag in ['-threads:a','-filter_threads','-filter_complex_threads']:assert argv[argv.index(flag)+1]=='1'
            assert 0<row['max_observed_combined_peak_working_set_bytes']<=corpus.BUDGET
            max_memory=max(max_memory,row['max_observed_combined_peak_working_set_bytes']);thread_ops+=1
    assert thread_ops==120
    before=corpus.sha(first/'seal.json');checks=[]
    def refuse(label,dest,extra=()):
        argv=[sys.executable,'-B','-X','utf8',str(Path(corpus.__file__).resolve()),'--root',str(root),'--destination',str(dest),*extra]
        r=subprocess.run(argv,capture_output=True,timeout=15)
        assert r.returncode!=0,label
        record={'name':label,'argv':argv,'exit_code':r.returncode,'expected':'nonzero refusal','stdout':r.stdout.decode('utf-8','replace'),'stderr':r.stderr.decode('utf-8','replace')}
        corpus.save(out/(label+'.json'),record);checks.append({'name':label,'passed':True,'observed_exit':r.returncode})
    refuse('existing-sealed-output',first)
    refuse('existing-partial-output',root/'fixtures/media4/initial-01')
    refuse('out-of-owned-prefix',root/'baseline')
    candidate=out/'invalid-format-should-not-exist';refuse('invalid-format',candidate,['--formats','flac']);assert not candidate.exists()
    candidate=out/'invalid-profile-should-not-exist';refuse('invalid-profile',candidate,['--profiles','unknown']);assert not candidate.exists()
    assert corpus.sha(first/'seal.json')==before;corpus.verify_seal(first)
    sample=dict(specs[0]);base=corpus.pcm(sample);sample['filename']='unused renamed %25.wav';assert corpus.pcm(sample)==base
    sample['phase_frames']+=1;assert corpus.pcm(sample)!=base
    checks += [{'name':'filename-does-not-alter-PCM','passed':True},{'name':'phase-seed-alters-PCM','passed':True}]
    summary={'status':'passed','media_count':20,'formats':{fmt:sum(r['format']==fmt for r in left['media']) for fmt in corpus.FORMATS},'profiles':{pro:sum(r['profile']==pro for r in left['media']) for pro in ['ascii','latin1','unicode','absent']},'total_media_bytes':total_bytes,'reproduction_pairs':pairs,'shared_metadata_groups':groups,'independent_source_WAV_reads':20,'lossless_source_exact':12,'single_thread_process_records':thread_ops,'maximum_observed_combined_peak_working_set_bytes':max_memory,'budget_bytes':corpus.BUDGET,'controls':checks,'primary_manifest_sha256':corpus.sha(first/'manifest.json'),'primary_seal_sha256':before,'native_acceptance':'unmeasured'}
    corpus.save(out/'qa.json',summary)
    print(json.dumps({k:summary[k] for k in ['status','media_count','formats','profiles','total_media_bytes','single_thread_process_records','maximum_observed_combined_peak_working_set_bytes','controls','primary_manifest_sha256']},indent=2))
if __name__=='__main__':main()
