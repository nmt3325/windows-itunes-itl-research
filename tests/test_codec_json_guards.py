import copy
import pytest
from itlkit import Container,FormatError,Library,UnsupportedError
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


def test_library_json_propagates_explicit_plaintext_budget():
    library = Library.from_bytes(library_bytes())
    doc = library.to_dict()
    with pytest.raises(FormatError, match='exceeds'):
        Library.from_dict(doc, max_plain_bytes=128)

    # A small projected payload must not bypass the retained original baseline.
    doc['container']['payload_hex'] = ''
    with pytest.raises(FormatError, match='exceeds'):
        Library.from_dict(doc, max_plain_bytes=128)

    exact = library.to_dict()
    assert Library.from_dict(
        exact, max_plain_bytes=len(library.container.payload)
    ).to_bytes() == library_bytes()
    with pytest.raises(ValueError, match='positive'):
        Library.from_dict(exact, max_plain_bytes=False)
