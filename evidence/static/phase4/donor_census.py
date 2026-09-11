"""Bounded read-only donor analysis; no native process, code imports, candidate or original writes."""
from pathlib import Path
from collections import Counter
import json,hashlib,zlib,runpy,datetime
from Crypto.Cipher import AES
ROOT=Path(r'<CI_TEMP_WIN>\<CI_BROKER>\WINDOWS_RESEARCH_RUN\work\itl');R=ROOT/'reports/static';O=R/'phase4';LIMIT=64*1024*1024
sha=lambda b:hashlib.sha256(b).hexdigest()
helper=R/'phase2/census_snapshots.py';assert sha(helper.read_bytes())=='377d6d9a3895c443eb86a517975d0d1281150f5ccfb44eb0244d8647bed2a6f4'
inspect=runpy.run_path(str(helper),run_name='phase4_readonly_helper')['inspect']
manifest=json.loads((O/'input-manifest.json').read_text());original_manifest=json.loads((ROOT/'reports/dynamic/phase2/independent-donor32-manifest.json').read_text(encoding='utf-8-sig'))
expected={int(t['persistent_id'],16):t for t in original_manifest['tracks']};results=[]
def payload(raw):
 h=int.from_bytes(raw[4:8],'big');b=raw[h:];cf=raw[0x41];cap=int.from_bytes(raw[0x5c:0x60],'big');assert cf in (0,1,2)
 n=(0 if cf==0 else len(b) if cf==1 else min(len(b),cap))&~15;b=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(b[:n])+b[n:]
 if raw[0x43]:
  z=zlib.decompressobj();p=z.decompress(b,LIMIT+1);assert len(p)<=LIMIT and z.eof and not z.unconsumed_tail and not z.unused_data
 else:p=b;assert len(p)<=LIMIT
 return p
for x in manifest['donor_snapshots']:
 path=Path(x['path']);raw=path.read_bytes();assert sha(raw)==x['sha256'];c=inspect(path);p=payload(raw);assert sha(p)==c['plaintext_sha256'];assert c['inner_endian']=='little'
 ui=lambda off,n=4:int.from_bytes(p[off:off+n],'little')
 sections=[]
 for s in c['sections']:
  a=s['offset'];h=s['header_length'];end=a+s['total_length'];body=p[a+h:end];v={**s,'body_sha256':sha(body),'body_bytes':len(body),'root_fourcc':body[:4].decode('ascii',errors='backslashreplace')}
  if len(body)>=12:v['root_header_length']=int.from_bytes(body[4:8],'little');v['root_word8']=int.from_bytes(body[8:12],'little')
  sections.append(v)
 records=[];track_locations=[]
 for r in c['records']:
  a=r['offset'];h=r['header_length'];tag=r['tag'];v={**r,'header_sha256':sha(p[a:a+h])}
  if tag=='mith':
   v['identities']={hex(o):ui(a+o,n) for o,n in [(0x10,4),(0x80,8),(0xdc,4),(0x1e0,4),(0x1f4,4)]};v['flag6d']=p[a+0x6d]
   objs=[]
   for m in c['mhoh']:
    if m['record_offset']!=a or m['type'] not in (1,11,13,0x13):continue
    st=m['offset'];mh=m['header_length'];body=p[st+mh:st+m['total_length']];q={'type_decimal':m['type'],'type_hex':hex(m['type']),'mhoh_offset':st,'atom_id':m['atom_id'],'total_length':m['total_length'],'body_sha256':sha(body),'prefix_hex':body[:32].hex()}
    if 'encoding' in m:
     data=body[16:16+m['length']];q.update(encoding=m['encoding'],byte_length=m['length'],suffix_bytes=m['suffix_bytes'])
     if m['encoding'] in (1,3) or m['type']==11 and m['encoding']==2:
      codec='utf-16-le' if m['encoding']==1 else 'latin1' if m['encoding']==3 else 'ascii';q['text']=data.decode(codec)
    objs.append(q)
   pid=ui(a+0x80,8);exp=expected.get(pid);track_locations.append({'pid':f'{pid:016X}','kind':ui(a+0x14),'objects':objs,'manifest_location':exp['Location'] if exp else None,'manifest_file_exists':Path(exp['Location']).is_file() if exp else None})
  else:v['identities']={'local_id':ui(a+0x10),'persistent_id':f'{ui(a+0x14,8):016X}'}
  records.append(v)
 outer={hex(o):int.from_bytes(raw[o:o+4],'big') for o in [0x30,0x3c,0x44,0x48,0x4c,0x54,0x58]};inner=[]
 for s in c['sections']:
  if s['type']==16:
   a=s['offset']+s['header_length'];inner.append({hex(o):ui(a+o) for o in [8,0x30,0x3c,0x44,0x48,0x4c,0x54,0x58]})
 recordcounts=dict(Counter(r['tag'] for r in records));counts=Counter(m['type'] for m in c['mhoh'] if m['parent_tag']=='mith')
 shared={}
 for field in ['0xdc','0x1e0']:
  counts2=Counter(r['identities'][field] for r in records if r['tag']=='mith');shared[field]={str(k):v for k,v in counts2.items() if k and v>1}
 results.append({'role':x['role'],'path':str(path),'sha256':sha(raw),'plaintext_sha256':sha(p),'outer_fields_be':outer,'inner_fields':inner,'sections':sections,'record_counts':recordcounts,'track_mhoh_counts_by_decimal_type':dict(counts),'records':records,'track_locations':track_locations,'shared_object_references':shared})
 assert path.read_bytes()==raw
before,imported,reloaded=results;by0={s['type']:s for s in before['sections']};by1={s['type']:s for s in imported['sections']};by2={s['type']:s for s in reloaded['sections']};comparison=[]
for typ in sorted(set(by0)|set(by1)|set(by2)):
 ss=[b.get(typ) for b in [by0,by1,by2]];comparison.append({'section_type':typ,'body_lengths':[s['body_bytes'] if s else None for s in ss],'body_sha256':[s['body_sha256'] if s else None for s in ss],'root_word8':[s.get('root_word8') if s else None for s in ss],'empty_to_import_changed':ss[0]!=ss[1] if None in ss[:2] else ss[0]['body_sha256']!=ss[1]['body_sha256'],'import_to_reload_changed':ss[1]!=ss[2] if None in ss[1:] else ss[1]['body_sha256']!=ss[2]['body_sha256']})
report={'status':'complete','created_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Three pinned saved donor snapshots; no live or candidate files. All strings are synthetic donor data.','files':results,'section_comparison':comparison,'limitations':['Section hashes show changes, not the meaning/necessity of every byte.','The source manifest is dynamic-owner provenance, not a static-owned native execution.','No cross-library import acceptance is implied.']}
(O/'donor-census.json').write_text(json.dumps(report,indent=2,ensure_ascii=False),encoding='utf-8')
print('DONOR_CENSUS_PASS')
for r in results:print(json.dumps({k:r[k] for k in ['role','outer_fields_be','inner_fields','record_counts','track_mhoh_counts_by_decimal_type','shared_object_references']},indent=2))
print('SECTION_COMPARISON',json.dumps(comparison,indent=2));print('FIRST_NATIVE_LOCATION',json.dumps(reloaded['track_locations'][:1],indent=2,ensure_ascii=True))
