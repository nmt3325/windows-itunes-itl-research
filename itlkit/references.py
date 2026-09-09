"""Conservative PID scans over retained bytes, not a reference semantic parser.

Offsets come from the bounded record tree, never from searching tag-like data.
Only explicitly removed ownership spans and known independent self-identity
slots are omitted. Same-kind identities remain visible, conservatively catching
possible cross-owner aliases. False positives in opaque bytes are intentional.
"""
from .model import serialize_sections


_SELF = {b'mfdh': (144, 0x34), b'mith': (756, 0x80),
         b'miah': (88, 20), b'miih': (100, 20),
         b'miph': (3500, 0x1b8), b'mtph': (84, 68)}


def possible_reference(library, persistent_id: int, *, excluded=None,
                       replacing_members=False, identity_tag=None) -> bool:
    if type(persistent_id) is not int or not 0 < persistent_id < 2**64:
        raise ValueError('reference scan requires a nonzero uint64 identity')
    raw = library.container.header + serialize_sections(library.sections)
    ignored = []
    if len(library.container.header) == 144:
        ignored.append((0x34, 0x3c))  # the library's own ID, not an object edge

    def walk(node, start):
        size = len(node.to_bytes())
        if node is excluded and not replacing_members:
            ignored.append((start, start + size))
            return start + size
        shape = _SELF.get(node.tag)
        if shape is not None and len(node.header) == shape[0]:
            if node.tag == b'mfdh' or (identity_tag is not None and node.tag != identity_tag):
                ignored.append((start + shape[1], start + shape[1] + 8))
        cursor = start + len(node.header)
        if node.children is None:
            cursor += len(node.payload)
        else:
            for child in node.children:
                if node is excluded and replacing_members and child.tag == b'mtph':
                    end = cursor + len(child.to_bytes())
                    ignored.append((cursor, end))
                    cursor = end
                else:
                    cursor = walk(child, cursor)
        assert cursor == start + size
        return cursor

    cursor = len(library.container.header)
    for section in library.sections:
        cursor = walk(section, cursor)
    assert cursor == len(raw)
    needles = (persistent_id.to_bytes(8, 'little'), persistent_id.to_bytes(8, 'big'),
               f'{persistent_id:016X}'.encode(), f'{persistent_id:016x}'.encode())
    # Do not concatenate around ignored spans: that would invent byte adjacency.
    cursor = 0
    for start, end in sorted(ignored):
        if start > cursor and any(needle in raw[cursor:start] for needle in needles):
            return True
        cursor = max(cursor, end)
    return any(needle in raw[cursor:] for needle in needles)
