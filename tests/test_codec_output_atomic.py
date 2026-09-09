"""Publication failure boundaries and alias/racing-writer protections."""
from pathlib import Path
import errno
from concurrent.futures import ThreadPoolExecutor
from threading import Barrier
import pytest
import itlkit.io as output
from itlkit.binary import put,uint
from itlkit import Library
from test_codec_tracks import profile,pid


@pytest.mark.parametrize('alias',['hardlink','symlink','dangling'])
def test_existing_alias_is_never_replaced(alias,tmp_path):
    source=tmp_path/'original';source.write_bytes(b'original')
    destination=tmp_path/'alias'
    if alias=='hardlink':output.os.link(source,destination)
    else:
        try:destination.symlink_to(source if alias=='symlink' else tmp_path/'missing')
        except OSError as exc:pytest.skip(f'host cannot create test symlink: {exc}')
    with pytest.raises(FileExistsError):output.write_new(destination,b'overwrite')
    assert source.read_bytes()==b'original' and output.os.path.lexists(destination)
    assert len(list(tmp_path.iterdir()))==2


def test_two_concurrent_publishers_never_merge_or_replace(tmp_path,monkeypatch):
    barrier=Barrier(2);real=output.os.link;dest=tmp_path/'out'
    def link(source,target):barrier.wait(timeout=5);real(source,target)
    monkeypatch.setattr(output.os,'link',link)
    def write(payload):
        try:output.write_new(dest,payload);return 'published'
        except FileExistsError:return 'exists'
    with ThreadPoolExecutor(max_workers=2) as workers:
        results=list(workers.map(write,[b'A'*100000,b'B'*100000]))
    assert sorted(results)==['exists','published']
    assert dest.read_bytes() in (b'A'*100000,b'B'*100000)
    assert [p.name for p in tmp_path.iterdir()]==['out']


@pytest.mark.parametrize('stage',['fdopen','close'])
def test_stream_setup_or_close_failure_precedes_publication(stage,tmp_path,monkeypatch):
    real=output.os.fdopen;dest=tmp_path/'out'
    class Stream:
        def __init__(self,inner):self.inner=inner
        def __getattr__(self,key):return getattr(self.inner,key)
        def __enter__(self):return self
        def __exit__(self,*exc):self.inner.close();raise OSError(errno.EIO,'close failure')
    def failing(*a,**k):
        if stage=='fdopen':raise OSError(errno.EIO,'fdopen failure')
        return Stream(real(*a,**k))
    monkeypatch.setattr(output.os,'fdopen',failing)
    with pytest.raises(OSError):output.write_new(dest,b'complete data')
    assert list(tmp_path.iterdir())==[]


@pytest.mark.parametrize('after_publish',[False,True])
def test_cleanup_failure_reports_unambiguous_destination_state(after_publish,tmp_path,monkeypatch):
    dest=tmp_path/'out';payload=b'complete payload';real=Path.unlink
    def unlink(path,*a,**k):
        if '.itlkit-' in path.name:raise PermissionError('injected cleanup failure')
        return real(path,*a,**k)
    with monkeypatch.context() as m:
        m.setattr(Path,'unlink',unlink)
        if not after_publish:
            def fail(stream,data):stream.write(data[:4]);raise OSError(errno.ENOSPC,'injected write failure')
            m.setattr(output,'_write_payload',fail)
        with pytest.raises(OSError) as exc:output.write_new(dest,payload)
        if after_publish:
            assert 'complete output was published' in str(exc.value)
            assert dest.read_bytes()==payload
        else:
            assert exc.value.errno==errno.ENOSPC and not dest.exists()
            assert any('cleanup also failed' in s for s in getattr(exc.value,'__notes__',[]))
    temporary=list(tmp_path.glob('*.tmp'));assert len(temporary)==1
    temporary[0].unlink()


def test_known_independent_self_identity_does_not_block_track_delete():
    lib=profile();wanted=pid(lib,1)
    put(lib._root(11).children[1].header,20,wanted,8)
    lib.delete_track(wanted)
    assert len(Library.from_bytes(lib.to_bytes()).tracks)==2
    assert uint(lib._root(11).children[0].header,20,8)==wanted


def test_equal_auxiliary_text_does_not_discard_distinct_retained_header_state():
    lib=profile();put(lib._root(9).children[1].header,40,0x12345678)
    lib.tracks[0].set(album='Album 2',artist='Artist 2')
    t=lib.tracks[0];album=next(n for n in lib._root(9).children if uint(n.header,16)==t.get('album_id'))
    assert t.get('album_id')!=102 and uint(album.header,40)==0x2000
    assert uint(next(n for n in lib._root(9).children if uint(n.header,16)==102).header,40)==0x12345678
