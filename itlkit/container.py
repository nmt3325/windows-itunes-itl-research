"""Lossless hdfm / partial AES-ECB / zlib container.

This layer does not assert that the decompressed bytes form a valid library.
The byte-preserving path and the forced reconstruction path are distinct.
"""
from __future__ import annotations
from dataclasses import dataclass, field
from pathlib import Path
import base64
import hashlib
import zlib
from Crypto.Cipher import AES
from .binary import uint, put
from .errors import FormatError, UnsupportedError

KEY = b'BHUILuilfghuila3'
DEFAULT_MAX_PLAIN_BYTES = 512 * 1024 * 1024

def crypt_length(body_length: int, limit: int, encryption_flag: int = 2) -> int:
    """Native header interval: 0=none, 1=whole body, 2=capped; floor last.

    For flag 2, a zero cap means zero encrypted bytes, not unlimited.
    Unaligned caps are valid. All lengths are nonnegative integers.
    """
    if type(body_length) is not int or type(limit) is not int or body_length < 0 or limit < 0:
        raise FormatError('body length and AES cap must be nonnegative integers')
    if type(encryption_flag) is not int or encryption_flag not in (0, 1, 2):
        raise UnsupportedError(f'unsupported encryption flag {encryption_flag}')
    interval = 0 if encryption_flag == 0 else body_length if encryption_flag == 1 else min(body_length, limit)
    return interval // 16 * 16

def _header_check(header: bytes) -> None:
    if len(header) < 0x60 or header[:4] != b'hdfm':
        raise FormatError('expected hdfm header of at least 0x60 bytes', 0)
    if uint(header, 4, endian='big') != len(header):
        raise FormatError('outer header length does not match header bytes', 4)
    crypt_length(0, uint(header, 0x5c, endian='big'), header[0x41])

