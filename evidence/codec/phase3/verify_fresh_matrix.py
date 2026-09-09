"""Independent phase3 oracle: no itlkit imports, no production pack/tree helpers.
Reads bounded hdfm/msdh/mlth/mith/mhoh spans; builds expected source->API payload
by declared boundaries and checks every candidate including factors and controls.
"""
from pathlib import Path
import argparse,hashlib,itertools,json,struct,sys,zlib
from Crypto.Cipher import AES
sys.dont_write_bytecode=True
P=Path(__file__).resolve().parent
PID=0xD018EAABC195E072
OLD='34e4b4348ee4db611d59c1da23791700558c3c91bc44504e4d89a8e5c228ec0f'
SOURCE='a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4'
FRESH={'name':'Codec Fresh 🧪','rating':80,'play_count':7,'skip_count':2,'year':2032,'track_number':9}
OFFSETS={'rating':(0x6c,1),'play_count':(0x4c,4),'skip_count':(0xd8,4),'year':(0x34,4),'track_number':(0x2c,4)}
def sha(b):return hashlib.sha256(b).hexdigest()
def le(b,o):return struct.unpack_from('<I',b,o)[0]
def put(b,o,n):struct.pack_into('<I',b,o,n)
def envelope(data):
 assert data[:4]==b'hdfm' and struct.unpack_from('>I',data,8)[0]==len(data)
 hsize=struct.unpack_from('>I',data,4)[0];assert hsize==144
 header=data[:hsize];body=data[hsize:];flag=header[65];cap=struct.unpack_from('>I',header,92)[0]
 assert flag in (0,1,2)
 n=(0 if flag==0 else len(body) if flag==1 else min(len(body),cap))&~15
 clear=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(body[:n])+body[n:] if n else body
 if header[67]:
  stream=zlib.decompressobj();payload=stream.decompress(clear)+stream.flush();assert stream.eof and not stream.unused_data
 else:payload=clear
 assert header[82]!=0
 return header,payload

def frame(b,pos,end,tag):
 assert 0<=pos<=end-12 and b[pos:pos+4]==tag
 size,total=le(b,pos+4),le(b,pos+8)
 assert size>=12 and size<=total<=end-pos
 return size,total

def sections(b):
 result=[];pos=0
 while pos<len(b):
  size,total=frame(b,pos,len(b),b'msdh');kind=le(b,pos+12)
  assert size>=16 and kind not in {s['kind'] for s in result}
  result.append({'offset':pos,'kind':kind,'header':b[pos:pos+size],'body':b[pos+size:pos+total]});pos+=total
 assert pos==len(b)
 return result

def tracks(payload):
 section=next(s for s in sections(payload) if s['kind']==1)
 body=section['body'];root_hlen=le(body,4);count=le(body,8)
 assert body[:4]==b'mlth' and 12<=root_hlen<=len(body)
 pos=root_hlen;result=[]
 while pos<len(body):
  hs,total=frame(body,pos,len(body),b'mith');assert hs==756
  chunk=body[pos:pos+total];head=chunk[:hs];current={'offset':section['offset']+len(section['header'])+pos,'header':head,'raw':chunk,'pid':struct.unpack_from('<Q',head,128)[0],'children':[]}
  cpos=hs
  while cpos<total:
   ch,ct=frame(chunk,cpos,total,b'mhoh');assert ch==24
   current['children'].append({'offset':current['offset']+cpos,'relative':cpos,'type':le(chunk,cpos+12),'header':chunk[cpos:cpos+ch],'payload':chunk[cpos+ch:cpos+ct],'raw':chunk[cpos:cpos+ct]});cpos+=ct
  assert cpos==total and len(current['children'])==le(head,12)
  result.append(current);pos+=total
 assert pos==len(body) and len(result)==count and len({t['pid'] for t in result})==count
 return result

def alpha(payload):return next(t for t in tracks(payload) if t['pid']==PID)
def title(t):
 values=[n for n in t['children'] if n['type']==2];assert len(values)==1;return values[0]
def text(n):
 p=n['payload'];code,size=le(p,0),le(p,4);assert code in (1,3) and 16+size<=len(p)
 return p[16:16+size].decode('utf-16-le' if code==1 else 'latin1')

