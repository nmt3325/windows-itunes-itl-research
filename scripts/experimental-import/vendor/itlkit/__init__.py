"""Independent, lossless Windows ITL codec with conservative semantic editing."""
from .container import Container, crypt_length
from .errors import ITLError, FormatError, UnsupportedError
from .model import Node, parse_sections, serialize_sections
from .library import Library, Track, Playlist, hfs_from_datetime, hfs_to_datetime

__version__ = '0.1.0'
__all__ = ['Container', 'Library', 'Track', 'Playlist', 'Node', 'ITLError', 'FormatError',
           'UnsupportedError', 'crypt_length', 'parse_sections', 'serialize_sections',
           'hfs_from_datetime', 'hfs_to_datetime']