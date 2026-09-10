"""Acquire only a currently linked, provider-hash-verified portable FFmpeg pair."""

# Safety assertions must never be disabled, including when this module is imported.
if not __debug__:
    raise SystemExit("ITL4_OPTIMIZATION_UNSUPPORTED: use Python without -O/-OO/PYTHONOPTIMIZE")

import argparse, hashlib, json, os, re, shutil, subprocess, zipfile
from pathlib import Path, PurePosixPath
from datetime import datetime, timezone
from html.parser import HTMLParser
from urllib.parse import urljoin

def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
def save(p,obj):
    with p.open('x',encoding='utf-8',newline='\n') as f:
        json.dump(obj,f,ensure_ascii=False,indent=2);f.write('\n');f.flush();os.fsync(f.fileno())
class Links(HTMLParser):
    def __init__(self): super().__init__();self.links=[]
    def handle_starttag(self,tag,attrs):
        if tag=='a': self.links += [v for k,v in attrs if k=='href' and v]
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--root',required=True);ap.add_argument('--curl',required=True);a=ap.parse_args()
    root=Path(a.root).resolve();home=root/'tools/media';out=home/'acquisition-01';out.mkdir(exist_ok=False)
    baseline=root/'baseline/evidence/research/media-tool-provenance.json'
    old=json.loads(baseline.read_text(encoding='utf-8'))
    def fetch(name,url,limit=120):
        target=out/name
        if target.exists():raise FileExistsError(target)
        argv=[a.curl,'--fail','--location','--proto','=https','--proto-redir','=https','--connect-timeout','15','--max-time',str(limit),'--max-filesize','209715200','--silent','--show-error','--output',str(target),'--write-out','%{json}',url]
        r=subprocess.run(argv,capture_output=True,timeout=limit+15)
        rec={'argv':argv,'exit_code':r.returncode,'stdout':r.stdout.decode('utf-8','replace'),'stderr':r.stderr.decode('utf-8','replace')}
        save(out/(name+'.transfer.json'),rec)
        if r.returncode:raise RuntimeError('HTTPS acquisition failed: '+name)
        return target
    official='https://ffmpeg.org/download.html';vendor='https://www.gyan.dev/ffmpeg/builds/'
    p=fetch('official.html',official,60);l=Links();l.feed(p.read_text(encoding='utf-8'));assert vendor in [urljoin(official,x) for x in l.links]
    p=fetch('vendor.html',vendor,60);l=Links();l.feed(p.read_text(encoding='utf-8'));links=[urljoin(vendor,x) for x in l.links]
    archive_url=old['archive']['archive_url'];checksum_url=old['archive']['checksum_url']
    assert archive_url in links and checksum_url in links,'Historical fixed release is not currently linked; do not guess'
    checksum=fetch('provider.sha256',checksum_url,60).read_text(encoding='ascii').strip()
    match=re.fullmatch(r'([0-9a-fA-F]{64})(?:\s+\*?\S+)?',checksum);assert match,'No unambiguous provider SHA256'
    expected=match.group(1).lower();archive=fetch('release-essentials.zip',archive_url,180)
    actual=sha(archive)
    if actual!=expected:raise ValueError('Archive SHA mismatch: no execution')
    if actual!=old['archive']['measured_sha256']:raise ValueError('Historical same-version hash changed: refuse')
    dest=home/'ffmpeg-8.1.2/bin';dest.mkdir(parents=True,exist_ok=False)
    binaries=[]
    with zipfile.ZipFile(archive) as z:
        infos=z.infolist();assert 1<len(infos)<10000
        for i in infos:
            pp=PurePosixPath(i.filename);assert not pp.is_absolute() and '..' not in pp.parts and '\\' not in i.filename and ':' not in i.filename
        for name in ['ffmpeg.exe','ffprobe.exe']:
            hits=[i for i in infos if i.filename.endswith('/bin/'+name)];assert len(hits)==1
            entry=hits[0];assert 1048576<entry.file_size<209715200 and (entry.external_attr>>16)&0o170000!=0o120000
            p=dest/name
            with z.open(entry) as src,p.open('xb') as f:shutil.copyfileobj(src,f,1048576)
            measured=sha(p);b=next(x for x in old['binaries'] if x['name']==name)
            if measured!=b['sha256']:raise ValueError('Pinned binary hash mismatch')
            argv=[str(p),'-version'];r=subprocess.run(argv,capture_output=True,timeout=15)
            text=r.stdout.decode('utf-8','replace')+r.stderr.decode('utf-8','replace');assert r.returncode==0 and '8.1.2' in text.splitlines()[0]
            binaries.append({'name':name,'path':str(p),'size_bytes':p.stat().st_size,'sha256':measured,'archive_entry':entry.filename,'version':text,'version_command':argv,'exit_code':r.returncode})
    result={'status':'verified','utc':datetime.now(timezone.utc).isoformat(),'official_url':official,'vendor_url':vendor,'archive_url':archive_url,'checksum_url':checksum_url,'provider_sha256':expected,'archive_sha256':actual,'archive_size_bytes':archive.stat().st_size,'archive_path':str(archive),'baseline_provenance_sha256':sha(baseline),'binaries':binaries,'global_install':False,'redistribute_third_party_executables':False}
    save(home/'provenance.json',result)
    print(json.dumps({'status':'ENCODER_READY','archive_sha256':actual,'binaries':[{k:b[k] for k in ['name','path','size_bytes','sha256']} for b in binaries]},indent=2),flush=True)
if __name__=='__main__':main()
