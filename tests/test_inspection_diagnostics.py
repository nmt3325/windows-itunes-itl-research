"""Unsupported title bytes must not hide unrelated readable library information.
These counterfactual fixtures are not claims of valid native encodings.
"""
import copy
import importlib.util
import json
import struct
from pathlib import Path
import pytest
from itlkit import Library
from itlkit.errors import FormatError, UnsupportedError
from itlkit.__main__ import main

_spec = importlib.util.spec_from_file_location("itl4_fixture_support", Path(__file__).with_name("test_core_support.py"))
_f = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_f)
TARGET = 0xBEEF000000000003
BAD = ("unknown", "utf16", "length", "duplicate")

def fixture(mode):
    lib = Library.from_bytes(_f.library_bytes(playlists=[
        _f.playlist([1], pid=0xBEEF000000000001, name="All", master=True, local_id=4),
        _f.playlist([1], pid=0xBEEF000000000002, name="Readable", local_id=5),
        _f.playlist([1], pid=TARGET, name="Target", local_id=6)]))
    target = lib.playlist(TARGET)
    title = target.node.children[0]
    if mode == "unknown": title.payload = struct.pack("<IIII", 99, 3, 0, 0) + b"abc"
    elif mode == "utf16": title.payload = struct.pack("<IIII", 1, 1, 0, 0) + b"x"
    elif mode == "length": title.payload = struct.pack("<IIII", 3, 999, 0, 0) + b"abc"
    elif mode == "duplicate": target.node.children.append(copy.deepcopy(title))
    elif mode == "empty": title.payload = struct.pack("<IIII", 3, 0, 0, 0)
    elif mode == "missing": target.node.children.remove(title)
    elif mode != "normal": raise ValueError(mode)
    raw = lib.to_bytes()
    return Library.from_bytes(raw), raw

@pytest.mark.parametrize("mode", BAD)
def test_unsupported_title_is_a_local_diagnostic(mode):
    lib, raw = fixture(mode)
    result = lib.summary()
    assert result["tracks"][0]["name"] == "Synthetic Track"
    assert result["playlists"][1]["name"] == "Readable"
    item = result["playlists"][2]
    assert "name" not in item
    assert item["field_errors"]["name"]
    assert item["persistent_id"] == f"{TARGET:016X}"
    assert item["track_ids"] == [1]
    assert lib.to_bytes() == raw
    assert Library.from_dict(lib.to_dict()).to_bytes() == raw

@pytest.mark.parametrize("mode,expected", [("normal", "Target"), ("empty", ""), ("missing", None)])
def test_supported_empty_and_missing_names_are_distinct(mode, expected):
    lib, raw = fixture(mode)
    row = lib.summary()["playlists"][2]
    assert row["name"] == expected
    assert "field_errors" not in row
    assert lib.to_bytes() == raw

def test_inspect_cli_retains_other_information(tmp_path, capsys):
    lib, raw = fixture("unknown")
    p = tmp_path / "opaque-title.itl"
    p.write_bytes(raw)
    assert main(["inspect", str(p)]) == 0
    output = capsys.readouterr()
    result = json.loads(output.out)
    assert result["playlists"][2]["field_errors"]["name"]
    assert result["tracks"][0]["name"] == "Synthetic Track"
    assert p.read_bytes() == raw

@pytest.mark.parametrize("mode", BAD)
def test_tolerant_inspection_does_not_allow_unsafe_rename(mode):
    lib, raw = fixture(mode)
    with pytest.raises((FormatError, UnsupportedError)):
        lib.playlist(TARGET).rename("Do not repair unknown title data")
    assert lib.to_bytes() == raw
