import dataclasses
import pytest
from itlkit.schema import (ReadLimits, LimitError, ProfileReport, FieldSpec, ByteSpan,
    ScopedID, AllocationReservation, AllocationLedger, ReferenceGraph, Blocker,
    encode_json, load_library, preflight_payload, read_bytes)
from itlkit.container import Container
from test_core_support import library_bytes, section, record, pack


def test_defaults_and_legacy_cap_separate():
    from itlkit.container import DEFAULT_MAX_PLAIN_BYTES
    limits=ReadLimits()
    assert limits.max_file_bytes==limits.max_plain_bytes==16*1024**2
    assert limits.memory_budget_bytes==DEFAULT_MAX_PLAIN_BYTES==512*1024**2
    assert limits.max_nodes==100000 and limits.max_depth==32
    assert limits.max_text_bytes==4*1024**2 and limits.max_json_bytes==64*1024**2


@pytest.mark.parametrize('name',[f.name for f in dataclasses.fields(ReadLimits)])
@pytest.mark.parametrize('value',[0,-1,True,1.5,'1'])
def test_invalid_limits(name,value):
    with pytest.raises(ValueError):ReadLimits(**{name:value})


def test_records_are_defensive_and_reports_detached():
    original={'matched':['one']}
    graph=ReferenceGraph(coverage=original)
    original['matched'].append('two')
    assert graph.coverage['matched']==('one',)
    with pytest.raises(TypeError):graph.coverage['x']=1
    report=graph.to_dict();report['matched']=False
    assert graph.coverage['matched']==('one',)
    assert ProfileReport(blockers=[Blocker('unknown','opaque')]).blocked


def test_scopes_and_ledger_capacity_are_explicit():
    a=ScopedID('track.pid','library-A',7,8);b=ScopedID('album.pid','library-A',7,8)
    assert a!=b
    r=AllocationReservation(a.namespace,a.scope,None,a,['track'],{'passed':True,'upper':2**64-1})
    ledger=AllocationLedger([r]);assert tuple(ledger)==(r,)
    with pytest.raises(ValueError):AllocationLedger([r,r])
    with pytest.raises(ValueError):AllocationReservation(b.namespace,b.scope,None,a,[],{'passed':True})
    with pytest.raises(ValueError):AllocationReservation(a.namespace,a.scope,None,a,[],{'passed':False})
    with pytest.raises(ValueError):ScopedID('track.pid','library-A',True,8)


def test_field_evidence_is_not_automatic_write_permission():
    f=FieldSpec('mith',1,'observed',756,0x6d,1,'little',1,None,
        'partial-bit','none',('library.py',),(ByteSpan(110,112),), 'name_refresh')
    assert f.signedness_or_mask==1 and f.write_level=='none'
    with pytest.raises(ValueError):dataclasses.replace(f,evidence_refs=())
    with pytest.raises(ValueError):dataclasses.replace(f,opaque_ranges=(ByteSpan(750,757),))


def test_bounded_reader_normal_and_limits(tmp_path):
    data=library_bytes();path=tmp_path/'input.itl';path.write_bytes(data)
    assert read_bytes(path)==data and load_library(data).tracks[0].track_id==1
    for kwargs in ({'max_file_bytes':len(data)-1},{'max_plain_bytes':32},
                   {'max_nodes':3},{'max_text_bytes':8},{'memory_budget_bytes':64},{'max_depth':1}):
        with pytest.raises(ValueError):load_library(data,limits=ReadLimits(**kwargs))
    with pytest.raises(LimitError):read_bytes(path,limits=ReadLimits(max_file_bytes=1))
    with pytest.raises(TypeError):load_library(bytearray(data))


def test_unknown_payload_not_tag_scanned():
    c=Container.from_bytes(pack(section(250,b'mith miph msdh'*20)))
    assert preflight_payload(c.payload)['nodes']==1


