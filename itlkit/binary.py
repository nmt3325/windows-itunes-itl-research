"""Bounds-checked binary primitives."""
import struct
from .errors import FormatError

def uint(data: bytes | bytearray, offset: int, size: int = 4, endian: str = 'little') -> int:
    if offset < 0 or size not in (1, 2, 4, 8) or offset + size > len(data):
        raise FormatError(f'truncated {size}-byte integer', offset)
    return int.from_bytes(data[offset:offset + size], endian)

def put(data: bytearray, offset: int, value: int, size: int = 4, endian: str = 'little') -> None:
    if type(value) is not int or not 0 <= value < 1 << (8 * size):
        raise ValueError(f'value must be an unsigned {8 * size}-bit integer')
    if offset < 0 or offset + size > len(data):
        raise FormatError(f'field exceeds {len(data)}-byte header', offset)
    data[offset:offset + size] = value.to_bytes(size, endian)

def prefix(data: bytes, offset: int, end: int) -> tuple[bytes, int, int]:
    if not 0 <= offset <= end <= len(data) or end - offset < 12:
        raise FormatError('truncated record prefix', offset)
    tag, header, value = struct.unpack_from('<4sII', data, offset)
    if header < 12 or header > end - offset:
        raise FormatError(f'invalid {tag!r} header length {header}', offset + 4)
    return tag, header, value