"""Type1-absent Windows text Location profile; URI tests are not native acceptance."""
from __future__ import annotations
from dataclasses import dataclass
from pathlib import PureWindowsPath
from urllib.parse import quote, unquote_to_bytes, urlsplit
import re
import struct

from .media import limit_value


class LocationError(ValueError):
    pass


def _need(condition, message):
    if not condition:
        raise LocationError(message)


def windows_path(value: str) -> str:
    _need(isinstance(value, str) and bool(value), 'nonempty Windows path required')
    try:
        value.encode('utf-16-le', errors='strict')
    except UnicodeError as exc:
        raise LocationError('invalid UTF16 path') from exc
    _need(not any(ord(c) < 32 or ord(c) == 127 for c in value), 'control in path')
    raw = value.replace('/', '\\')
    _need(re.match(r'^[A-Za-z]:\\', raw) is not None, 'only drive-absolute paths; UNC/device/relative profile unverified')
    parts = raw[3:].split('\\')
    for part in parts:
        _need(part not in ('', '.', '..'), 'empty/dot/traversal component')
        _need(len(part.encode('utf-16-le')) // 2 <= 255, 'component length')
        _need(not any(c in part for c in '<>:"|?*'), 'Win32 character or alternate stream')
        _need(not part.endswith((' ', '.')), 'trailing-dot/space alias')
        # Classify DOS aliases only; never trim the accepted destination.
        # Win32 also reserves names with ASCII spaces before the first dot.
        stem = part.split('.', 1)[0].rstrip(' ').upper()
        _need(stem not in {'CON', 'PRN', 'AUX', 'NUL', 'CONIN$', 'CONOUT$'} and
              re.fullmatch(r'(COM|LPT)[1-9\u00b9\u00b2\u00b3]', stem) is None, 'reserved Win32 device')
    canonical = str(PureWindowsPath(raw))
    _need(len(canonical.encode('utf-16-le')) // 2 < 260, 'extended-length paths unverified')
    return canonical


def decode_file_url(value: str) -> str:
    _need(isinstance(value, str) and value.isascii(), 'ASCII URL11 required')
    _need(not any(ord(c) < 33 or ord(c) == 127 for c in value), 'URL whitespace/control')
    _need('?' not in value and '#' not in value, 'raw query/fragment delimiter')
    _need(re.search(r'%(?![0-9a-fA-F]{2})', value) is None, 'invalid percent escape')
    _need(re.search(r'%(2f|5c)', value, re.I) is None, 'encoded separator')
    parsed = urlsplit(value)
    _need(parsed.scheme.lower() == 'file' and parsed.netloc.lower() in ('', 'localhost'), 'remote/non-file URL')
    _need(re.match(r'^/[A-Za-z]:/', parsed.path) is not None, 'URL drive syntax')
    try:
        path = unquote_to_bytes(parsed.path[1:]).decode('utf-8', errors='strict')
    except UnicodeError as exc:
        raise LocationError('invalid percent-encoded UTF8') from exc
    return windows_path(path)


@dataclass(frozen=True, slots=True)
class LocationBundle:
    path: str
    url: str
    path_encoding: int
    url_encoding: int = 2
    profile: str = 'windows_drive_absolute_type1_absent'


def plan_location(path: str, *, type1_payload=None, limits=None) -> LocationBundle:
    _need(type1_payload is None, 'opaque type1 blocks construction/rebinding, even if empty')
    path = windows_path(path)
    url = 'file://localhost/' + quote(path.replace('\\', '/'), safe='/:')
    _need(decode_file_url(url) == path, 'Location roundtrip mismatch')
    _need(len(path.encode('utf-16-le')) + len(url) <= limit_value(limits, 'max_text_bytes'), 'Location text budget')
    return LocationBundle(path, url, 3 if path.isascii() else 1)


def _text_record(code, external_id, text, encoding):
    encoded = text.encode('utf-16-le' if encoding == 1 else 'ascii', errors='strict')
    payload = struct.pack('<IIQ', encoding, len(encoded), 0) + encoded
    return struct.pack('<4sIIIII', b'mhoh', 24, 24 + len(payload), code, external_id, 0) + payload


def location_records(bundle: LocationBundle, *, limits=None) -> tuple[bytes, bytes]:
    """Fresh mhoh13/11 bytes with file-local IDs1/2; no global atom allocation."""
    _need(type(bundle) is LocationBundle and bundle == plan_location(bundle.path, limits=limits), 'forged/inconsistent Location bundle')
    return (_text_record(13, 1, bundle.path, bundle.path_encoding),
            _text_record(11, 2, bundle.url, 2))


def inspect_location_records(records, *, limits=None) -> LocationBundle:
    """Decode an isolated13/11 pair without mutating it; unknown suffix/prefix refuses."""
    _need(isinstance(records, (tuple, list)) and len(records) == 2, 'exactly path13 and URL11 required')
    texts = {}
    encodings = {}
    for raw in records:
        _need(isinstance(raw, bytes) and len(raw) >= 40, 'location record bounds')
        tag, header, total, code, atom, reserved = struct.unpack_from('<4sIIIII', raw)
        _need(tag == b'mhoh' and header == 24 and total == len(raw), 'mhoh header/length')
        _need(code in (13, 11) and code not in texts and reserved == 0, 'unknown/type1/duplicate Location record')
        _need(atom == (1 if code == 13 else 2), 'unverified file-local text ID')
        encoding, count, extra = struct.unpack_from('<IIQ', raw, 24)
        _need(extra == 0 and count == len(raw) - 40, 'opaque prefix/suffix')
        _need(count <= limit_value(limits, 'max_text_bytes'), 'text budget')
        _need(encoding == 2 if code == 11 else encoding in (1, 3), 'text encoding')
        try:
            text = raw[40:].decode('utf-16-le' if encoding == 1 else 'ascii', errors='strict')
        except UnicodeError as exc:
            raise LocationError('invalid encoded Location text') from exc
        texts[code], encodings[code] = text, encoding
    canonical = plan_location(texts[13], limits=limits)
    _need(decode_file_url(texts[11]) == canonical.path, 'path/URL mismatch')
    _need(texts[11] == canonical.url and encodings[13] == canonical.path_encoding, 'noncanonical/unqualified representation')
    return canonical
