import pytest
from itlkit import Library,Node,UnsupportedError
from itlkit.binary import put
from itlkit.__main__ import main
from test_codec_tracks import profile,pid

@pytest.mark.parametrize('value',[True,False,1.0,'1',0,-1,2**32])
def test_strict_local_track_selector(value):
    with pytest.raises(ValueError):profile().track(track_id=value)

@pytest.mark.parametrize('value',[True,False,1.0,0,-1,2**64,'ABC','zzzzzzzzzzzzzzzz','0123456789ABCDE '])
def test_strict_persistent_selector(value):
    lib=profile()
    with pytest.raises(ValueError):lib.track(persistent_id=value)
    with pytest.raises(ValueError):lib.playlist(value)

@pytest.mark.parametrize('action',['set_track','rename_playlist','create_playlist','delete_playlist','replace_playlist_members','delete_track'])
def test_unknown_operation_keys_are_rejected_atomically(action):
    lib=profile();before=lib.to_bytes()
    with pytest.raises(ValueError):lib.apply_operations([{'op':action,'misspelled_option':1}])
    assert lib.to_bytes()==before

@pytest.mark.parametrize('action',[False,[],{},None,'unknown'])
def test_malformed_operation_names(action):
    with pytest.raises(ValueError):profile().apply_operations([{'op':action}])


def test_opaque_file_location_blocks_url_only_relocation():
    lib=profile();track=lib.tracks[0]
    h=bytearray(24);h[:4]=b'mhoh';put(h,4,24);put(h,8,32);put(h,12,1)
    track.node.children.append(Node(h,payload=b'opaque00'))
    before=lib.to_bytes()
    with pytest.raises(UnsupportedError,match='file-location'):track.set(url='file:///different.wav')
    assert lib.to_bytes()==before
    track.set(url=track.get('url'))


def test_cli_track_restore(tmp_path):
    source=tmp_path/'source.itl';donor=tmp_path/'donor.itl';out=tmp_path/'out.itl'
    first=profile((1,));three=profile();p=pid(three,2)
    first.write(source);three.write(donor)
    assert main(['import-track',str(source),str(donor),f'{p:016X}',str(out)])==0
    assert len(Library.read(out).tracks)==2
    assert len(Library.read(source).tracks)==1
    assert main(['import-track',str(source),str(donor),f'{p:016X}',str(out)])==2