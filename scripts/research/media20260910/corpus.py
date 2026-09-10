"""Deterministic synthetic ITL4 corpus. No native APIs; existing outputs refused."""

# Safety assertions must never be disabled, including when this module is imported.
if not __debug__:
    raise SystemExit("ITL4_OPTIMIZATION_UNSUPPORTED: use Python without -O/-OO/PYTHONOPTIMIZE")

import argparse, ctypes, hashlib, json, math, os, re, stat, struct, subprocess, time, wave
from pathlib import Path
from datetime import datetime, timezone
import mutagen
from mutagen import id3
from mutagen.mp4 import MP4

RATE=48000
FRAMES=60000
SEED=2026091000
BUDGET=512*1024*1024
FORMATS={'wav':('.wav','pcm_s16le',[]),'aiff':('.aiff','pcm_s16be',[]),'mp3':('.mp3','libmp3lame',['-b:a','64k','-id3v2_version','3','-write_id3v1','0','-write_xing','1']),'aac':('.m4a','aac',['-b:a','64k','-movflags','+faststart']),'alac':('.m4a','alac',['-sample_fmt','s16p','-movflags','+faststart'])}
TEXT=['title','artist','album','album_artist','genre','comment','composer','year']
FIELDS=TEXT+['track_number','track_total','disc_number','disc_total']
ID3_MAP={'title':'TIT2','artist':'TPE1','album':'TALB','album_artist':'TPE2','genre':'TCON','composer':'TCOM','year':'TDRC'}
MP4_MAP={'title':'\xa9nam','artist':'\xa9ART','album':'\xa9alb','album_artist':'aART','genre':'\xa9gen','comment':'\xa9cmt','composer':'\xa9wrt','year':'\xa9day'}

def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(1048576),b''):h.update(b)
    return h.hexdigest()
def save(p,data):
    with Path(p).open('x',encoding='utf-8',newline='\n') as f:
        json.dump(data,f,ensure_ascii=False,indent=2);f.write('\n');f.flush();os.fsync(f.fileno())
def utc():return datetime.now(timezone.utc).isoformat()

def memory(handle=None):
    if os.name!='nt':return None
    from ctypes import wintypes
    class Counters(ctypes.Structure):
        _fields_=[('cb',wintypes.DWORD),('PageFaultCount',wintypes.DWORD)]+[(k,ctypes.c_size_t) for k in ['PeakWorkingSetSize','WorkingSetSize','QuotaPeakPagedPoolUsage','QuotaPagedPoolUsage','QuotaPeakNonPagedPoolUsage','QuotaNonPagedPoolUsage','PagefileUsage','PeakPagefileUsage']]
    api=ctypes.WinDLL('psapi',use_last_error=True)
    api.GetProcessMemoryInfo.argtypes=[wintypes.HANDLE,ctypes.POINTER(Counters),wintypes.DWORD]
    api.GetProcessMemoryInfo.restype=wintypes.BOOL
    c=Counters();c.cb=ctypes.sizeof(c)
    if not api.GetProcessMemoryInfo(wintypes.HANDLE(-1 if handle is None else int(handle)),ctypes.byref(c),c.cb):return None
    return int(c.PeakWorkingSetSize)

def command(argv,logdir,label):
    argv=[str(x) for x in argv];out=logdir/(label+'.stdout');err=logdir/(label+'.stderr');start=time.monotonic();peak=0;reason=None
    with out.open('xb') as so,err.open('xb') as se:
        with subprocess.Popen(argv,stdin=subprocess.DEVNULL,stdout=so,stderr=se,shell=False) as child:
            while True:
                mine=memory();theirs=memory(child._handle) if os.name=='nt' else None
                peak=max(peak,(mine or 0)+(theirs or 0))
                if peak>BUDGET:reason='own process plus child exceeded 512 MiB';child.kill()
                if time.monotonic()-start>30:reason='bounded child timeout';child.kill()
                code=child.poll()
                if code is not None:break
                time.sleep(.01)
    record={'argv':argv,'exit_code':code,'stdout':out.name,'stderr':err.name,'elapsed_seconds':round(time.monotonic()-start,6),'max_observed_combined_peak_working_set_bytes':peak,'budget_bytes':BUDGET,'failure':reason}
    save(logdir/(label+'.command.json'),record)
    if code or reason:raise RuntimeError(label+': '+str(reason or err.read_text(encoding='utf-8',errors='replace')))
    return out,record

