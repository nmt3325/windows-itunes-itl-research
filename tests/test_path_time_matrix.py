"""Path/time matrix regression tests; native execution stays explicit opt-in."""
from datetime import datetime, timedelta, timezone
from pathlib import Path
from types import SimpleNamespace
import json
import unicodedata

import pytest
from zoneinfo import ZoneInfo

from itlkit import hfs_from_datetime, hfs_to_datetime
from scripts.windows.path_time_matrix import (
    _guard_com_locations,
    build_offline_report,
    classify_windows_spelling,
    lexical_windows_identity,
    run_native,
    wall_time_state,
    windows_file_url,
    windows_path_from_file_url,
)


def test_drive_file_url_is_ascii_percent_encoded_and_reversible():
    path = r"D:\owned\日本語\café-🎵.wav"
    url = windows_file_url(path)
    assert url.startswith("file:///D:/owned/")
    assert url.isascii()
    assert "%E6%97%A5" in url and "%F0%9F%8E%B5" in url
    assert windows_path_from_file_url(url) == path


def test_unc_file_url_is_reversible():
    path = r"\\localhost\PTM$\日本語\track.wav"
    url = windows_file_url(path)
    assert url.startswith("file://localhost/PTM%24/")
    assert windows_path_from_file_url(url) == path


def test_localhost_drive_file_url_decodes_as_local_drive():
    assert windows_path_from_file_url("file://localhost/C:/PTM/a.wav") == r"C:\PTM\a.wav"


def test_lexical_identity_normalizes_drive_case_and_slashes_only_lexically():
    left = lexical_windows_identity(r"C:\PTM\Media\Track.wav")
    right = lexical_windows_identity("c:/ptm/media/track.wav")
    assert left == right
    assert classify_windows_spelling(r"media\track.wav")["kind"] == "relative"
    assert classify_windows_spelling(r"\\server\share\track.wav")["kind"] == "unc"


def test_unicode_nfc_nfd_are_preserved_as_distinct_spellings():
    nfc = r"C:\PTM\café.wav"
    nfd = unicodedata.normalize("NFD", nfc)
    assert nfc != nfd
    assert classify_windows_spelling(nfc)["unicode_form"] == "NFC"
    assert classify_windows_spelling(nfd)["unicode_form"] == "NFD"
    assert lexical_windows_identity(nfc) != lexical_windows_identity(nfd)


def test_hfs_zero_is_epoch_collision_and_one_is_first_unambiguous_second():
    epoch = datetime(1904, 1, 1, tzinfo=timezone.utc)
    assert hfs_from_datetime(epoch) == 0
    assert hfs_to_datetime(0, utc_offset_seconds=0) is None
    assert hfs_from_datetime(epoch + timedelta(seconds=1)) == 1
    assert hfs_to_datetime(1, utc_offset_seconds=0) == epoch + timedelta(seconds=1)


def test_hfs_uses_displayed_wall_time_not_instant():
    utc_wall = datetime(2026, 1, 15, 12, 34, 56, tzinfo=timezone.utc)
    offset_wall = datetime(2026, 1, 15, 12, 34, 56,
                           tzinfo=timezone(timedelta(hours=-5)))
    assert hfs_from_datetime(utc_wall) == hfs_from_datetime(offset_wall)
    same_instant = utc_wall.astimezone(timezone(timedelta(hours=-5)))
    assert same_instant.timestamp() == utc_wall.timestamp()
    assert hfs_from_datetime(same_instant) != hfs_from_datetime(utc_wall)


def test_hfs_rejects_naive_and_pre_epoch_fraction():
    with pytest.raises(ValueError, match="aware"):
        hfs_from_datetime(datetime(2026, 1, 15, 12, 34, 56))
    with pytest.raises(ValueError, match="outside"):
        hfs_from_datetime(datetime(1903, 12, 31, 23, 59, 59, 500000,
                                   tzinfo=timezone.utc))


def test_hfs_uint32_upper_bound():
    decoded = hfs_to_datetime(2**32 - 1, utc_offset_seconds=0)
    assert decoded == datetime(1904, 1, 1, tzinfo=timezone.utc) + timedelta(seconds=2**32 - 1)
    with pytest.raises(ValueError):
        hfs_to_datetime(2**32, utc_offset_seconds=0)


def test_dst_fold_and_gap_are_classified_and_codec_drops_fold():
    zone = ZoneInfo("America/New_York")
    fold = datetime(2026, 11, 1, 1, 30)
    gap = datetime(2026, 3, 8, 2, 30)
    assert wall_time_state(fold, zone)["classification"] == "ambiguous_fold"
    assert wall_time_state(gap, zone)["classification"] == "nonexistent_gap"
    assert hfs_from_datetime(fold.replace(tzinfo=zone, fold=0)) == hfs_from_datetime(
        fold.replace(tzinfo=zone, fold=1))
    # The codec checks awareness/range, not zone transition validity.
    assert hfs_from_datetime(gap.replace(tzinfo=zone, fold=0)) == hfs_from_datetime(
        gap.replace(tzinfo=zone, fold=1))


def test_offline_report_labels_non_native_evidence():
    report = build_offline_report()
    assert report["mode"] == "offline"
    assert len(report["path_matrix"]) >= 14
    assert len(report["time_matrix"]) >= 11
    assert all(row["evidence_class"] != "native" for row in report["path_matrix"])
    assert any("do not establish" in item for item in report["limitations"])


def test_location_guard_requires_immutable_inventory(tmp_path: Path):
    source = tmp_path / "owned.wav"
    source.write_bytes(b"owned bytes")
    row = {"tracks": [{"persistent_id": "0000000000000001", "Location": str(source)}]}
    digest = __import__("hashlib").sha256(source.read_bytes()).hexdigest()
    assert _guard_com_locations(row, {digest})[0]["sha256"] == digest
    with pytest.raises(RuntimeError, match="outside"):
        _guard_com_locations(row, {"0" * 64})


def test_native_mode_requires_explicit_disposable_confirmation(tmp_path: Path):
    args = SimpleNamespace(confirm_disposable=False, root=tmp_path / "root",
                           evidence=tmp_path / "evidence", seed=tmp_path / "seed.itl")
    with pytest.raises(RuntimeError, match="confirm-disposable"):
        run_native(args)


def test_offline_report_json_roundtrip():
    encoded = json.dumps(build_offline_report(), ensure_ascii=False)
    assert json.loads(encoded)["schema_version"] == 1



def test_authenticode_embeds_space_path_as_literal(monkeypatch):
    import scripts.windows.path_time_matrix as matrix

    captured = {}

    def fake_run(argv):
        captured["argv"] = argv
        return {"returncode": 0, "output": '{"Status":"Valid"}'}

    monkeypatch.setattr(matrix, "_run_text", fake_run)
    result = matrix._authenticode(Path(r"C:\Program Files\iTunes\iTunes.exe"))
    assert len(captured["argv"]) == 5
    assert "Program Files" in captured["argv"][-1]
    assert r"-LiteralPath 'C:\Program Files\iTunes\iTunes.exe'" in captured["argv"][-1]
    assert result["signature"]["Status"] == "Valid"
