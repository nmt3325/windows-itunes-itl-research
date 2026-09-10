"""Physical CLI byte caps; OS subprocesses, no iTunes or media operations."""
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import pytest
from itlkit import __main__ as cli
from test_core_support import library_bytes

COMMANDS = ('inspect-coverage', 'inspect-playlists')

@pytest.fixture
def closed_bytes(tmp_path):
    path = tmp_path / 'closed input.itl'
    raw = library_bytes()
    path.write_bytes(raw)
    return path, raw, path.stat().st_mtime_ns


def reference_output(command, path):
    output = path.with_name(command + '.json')
    assert cli.main([command, str(path), '--output', str(output)]) == 0
    data = output.read_bytes()
    assert data.endswith(b'\n') and not data.endswith(b'\r\n')
    json.loads(data)
    return data


def physical_cli(command, path, cap):
    root = Path(__file__).resolve().parents[1]
    env = dict(os.environ, PYTHONUTF8='1', PYTHONIOENCODING='utf-8',
               PYTHONDONTWRITEBYTECODE='1', PYTHONOPTIMIZE='0', PYTHONPATH=str(root))
    return subprocess.run([sys.executable, '-B', '-m', 'itlkit', command,
                           str(path), '--max-json-bytes', str(cap)],
                          cwd=root, env=env, stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE, timeout=30, check=False)


@pytest.mark.parametrize('command', COMMANDS)
def test_physical_stdout_matches_exact_file_byte_cap(command, closed_bytes):
    path, raw, mtime = closed_bytes
    expected = reference_output(command, path)
    result = physical_cli(command, path, len(expected))
    assert result.returncode == 0, result.stderr.decode('utf-8', 'replace')
    assert result.stderr == b''
    assert len(result.stdout) == len(expected), (len(expected), len(result.stdout))
    assert result.stdout == expected
    assert path.read_bytes() == raw and path.stat().st_mtime_ns == mtime


@pytest.mark.parametrize('command', COMMANDS)
def test_physical_stdout_budget_refuses_before_any_output(command, closed_bytes):
    path, raw, mtime = closed_bytes
    expected = reference_output(command, path)
    result = physical_cli(command, path, len(expected) - 1)
    assert result.returncode == 2
    assert result.stdout == b'' and result.stderr
    assert path.read_bytes() == raw and path.stat().st_mtime_ns == mtime


@pytest.mark.parametrize('command', COMMANDS)
def test_text_only_embedding_remains_supported(command, closed_bytes, monkeypatch):
    path, raw, mtime = closed_bytes
    expected = reference_output(command, path)
    text = io.StringIO()
    with monkeypatch.context() as patch:
        patch.setattr(sys, 'stdout', text)
        assert cli.main([command, str(path), '--max-json-bytes', str(len(expected))]) == 0
    assert text.getvalue().encode('ascii') == expected
    assert path.read_bytes() == raw and path.stat().st_mtime_ns == mtime
