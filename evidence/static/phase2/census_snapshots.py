"""Read-only bounded census. Emits IDs/offsets/hashes, not URLs or metadata text."""
from pathlib import Path
from collections import Counter
import hashlib,json,datetime,re,zlib
from Crypto.Cipher import AES
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl')
OUT=ROOT/'reports/static/phase2';SOURCE=ROOT/'fixtures/dynamic/snapshots'
LIMIT=64*1024*1024
sha=lambda b:hashlib.sha256(b).hexdigest()

def inspect(path):
 raw=path.read_bytes();assert 0x60<=len(raw)<=LIMIT,'outer bounds'
 assert raw[:4]==b'hdfm','outer magic'
 h=int.from_bytes(raw[4:8],'big');assert 0x60<=h<=len(raw)
 assert int.from_bytes(raw[8:12],'big')==len(raw),'outer physical length'
 cf,zf,le=raw[0x41],raw[0x43],raw[0x52];cap=int.from_bytes(raw[0x5c:0x60],'big')
 assert cf in (0,1,2),'unknown encryption flag'
 body=raw[h:];n=(0 if cf==0 else len(body) if cf==1 else min(len(body),cap))&~15
 dec=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(body[:n])+body[n:]
 if zf:
  z=zlib.decompressobj();plain=z.decompress(dec,LIMIT+1)
  assert len(plain)<=LIMIT and z.eof and not z.unconsumed_tail,'zlib bounds/eof'
  trailer=len(z.unused_data)
 else:plain=dec;trailer=0
 endian='little' if le else 'big'
 def ui(off,size=4):
  assert 0<=off<=len(plain)-size,'integer bounds'
  return int.from_bytes(plain[off:off+size],endian)
 def prefix(off,end):
  assert 0<=off<=end-12,'record prefix bounds'
  tag=plain[off:off+4];tag=tag if le else tag[::-1]
  hl,tl=ui(off+4),ui(off+8);assert hl>=12 and off+hl<=end,'record header bounds'
  return tag,hl,tl
 rows=[];sections=[];records=[];urlstats=Counter();encstats=Counter();off=0
 families={1:(b'mlth',b'mith'),13:(b'mlth',b'mith'),9:(b'mlah',b'miah'),11:(b'mlih',b'miih')}
 while off<len(plain):
  tag,hl,tl=prefix(off,len(plain));assert tag==b'msdh' and hl>=16 and tl>=hl and off+tl<=len(plain),'section bounds'
  typ=ui(off+12);end=off+tl;sec={'type':typ,'offset':off,'header_length':hl,'total_length':tl};sections.append(sec)
  if typ in families:
   pos=off+hl;lt,lh,cnt=prefix(pos,end);assert lt==families[typ][0] and cnt<100000,'list header/count';pos+=lh
   sec['record_count']=cnt
   for idx in range(cnt):
    rt,rh,rl=prefix(pos,end);assert rt==families[typ][1] and rh>=16 and rl>=rh and pos+rl<=end,'record bounds'
    r_end=pos+rl;nc=ui(pos+12);assert nc<100000,'child count'
    rec={'section_type':typ,'tag':rt.decode('ascii'),'index':idx,'offset':pos,'header_length':rh,'total_length':rl,'mhoh_count':nc}
    rec['header_fields_u32']={hex(o):ui(pos+o) for o in ([0x10,0x14,0xdc,0x1e0,0x120,0x134,0x174,0x290,0x294,0x298,0x29c,0x2a0,0x2a4,0x2a8] if rt==b'mith' else range(0x10,rh,4)) if o+4<=rh}
    if rt==b'mith':rec['track_pid']=hex(ui(pos+0x80,8));rec['track_kind']=ui(pos+0x14)
    child=pos+rh
    for ci in range(nc):
     ct,ch,cl=prefix(child,r_end);assert ct==b'mhoh' and ch>=24 and cl>=ch and child+cl<=r_end,'mhoh bounds'
     mt,atom=ui(child+12),ui(child+16)
     row={'section_type':typ,'parent_tag':rt.decode('ascii'),'parent_index':idx,'record_offset':pos,'offset':child,'type':mt,'atom_id':atom,'header_length':ch,'total_length':cl}
     if mt not in (1,0x13,0x42):
      assert cl>=ch+16,'string prefix bounds'
      enc,length=ui(child+ch),ui(child+ch+4);assert length<=cl-ch-16,'string length bounds'
      data=plain[child+ch+16:child+ch+16+length]
      row.update(encoding=enc,length=length,data_sha256=sha(data),suffix_bytes=cl-ch-16-length)
      encstats[f'{rt.decode()}:type_{mt}:encoding_{enc}']+=1
      if enc in (1,3):
       try:
        text=data.decode('utf-16-le' if le else 'utf-16-be') if enc==1 else data.decode('latin1')
        row['utf16le_semantic_sha256']=sha(text.encode('utf-16-le'))
       except UnicodeError:row['semantic_decode_error']=True
      if rt==b'mith' and mt==11:
       ascii_ok=all(x<128 for x in data);utf8_ok=True
       try:data.decode('utf-8')
       except UnicodeError:utf8_ok=False
       scheme=data.split(b':',1)[0].lower();scheme_name=scheme.decode('ascii') if scheme in (b'file',b'http',b'https') else 'other'
       row.update(track_kind=rec['track_kind'],all_ascii=ascii_ok,valid_utf8=utf8_ok,high_byte_count=sum(x>=128 for x in data),nul_count=data.count(b'\0'),percent_count=data.count(b'%'),well_formed_percent_escapes=re.search(br'%(?![0-9a-fA-F]{2})',data) is None,scheme=scheme_name)
       urlstats[f'kind_{rec["track_kind"]}:encoding_{enc}']+=1
     rows.append(row);child+=cl
    assert child==r_end,'unconsumed track/album/artist bytes'
    records.append(rec);pos=r_end
   assert pos==end,'list count/section length mismatch'
  off=end
 assert path.read_bytes()==raw,'snapshot changed during census'
 return {'path':path.relative_to(ROOT).as_posix(),'sha256':sha(raw),'bytes':len(raw),'version':raw[17:17+raw[16]].decode('ascii'),'crypto_flag':cf,'compression_flag':zf,'inner_endian':endian,'cap':cap,'plaintext_bytes':len(plain),'plaintext_sha256':sha(plain),'trailer_bytes':trailer,'sections':sections,'records':records,'mhoh':rows,'url_distribution':dict(urlstats),'encoding_distribution':dict(encstats)}

