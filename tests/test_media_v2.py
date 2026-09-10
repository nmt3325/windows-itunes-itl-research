from dataclasses import FrozenInstanceError
import io
import struct
import wave

import pytest
from itlkit.media import MediaError, probe_bytes, probe_file, limit_value


def pcm(frames=60000, rate=48000, channels=1, bits=16, sample=0):
    stream = io.BytesIO()
    with wave.open(stream, 'wb') as out:
        out.setnchannels(channels)
        out.setsampwidth(bits // 8)
        out.setframerate(rate)
        out.writeframes(bytes([sample]) * (frames * channels * bits // 8))
    return stream.getvalue()


@pytest.mark.parametrize('rate,frames,channels,bits', [(48000,60000,1,16),(44100,11025,1,16),(48000,18000,2,16),(8000,1000,1,8),(22050,1000,1,24),(48000,100,2,32)])
def test_pcm_dimensions(rate, frames, channels, bits):
    data = pcm(frames, rate, channels, bits)
    facts = probe_bytes(data)
    assert (facts.sample_rate, facts.frames, facts.channels, facts.bits_per_sample) == (rate, frames, channels, bits)
    assert facts.exact_pcm_milliseconds == frames * 1000 // rate
    assert facts.bitrate_bps == rate * channels * bits
    assert len(data) == facts.size_bytes
    with pytest.raises(FrozenInstanceError):
        facts.frames = 0


def test_aiff():
    rate, frames = 22050, 4410
    exp = rate.bit_length() - 1
    comm = struct.pack('>HIHHQ', 1, frames, 16, exp + 16383, rate << (63 - exp))
    sound = b'\0' * (8 + frames * 2)
    body = b'AIFF' + b'COMM' + struct.pack('>I', len(comm)) + comm + b'SSND' + struct.pack('>I', len(sound)) + sound
    facts = probe_bytes(b'FORM' + struct.pack('>I', len(body)) + body)
    assert (facts.format, facts.frames, facts.sample_rate, facts.exact_pcm_milliseconds) == ('AIFF',4410,22050,200)


@pytest.mark.parametrize('cut', [0,1,8,12,15,20,36,43,99])
def test_truncated(cut):
    with pytest.raises(MediaError):
        probe_bytes(pcm()[:cut])


@pytest.mark.parametrize('offset,value,fmt', [(20,3,'H'),(22,3,'H'),(24,0,'I'),(28,1,'I'),(32,1,'H'),(34,12,'H'),(16,18,'I')])
def test_bad_fmt(offset, value, fmt):
    data = bytearray(pcm())
    struct.pack_into('<'+fmt, data, offset, value)
    with pytest.raises(MediaError):
        probe_bytes(bytes(data))


def test_partial_frame_duplicate_and_trailer():
    data = pcm()
    with pytest.raises(MediaError):
        probe_bytes(data + b'x')
    dupe = data + b'fmt ' + struct.pack('<I',16) + data[20:36]
    dupe = dupe[:4] + struct.pack('<I',len(dupe)-8) + dupe[8:]
    with pytest.raises(MediaError):
        probe_bytes(dupe)


def test_audio_content_not_a_fixed_sha_gate():
    a, b = probe_bytes(pcm(sample=0)), probe_bytes(pcm(sample=1))
    assert a.sha256 != b.sha256
    assert a.frames == b.frames and a.sample_rate == b.sample_rate


def test_readonly_file_and_seal(tmp_path):
    path = tmp_path/'new.wav'
    path.write_bytes(pcm())
    before = path.stat().st_mtime_ns
    observed = probe_file(path, expected_size=path.stat().st_size, expected_mtime_ns=before)
    assert probe_file(path, expected_sha256=observed.sha256) == observed
    with pytest.raises(MediaError):
        probe_file(path, expected_sha256='0'*64)
    assert path.stat().st_mtime_ns == before


@pytest.mark.parametrize('limits', [{'max_file_bytes':1},{'max_file_bytes':True},{'max_nodes':0},{'unexpected':1}])
def test_limits(limits):
    with pytest.raises(MediaError):
        probe_bytes(pcm(), limits=limits)


def test_mutable_and_empty_data():
    for data in (bytearray(pcm()), b'', pcm(frames=0)):
        with pytest.raises(MediaError):
            probe_bytes(data)


@pytest.mark.parametrize('pins', [{'expected_sha256':True},{'expected_sha256':'A'*64},{'expected_sha256':'g'*64},{'expected_size':True},{'expected_mtime_ns':1.0},{'expected_size':-1}])
def test_strict_file_pin_types(tmp_path,pins):
    path=tmp_path/'sealed.wav';path.write_bytes(pcm())
    with pytest.raises(MediaError):probe_file(path,**pins)


def test_actual_shared_read_limits():
    from itlkit.schema import ReadLimits
    assert probe_bytes(pcm(),limits=ReadLimits()).sample_rate==48000
    with pytest.raises(MediaError):probe_bytes(pcm(),limits={'max_depth':33})


@pytest.mark.parametrize('same_size',[False,True])
@pytest.mark.parametrize('use_pins',[False,True])
def test_review_media01_opened_handle_aba(tmp_path,monkeypatch,same_size,use_pins):
    from contextlib import contextmanager
    from pathlib import Path
    import os,hashlib
    def fingerprint(p):
        s=p.stat();return (s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns,hashlib.sha256(p.read_bytes()).hexdigest())
    def sound(frames,amp):
        body=struct.pack('<h',amp)*frames
        fmt=struct.pack('<HHIIHH',1,1,48000,96000,2,16)
        return b'RIFF'+struct.pack('<I',36+len(body))+b'WAVEfmt '+struct.pack('<I',16)+fmt+b'data'+struct.pack('<I',len(body))+body
    a=tmp_path/'a.wav';b=tmp_path/'b.wav';saved=tmp_path/'a.saved'
    a.write_bytes(sound(257,29));b.write_bytes(sound(257 if same_size else 509,-47))
    st=a.stat();os.utime(b,ns=(st.st_atime_ns,st.st_mtime_ns))
    first,other=fingerprint(a),fingerprint(b)
    assert first[1]!=other[1] and first[-1]!=other[-1]
    if same_size:assert first[2:4]==other[2:4]  # only opened-file identity detects this control
    original=Path.open;calls={'opens':0,'reads':0}
    @contextmanager
    def scheduled(path,*args,**kwargs):
        if path!=a:
            with original(path,*args,**kwargs) as f:yield f
            return
        assert args==('rb',);a.rename(saved);b.rename(a)
        try:
            with original(a,*args,**kwargs) as handle:
                calls['opens']+=1
                class ObservedHandle:
                    def fileno(self):return handle.fileno()
                    def read(self,n):calls['reads']+=1;return handle.read(n)
                yield ObservedHandle()
        finally:a.rename(b);saved.rename(a)
    pins={'expected_sha256':first[-1],'expected_size':first[2],'expected_mtime_ns':first[3]} if use_pins else {}
    with monkeypatch.context() as m:
        m.setattr(Path,'open',scheduled)
        with pytest.raises(MediaError,match='replaced before open'):probe_file(a,**pins)
    assert calls=={'opens':1,'reads':0}
    assert fingerprint(a)==first and fingerprint(b)==other and not saved.exists()
    result=probe_file(a,expected_sha256=first[-1],expected_size=first[2],expected_mtime_ns=first[3])
    assert result.sha256==first[-1] and result.size_bytes==first[2]


@pytest.mark.parametrize('pin',['expected_sha256','expected_size','expected_mtime_ns'])
def test_review_media01_external_pins_still_enforced(tmp_path,pin):
    import hashlib
    p=tmp_path/'normal.wav';data=pcm();p.write_bytes(data);s=p.stat()
    pins={'expected_sha256':hashlib.sha256(data).hexdigest(),'expected_size':len(data),'expected_mtime_ns':s.st_mtime_ns}
    assert probe_file(p,**pins).sha256==pins['expected_sha256']
    pins[pin]='0'*64 if pin=='expected_sha256' else pins[pin]+1
    with pytest.raises(MediaError,match='provenance mismatch'):probe_file(p,**pins)


def test_review_media01_exact_opened_length(tmp_path,monkeypatch):
    from contextlib import contextmanager
    from pathlib import Path
    p=tmp_path/'short-read.wav';data=pcm();p.write_bytes(data);original=Path.open
    @contextmanager
    def shortened(path,*args,**kwargs):
        with original(path,*args,**kwargs) as f:
            if path!=p:yield f;return
            class ShortReader:
                def fileno(self):return f.fileno()
                def read(self,n):return f.read(len(data)-2)  # real handle, deliberately short read
            yield ShortReader()
    with monkeypatch.context() as m:
        m.setattr(Path,'open',shortened)
        with pytest.raises(MediaError,match='changed during read'):probe_file(p)
    assert p.read_bytes()==data