@dataclass
class Container:
    header: bytes
    payload: bytes
    trailer: bytes = b''
    _original: bytes | None = field(default=None, repr=False)
    _baseline: tuple[bytes, bytes, bytes] | None = field(default=None, repr=False)

    @classmethod
    def from_bytes(cls, data: bytes, *, max_plain_bytes: int = DEFAULT_MAX_PLAIN_BYTES,
                   strict_size: bool = True) -> Container:
        data = bytes(data)
        if type(max_plain_bytes) is not int or max_plain_bytes < 1:
            raise ValueError('max_plain_bytes must be positive')
        if len(data) < 0x60 or data[:4] != b'hdfm':
            raise FormatError('not a supported hdfm container', 0)
        hlen = uint(data, 4, endian='big')
        if hlen < 0x60 or hlen > len(data):
            raise FormatError('outer header is truncated or has invalid size', 4)
        header = data[:hlen]
        _header_check(header)
        if strict_size and uint(header, 8, endian='big') != len(data):
            raise FormatError('declared outer file size differs from actual file size', 8)
        body = data[hlen:]
        if not header[0x43] and len(body) > max_plain_bytes:
            raise FormatError(f'uncompressed payload exceeds {max_plain_bytes} bytes', hlen)
        n = crypt_length(len(body), uint(header, 0x5c, endian='big'), header[0x41])
        decoded = AES.new(KEY, AES.MODE_ECB).decrypt(body[:n]) + body[n:] if n else body
        if header[0x43]:  # Native field is a Boolean: any nonzero byte selects zlib.
            inflater = zlib.decompressobj()
            try:
                payload = inflater.decompress(decoded, max_plain_bytes + 1)
            except zlib.error as exc:
                raise FormatError(f'invalid encrypted/zlib payload: {exc}', hlen) from exc
            if len(payload) > max_plain_bytes or inflater.unconsumed_tail:
                raise FormatError(f'decompressed payload exceeds {max_plain_bytes} bytes', hlen)
            if not inflater.eof:
                raise FormatError('truncated zlib stream (end marker/checksum missing)', hlen)
            trailer = inflater.unused_data
        else:
            payload, trailer = decoded, b''  # No stream boundary exists to identify a trailer.
        obj = cls(header, payload, trailer, data)
        obj._baseline = (header, payload, trailer)
        return obj

    @classmethod
    def read(cls, path: str | Path, **kwargs) -> Container:
        return cls.from_bytes(Path(path).read_bytes(), **kwargs)

    @property
    def version(self) -> str:
        # Pascal string, NOT a C string at 0x10.
        if len(self.header) <= 0x10:
            return ''
        n = self.header[0x10]
        if n > 15 or 0x11 + n > len(self.header):
            return ''
        return self.header[0x11:0x11 + n].decode('ascii', errors='replace')

    @property
    def max_crypt_size(self) -> int:
        return uint(self.header, 0x5c, endian='big')

    @property
    def encryption_flag(self) -> int:
        return uint(self.header, 0x41, 1)

    @property
    def compression_flag(self) -> int:
        return uint(self.header, 0x43, 1)

    @property
    def payload_byteorder(self) -> str:
        return 'little' if uint(self.header, 0x52, 1) else 'big'

    def validate_header(self) -> None:
        """Validate envelope flags/framing, not the opaque payload's semantics."""
        _header_check(self.header)

    @property
    def unchanged(self) -> bool:
        return self._original is not None and self._baseline == (self.header, self.payload, self.trailer)

    def to_bytes(self, *, rebuild: bool = False, compression_level: int = 6) -> bytes:
        if type(compression_level) is not int or not -1 <= compression_level <= 9:
            raise ValueError('compression_level must be -1 through 9')
        _header_check(self.header)
        if not rebuild and self.unchanged:
            return self._original  # type: ignore[return-value]
        if not self.compression_flag and self.trailer:
            raise UnsupportedError('an uncompressed body has no separate trailer; merge it into payload explicitly')
        encoded = (zlib.compress(bytes(self.payload), compression_level) + bytes(self.trailer)
                   if self.compression_flag else bytes(self.payload))
        n = crypt_length(len(encoded), self.max_crypt_size, self.encryption_flag)
        body = AES.new(KEY, AES.MODE_ECB).encrypt(encoded[:n]) + encoded[n:] if n else encoded
        header = bytearray(self.header)
        put(header, 8, len(header) + len(body), endian='big')
        return bytes(header) + body

    def write(self, path: str | Path, **kwargs) -> None:
        from .io import write_new
        write_new(Path(path), self.to_bytes(**kwargs))

    def to_dict(self) -> dict:
        return {'schema': 'itlkit.container.v1', 'header_hex': self.header.hex(),
                'payload_hex': self.payload.hex(), 'trailer_hex': self.trailer.hex(),
                'original_file_b64': base64.b64encode(self._original).decode('ascii') if self._original else None,
                'original_sha256': hashlib.sha256(self._original).hexdigest() if self._original else None}

    @classmethod
    def from_dict(cls, value: dict, *, max_plain_bytes: int = DEFAULT_MAX_PLAIN_BYTES) -> Container:
        if type(max_plain_bytes) is not int or max_plain_bytes < 1:
            raise ValueError('max_plain_bytes must be positive')
        try:
            if value['schema'] != 'itlkit.container.v1':
                raise FormatError('unsupported container JSON schema')
            payload_hex = value['payload_hex']
            if not isinstance(payload_hex, str):
                raise TypeError('payload_hex must be a string')
            if sum(not char.isspace() for char in payload_hex) > max_plain_bytes * 2:
                raise FormatError(f'decompressed payload exceeds {max_plain_bytes} bytes')
            header = bytes.fromhex(value['header_hex'])
            payload = bytes.fromhex(payload_hex)
            trailer = bytes.fromhex(value['trailer_hex'])
            _header_check(header)
            original_b64 = value.get('original_file_b64')
            obj = (cls.from_bytes(base64.b64decode(original_b64, validate=True),
                                  max_plain_bytes=max_plain_bytes)
                   if original_b64 else cls(header, payload, trailer))
            if original_b64 and hashlib.sha256(obj._original).hexdigest() != value.get('original_sha256'):
                raise FormatError('original container digest mismatch')
            obj.header, obj.payload, obj.trailer = header, payload, trailer
            return obj
        except (KeyError, TypeError, ValueError) as exc:
            if isinstance(exc, (FormatError, UnsupportedError)):
                raise
            raise FormatError(f'invalid container JSON: {exc}') from exc