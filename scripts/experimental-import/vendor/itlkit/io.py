"""Exclusive publication of a complete new file, never replacement of an input.

A sibling temporary file is written, flushed, fsynced and closed before a
hard-link commit. Existing destinations (including aliases/symlinks) are never
replaced. Unsupported hard-link filesystems fail closed. This is not a promise
of power-loss durability or safety against a hostile destination-directory
owner. A crash can leave a temporary file; after the link commit an error can
leave a COMPLETE destination, never a deliberately published partial one.
"""
from pathlib import Path
import errno
import os
import tempfile


def _write_payload(stream, data: bytes) -> None:
    if stream.write(data) != len(data):
        raise OSError(errno.EIO, 'short output write')
    stream.flush()
    os.fsync(stream.fileno())


def write_new(path: Path, data: bytes) -> None:
    path = Path(path)
    if not isinstance(data, (bytes, bytearray, memoryview)):
        raise TypeError('output data must be bytes-like')
    data = bytes(data)
    if os.path.lexists(path):
        raise FileExistsError(errno.EEXIST, 'output must not exist', str(path))
    fd, name = tempfile.mkstemp(prefix=f'.{path.name}.itlkit-', suffix='.tmp', dir=path.parent)
    temporary = Path(name)
    failure = None
    published = False
    try:
        stream = os.fdopen(fd, 'wb')
        fd = None  # the stream now owns the descriptor, including on exceptions
        with stream:
            _write_payload(stream, data)
        # Unlike replace(), link() cannot overwrite an existing destination.
        # The sibling location keeps publication on the same filesystem.
        os.link(temporary, path)
        published = True
    except BaseException as exc:
        failure = exc
        raise
    finally:
        if fd is not None:
            os.close(fd)
        try:
            temporary.unlink()
        except FileNotFoundError:
            pass
        except OSError as cleanup_error:
            if failure is not None:
                if hasattr(failure, 'add_note'):
                    failure.add_note(f'temporary output cleanup also failed: {temporary}: {cleanup_error}')
            elif published:
                raise OSError(f'complete output was published to {path}; temporary cleanup failed: {temporary}') from cleanup_error
            else:
                raise
