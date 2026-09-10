"""Read-only complete record capture for fresh native LE discovery oracles.
Capture is not a semantic acceptance gate. Unknown bytes remain unlabelled.
Metadata occurrences and physical member order are deliberately preserved.
"""
import hashlib
import pathlib
import native_oracle as n
import native_saved_audit as r

def digest(b):return hashlib.sha256(b).hexdigest()

def metadata(rec,h):
    return dict(tag=rec[:4].decode('ascii'),header_bytes=h,bytes=len(rec),type=r.number(rec,12) if rec[:4]==b'mhoh' else None,sha256=digest(rec),hex=rec.hex())

def capture(path):
    path=pathlib.Path(path);outer,plain=r.decode(path)
    result=dict(schema='itl4.raw-record-capture.v1',source=n.facts(path),outer_header_hex=outer[:r.number(outer,4,endian='big')].hex(),expanded_sha256=digest(plain),file_pid=f'{r.number(outer,0x34,8,"big"):016X}',sections=[],tracks={},playlists={},auxiliary={})
    for sec,h in r.frames(plain):
        r.need(sec[:4]==b'msdh' and h>=16,'Unverified section header')
        kind=r.number(sec,12);data=sec[h:]
        entry=dict(type=kind,bytes=len(sec),sha256=digest(sec),header_hex=sec[:h].hex())
        result['sections'].append(entry)
        if kind not in (1,2,9,11):
            entry['unclassified_payload_hex']=data.hex();continue
        tag={1:b'mlth',2:b'mlph',9:b'mlah',11:b'mlih'}[kind]
        r.need(data[:4]==tag and len(data)>=12,'Wrong known list')
        lh=r.number(data,4);r.need(12<=lh<=len(data),'Bad list boundary')
        rows=r.frames(data[lh:]);r.need(len(rows)==r.number(data,8),'List count mismatch')
        entry.update(list_header_hex=data[:lh].hex(),list_count=len(rows))
        for rec,rh in rows:
            children=r.children(rec,rh)
            if kind==1:
                r.need(rec[:4]==b'mith' and rh==756,'Unverified track capture header')
                pid=f'{r.number(rec,0x80,8):016X}'
                r.need(pid not in result['tracks'],'Duplicate track PID')
                result['tracks'][pid]=dict(header_hex=rec[:rh].hex(),record_sha256=digest(rec),local_id=r.number(rec,0x10),children=[metadata(c,ch) for c,ch in children])
            elif kind==2:
                r.need(rec[:4]==b'miph' and rh==3500,'Unverified playlist capture header')
                pid=f'{r.number(rec,0x1b8,8):016X}';r.need(pid not in result['playlists'],'Duplicate playlist PID')
                ordered=[]
                for c,ch in children:
                    item=metadata(c,ch)
                    if c[:4]==b'mtph':
                        r.need(ch>=0x4c,'Short mtph header')
                        item.update(header_hex=c[:ch].hex(),local_id=r.number(c,0x10),u32_14=r.number(c,0x14),track_ref_18=r.number(c,0x18),byte_1c=c[0x1c],item_pid=f'{r.number(c,0x44,8):016X}',children=[metadata(x,xh) for x,xh in r.children(c,ch)])
                    ordered.append(item)
                result['playlists'][pid]=dict(header_hex=rec[:rh].hex(),record_sha256=digest(rec),local_id=r.number(rec,0xd40),children=ordered)
            else:
                r.need(rh>=28,'Short auxiliary header')
                pid=f'{r.number(rec,20,8):016X}'
                result['auxiliary'].setdefault(str(kind),[]).append(dict(persistent_id=pid,local_id=r.number(rec,16),header_hex=rec[:rh].hex(),record_sha256=digest(rec),children=[metadata(c,ch) for c,ch in children]))
    return result

def header_differences(a,b):
    result={}
    for kind in ['tracks','playlists']:
        aa=a[kind];bb=b[kind];same=set(aa)&set(bb)
        result[kind]=dict(added=sorted(set(bb)-set(aa)),removed=sorted(set(aa)-set(bb)),shared_count=len(same),headers={})
        for pid in sorted(same):
            x=bytes.fromhex(aa[pid]['header_hex']);y=bytes.fromhex(bb[pid]['header_hex'])
            if len(x)!=len(y):result[kind]['headers'][pid]={'header_length_change':[len(x),len(y)]}
            else:
                changes=[dict(offset=i,before=u,after=v) for i,(u,v) in enumerate(zip(x,y)) if u!=v]
                if changes:result[kind]['headers'][pid]=changes
    return result
