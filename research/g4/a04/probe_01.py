"""Task-local read-only probe: GATE01 vs known-graph closure facts."""
import json, sys, traceback
sys.path.insert(0, 'tests')
from test_core_support import library_bytes, track, playlist
from test_graph_v2 import sample
from itlkit import Library
from itlkit.admission import require_complete_master
from itlkit.graph import build_graph
from itlkit import references, cow


def gate(data):
    try:
        require_complete_master(Library.from_bytes(data))
        return 'ACCEPT'
    except Exception as exc:
        return 'REJECT:%s:%s' % (type(exc).__name__, exc)


def facts(data):
    g = build_graph(data); d = g.to_dict()
    return {'issues': sorted({i['code'] for i in d['issues']}),
            'unknown': sorted({u.get('reason', '') for u in d['unknown']}),
            'blockers': list(g.coverage['pool_blockers'])}


cases = {
    'sample': sample(),
    'sample_secondary': sample(secondary=True),
    'sample_opaque': sample(opaque=True),
    'sample_alias': sample(alias=True),
    'zero_ref': library_bytes(tracks=[track(i) for i in (1, 2, 3)],
                              playlists=[playlist([1, 2, 3], pid=0xBEEF000000000001,
                                                  master=True, local_id=4)]),
}
for name, data in cases.items():
    print('---', name)
    print('  gate:', gate(data))
    try:
        print('  closure:', json.dumps(facts(data)))
    except Exception as exc:
        print('  closure_error:', type(exc).__name__, exc)

print('=== cow probe ===')
data = sample()
intent = {'track_pid': '%016X' % 0xAACC000000000001, 'fields': {'album': 'Different Album'}}
try:
    res = cow._prepare_candidate(data, intent, seed=b'a' * 32)
    print('cow result:', type(res).__name__)
    if type(res).__name__ == 'BlockedCOW':
        print('  blockers:', res.blockers)
    else:
        cand = res.candidate_bytes
        print('  lens:', len(data), len(cand))
        libc = Library.from_bytes(cand)
        print('  old_album_pid_possible_ref:', references.possible_reference(libc, 0xBBBB000000000001))
        print('  patches:', [(p.owner, p.code, p.value, p.identity.namespace, p.identity.value) for p in res.text_patches])
        gc = build_graph(cand).to_dict()
        print('  cand_issues:', sorted({i['code'] for i in gc['issues']}))
        print('  albums_after:', [(a['local_id'], a['pid']) for a in gc['albums']])
        print('  gate_after:', gate(cand))
except Exception as exc:
    print('cow_error:', type(exc).__name__, exc)
    traceback.print_exc()

print('=== references probe ===')
lib = Library.from_bytes(sample())
print('  album_pid:', references.possible_reference(lib, 0xBBBB000000000001))
print('  album_pid identity_tag=miah:', references.possible_reference(lib, 0xBBBB000000000001, identity_tag=b'miah'))
print('  unused_pid:', references.possible_reference(lib, 0x0123456789ABCDEF))
