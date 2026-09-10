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


# G2 resource admission regressions: new tests, not recovered G1 receipts.
@pytest.mark.parametrize('form', ['record', 'dict'])
@pytest.mark.parametrize('frames', [257, 60000])
def test_g2_budget_one_pcm_before_parser(monkeypatch, form, frames):
    from itlkit import media
    from itlkit.schema import ReadLimits
    data = pcm(frames=frames)
    limits = ReadLimits(memory_budget_bytes=1) if form == 'record' else {'memory_budget_bytes': 1}
    calls = []
    original = media._pcm
    def observed(*args, **kwargs):
        calls.append('pcm')
        return original(*args, **kwargs)
    monkeypatch.setattr(media, '_pcm', observed)
    with pytest.raises(ValueError, match='memory budget'):
        probe_bytes(data, limits=limits)
    assert calls == []


def test_g2_budget_one_optional_parser_before_buffer(monkeypatch):
    import sys
    from types import SimpleNamespace
    from itlkit import media
    from itlkit.schema import ReadLimits
    calls = []
    class Audio:
        __module__ = 'mutagen.mp3'
        info = SimpleNamespace(sample_rate=48000, channels=1, length=1.25,
                               bitrate=64000, sketchy=False)
        tags = {'TIT2': 'already parsed data'}
    def parser(*args, **kwargs):
        calls.append('parser')
        return Audio()
    original = media.BytesIO
    def buffer(*args, **kwargs):
        calls.append('buffer')
        return original(*args, **kwargs)
    monkeypatch.setitem(sys.modules, 'mutagen', SimpleNamespace(File=parser))
    monkeypatch.setattr(media, 'BytesIO', buffer)
    data = b'ID3' + b'\0' * 61
    with pytest.raises(ValueError, match='memory budget'):
        probe_bytes(data, limits=ReadLimits(memory_budget_bytes=1))
    assert calls == []
    result = probe_bytes(data, limits=ReadLimits(memory_budget_bytes=64 * 1024 * 1024))
    assert result.format == 'MP3' and result.tag_keys == ('TIT2',)
    assert calls == ['buffer', 'parser']


@pytest.mark.parametrize('budget', [1, 1024 * 1024])
def test_g2_budget_file_refuses_before_open_or_read(tmp_path, monkeypatch, budget):
    from pathlib import Path
    from itlkit.schema import ReadLimits
    path = tmp_path / 'resource-control.wav'
    data = pcm(frames=60000)
    path.write_bytes(data)
    before = path.stat()
    calls = []
    original = Path.open
    def observed(p, *args, **kwargs):
        if p == path:
            calls.append('open')
        return original(p, *args, **kwargs)
    with monkeypatch.context() as m:
        m.setattr(Path, 'open', observed)
        with pytest.raises(ValueError, match='memory budget'):
            probe_file(path, limits=ReadLimits(memory_budget_bytes=budget))
    assert calls == []
    assert path.read_bytes() == data and path.stat().st_mtime_ns == before.st_mtime_ns


def test_g2_budget_one_file_before_path_conversion():
    from itlkit.schema import ReadLimits
    class PathNotReached:
        def __fspath__(self):
            raise AssertionError('path conversion reached before resource admission')
    with pytest.raises(ValueError, match='memory budget'):
        probe_file(PathNotReached(), limits=ReadLimits(memory_budget_bytes=1))


def test_g2_budget_file_read_uses_verified_length_not_configured_cap(tmp_path, monkeypatch):
    from contextlib import contextmanager
    from pathlib import Path
    from itlkit.schema import ReadLimits
    data = pcm(frames=257)
    path = tmp_path / 'small-read.wav'
    path.write_bytes(data)
    original = Path.open
    requests = []
    @contextmanager
    def observe(p, *args, **kwargs):
        with original(p, *args, **kwargs) as handle:
            if p != path:
                yield handle
                return
            class Stream:
                def fileno(self):
                    return handle.fileno()
                def read(self, n):
                    requests.append(n)
                    return handle.read(n)
            yield Stream()
    with monkeypatch.context() as m:
        m.setattr(Path, 'open', observe)
        result = probe_file(path, limits=ReadLimits(memory_budget_bytes=64 * 1024 * 1024))
    assert result.facts.frames == 257
    assert requests == [len(data) + 1]


@pytest.mark.parametrize('bad', [True, False, 1.0, 0.0, -1.0, -1, 0, '1', None])
def test_g2_budget_actual_limit_value_contract(bad):
    from itlkit.schema import ReadLimits
    with pytest.raises(ValueError, match='memory_budget_bytes must be a positive integer'):
        ReadLimits(memory_budget_bytes=bad)
    with pytest.raises(MediaError, match='invalid shared ReadLimits'):
        probe_bytes(pcm(frames=257), limits={'memory_budget_bytes': bad})


@pytest.mark.parametrize('form', ['record', 'dict'])
def test_g2_budget_sufficient_file_and_pcm_are_unchanged(tmp_path, form):
    from hashlib import sha256
    from itlkit.schema import ReadLimits
    data = pcm(frames=257, sample=31)
    path = tmp_path / 'ordinary.wav'
    path.write_bytes(data)
    state = path.stat()
    limits = ReadLimits(memory_budget_bytes=64 * 1024 * 1024) if form == 'record' else {'memory_budget_bytes': 64 * 1024 * 1024}
    result = probe_file(path, limits=limits, expected_sha256=sha256(data).hexdigest(),
                        expected_size=len(data), expected_mtime_ns=state.st_mtime_ns)
    assert result.facts == probe_bytes(data) == probe_bytes(data, limits=limits)
    assert result.sha256 == sha256(data).hexdigest()
    assert path.read_bytes() == data and path.stat().st_mtime_ns == state.st_mtime_ns


def test_g2_budget_large_path_refused_before_path_object(monkeypatch):
    from itlkit import media
    from itlkit.schema import ReadLimits
    def should_not_construct(*args, **kwargs):
        raise AssertionError('Path construction preceded budget check')
    monkeypatch.setattr(media, 'Path', should_not_construct)
    with pytest.raises(ValueError, match='memory budget'):
        probe_file('D:/' + 'x' * 100000, limits=ReadLimits(memory_budget_bytes=65536))
