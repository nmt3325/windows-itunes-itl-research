"""Compatibility phase: immutable originals, exact v3 reconstruction, new native probes.
No iTunes/COM/media operation. Old candidates and v3 manifest are read-only.
"""
from pathlib import Path
import copy,hashlib,json,struct,zlib,subprocess
from Crypto.Cipher import AES
from itlkit import Library,Container,FormatError
from itlkit.library import text_nodes
R=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');W=R/'wt/codec';O=R/'reports/codec';P=O/'compatibility';P.mkdir(exist_ok=True)
def sha(b):return hashlib.sha256(b).hexdigest()
def out(p,b):
 with p.open('xb') as f:f.write(b)
def jnew(p,d):out(p,json.dumps(d,ensure_ascii=False,indent=2).encode('utf8'))
def oracle(data):
 hlen=struct.unpack_from('>I',data,4)[0];body=data[hlen:];flag=data[0x41];cap=struct.unpack_from('>I',data,92)[0]
 assert flag in (0,1,2)
 n=(0 if flag==0 else len(body) if flag==1 else min(len(body),cap))//16*16
 decoded=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(body[:n])+body[n:] if n else body
 if data[0x43]:
  z=zlib.decompressobj();payload=z.decompress(decoded);assert z.eof;return payload,z.unused_data
 return decoded,b''

