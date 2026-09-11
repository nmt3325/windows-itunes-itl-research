"""Task-local read-only probe: COW retention, GC class, per-class allocation gates."""
import sys, traceback
sys.path.insert(0, 'tests')
from test_graph_v2 import sample
from itlkit import Library
from itlkit.graph import build_graph
from itlkit import references, cow
from itlkit.identity import ReservationAllocator

OLD_ALBUM_PID = 0xBBBB000000000001
INTENT = {'track_pid': '%016X' % 0xAACC000000000001, 'fields': {'album': 'Different Album'}}

base = sample()
res = cow._prepare_candidate(base, INTENT, seed=b'a' * 32)
cand = res.candidate_bytes
libc = Library.from_bytes(cand)
new_pid = int([p.owner for p in res.text_patches if p.owner.startswith('album:')][0].split(':')[1], 16)

print('=== COW retention / scan discrimination ===')
print('old default          :', references.possible_reference(libc, OLD_ALBUM_PID))
print('old self-slot-ignored:', references.possible_reference(libc, OLD_ALBUM_PID, identity_tag=b'mith'))
print('new default          :', references.possible_reference(libc, new_pid))
print('new self-slot-ignored:', references.possible_reference(libc, new_pid, identity_tag=b'mith'))

print('=== candidate GC rows ===')
for row in build_graph(cand).to_dict()['gc']:
    print(' ', row['role'], row['local_id'], row['pid'], 'inbound=', row['known_track_inbound'],
          'unreachable=', row['known_unreachable'], row['semantic_gc'])

print('=== extra_identities (secondary scope) ===')
print(build_graph(sample(secondary=True)).to_dict()['extra_identities'])

print('=== COW on non-closed inputs ===')
for name, data in (('secondary', sample(secondary=True)), ('opaque', sample(opaque=True)), ('alias', sample(alias=True))):
    try:
        out = cow._prepare_candidate(data, INTENT, seed=b'a' * 32)
        print(' ', name, '->', type(out).__name__, getattr(out, 'blockers', ''))
    except Exception as exc:
        print(' ', name, '-> EXC', type(exc).__name__, exc)

print('=== per-class allocation gates ===')
for name, data in (('clean', base), ('secondary', sample(secondary=True)), ('opaque', sample(opaque=True))):
    g = build_graph(data)
    a = ReservationAllocator(g, seed=b'a' * 32)
    try:
        loc = a.local('album'); print(' ', name, 'local ->', loc.value)
    except Exception as exc:
        print(' ', name, 'local -> EXC', type(exc).__name__, exc)
    try:
        a2 = ReservationAllocator(build_graph(data), seed=b'a' * 32)
        pid = a2.persistent('album'); print(' ', name, 'pid   ->', hex(pid.value))
    except Exception as exc:
        print(' ', name, 'pid   -> EXC', type(exc).__name__, exc)
    try:
        a3 = ReservationAllocator(build_graph(data), seed=b'a' * 32)
        atom = a3.atom('L+0x1c0', None, 'Whatever'); print(' ', name, 'atom  ->', atom.value)
    except Exception as exc:
        print(' ', name, 'atom  -> EXC', type(exc).__name__, str(exc)[:110])
