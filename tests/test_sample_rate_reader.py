"""Sample rate and count-like storage are different quantities.
Native regression uses synthetic checkpoint-01 media/ITL, never private inputs.
Counterfactual float tests specify reader policy, not native acceptance.
"""
import importlib.util
import json
import struct
from pathlib import Path
import pytest
from itlkit import Library
from itlkit.errors import UnsupportedError
from itlkit.__main__ import main

_spec = importlib.util.spec_from_file_location(
    "itl_sample_fixture_support", Path(__file__).with_name("test_core_support.py"))
_f = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_f)
ROOT = Path(__file__).resolve().parents[1]


def fixture(rate=48000.0, raw_quantity=60000):
    t = bytearray(_f.track())
    struct.pack_into("<f", t, 0x98, rate)
    struct.pack_into("<Q", t, 0xf4, raw_quantity)
    data = _f.library_bytes(tracks=[bytes(t)], playlists=[_f.playlist([1], master=True)])
    return Library.from_bytes(data), data


@pytest.mark.parametrize("rate,raw_quantity", [
    (48000.0, 60000), (44100.0, 22050), (8000.0, 1000),
    (96000.0, 2**32 + 123), (0.0, 0)])
def test_rate_is_float32_hz_not_count_like_u64(rate, raw_quantity):
    lib, data = fixture(rate, raw_quantity)
    t = lib.tracks[0]
    assert t.get("sample_rate") == rate
    assert type(t.get("sample_rate")) is int
    assert t.get("mith_0xf4_u64_raw") == raw_quantity
    summary = t.to_dict()
    assert summary["sample_rate"] == rate
    assert summary["mith_0xf4_u64_raw"] == raw_quantity
    assert lib.to_bytes() == data
    assert Library.from_dict(lib.to_dict()).to_bytes() == data


@pytest.mark.parametrize("rate", [float("nan"), float("inf"), -float("inf"), -1.0, 48000.5])
def test_nonfinite_negative_and_fractional_rates_are_local_diagnostics(rate):
    lib, data = fixture(rate)
    with pytest.raises(UnsupportedError, match="sample_rate"):
        lib.tracks[0].get("sample_rate")
    row = lib.tracks[0].to_dict()
    assert "sample_rate" not in row
    assert row["field_errors"]["sample_rate"]
    assert row["mith_0xf4_u64_raw"] == 60000
    assert row["name"] == "Synthetic Track"
    json.dumps(lib.summary(), allow_nan=False)
    assert lib.to_bytes() == data
    assert Library.from_dict(lib.to_dict()).to_bytes() == data


@pytest.mark.parametrize("field", ["sample_rate", "mith_0xf4_u64_raw"])
def test_both_quantities_remain_read_only(field):
    lib, data = fixture()
    with pytest.raises(UnsupportedError):
        lib.tracks[0].set(**{field: 123})
    assert lib.to_bytes() == data


def test_short_header_rate_fails_with_domain_error():
    lib, _ = fixture()
    t = lib.tracks[0]
    t.node.header = t.node.header[:0x98]
    with pytest.raises(UnsupportedError, match="sample_rate"):
        t.get("sample_rate")


def test_unqualified_version_rate_fails_without_changing_bytes():
    lib, _ = fixture()
    original = bytes(lib.container.header)
    changed = bytearray(original)
    changed[17:27] = b"12.13.9.1\x00"
    changed[16] = 9
    lib.container.header = bytes(changed)
    with pytest.raises(UnsupportedError, match="sample_rate"):
        lib.tracks[0].get("sample_rate")
    assert lib.tracks[0].get("mith_0xf4_u64_raw") == 60000
    lib.container.header = original


def test_inspect_diagnostic_is_json_and_does_not_repair(tmp_path, capsys):
    _, data = fixture(float("nan"))
    p = tmp_path / "counterfactual-rate.itl"
    p.write_bytes(data)
    assert main(["inspect", str(p)]) == 0
    row = json.loads(capsys.readouterr().out)["tracks"][0]
    assert "sample_rate" not in row
    assert row["field_errors"]["sample_rate"]
    assert p.read_bytes() == data


def test_twenty_native_synthetic_tracks_have_48000_hz():
    folder = ROOT / "evidence" / "20260910" / "checkpoint-01" / "native-snapshots"
    paths = list(folder.rglob("donor-v1-twenty-reopen2.itl"))
    assert len(paths) == 1, "required published synthetic native witness missing"
    import hashlib
    data = paths[0].read_bytes()
    assert hashlib.sha256(data).hexdigest() == "79686fa16cd29adf2d22f52d7842e4c8fd92eb8877a3e060368f7accccd1d588"
    lib = Library.from_bytes(data)
    assert len(lib.tracks) == 20
    counts = []
    for t in lib.tracks:
        assert t.get("sample_rate") == 48000
        assert struct.unpack_from("<f", t.node.header, 0x98)[0] == 48000.0
        counts.append(t.get("mith_0xf4_u64_raw"))
    assert counts.count(60000) == 16
    assert sorted(v for v in counts if v != 60000) == [60916, 60950, 60968, 60987]
    assert lib.to_bytes() == data