def test_json_budget_and_nan():
    assert encode_json({'x':'日本語'})==b'{"x":"\\u65e5\\u672c\\u8a9e"}'
    with pytest.raises(LimitError):encode_json({'x':'x'*20},limits=ReadLimits(max_json_bytes=10))
    with pytest.raises(ValueError):encode_json({'x':float('nan')})
    with pytest.raises(ValueError):ReadLimits(max_depth=33)
    cyclic=[];cyclic.append(cyclic)
    with pytest.raises(ValueError,match='cyclic'):encode_json(cyclic)
    deep=[];v=deep
    for _ in range(120):v.append([]);v=v[0]
    with pytest.raises(ValueError,match='nesting'):encode_json(deep)


# New G2 schema-budget cases, not recovery of the missing b985 tests.
def _g2_sb_facts(path):
    import hashlib
    s=path.stat()
    return (hashlib.sha256(path.read_bytes()).hexdigest(),s.st_size,s.st_mtime_ns)


def test_g2_schema_budget_red_read_memory(tmp_path, monkeypatch, capsys, record_property):
    from pathlib import Path
    import json
    data=library_bytes(); assert len(data)==486
    p=tmp_path/'input.itl';p.write_bytes(data);before=_g2_sb_facts(p)
    real=Path.open;opened=[];output=None;error=None
    def seen(self,*a,**k):
        if self==p:opened.append((a,k))
        return real(self,*a,**k)
    with monkeypatch.context() as m:
        m.setattr(Path,'open',seen)
        try:output=read_bytes(p,limits=ReadLimits(memory_budget_bytes=1))
        except LimitError as exc:error=exc
    record_property('observation',json.dumps({'opened':len(opened),'returned_bytes':len(output) if output is not None else None,'error':str(error)}))
    assert _g2_sb_facts(p)==before and set(tmp_path.iterdir())=={p}
    assert capsys.readouterr()==('','')
    assert isinstance(error,LimitError) and output is None and not opened


def test_g2_schema_budget_red_read_extent(tmp_path, monkeypatch, record_property):
    import contextlib,json
    from pathlib import Path
    p=tmp_path/'tiny.bin';p.write_bytes(b'abc');before=_g2_sb_facts(p)
    real=Path.open;requests=[]
    class Seen:
        def __init__(self,f):self.f=f
        def fileno(self):return self.f.fileno()
        def read(self,n):requests.append(n);return self.f.read(n)
    @contextlib.contextmanager
    def opened(self,*a,**k):
        with real(self,*a,**k) as f:yield Seen(f) if self==p else f
    with monkeypatch.context() as m:
        m.setattr(Path,'open',opened)
        assert read_bytes(p,limits=ReadLimits(max_file_bytes=16*1024**2,memory_budget_bytes=24))==b'abc'
    record_property('read_requests',json.dumps(requests))
    assert _g2_sb_facts(p)==before
    assert requests and all(0<=n<=4 for n in requests)


def test_g2_schema_budget_red_decompression(monkeypatch, tmp_path, capsys, record_property):
    import json
    import itlkit.schema as schema
    import itlkit.container as core
    data=library_bytes(opaque=b'Z'*(512*1024));assert len(data)==1046
    p=tmp_path/'compressed.itl';p.write_bytes(data);before=_g2_sb_facts(p)
    budget=6*len(data)+4096;assert budget==10372
    cap_calls=[];allocations=[];returned=[];error=None
    original=Container.from_bytes;decompressobj=core.zlib.decompressobj
    class Seen:
        def __init__(self):self.inner=decompressobj()
        def decompress(self,b,n):
            result=self.inner.decompress(b,n);allocations.append((n,len(result)));return result
        def __getattr__(self,k):return getattr(self.inner,k)
    def observe(*a,**k):
        cap_calls.append(k['max_plain_bytes']);c=original(*a,**k);returned.append(len(c.payload));return c
    with monkeypatch.context() as m:
        m.setattr(Container,'from_bytes',observe);m.setattr(core.zlib,'decompressobj',Seen)
        try:schema.load_container(data,limits=ReadLimits(memory_budget_bytes=budget))
        except (schema.FormatError,LimitError) as exc:error=exc
    record_property('observation',json.dumps({'budget':budget,'caps':cap_calls,'inflations':allocations,'completed_payloads':returned,'error':str(error)}))
    assert _g2_sb_facts(p)==before and set(tmp_path.iterdir())=={p}
    assert capsys.readouterr()==('','') and error is not None
    assert cap_calls and max(cap_calls)<=681 and allocations and max(n for _,n in allocations)<=682 and not returned