producer={str(p.relative_to(W)).replace('\\','/'):sha(p.read_bytes()) for p in sorted((W/'itlkit').glob('*.py'))}
producer.update({str(p.relative_to(W)).replace('\\','/'):sha(p.read_bytes()) for p in [W/'tests/test_core_compatibility.py',W/'docs/format.md']})
results={'producer_head_before_commit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=W,text=True).strip(),'producer_source_sha256':producer,'generator_sha256':sha(Path(__file__).read_bytes()),'originals':[],'native_snapshots':[],'phase1_reconstructions':[]}
prev=json.loads((O/'final-fixtures.json').read_text(encoding='utf8'))
for old in prev['originals']:
 f=R/'reference/projects/reverse-itunes'/old['path'];raw=f.read_bytes();assert sha(raw)==old['sha256'];c=Container.from_bytes(raw);assert c.to_bytes()==raw
 assert oracle(c.to_bytes(rebuild=True))==(c.payload,c.trailer)
 changed=copy.deepcopy(c);changed.payload+=b'compatibility raw probe';assert oracle(changed.to_bytes())==(changed.payload,changed.trailer)
 row={'path':str(f),'sha256':sha(raw),'container_noop':True,'container_forced_oracle':True,'raw_modified_oracle':True}
 try:lib=Library.from_bytes(raw)
 except FormatError as e:
  assert old['structurally_valid'] is False;row.update(structurally_valid=False,expected_rejection=str(e))
 else:
  assert old['structurally_valid'] is True;assert lib.to_bytes()==raw;again=Library.from_bytes(lib.to_bytes(rebuild=True));row.update(structurally_valid=True,tracks=len(lib.tracks),playlists=len(lib.playlists))
  if lib.tracks:
   t=lib.tracks[0];pid=t.persistent_id;t.set(name='Compat Café ÿ 日本語 🎵',rating=60,year=2033);t2=Library.from_bytes(lib.to_bytes()).track(persistent_id=pid)
   assert t2.get('name')=='Compat Café ÿ 日本語 🎵' and t2.get('rating')==60 and t2.get('year')==2033;row['semantic_modified_redecode']=True
 assert sha(f.read_bytes())==old['sha256'];row['original_unchanged']=True;results['originals'].append(row)
for f in sorted((R/'fixtures/dynamic/snapshots').glob('*.itl')):
 raw=f.read_bytes();lib=Library.from_bytes(raw);assert lib.to_bytes()==raw
 rebuilt=lib.to_bytes(rebuild=True);again=Library.from_bytes(rebuilt);assert oracle(rebuilt)==(lib.container.payload,lib.container.trailer)
 assert sha(f.read_bytes())==sha(raw)
 results['native_snapshots'].append({'path':str(f),'sha256':sha(raw),'exact_noop':True,'forced_redecode':True,'tracks':len(again.tracks),'playlists':len(again.playlists)})

v3path=O/'native-validation-requests-v3.json';v3bytes=v3path.read_bytes();assert sha(v3bytes)=='03003d91ca213cae2a6fad15cb7f39c4a348704f34b567ee1c41b42b101f58a6';v3=json.loads(v3bytes);v4=[]
for old in v3:
 f=Path(old['output']);raw=f.read_bytes();assert sha(raw)==old['sha256'];lib=Library.from_bytes(raw);rebuilt=lib.to_bytes(rebuild=True);assert oracle(rebuilt)==(lib.container.payload,lib.container.trailer)
 dest=P/('v4-'+old['name']+'.itl');out(dest,rebuilt);same=sha(rebuilt)==old['sha256'];assert same
 row=copy.deepcopy(old);row.update(name='v4-'+old['name'],output=str(dest),sha256=sha(rebuilt),phase1_case=old['name'],phase1_output=str(f),phase1_sha256=old['sha256'],same_sha_as_phase1=same,generation_input=str(f),generation_method='force reserialize/recompress/re-encrypt immutable phase1 candidate; original semantic operations are not replayed',producer_sources=producer)
 # Seven accepted byte strings retain their existing evidence; four remain pending.
 v4.append(row);results['phase1_reconstructions'].append({k:row[k] for k in ['name','output','sha256','phase1_case','same_sha_as_phase1']})
 assert sha(f.read_bytes())==old['sha256']

src=R/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl';srcraw=src.read_bytes();srcsha=sha(srcraw);target='D018EAABC195E072'
new_specs=[('crypto0',0,102400,1,None),('crypto1-ignore-cap17',1,17,1,None),('crypto2-cap0',2,0,1,None),('crypto2-cap17',2,17,1,None),('raw-crypto0',0,0,0,None),('raw-crypto1',1,17,0,None),('raw-crypto2-cap17',2,17,0,None),('text-latin1',2,102400,1,'latin1'),('text-unicode',2,102400,1,'unicode')]
for name,flag,cap,compression,textmode in new_specs:
 lib=Library.from_bytes(srcraw);h=bytearray(lib.container.header);h[0x41]=flag;h[0x43]=compression;struct.pack_into('>I',h,92,cap);lib.container.header=bytes(h);fields={}
 if textmode=='latin1':
  node=text_nodes(lib.track(persistent_id=target).node,2)[0];prefix=bytearray(node.payload[:16]);s=b'Caf\xe9 \xff';struct.pack_into('<II',prefix,0,3,len(s));node.payload=bytes(prefix)+s;fields={'name':'Café ÿ'}
 elif textmode=='unicode':
  fields={'name':'Café ÿ 日本語 🎵'};lib.track(persistent_id=target).set(**fields)
 data=lib.to_bytes(rebuild=True);loaded=Library.from_bytes(data);assert oracle(data)==(loaded.container.payload,loaded.container.trailer)
 for k,v in fields.items():assert loaded.track(persistent_id=target).get(k)==v
 aux=loaded.track(persistent_id=target).get('rating_aux_raw');assert aux==1
 dest=P/('v4-'+name+'.itl');out(dest,data);summ=loaded.summary()
 v4.append({'name':'v4-'+name,'input':str(src),'input_sha256':srcsha,'generation_input':str(src),'generation_method':'header mode change and optional explicit string representation on immutable native snapshot; fresh codec serialization','output':str(dest),'sha256':sha(data),'library_persistent_id':summ['library_persistent_id'],'file_persistent_id':summ['file_persistent_id'],'track_count':len(loaded.tracks),'track_persistent_ids':[f'{t.persistent_id:016X}' for t in loaded.tracks],'target_track':target,'expected_fields':fields,'encryption_flag':flag,'cap':cap,'compression_flag':compression,'rating_aux_before':1,'rating_aux_written':aux,'native_acceptance':'pending','producer_sources':producer,'master_playlist_policy':'compare track persistent ID sets, not raw name or auto-sort order'})
assert sha(src.read_bytes())==srcsha and v3path.read_bytes()==v3bytes
results['new_native_candidates']=[{k:r[k] for k in ['name','output','sha256','expected_fields','native_acceptance']} for r in v4 if 'phase1_case' not in r]
results['native_candidate_count']=len(v4);results['phase1_candidates_unchanged']=11
jnew(O/'native-validation-requests-v4.json',v4);jnew(O/'compatibility-validation.json',results)
print('ORIGINALS',len(results['originals']),'VALID',sum(r['structurally_valid'] for r in results['originals']))
print('NATIVE_SNAPSHOTS',len(results['native_snapshots']));print('PHASE1_IDENTICAL',len(results['phase1_reconstructions']));print('V4_CANDIDATES',len(v4))
for r in v4:print(r['name'],r['sha256'],r['native_acceptance'])
print('V4_SHA',sha((O/'native-validation-requests-v4.json').read_bytes()));print('GENERATOR_SHA',results['generator_sha256']);print('ALL_ORIGINALS_AND_V3_UNCHANGED')