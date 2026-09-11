"""a03: the identity/SourceBinding seam between construct.py and planning.py.

Synthetic fixtures only. These tests prove structural evidence conversion and
its refusals. Nothing here proves semantic permission, container membership,
reference closure or native acceptance, and nothing here relaxes a gate.
"""
import json
from dataclasses import fields

import pytest

from test_graph_v2 import sample
from itlkit import construct, planning, schema
from itlkit.construct import (ConstructionError, IDENTITY_REQUIREMENTS, WaveRecordBindings,
                              bindings_from_ledger, unmet_construction_conditions)
from itlkit.errors import FormatError
from itlkit.graph import build_graph
from itlkit.identity import ReservationAllocator, source_binding, to_canonical_ledger

RECIPE = tuple(row[1] for row in IDENTITY_REQUIREMENTS)
SLOTS = tuple(row[3] for row in IDENTITY_REQUIREMENTS)


def _name_rows(graph):
    return [r for r in graph.to_dict()['strings']
            if r['registered_pool_binding'] and r['pool'] == 'L+0x178']


def _canonical_ledger(*, bind_name=False, skip=None, extra=False, seed=20260911):
    graph = build_graph(sample())
    allocator = ReservationAllocator(graph, seed=seed)

    def name_atom():
        rows = _name_rows(graph)
        assert rows, 'fixture must expose a registered Name pool row'
        binding = source_binding(graph, rows[0]['owner'], rows[0]['type']) if bind_name else None
        return allocator.atom('L+0x178', binding, 'A03 constructed title')

    steps = (
        ('track.common_local', lambda: allocator.local('track.common')),
        ('track.file_local', lambda: allocator.local('track.file')),
        ('album.local', lambda: allocator.local('album')),
        ('artist.local', lambda: allocator.local('artist')),
        ('track.pid', lambda: allocator.persistent('track')),
        ('pool:L+0x178', name_atom),
        ('pool:L+0x370', lambda: allocator.atom('L+0x370', None, 'WAV audio file')),
    )
    for namespace, step in steps:
        if namespace != skip:
            step()
    if extra:
        allocator.atom('L+0x1c0', None, 'A03 album')
    return to_canonical_ledger(allocator.freeze(), graph.data,
                               seed_material=allocator.seed_material)


def test_a03_requirements_match_the_shared_identity_vocabulary():
    names = [row[0] for row in IDENTITY_REQUIREMENTS]
    assert len(names) == len(set(names)) == 7
    assert set(names) <= {f.name for f in fields(WaveRecordBindings)}
    assert len(set(SLOTS)) == 7
    for _field, namespace, width, _slot in IDENTITY_REQUIREMENTS:
        assert schema.IDENTITY_V2_WIDTHS[namespace] == width
        if namespace.startswith('pool:'):
            assert namespace[5:] in schema.IDENTITY_V2_POOLS
    assert IDENTITY_REQUIREMENTS[5][1] == 'pool:' + schema.importer_pool_domain('name')
    assert IDENTITY_REQUIREMENTS[6][1] == 'pool:' + schema.importer_pool_domain('kind')


def test_a03_complete_canonical_ledger_binds_every_recipe_slot():
    ledger = _canonical_ledger()
    index = planning.identity_binding_index(ledger)
    assert set(index) == set(RECIPE)
    bindings, provenance = bindings_from_ledger(ledger)
    assert type(bindings) is WaveRecordBindings
    assert set(provenance) == set(SLOTS)
    for field_name, namespace, width, slot in IDENTITY_REQUIREMENTS:
        assert len(index[namespace]) == 1
        reserved = index[namespace][0].reserved_identity
        assert reserved.width == width
        assert reserved.scope == ledger.snapshot.digest
        assert getattr(bindings, field_name) == reserved.value
        assert reserved.value > 0
        assert provenance[slot]['namespace'] == namespace
    assert len({bindings.track_local, bindings.secondary_local,
                bindings.album_local, bindings.artist_local}) == 4
    bindings.validate()


@pytest.mark.parametrize('missing', RECIPE)
def test_a03_incomplete_identity_set_is_refused(missing):
    ledger = _canonical_ledger(skip=missing)
    assert missing not in planning.identity_binding_index(ledger)
    with pytest.raises(ConstructionError):
        bindings_from_ledger(ledger)


def test_a03_reservation_outside_the_recipe_is_refused():
    ledger = _canonical_ledger(extra=True)
    index = planning.identity_binding_index(ledger)
    assert 'pool:L+0x1c0' in index and set(RECIPE) <= set(index)
    with pytest.raises(ConstructionError):
        bindings_from_ledger(ledger)


def test_a03_source_binding_provenance_is_preserved_not_relabeled():
    ledger = _canonical_ledger(bind_name=True)
    bindings, provenance = bindings_from_ledger(ledger)
    row = _name_rows(build_graph(sample()))[0]
    name = provenance['mhoh:mith:2']
    assert name['source_binding'] is not None
    assert name['source_binding']['pool'] == 'L+0x178'
    assert name['source_binding']['wire_id'] == row['wire_id']
    assert name['source_binding']['value_digest'] == row['utf16_sha256']
    assert name['source_binding']['snapshot'] == ledger.snapshot.digest
    assert name['consumers'] and all(':' in c for c in name['consumers'])
    assert provenance['mhoh:mith:6']['source_binding'] is None
    assert provenance['mhoh:mith:6']['consumers'] == ()
    assert bindings.name_atom > 0 and bindings.kind_atom > 0


def test_a03_index_refuses_reports_and_snapshotless_ledgers():
    ledger = _canonical_ledger()
    with pytest.raises(TypeError):
        planning.identity_binding_index(schema.plain(ledger))
    with pytest.raises(TypeError):
        planning.identity_binding_index({'reservations': (), 'snapshot': None})
    empty = schema.AllocationLedger()
    assert empty.snapshot is None and empty.reservations == ()
    with pytest.raises(FormatError):
        planning.identity_binding_index(empty)
    with pytest.raises(FormatError):
        bindings_from_ledger(empty)


def test_a03_binding_evidence_does_not_unblock_the_constructor():
    from test_construct_v2 import _g2fac_input
    target, intent, source = _g2fac_input()
    result = construct.prepare(target, intent, {'media': source})
    assert type(result) is schema.ProfileReport and result.blocked
    codes = {b.code for b in result.blockers}
    assert {'identity_pool_master_closure_pending', 'constructor_candidate_unavailable',
            'candidate_accounting_pending', 'identity_binding_closure_unproved'} <= codes
    assert 'media_resource_lane' in result.capabilities
    blocker = next(b for b in result.blockers if b.code == 'identity_binding_closure_unproved')
    assert all(row['code'] in blocker.message for row in unmet_construction_conditions())


def test_a03_unmet_conditions_are_explicit_and_json_safe():
    conditions = unmet_construction_conditions()
    assert len(conditions) >= 6
    codes = [row['code'] for row in conditions]
    assert len(codes) == len(set(codes))
    for row in conditions:
        assert set(row) == {'code', 'owner', 'detail'}
        assert all(type(value) is str and value for value in row.values())
    assert 'kind_atom_outside_constructor_pool_guard' in codes
    json.dumps(conditions)