def test_g2_schema_budget_red_json_key(monkeypatch, tmp_path, capsys, record_property):
    import json,pickle
    value={'K'*20000:0};before=pickle.dumps(value,protocol=4)
    real=json.encoder.encode_basestring_ascii;calls=[];error=None;output=None
    def observe(v):
        result=real(v);calls.append((len(v),len(result)));return result
    with monkeypatch.context() as m:
        m.setattr(json.encoder,'encode_basestring_ascii',observe)
        try:output=encode_json(value,limits=ReadLimits(max_json_bytes=16,memory_budget_bytes=4096))
        except LimitError as exc:error=exc
    record_property('observation',json.dumps({'encoded_strings':calls,'error':str(error)}))
    assert before==pickle.dumps(value,protocol=4) and not list(tmp_path.iterdir())
    assert capsys.readouterr()==('','') and error is not None and output is None
    assert not calls


@pytest.mark.parametrize('size',[0,1,3,486])
def test_g2_schema_budget_read_boundary(size,tmp_path,monkeypatch):
    from pathlib import Path
    data=b'x'*size;p=tmp_path/'small.bin';p.write_bytes(data);before=_g2_sb_facts(p)
    assert read_bytes(p,limits=ReadLimits(memory_budget_bytes=6*(size+1)))==data
    def forbidden(*a,**k):raise AssertionError('open reached after insufficient memory')
    with monkeypatch.context() as m:
        m.setattr(Path,'open',forbidden)
        with pytest.raises(LimitError):read_bytes(p,limits=ReadLimits(memory_budget_bytes=6*(size+1)-1))
    assert _g2_sb_facts(p)==before


@pytest.mark.parametrize('compression',[0,1,6])
@pytest.mark.parametrize('payload',[b'',b'x',b'ABC'*128])
def test_g2_schema_budget_container_boundary(compression,payload,monkeypatch):
    from itlkit.schema import load_container
    data=pack(payload,encryption=0,compression=compression)
    needed=max(1,len(payload));budget=6*len(data)+6*(needed+1)
    limits=ReadLimits(memory_budget_bytes=budget,max_plain_bytes=needed)
    c=load_container(data,limits=limits)
    assert c.payload==payload and c.to_bytes()==data
    if len(payload)>1:
        with pytest.raises(ValueError):load_container(data,limits=dataclasses.replace(limits,memory_budget_bytes=budget-6))
        with pytest.raises(ValueError):load_container(data,limits=dataclasses.replace(limits,max_plain_bytes=len(payload)-1))
    def forbidden(*a,**k):raise AssertionError('Container called without memory headroom')
    with monkeypatch.context() as m:
        m.setattr(Container,'from_bytes',forbidden)
        with pytest.raises(LimitError):load_container(data,limits=dataclasses.replace(limits,memory_budget_bytes=6*len(data)))


@pytest.mark.parametrize('where',['key','value'])
@pytest.mark.parametrize('dimension',['text','json','memory'])
@pytest.mark.parametrize('token',['x','日本語','\U0001f9ea','\x00"\\'])
def test_g2_schema_budget_strings_precede_encoder(where,dimension,token,monkeypatch):
    import json,pickle
    s=token*200;value={s:0} if where=='key' else {'k':s};before=pickle.dumps(value)
    kwargs={'text':{'max_text_bytes':16},'json':{'max_json_bytes':16},'memory':{'memory_budget_bytes':1024}}[dimension]
    def forbidden(*a,**k):raise AssertionError('encoder reached before string budget refusal')
    with monkeypatch.context() as m:
        m.setattr(json.encoder,'encode_basestring_ascii',forbidden)
        with pytest.raises(LimitError):encode_json(value,limits=ReadLimits(**kwargs))
    assert pickle.dumps(value)==before