def case_specs():
    result=[]
    for fi,(fmt,(ext,_,_)) in enumerate(FORMATS.items()):
        for pi,profile in enumerate(['ascii','latin1','unicode','absent']):
            n=fi*4+pi+1;case=f'{n:02d}-{fmt}-{profile}';tag={k:None for k in FIELDS}
            if profile=='ascii':
                tag.update(title=f'Title A {fmt.upper()} independent',artist='Shared Artist A',album='Shared Album A',album_artist='Shared AlbumArtist A',genre='Synthetic A',comment=f'Comment A {fmt} only',composer=f'Composer A {fmt}',year='1999',track_number=3,track_total=11,disc_number=1,disc_total=2)
                name=f'FILE_ONLY_{n:02d}_different_name{ext}'
            elif profile=='latin1':
                tag.update(title=f'\u00c9t\u00e9 B {fmt.upper()}',artist='Cr\u00e9ateur B',album='Caf\u00e9 \u00e9tude B',album_artist='Ensemble No\u00ebl B',genre='\u00c9tude B',comment=f'C\u00f4te B {fmt} - \u00a3 \u00ff',composer=f'Fran\u00e7ois B {fmt}',year='2001',track_number=7,track_total=13,disc_number=2,disc_total=3)
                name=f'file only {n:02d} Caf\u00e9 100%{ext}'
            elif profile=='unicode':
                tag.update(title=f'\u57cb\u8fbc\u30bf\u30a4\u30c8\u30eb C {fmt.upper()} \u03a9 \U0001f3b5',artist='\u5171\u6709\u30a2\u30fc\u30c6\u30a3\u30b9\u30c8 C',album='\u5171\u901a\u30a2\u30eb\u30d0\u30e0 C',album_artist='\u5171\u540c\u6f14\u594f\u8005 C',genre='\u96fb\u5b50\u97f3 C',comment=f'\u30b3\u30e1\u30f3\u30c8 C {fmt} %25 # &',composer=f'\u4f5c\u66f2\u8005 C {fmt}',year='2026',track_number=12,track_total=34,disc_number=3,disc_total=4)
                name=f'file {n:02d} %25 \u65e5\u672c\u8a9e # space & [C]{ext}'
            else:name=f'file-only {n:02d} no embedded title % [D]{ext}'
            result.append({'id':case,'format':fmt,'profile':profile,'filename':name,'tags':tag,'seed':SEED+n,'period_frames':200+10*n,'phase_frames':(SEED+n)%(200+10*n),'amplitude':1024+n,'mtime_ns':(int(datetime(2026,9,10,tzinfo=timezone.utc).timestamp())+60*n)*1000000000,'native_observations':None})
    return result

