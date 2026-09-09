import copy
import pytest
from itlkit import Container,Library,UnsupportedError
from test_core_support import library_bytes

def test_json_tampering_cannot_rebase_around_operations_guard():
    for field in ['original_file_b64','header_hex','payload_hex']:
        doc=Library.from_bytes(library_bytes()).to_dict()
        if field=='original_file_b64':doc['container'][field]=None
        elif field=='header_hex':
            h=bytearray.fromhex(doc['container'][field]);h[140]^=1;doc['container'][field]=h.hex()
        else:
            p=bytearray.fromhex(doc['container'][field]);p[-1]^=1;doc['container'][field]=p.hex()
        with pytest.raises(UnsupportedError):Library.from_dict(doc)