@pytest.mark.parametrize('token',['','a','é','日本語','\U0001f9ea','\x00\b\f\n\r\t"\\','\x7f','e\u0301','\ud800'])
@pytest.mark.parametrize('where',['key','value'])
def test_g2_schema_budget_unicode_boundary(token,where,monkeypatch):
    import json
    value={token:0} if where=='key' else {'k':token}
    expected=json.dumps(value,ensure_ascii=True,allow_nan=False,sort_keys=True,separators=(',',':')).encode('ascii')
    text_size=sum(len(s.encode('utf-8','surrogatepass')) for s in ([token] if where=='key' else ['k',token]))
    limits=ReadLimits(max_json_bytes=len(expected),max_text_bytes=max(1,text_size))
    assert encode_json(value,limits=limits)==expected
    def forbidden(*a,**k):raise AssertionError('encoder reached at undersized exact boundary')
    with monkeypatch.context() as m:
        m.setattr(json.encoder,'encode_basestring_ascii',forbidden)
        with pytest.raises(LimitError):encode_json(value,limits=dataclasses.replace(limits,max_json_bytes=len(expected)-1))
        if text_size>1:
            with pytest.raises(LimitError):encode_json(value,limits=dataclasses.replace(limits,max_text_bytes=text_size-1))


def test_g2_schema_budget_aggregate_strings_and_record_keys(monkeypatch):
    import json
    value={'a':'x'*8,'b':['y'*8]}
    @dataclasses.dataclass(frozen=True)
    class Description:
        long_field_name:str='v'
    def forbidden(*a,**k):raise AssertionError('encoder reached before aggregate/key refusal')
    with monkeypatch.context() as m:
        m.setattr(json.encoder,'encode_basestring_ascii',forbidden)
        with pytest.raises(LimitError):encode_json(value,limits=ReadLimits(max_text_bytes=17))
        with pytest.raises(LimitError):encode_json(Description(),limits=ReadLimits(max_text_bytes=4))
        with pytest.raises(LimitError):encode_json({'a':list(range(32))},limits=ReadLimits(max_nodes=1))
    assert encode_json({'a':[1,True,None,-0.0]})==b'{"a":[1,true,null,-0.0]}'


@pytest.mark.parametrize('when',['before_open','after_close'])
def test_g2_schema_budget_same_size_same_mtime_replacement(when,tmp_path,monkeypatch):
    import contextlib,os
    from pathlib import Path
    a=tmp_path/'a';b=tmp_path/'b';old=tmp_path/'old'
    a.write_bytes(b'AAA');b.write_bytes(b'BBB');st=a.stat();os.utime(b,ns=(st.st_atime_ns,st.st_mtime_ns))
    real=Path.open;reads=[]
    def swap():a.rename(old);b.rename(a)
    class Seen:
        def __init__(self,f):self.f=f
        def fileno(self):return self.f.fileno()
        def read(self,n):reads.append(n);return self.f.read(n)
    @contextlib.contextmanager
    def opened(self,*args,**kwargs):
        if self!=a:
            with real(self,*args,**kwargs) as f:yield f
            return
        if when=='before_open':swap()
        with real(self,*args,**kwargs) as f:yield Seen(f)
        if when=='after_close':swap()
    try:
        with monkeypatch.context() as m:
            m.setattr(Path,'open',opened)
            with pytest.raises(ValueError,match='input changed'):read_bytes(a)
        assert a.read_bytes()==b'BBB' and old.read_bytes()==b'AAA'
        if when=='before_open':assert not reads
        else:assert reads==[4]
    finally:
        if old.exists():a.rename(b);old.rename(a)
    assert a.read_bytes()==b'AAA' and b.read_bytes()==b'BBB'


@pytest.mark.parametrize('change',['grow','shrink'])
def test_g2_schema_budget_file_growth_or_shrink(change,tmp_path,monkeypatch):
    import contextlib
    from pathlib import Path
    p=tmp_path/'input';p.write_bytes(b'abc');real=Path.open;requests=[]
    class Seen:
        def __init__(self,f):self.f=f
        def fileno(self):return self.f.fileno()
        def read(self,n):
            requests.append(n)
            with real(p,'r+b',buffering=0) as other:
                if change=='grow':other.seek(0,2);other.write(b'x'*10000)
                else:other.truncate(1)
            return self.f.read(n)
    @contextlib.contextmanager
    def opened(self,*a,**k):
        with real(self,*a,**k) as f:yield Seen(f) if self==p else f
    with monkeypatch.context() as m:
        m.setattr(Path,'open',opened)
        with pytest.raises(ValueError,match='input changed'):read_bytes(p)
    assert requests==[4] and p.stat().st_size==(10003 if change=='grow' else 1)