def main():
 pinned_path=OUT/'snapshot-manifest.json'
 pinned=json.loads(pinned_path.read_text()) if pinned_path.exists() else None
 expected={f['path']:f['sha256'] for f in pinned['files']} if pinned else {}
 paths=sorted(ROOT/path for path in expected) if pinned else sorted(SOURCE.glob('*.itl'));files=[];errors=[]
 for p in paths:
  try:
   result=inspect(p);files.append(result)
  except Exception as exc:errors.append({'path':p.relative_to(ROOT).as_posix(),'error':f'{type(exc).__name__}: {exc}'})
 urls=[m for f in files for m in f['mhoh'] if m['parent_tag']=='mith' and m['type']==11]
 aggregate={'snapshots_enumerated':len(paths),'snapshots_parsed':len(files),'snapshots_with_url':sum(bool(f['url_distribution']) for f in files),'url_record_occurrences':len(urls),'unique_url_payload_hashes':len({m['data_sha256'] for m in urls}),'by_kind_and_encoding':dict(Counter(f'kind_{m["track_kind"]}:encoding_{m["encoding"]}' for m in urls)),'all_ascii':all(m['all_ascii'] for m in urls),'with_non_ascii_bytes':sum(not m['all_ascii'] for m in urls),'with_nul':sum(m['nul_count']>0 for m in urls),'with_percent_escapes':sum(m['percent_count']>0 for m in urls),'malformed_percent_escapes':sum(not m['well_formed_percent_escapes'] for m in urls),'schemes':dict(Counter(m['scheme'] for m in urls)),'encoded_byte_lengths':dict(Counter(m['length'] for m in urls))}
 stable=(bool(pinned) or paths==sorted(SOURCE.glob('*.itl'))) and all(sha((ROOT/f['path']).read_bytes())==f['sha256'] and (not expected or expected[f['path']]==f['sha256']) for f in files)
 report={'status':'complete' if not errors and stable else 'partial','captured_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Private-origin material is excluded from this generated synthetic-only corpus; no coverage is claimed for it.','limitations':['These repeated snapshots are not independent libraries. Distinct URL payload hashes quantify coverage.','No iTunes execution by this census. Native provenance comes from dynamic-owner reports.','Unparsed top-level section families are structurally skipped; their arbitrary bytes are not mistaken for mhoh records.'],'dynamic_provenance_sha256':sha((ROOT/'reports/dynamic/report.json').read_bytes()),'source_files_stable_at_end':stable,'cohort_manifest':'snapshot-manifest.json' if pinned else None,'additional_snapshot_files_not_censused':[p.relative_to(ROOT).as_posix() for p in sorted(SOURCE.glob('*.itl')) if p not in paths],'aggregate':aggregate,'errors':errors,'files':files}
 (OUT/'native-url-census.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
 print('NATIVE_URL_CENSUS',json.dumps(aggregate));print('ERRORS',json.dumps(errors));print('SOURCE_STABLE',stable)
 if errors or not stable:raise SystemExit(1)
if __name__=='__main__':main()
