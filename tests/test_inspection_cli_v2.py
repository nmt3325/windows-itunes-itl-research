"""Read-only CLI diagnostics; independent synthetic bytes, no native actions."""
import json
from pathlib import Path
import pytest
from itlkit import __main__ as cli
from itlkit.container import Container
from itlkit.library import Library
from test_core_support import library_bytes, playlist, u32

COMMANDS=('inspect-coverage','inspect-playlists')

@pytest.fixture
def closed(tmp_path):
    p=tmp_path/'closed library.itl'; data=library_bytes();p.write_bytes(data)
    return p,data,p.stat().st_mtime_ns

@pytest.mark.parametrize('command',COMMANDS)
def test_readonly_stdout_without_legacy_semantic_reader(command,closed,capsys,monkeypatch):
    p,data,mtime=closed
    def forbidden(*a,**k):raise AssertionError('diagnostic invoked semantic reader/rebuild')
    monkeypatch.setattr(Library,'read',forbidden)
    monkeypatch.setattr(Library,'to_bytes',forbidden)
    monkeypatch.setattr(Container,'to_bytes',forbidden)
    assert cli.main([command,str(p)])==0
    out=capsys.readouterr();value=json.loads(out.out);assert not out.err
    if command=='inspect-coverage':
        assert value['schema']=='itlkit.coverage.v1'
        assert value['profile_report']['blockers']
        assert value['totals']['record_count_including_outer']>1
    else:
        assert value['model']['schema']=='itlkit.playlist-models.v2'
        assert value['model']['semantic_write_level']=='none'
        assert value['model']['native_level']=='not-qualified'
    assert p.read_bytes()==data and p.stat().st_mtime_ns==mtime

@pytest.mark.parametrize('command',COMMANDS)
def test_output_new_and_existing_is_never_overwritten(command,closed,capsys):
    p,data,mtime=closed;out=p.with_suffix('.json')
    assert cli.main([command,str(p),'--output',str(out)])==0
    saved=out.read_bytes();json.loads(saved);om=out.stat().st_mtime_ns
    assert cli.main([command,str(p),'--output',str(out)])==2
    assert out.read_bytes()==saved and out.stat().st_mtime_ns==om
    assert p.read_bytes()==data and p.stat().st_mtime_ns==mtime
    assert not capsys.readouterr().out

@pytest.mark.parametrize('command',COMMANDS)
def test_same_input_output_refused_without_mutation(command,closed,capsys):
    p,data,mtime=closed
    assert cli.main([command,str(p),'--output',str(p)])==2
    assert p.read_bytes()==data and p.stat().st_mtime_ns==mtime
    assert not capsys.readouterr().out

@pytest.mark.parametrize('command',COMMANDS)
def test_file_budget_precedes_open(command,closed,monkeypatch,capsys):
    p,data,_=closed;real=Path.open
    def watched(self,*a,**k):
        if self==p:raise AssertionError('oversized input was opened')
        return real(self,*a,**k)
    with monkeypatch.context() as m:
        m.setattr(Path,'open',watched)
        assert cli.main([command,str(p),'--max-file-bytes',str(len(data)-1)])==2
    assert not capsys.readouterr().out
    assert p.read_bytes()==data

@pytest.mark.parametrize('command',COMMANDS)
def test_json_budget_creates_no_partial_file(command,closed,capsys):
    p,data,_=closed;out=p.with_suffix('.json')
    assert cli.main([command,str(p),'--max-json-bytes','1','--output',str(out)])==2
    assert not out.exists() and p.read_bytes()==data
    assert not capsys.readouterr().out

@pytest.mark.parametrize('command',COMMANDS)
@pytest.mark.parametrize('value',('0','-1',str(16*1024**2+1)))
def test_file_caps_only_reduce_defaults(command,value,closed,capsys):
    p,data,_=closed
    assert cli.main([command,str(p),'--max-file-bytes',value])==2
    assert p.read_bytes()==data and not capsys.readouterr().out

@pytest.mark.parametrize('command',COMMANDS)
def test_plain_budget_refuses_without_output(command,closed,capsys):
    p,data,_=closed
    assert cli.main([command,str(p),'--max-plain-bytes','1'])==2
    assert p.read_bytes()==data and not capsys.readouterr().out


def test_unknown_playlist_title_remains_local_diagnostic(tmp_path,capsys):
    rec=bytearray(playlist([1],name='Alpha'));u32(rec,3500+24,99)
    p=tmp_path/'unknown.itl';data=library_bytes(playlists=[bytes(rec)]);p.write_bytes(data)
    assert cli.main(['inspect-playlists',str(p)])==0
    doc=json.loads(capsys.readouterr().out)['model']
    rows=[v for section in doc['sections'] for v in section['playlists']]
    title=rows[0]['metadata'][0]
    assert title['encoding']==99 and title['text'] is None
    assert any(x['code']=='unknown_text_encoding' for x in title['diagnostics'])
    assert p.read_bytes()==data


def test_optional_raw_payload_is_one_exact_copy(closed,capsys):
    p,data,_=closed
    assert cli.main(['inspect-playlists',str(p),'--include-raw'])==0
    doc=json.loads(capsys.readouterr().out)
    assert bytes.fromhex(doc['payload_hex'])==Container.from_bytes(data).payload
    assert doc['payload_base_offset']==0
    assert p.read_bytes()==data

@pytest.mark.parametrize('command',COMMANDS)
def test_big_endian_is_opaque_not_semantic_success(command,closed,capsys):
    p,data,_=closed;changed=bytearray(data);changed[0x52]=0;p.write_bytes(changed)
    assert cli.main([command,str(p)])==0
    result=json.loads(capsys.readouterr().out)
    if command=='inspect-playlists':
        assert result['model']['byteorder']=='big'
        assert any(d['code']=='inner_endian' for d in result['model']['diagnostics'])
    else:
        assert result['profile_report']['endian']=='big'
        assert result['profile_report']['blockers']
    assert p.read_bytes()==changed