@pytest.mark.parametrize('change',['inode','device','size','mtime','ctime','mode'])
def test_g2_schema_budget_fstat_after_read_checks_identity(change,tmp_path,monkeypatch):
    import os
    from types import SimpleNamespace
    import itlkit.schema as schema
    p=tmp_path/'input';p.write_bytes(b'abc');before=_g2_sb_facts(p);real=os.fstat;calls=[]
    attrs=['st_dev','st_ino','st_size','st_mtime_ns','st_ctime_ns','st_mode']
    chosen={'inode':'st_ino','device':'st_dev','size':'st_size','mtime':'st_mtime_ns','ctime':'st_ctime_ns','mode':'st_mode'}[change]
    def observed(fd):
        s=real(fd);calls.append(1)
        if len(calls)==2:
            fields={k:getattr(s,k) for k in attrs};fields[chosen]+=1;return SimpleNamespace(**fields)
        return s
    with monkeypatch.context() as m:
        m.setattr(schema.os,'fstat',observed)
        with pytest.raises(ValueError,match='input changed'):read_bytes(p)
    assert len(calls)==2 and _g2_sb_facts(p)==before


def test_g2_schema_budget_prepare_never_calls_engine_for_oversized_key(monkeypatch):
    import pickle
    from itlkit.planning import prepare_mutation
    data=library_bytes();intent={'K'*20000:0};before=pickle.dumps(intent)
    def forbidden(*a,**k):raise AssertionError('trusted engine callback reached')
    with pytest.raises(LimitError):
        prepare_mutation('new-budget-test',data,intent,build=forbidden,validate=forbidden,
                         limits=ReadLimits(max_json_bytes=16))
    assert pickle.dumps(intent)==before



def test_g2_schema_budget_closed_file_stat_clocks(tmp_path):
    import time
    p=tmp_path/'closed';p.write_bytes(b'abc');time.sleep(0.02);p.write_bytes(b'abc')
    before=_g2_sb_facts(p)
    assert read_bytes(p)==b'abc'
    assert _g2_sb_facts(p)==before


@pytest.mark.parametrize('restore',[False,True])
def test_g2_schema_budget_same_size_mtime_inplace_aba(restore,tmp_path,monkeypatch):
    import contextlib,os,time
    from pathlib import Path
    p=tmp_path/'aba';p.write_bytes(b'AAA');st=p.stat();real=Path.open;seen=[]
    class Seen:
        def __init__(self,f):self.f=f
        def fileno(self):return self.f.fileno()
        def read(self,n):
            seen.append(n);time.sleep(0.01)
            with real(p,'r+b',buffering=0) as other:other.write(b'BBB')
            os.utime(p,ns=(st.st_atime_ns,st.st_mtime_ns))
            result=self.f.read(n)
            if restore:
                with real(p,'r+b',buffering=0) as other:other.write(b'AAA')
                os.utime(p,ns=(st.st_atime_ns,st.st_mtime_ns))
            return result
    @contextlib.contextmanager
    def opened(self,*a,**k):
        with real(self,*a,**k) as f:yield Seen(f) if self==p else f
    with monkeypatch.context() as m:
        m.setattr(Path,'open',opened)
        with pytest.raises(ValueError,match='input changed'):read_bytes(p)
    assert seen==[4] and p.read_bytes()==(b'AAA' if restore else b'BBB')
    final=p.stat();assert (st.st_size,st.st_ino,st.st_mtime_ns)==(final.st_size,final.st_ino,final.st_mtime_ns)


def test_g2_schema_budget_final_path_missing(tmp_path,monkeypatch):
    import contextlib
    from pathlib import Path
    p=tmp_path/'gone';p.write_bytes(b'abc');real=Path.open
    @contextlib.contextmanager
    def opened(self,*a,**k):
        with real(self,*a,**k) as f:yield f
        if self==p:p.unlink()
    with monkeypatch.context() as m:
        m.setattr(Path,'open',opened)
        with pytest.raises(ValueError,match='input changed after read'):read_bytes(p)
    assert not p.exists()
