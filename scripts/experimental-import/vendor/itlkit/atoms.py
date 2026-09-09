"""Fail closed on known string-pool aliases; no global-ID renumbering or COW.

These are qualified, statically traced domains, not one namespace for every
mhoh. Pool allocation/compaction and unknown consumers remain unsupported.
"""
from .binary import uint
from .errors import UnsupportedError

_POOLS = {}
for owner, codes, pool in (
    (b'mith', (2,), 'name'), (b'mith', (3,), 'album'),
    (b'miah', (300,), 'album'), (b'mith', (4, 12, 27), 'artist'),
    (b'miah', (301, 302), 'artist'), (b'miih', (400,), 'artist'),
    (b'mith', (5,), 'genre'), (b'mith', (8,), 'comment'),
    (b'mith', (30,), 'sort_name'), (b'mith', (31,), 'sort_album'),
    (b'mith', (32, 33, 34), 'sort_artist'), (b'miih', (401,), 'sort_artist')):
    for code in codes:
        _POOLS[owner, code] = pool


def _rows(library, pools):
    from .library import read_text
    for section in library.sections:
        for owner in section.walk():
            if owner.tag not in (b'mith', b'miah', b'miih'):
                continue
            for node in owner.children or ():
                pool = _POOLS.get((owner.tag, node.type_code)) if node.tag == b'mhoh' else None
                if pool not in pools:
                    continue
                yield owner, node, pool, uint(node.header, 16), read_text(node)


def assert_pool_bindings(library, pools=None):
    """Check only known nonempty, positive-ID bindings; raw reads remain lossless."""
    pools = set(_POOLS.values()) if pools is None else pools
    bindings = {}
    for owner, node, pool, atom_id, value in _rows(library, pools):
        if not atom_id or not value:
            continue  # native empty text does not register a reference-only atom
        key = pool, atom_id
        if key in bindings and bindings[key] != value:
            raise UnsupportedError('conflicting text in a known string-pool identity')
        bindings[key] = value
    return bindings


def guard_text_changes(library, changes):
    """Allow a known binding update only when every known consumer agrees.

    No allocation is attempted. Shared unchanged users, differing replacements,
    and unkeyed additions into a populated explicit-ID domain are refused.
    The caller must update all supplied occurrences in one transaction.
    """
    from .library import read_text, text_nodes
    active = []
    for owner, code, value in changes:
        if not isinstance(value, str):
            raise ValueError('text must be a string')
        nodes = text_nodes(owner, code)
        if len(nodes) > 1:
            raise UnsupportedError('ambiguous text occurrence')
        node = nodes[0] if nodes else None
        if (read_text(node) if node else '') == value:
            continue
        pool = _POOLS.get((owner.tag, code))
        if pool is None:
            if owner.tag == b'mith' and code in (11, 13):
                continue  # distinct file-local domain; relocation has its own guard
            raise UnsupportedError('text edits in an unknown pool are unsupported')
        atom_id = uint(node.header, 16) if node else 0
        active.append((node, pool, atom_id, value))
    pools = {row[1] for row in active}
    bindings = assert_pool_bindings(library, pools)
    users = list(_rows(library, pools))
    changed = {id(node): value for node, pool, atom_id, value in active if node is not None}
    desired = {}
    for node, pool, atom_id, value in active:
        if not atom_id:
            if any(p == pool for p, _ in bindings):
                raise UnsupportedError('new/unkeyed text in an explicit string pool requires unimplemented scoped allocation')
            continue
        key = pool, atom_id
        if key in desired and desired[key] != value:
            raise UnsupportedError('different replacements of a shared string atom require unimplemented COW')
        desired[key] = value
        for owner, other, other_pool, other_id, old_value in users:
            if other_pool == pool and other_id == atom_id and old_value and other is not node:
                if id(other) not in changed or changed[id(other)] != value:
                    raise UnsupportedError('shared string atom requires unimplemented scoped COW')
