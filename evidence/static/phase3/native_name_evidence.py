from pathlib import Path
import json,hashlib,runpy,zlib,datetime
from Crypto.Cipher import AES
ROOT=Path(r'D:\a\_temp\gha-mcp\WINDOWS_RESEARCH_RUN\work\itl');OUT=ROOT/'reports/static/phase3'
# The previously read source has a main guard. Loading this name invokes no census or write.
mod=runpy.run_path(str(ROOT/'reports/static/phase2/census_snapshots.py'),run_name='phase2_readonly_helpers')
sha=lambda b:hashlib.sha256(b).hexdigest()
def load(name):
    p=ROOT/'fixtures/dynamic/snapshots'/name;r=mod['inspect'](p);raw=p.read_bytes();h=int.from_bytes(raw[4:8],'big');b=raw[h:]
    n=(0 if raw[0x41]==0 else len(b) if raw[0x41]==1 else min(len(b),int.from_bytes(raw[0x5c:0x60],'big')))&~15
    plain=AES.new(b'BHUILuilfghuila3',AES.MODE_ECB).decrypt(b[:n])+b[n:]
    if raw[0x43]:
        z=zlib.decompressobj();plain=z.decompress(plain,64*1024*1024+1);assert z.eof and not z.unconsumed_tail and len(plain)<=64*1024*1024
    assert sha(plain)==r['plaintext_sha256']
    tracks=[]
    for t in r['records']:
        if t['tag']!='mith':continue
        off=t['offset'];hdr=plain[off:off+t['header_length']];mh=[]
        for m in r['mhoh']:
            if m['parent_tag']=='mith' and m['record_offset']==off:
                data=plain[m['offset']:m['offset']+m['total_length']]
                mh.append({'type':m['type'],'external_id':m['atom_id'],'encoding':m.get('encoding'),'length':m.get('length'),'whole_mhoh_sha256':sha(data),'payload_sha256':m.get('data_sha256')})
        tracks.append({'track_pid':t['track_pid'],'header_sha256':sha(hdr),'header_hex':hdr.hex(),'flag6d':hdr[0x6d],'rank290':int.from_bytes(hdr[0x290:0x294],r['inner_endian']),'mhoh':mh})
    assert sha(p.read_bytes())==r['sha256']
    return {'path':r['path'],'sha256':r['sha256'],'version':r['version'],'tracks':tracks}
a=load('003-three-tracks-reloaded.itl');b=load('010-name-unicode.itl');diffs=[]
for x,y in zip(a['tracks'],b['tracks']):
    assert x['track_pid']==y['track_pid'];hx=bytes.fromhex(x['header_hex']);hy=bytes.fromhex(y['header_hex']);assert len(hx)==len(hy)
    changes=[{'offset':hex(i),'before':v,'after':hy[i]} for i,v in enumerate(hx) if v!=hy[i]]
    xm={m['type']:m for m in x['mhoh']};ym={m['type']:m for m in y['mhoh']}
    assert len(xm)==len(x['mhoh']) and len(ym)==len(y['mhoh'])
    diffs.append({'track_pid':x['track_pid'],'header_byte_changes':changes,'flag6d':[x['flag6d'],y['flag6d']],'rank290':[x['rank290'],y['rank290']],'mhoh_changes':[{'type':t,'before':xm.get(t),'after':ym.get(t)} for t in sorted(set(xm)|set(ym)) if xm.get(t)!=ym.get(t)],'unchanged_mhoh_types':[t for t in sorted(set(xm)&set(ym)) if xm[t]==ym[t]]})
for v in [a,b]:
    for t in v['tracks']:del t['header_hex']
# Mathematical equivalence of the exact reader/writer bit extraction (not native execution).
for wire in range(256):
    for flags in range(256):
        nflags=(flags&0xef)|((wire&1)<<4)
        assert (nflags&0xef)==(flags&0xef)
        assert ((nflags>>4)&1)==(wire&1)
report={'captured_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'scope':'Two previously pinned native saved synthetic snapshots, read-only; no iTunes execution and no factorial candidates.','inputs':[a,b],'diffs':diffs,'bit_mapping_model_checks':65536,'bit_check_scope':'Pure Python transcription of confirmed C/ASM bit operations, not original-code emulation or native acceptance.','causal_limit':'Native snapshot changes co-vary; this pair alone cannot identify the cause of a separate Fresh rollback.'}
(OUT/'native-name-diff.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps({'input_hashes':[(v['path'],v['sha256']) for v in [a,b]],'diffs':diffs,'bit_mapping_model_checks':65536},indent=2))
