"""Correlate native Frida zlib streams with immutable ITLs without using itlkit."""
import argparse,hashlib,json,pathlib,zlib
from Crypto.Cipher import AES

KEY=b'BHUILuilfghuila3'
def digest(b):return hashlib.sha256(b).hexdigest()

def decode(path):
    raw=path.read_bytes()
    if raw[:4]!=b'hdfm':raise ValueError('Not hdfm')
    h=int.from_bytes(raw[4:8],'big');declared=int.from_bytes(raw[8:12],'big')
    if not 96<=h<=len(raw) or declared!=len(raw):raise ValueError('Bounds/size mismatch')
    limit=int.from_bytes(raw[0x5c:0x60],'big');body=raw[h:];n=min(limit,len(body))&~15
    compressed=AES.new(KEY,AES.MODE_ECB).decrypt(body[:n])+body[n:]
    d=zlib.decompressobj();plain=d.decompress(compressed)+d.flush()
    if not d.eof:raise ValueError('Incomplete zlib')
    return {'path':str(path),'file_sha256':digest(raw),'file_bytes':len(raw),'header_bytes':h,'encrypted_bytes':n,'encryption_limit':limit,'clear_tail_bytes':len(body)-n,'zlib_unused_bytes':len(d.unused_data),'compressed_sha256':digest(compressed[:len(compressed)-len(d.unused_data)]),'expanded_sha256':digest(plain),'compressed_bytes':len(compressed)-len(d.unused_data),'expanded_bytes':len(plain),'expanded_prefix':plain[:24].hex()},compressed[:len(compressed)-len(d.unused_data)],plain

def groups(trace):
    result=[];active={}
    for line in (trace/'events.jsonl').read_text(encoding='utf-8').splitlines():
        rec=json.loads(line);m=rec.get('message',{}).get('payload',{})
        if m.get('kind')!='zlib':continue
        key=(m['fn'],m['stream']);g=active.get(key)
        if g is None or g['closed']:
            g={'function':m['fn'],'stream':m['stream'],'input':bytearray(),'output':bytearray(),'seqs':[],'closed':False,'complete_capture':True,'stack':m['stack']};active[key]=g;result.append(g)
        side=m['side'];expected=m['consumed'] if side=='input' else m['produced'];data=(trace/rec['blob']).read_bytes() if 'blob' in rec else b''
        if expected!=len(data):g['complete_capture']=False
        if rec.get('sha256') and digest(data)!=rec['sha256']:raise ValueError('Captured blob hash mismatch')
        g[side].extend(data);g['seqs'].append(rec['seq'])
        if side=='output' and m['ret']==1:g['closed']=True
    return result

def analyze(trace,files):
    containers=[decode(p)[0] for p in files];results=[]
    for g in groups(trace):
        inp=bytes(g.pop('input'));out=bytes(g.pop('output'));compressed,expanded=(inp,out) if g['function']=='inflate' else (out,inp)
        g.update(compressed_bytes=len(compressed),expanded_bytes=len(expanded),compressed_sha256=digest(compressed),expanded_sha256=digest(expanded),expanded_prefix=expanded[:24].hex())
        try:g['captured_transform_valid']=zlib.decompress(compressed)==expanded
        except zlib.error:g['captured_transform_valid']=False
        g['matches']=[c['path'] for c in containers if c['compressed_sha256']==g['compressed_sha256'] and c['expanded_sha256']==g['expanded_sha256']]
        results.append(g)
    return {'trace_dir':str(trace),'containers':containers,'streams':results,'matched_functions':sorted({x['function'] for x in results if x['matches'] and x['complete_capture'] and x['captured_transform_valid']})}

def main():
    p=argparse.ArgumentParser();p.add_argument('--trace',type=pathlib.Path,required=True);p.add_argument('--itl',type=pathlib.Path,action='append',required=True);p.add_argument('--out',type=pathlib.Path,required=True);p.add_argument('--require-both',action='store_true');a=p.parse_args()
    if a.out.exists():raise RuntimeError('Evidence output exists')
    result=analyze(a.trace,a.itl);a.out.write_text(json.dumps(result,indent=2),encoding='utf-8');print(json.dumps({'matched_functions':result['matched_functions'],'matching_streams':[s for s in result['streams'] if s['matches']],'container_count':len(result['containers'])},indent=2),flush=True)
    if a.require_both and result['matched_functions']!=['deflate','inflate']:raise RuntimeError('Both load and save correlations are required')
if __name__=='__main__':main()
