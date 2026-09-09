import json
from pathlib import Path
import pytest
from itlkit import Library
from itlkit.__main__ import main
from test_core_support import library_bytes


def test_cli_full_roundtrip_patch_and_refuse_overwrite(tmp_path,capsys):
    source=tmp_path/'in.itl';source.write_bytes(library_bytes())
    assert main(['check',str(source)])==0
    assert '"noop_bit_exact": true' in capsys.readouterr().out
    plain=tmp_path/'plain.raw'
    assert main(['decode',str(source),str(plain)])==0
    encoded=tmp_path/'encoded.itl'
    assert main(['encode',str(source),str(plain),str(encoded)])==0
    assert Library.read(encoded).summary()==Library.read(source).summary()
    for rebuild in [False,True]:
        out=tmp_path/f'rt-{rebuild}.itl'
        args=['roundtrip',str(source),str(out)]+(['--rebuild'] if rebuild else [])
        assert main(args)==0
        if not rebuild:assert out.read_bytes()==source.read_bytes()
    doc=tmp_path/'lib.json';again=tmp_path/'again.itl'
    assert main(['export-json',str(source),str(doc)])==0
    assert main(['import-json',str(doc),str(again)])==0
    assert again.read_bytes()==source.read_bytes()
    patch=tmp_path/'ops.json';patch.write_text(json.dumps([{'op':'set_track','track_id':1,'fields':{'rating':60,'name':'hello'}}]),encoding='utf8')
    changed=tmp_path/'changed.itl'
    assert main(['patch',str(source),str(patch),str(changed)])==0
    assert Library.read(changed).tracks[0].get('rating')==60
    assert main(['roundtrip',str(source),str(source)])==2
    assert source.read_bytes()==library_bytes()
    summary=tmp_path/'summary.json'
    assert main(['inspect',str(source),'--output',str(summary)])==0
    assert len(json.loads(summary.read_text())['tracks'])==1


def test_cli_errors(tmp_path,capsys):
    bad=tmp_path/'bad.itl';bad.write_bytes(b'bad')
    assert main(['inspect',str(bad)])==2
    assert 'itlkit:' in capsys.readouterr().err
    with pytest.raises(SystemExit) as ex:main(['--help'])
    assert ex.value.code==0
    source=tmp_path/'in.itl';source.write_bytes(library_bytes());p=tmp_path/'ops.json';p.write_text('[{"op":"unknown"}]')
    out=tmp_path/'not-created.itl'
    assert main(['patch',str(source),str(p),str(out)])==2
    assert not out.exists()