def expected_api_payload(source,fields):
 record=alpha(source);header=bytearray(record['header']);new_children=[]
 for key,value in fields.items():
  if key=='name':continue
  offset,width=OFFSETS[key];header[offset:offset+width]=value.to_bytes(width,'little')
 for node in record['children']:
  if node['type']!=2 or 'name' not in fields:new_children.append(node['raw']);continue
  h=bytearray(node['header']);p=node['payload'];length=le(p,4);prefix=bytearray(p[:16]);content=fields['name'].encode('utf-16-le');suffix=p[16+length:]
  put(prefix,0,1);put(prefix,4,len(content));body=bytes(prefix)+content+suffix;put(h,8,len(h)+len(body));new_children.append(bytes(h)+body)
 body=b''.join(new_children);put(header,8,len(header)+len(body));changed=bytes(header)+body
 parts=sections(source);new_parts=[]
 for sec in parts:
  if sec['kind']==1:
   old=sec['body'];root_size=le(old,4);records=[changed if t['pid']==PID else t['raw'] for t in tracks(source)];body=old[:root_size]+b''.join(records);h=bytearray(sec['header']);put(h,8,len(h)+len(body));new_parts.append(bytes(h)+body)
  else:new_parts.append(sec['header']+sec['body'])
 result=bytearray(b''.join(new_parts));main=next(s for s in sections(result) if s['kind']==16);pos=main['offset']+len(main['header']);assert result[pos:pos+4]==b'mfdh';put(result,pos+8,len(result)+144)
 return bytes(result)

def main():
 ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--generated',type=Path,default=P/'generated');args=ap.parse_args();folder=args.generated
 manifest_bytes=(folder/'manifest.json').read_bytes();m=json.loads(manifest_bytes);cases=m['candidates'];assert len(cases)==12
 root=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');source_path=root/'fixtures/dynamic/snapshots/003-three-tracks-reloaded.itl';source_data=source_path.read_bytes();assert sha(source_data)==SOURCE
 sh,source=envelope(source_data);baseline_expected=expected_api_payload(source,FRESH);bt=alpha(baseline_expected);bn=title(bt);result=[]
 assert {(c['raw_factors']['A'],c['raw_factors']['B'],c['raw_factors']['C']) for c in cases if c['category']=='factorial'}==set(itertools.product((0,1),repeat=3))
 for row in cases:
  raw=(folder/row['file']).read_bytes();assert sha(raw)==row['sha256']
  h,payload=envelope(raw);assert sha(payload)==row['expanded_sha256']
  h0=bytearray(h);s0=bytearray(sh);h0[8:12]=s0[8:12];assert h0==s0
  if row['category']=='factorial':
   expected=bytearray(baseline_expected);a,b,c=[row['raw_factors'][k] for k in ('A','B','C')]
   if a:expected[bt['offset']+0x6d]=0
   if b:put(expected,bn['offset']+16,4)
   if c:put(expected,bt['offset']+0x290,0)
   expected=bytes(expected)
  elif row['category']=='reference':expected=source;assert raw==source_data
  else:expected=expected_api_payload(source,row['semantic_api_fields'])
  assert payload==expected,row['name']+' payload differs from independent source edit'
  t=alpha(payload);n=title(t);observed={'name':text(n)}
  for key,(off,width) in OFFSETS.items():observed[key]=int.from_bytes(t['header'][off:off+width],'little')
  assert observed==row['expected_fields'];assert t['header'][0xee]==0
  main=next(s for s in sections(payload) if s['kind']==16);assert le(main['body'],8)==len(payload)+144
  other=[x['raw'] for x in tracks(payload) if x['pid']!=PID];assert other==[x['raw'] for x in tracks(source) if x['pid']!=PID]
  assert len(tracks(payload))==3 and struct.unpack_from('>I',h,0x44)[0]==3
  if row['name'] in ('fresh-api-baseline','factor-A0-B0-C0'):assert sha(raw)==OLD
  result.append({'name':row['name'],'sha256':sha(raw),'independent_source_edit_oracle':True,'other_tracks_unchanged':True,'exact_expected_field_values':True})
 assert sha(source_path.read_bytes())==SOURCE and sha((root/'reports/codec/native-fresh-modified.itl').read_bytes())==OLD
 output={'status':'passed','production_modules_imported':False,'candidate_count':len(result),'unique_hashes':len({r['sha256'] for r in result}),'validator_sha256':sha(Path(__file__).read_bytes()),'manifest_sha256':sha(manifest_bytes),'cases':result}
 with (folder/'independent-validation.json').open('x',encoding='utf8') as f:json.dump(output,f,ensure_ascii=False,indent=2)
 print('INDEPENDENT_ORACLE_PASS 12 files / 11 unique hashes; all exact payloads and values; production not imported')
if __name__=='__main__':main()