def pcm(spec):
    period=spec['period_frames'];amp=spec['amplitude'];phase=spec['phase_frames'];buf=bytearray(FRAMES*2)
    for i in range(FRAMES):
        pos=(i+phase)%period;tri=period//2-abs(2*pos-period)
        value=(tri*amp//(period//2))*min(i,FRAMES-1-i,240)//240
        struct.pack_into('<h',buf,2*i,value)
    return bytes(buf)
def statistics(raw):
    assert len(raw)%2==0 and len(raw)>0
    values=struct.unpack('<'+'h'*(len(raw)//2),raw)
    return {'frames':len(values),'duration_seconds':len(values)/RATE,'sha256':hashlib.sha256(raw).hexdigest(),'peak':max(abs(x) for x in values),'rms':round(math.sqrt(sum(x*x for x in values)/len(values)),6)}

def write_tags(path,spec):
    obj=mutagen.File(str(path));assert obj is not None
    if obj.tags is None:obj.add_tags()
    obj.tags.clear();t=spec['tags']
    if isinstance(obj,MP4):
        for k,atom in MP4_MAP.items():
            if t[k] is not None:obj.tags[atom]=[t[k]]
        if t['track_number'] is not None:obj.tags['trkn']=[(t['track_number'],t['track_total'])];obj.tags['disk']=[(t['disc_number'],t['disc_total'])]
        obj.save(padding=lambda _:0)
    else:
        enc=1 if spec['profile']=='unicode' else 0
        for k,frame in ID3_MAP.items():
            if t[k] is not None:obj.tags.add(getattr(id3,frame)(encoding=enc,text=[t[k]]))
        if t['comment'] is not None:obj.tags.add(id3.COMM(encoding=enc,lang='eng',desc='',text=[t['comment']]))
        if t['track_number'] is not None:
            obj.tags.add(id3.TRCK(encoding=enc,text=[f"{t['track_number']}/{t['track_total']}"]))
            obj.tags.add(id3.TPOS(encoding=enc,text=[f"{t['disc_number']}/{t['disc_total']}"]))
        obj.tags.update_to_v23()
        if spec['format']=='mp3':obj.save(v1=0,v2_version=3,padding=lambda _:0)
        else:obj.save(v2_version=3,padding=lambda _:0)

def read_tags(path):
    obj=mutagen.File(str(path));assert obj is not None
    result={k:None for k in FIELDS};tags=obj.tags or {};raw={};encoding={}
    if isinstance(obj,MP4):
        for k,atom in MP4_MAP.items():
            if tags.get(atom):result[k]=str(tags[atom][0])
        for atom,n,total in [('trkn','track_number','track_total'),('disk','disc_number','disc_total')]:
            if tags.get(atom):result[n],result[total]=tags[atom][0]
        raw={k:list(v) for k,v in tags.items()}
    else:
        for k,frame in ID3_MAP.items():
            if tags.get(frame) is not None:result[k]=str(tags[frame].text[0])
        comments=tags.getall('COMM') if obj.tags else []
        if comments:result['comment']=str(comments[0].text[0])
        for frame,n,total in [('TRCK','track_number','track_total'),('TPOS','disc_number','disc_total')]:
            if tags.get(frame) is not None:
                pair=str(tags[frame].text[0]).split('/');result[n]=int(pair[0]);result[total]=int(pair[1]) if len(pair)>1 else None
        for k,v in tags.items():
            raw[k]=v.pprint()
            if hasattr(v,'encoding'):encoding[k]=int(v.encoding)
    info={k:getattr(obj.info,k,None) for k in ['length','sample_rate','channels','bits_per_sample','bitrate','codec']}
    return {'type':type(obj).__name__,'normalized':result,'raw_tags':raw,'id3_encodings':encoding,'info':info,'version':mutagen.version_string}

def normalized_probe(data):
    tags={k.lower():v for k,v in data['format'].get('tags',{}).items()};result={k:None for k in FIELDS}
    for k in TEXT:
        value=tags.get('date' if k=='year' else k)
        if value is not None and value!='':result[k]=value[:4] if k=='year' else value
    for key,n,total in [('track','track_number','track_total'),('disc','disc_number','disc_total')]:
        if tags.get(key):
            pair=tags[key].split('/');result[n]=int(pair[0]);result[total]=int(pair[1]) if len(pair)>1 else None
    return result

def verify_case(path,spec,ffmpeg,ffprobe,logdir,input_raw):
    probe,pc=command([ffprobe,'-v','error','-threads','1','-show_format','-show_streams','-of','json',path],logdir,spec['id']+'-probe')
    data=json.loads(probe.read_text(encoding='utf-8'));assert len(data['streams'])==1
    stream=data['streams'][0];expected_codec='mp3' if spec['format']=='mp3' else FORMATS[spec['format']][1]
    assert stream['codec_type']=='audio' and stream['codec_name']==expected_codec
    assert int(stream['sample_rate'])==RATE and stream['channels']==1 and int(data['format']['size'])==path.stat().st_size
    observed=read_tags(path);assert observed['normalized']==spec['tags'],('mutagen',spec['id'],observed['normalized'],spec['tags'])
    ff_tags=normalized_probe(data);assert ff_tags==spec['tags'],('ffprobe',spec['id'],ff_tags,spec['tags'])
    if spec['profile']=='latin1' and observed['id3_encodings']:assert set(observed['id3_encodings'].values())=={0}
    if spec['profile']=='unicode' and observed['id3_encodings']:
        # Mutagen normalizes v2.3 TYER to an ASCII TDRC object on reload.
        assert all(v==1 for k,v in observed['id3_encodings'].items() if k!='TDRC')
        assert observed['id3_encodings'].get('TDRC') in (0,1)
    decoded=logdir/(spec['id']+'.decoded.s16le')
    _,dc=command([ffmpeg,'-nostdin','-v','error','-n','-threads','1','-filter_threads','1','-filter_complex_threads','1','-i',path,'-map','0:a:0','-c:a','pcm_s16le','-threads:a','1','-ac','1','-ar',str(RATE),'-f','s16le',decoded],logdir,spec['id']+'-decode')
    raw=decoded.read_bytes();stats=statistics(raw);source=statistics(input_raw)
    assert stats['peak']>0 and stats['peak']<32767 and stats['rms']>0
    assert abs(stats['frames']-FRAMES)<=4096
    lossless=spec['format'] in ['wav','aiff','alac']
    if lossless:assert raw==input_raw,'Lossless decoded PCM differs'
    return {'mutagen':observed,'ffprobe':data,'ffprobe_normalized_tags':ff_tags,'source_pcm':source,'decoded_pcm':stats,'lossless':lossless,'pcm_exact_source_match':raw==input_raw,'padding_frames_vs_source':stats['frames']-FRAMES,'peak_process_bytes':max(pc['max_observed_combined_peak_working_set_bytes'],dc['max_observed_combined_peak_working_set_bytes'])}

def generate(root,destination,formats,profiles):
    if destination.exists():raise FileExistsError('Existing set refused, including sealed or partial sets')
    if not any(destination.is_relative_to(root/x) for x in ['fixtures/media4','reports/media']) or destination.name in ['media4','media']:
        raise ValueError('Destination outside owned corpus/report scope')
    provenance=root/'tools/media/provenance.json';tools=json.loads(provenance.read_text(encoding='utf-8'))
    if tools.get('status')!='verified':raise ValueError('Unverified encoder provenance')
    exe={b['name']:Path(b['path']) for b in tools['binaries']}
    for b in tools['binaries']:
        if not Path(b['path']).resolve().is_relative_to((root/'tools/media').resolve()):raise ValueError('Encoder outside owned tools scope')
        if sha(b['path'])!=b['sha256']:raise ValueError('Encoder SHA256 mismatch')
    ffmpeg=exe['ffmpeg.exe'];ffprobe=exe['ffprobe.exe'];destination.mkdir(parents=True,exist_ok=False)
    for part in ['media','inputs','qa']: (destination/part).mkdir()
    specs=[s for s in case_specs() if s['format'] in formats and s['profile'] in profiles];assert specs
    save(destination/'matrix.json',{'schema':'itl4.media.matrix.v1','cases':specs,'seed_base':SEED,'source_frames':FRAMES,'sample_rate':RATE,'source_channels':1,'source_bits':16,'generator':'integer triangle with 240-frame fade; no random runtime values','absence_semantics':'absent means omitted embedded user tags, not a claimed stored empty string','shared_index_intent':'Within each nonempty profile, artist/album/album_artist/genre are repeated across formats. Native sharing/PIDs remain unobserved.'})
    rows=[]
    for spec in specs:
        source=destination/'inputs'/(spec['id']+'.wav');raw=pcm(spec)
        with wave.open(str(source),'wb') as w:w.setparams((1,2,RATE,0,'NONE','not compressed'));w.writeframes(raw)
        path=destination/'media'/spec['filename'];_,codec,options=FORMATS[spec['format']]
        argv=[ffmpeg,'-nostdin','-hide_banner','-loglevel','error','-n','-threads','1','-filter_threads','1','-filter_complex_threads','1','-i',source,'-map','0:a:0','-map_metadata','-1','-c:a',codec,'-threads:a','1','-flags:a','+bitexact','-fflags','+bitexact',*options,path]
        _,enc=command(argv,destination/'qa',spec['id']+'-encode');write_tags(path,spec)
        os.utime(path,ns=(spec['mtime_ns'],spec['mtime_ns']))
        observed=verify_case(path,spec,ffmpeg,ffprobe,destination/'qa',raw)
        assert path.stat().st_mtime_ns==spec['mtime_ns']
        row={'id':spec['id'],'path':str(path),'relative_path':path.relative_to(destination).as_posix(),'file_only_name':path.name,'format':spec['format'],'profile':spec['profile'],'seed':spec['seed'],'source_spec':{k:spec[k] for k in ['period_frames','phase_frames','amplitude']},'size_bytes':path.stat().st_size,'sha256':sha(path),'mtime_ns':path.stat().st_mtime_ns,'mtime_utc':datetime.fromtimestamp(path.stat().st_mtime_ns/1e9,timezone.utc).isoformat(),'expected_embedded_tags':spec['tags'],'observed':observed,'encode_peak_process_bytes':enc['max_observed_combined_peak_working_set_bytes'],'native_acceptance':'unmeasured'}
        rows.append(row);save(destination/'qa'/(spec['id']+'.verified.json'),row)
        print('VERIFIED '+spec['id']+' '+row['sha256'],flush=True)
    manifest={'schema':'itl4.media.manifest.v1','status':'sealed','sealed_utc':utc(),'corpus_root':str(destination),'generator_sha256':sha(__file__),'tool_provenance_sha256':sha(provenance),'sample_rate':RATE,'source_channels':1,'source_bits':16,'source_frames':FRAMES,'source_duration_seconds':FRAMES/RATE,'count':len(rows),'media':rows,'native_observations':None,'immutable_policy':'Never overwrite, retag or regenerate inside this directory. Native uses verified disposable copies. Additional cases use new sets.'}
    save(destination/'manifest.json',manifest)
    requests={'schema':'itl4.media.native-requests.v1','task':'Create fresh native donors from copies; discovery only, not independent-writer acceptance','native_owner':'dynamic','source_manifest_sha256':sha(destination/'manifest.json'),'native_observations':None,'identities':{'file_pid':None,'master_pid':None,'track_pids':None,'album_pids':None,'artist_pids':None},'procedure':['Copy media to a new disposable dynamic-owned folder; verify SHA256 and record actual Location. Do not mutate sealed media.','Import and enumerate raw native fields before any setters or UpdateInfoFromFile. Record filename fallback separately from embedded title.','Record raw track metadata, master/track/file/album/artist IDs and shared-index relationships without equating distinct ID domains.','Save/normal quit; capture ITL hashes, count/reference closure and immediate/45-second first-open and second-open/30-second observations. Playback is separate.','A future independent writer request must predeclare old/new identities, Locations and memberships before native acceptance. This file is not that claim.'],'requests':[{'id':r['id'],'media_path':r['path'],'sha256':r['sha256'],'size_bytes':r['size_bytes'],'mtime_ns':r['mtime_ns'],'source_duration_seconds':FRAMES/RATE,'ffprobe_duration_seconds':float(r['observed']['ffprobe']['format']['duration']),'decoded_frames':r['observed']['decoded_pcm']['frames'],'expected_embedded_tags':r['expected_embedded_tags'],'file_only_name':r['file_only_name'],'expected_title_source':'filename fallback to measure' if r['profile']=='absent' else 'embedded tag; filename intentionally differs','expected_live_location':None,'native_raw':None,'native_acceptance':'unmeasured'} for r in rows]}
    save(destination/'native-requests.json',requests)
    inventory=[]
    for p in sorted(destination.rglob('*')):
        if p.is_file():inventory.append({'path':p.relative_to(destination).as_posix(),'size_bytes':p.stat().st_size,'sha256':sha(p)})
    save(destination/'seal.json',{'status':'sealed','files':inventory,'manifest_sha256':sha(destination/'manifest.json'),'native_requests_sha256':sha(destination/'native-requests.json')})
    for p in destination.rglob('*'):
        if p.is_file():os.chmod(p,stat.S_IREAD)
    print(json.dumps({'status':'ITL4_CORPUS_SEALED','destination':str(destination),'count':len(rows),'manifest_sha256':sha(destination/'manifest.json'),'seal_sha256':sha(destination/'seal.json'),'max_observed_process_bytes':max(max(r['encode_peak_process_bytes'],r['observed']['peak_process_bytes']) for r in rows)},indent=2),flush=True)

def verify_seal(destination):
    seal=json.loads((destination/'seal.json').read_text(encoding='utf-8'))
    if seal.get('status')!='sealed':raise ValueError('Corpus is not sealed')
    for item in seal['files']:
        p=(destination/item['path']).resolve()
        if not p.is_relative_to(destination.resolve()):raise ValueError('Seal path escapes corpus')
        if p.stat().st_size!=item['size_bytes'] or sha(p)!=item['sha256']:raise ValueError('Seal mismatch: '+str(p))
    m=json.loads((destination/'manifest.json').read_text(encoding='utf-8'))
    for r in m['media']:
        p=(destination/r['relative_path']).resolve()
        if not p.is_relative_to(destination.resolve()):raise ValueError('Media path escapes corpus')
        if p.stat().st_mtime_ns!=r['mtime_ns'] or sha(p)!=r['sha256']:raise ValueError('Media hash/mtime mismatch')
        if read_tags(p)['normalized']!=r['expected_embedded_tags']:raise ValueError('Embedded tag mismatch')
    print(json.dumps({'status':'SEAL_VERIFIED','files':len(seal['files']),'media':m['count'],'manifest_sha256':sha(destination/'manifest.json')},indent=2))

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--root',required=True);ap.add_argument('--destination',required=True);ap.add_argument('--formats',default=','.join(FORMATS));ap.add_argument('--profiles',default='ascii,latin1,unicode,absent');ap.add_argument('--verify',action='store_true');a=ap.parse_args()
    root=Path(a.root).resolve();dest=Path(a.destination).resolve()
    if Path.cwd().resolve()!=root/'wt/media':raise ValueError('Assigned cwd required')
    if a.verify:verify_seal(dest);return
    formats=a.formats.split(',');profiles=a.profiles.split(',');assert set(formats)<=set(FORMATS) and set(profiles)<={'ascii','latin1','unicode','absent'}
    generate(root,dest,formats,profiles)
if __name__=='__main__':main()
