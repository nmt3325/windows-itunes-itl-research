"""Task-local a04 controls: whole-reference closure PROPOSAL vs the opt-in predicate.

These tests demonstrate a proposal against the existing synthetic fixture
harness. They prove nothing about native acceptance, persistence, playback or
complete semantic admission, and they grant no write capability. No existing
production file or fixture is modified.
"""
import pathlib
import sys

import pytest

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[1] / 'research' / 'g4' / 'a04'))

import closure_prototype as closure  # noqa: E402
from itlkit import Library, cow, references  # noqa: E402
from itlkit.errors import UnsupportedError  # noqa: E402
from itlkit.graph import build_graph  # noqa: E402
from itlkit.identity import ReservationAllocator  # noqa: E402
from test_core_support import library_bytes, playlist, track  # noqa: E402
from test_graph_v2 import sample  # noqa: E402

MASTER = 0xBEEF000000000001
OLD_ALBUM_PID = 0xBBBB000000000001
TRACK_PID = 0xAACC000000000001
INTENT = {'track_pid': '%016X' % TRACK_PID, 'fields': {'album': 'Different Album'}}
SEED = b'a' * 32


def zero_reference_library():
    """Opt-in-clean fixture whose typed album/artist reference slots stay zero."""
    return library_bytes(tracks=[track(i) for i in (1, 2, 3)],
                         playlists=[playlist([1, 2, 3], pid=MASTER, master=True, local_id=4)])


CASES = {
    'resolved': sample(),
    'secondary_consumer_scope': sample(secondary=True),
    'unmapped_opaque_section': sample(opaque=True),
    'pool_alias': sample(alias=True),
    'zero_reference': zero_reference_library(),
}
COUNTEREXAMPLES = ('secondary_consumer_scope', 'unmapped_opaque_section',
                   'pool_alias', 'zero_reference')


@pytest.mark.parametrize('name', sorted(CASES))
def test_opt_in_predicate_accepts_every_case(name):
    assert closure.opt_in_master_accepts(CASES[name]) is True


def test_closure_holds_only_for_the_fully_resolved_fixture():
    report = closure.reference_closure(CASES['resolved'])
    assert report.closed and report.violations == ()
    assert report.complete_semantic is False


@pytest.mark.parametrize('name,expected', [
    ('secondary_consumer_scope', 'R9'),
    ('unmapped_opaque_section', 'R10'),
    ('pool_alias', 'R7'),
    ('zero_reference', 'R11'),
])
def test_counterexamples_accepted_by_opt_in_predicate_but_rejected_by_closure(name, expected):
    data = CASES[name]
    assert closure.opt_in_master_accepts(data) is True
    report = closure.reference_closure(data)
    assert not report.closed
    assert expected in {name for name, _ in report.violations}


def test_zero_reference_case_also_breaks_file_identity_coherence():
    report = closure.reference_closure(CASES['zero_reference'])
    assert {'R6', 'R11'} <= {name for name, _ in report.violations}


@pytest.mark.parametrize('name', ['secondary_consumer_scope', 'unmapped_opaque_section'])
def test_pool_allocation_is_closure_gated_but_local_and_pid_are_not(name):
    data = CASES[name]
    assert not closure.reference_closure(data).closed
    with pytest.raises(UnsupportedError):
        ReservationAllocator(build_graph(data), seed=SEED).atom('L+0x1c0', None, 'Any Title')
    assert ReservationAllocator(build_graph(data), seed=SEED).local('album').value > 0
    assert ReservationAllocator(build_graph(data), seed=SEED).persistent('album').width == 8


@pytest.mark.parametrize('name', ['secondary_consumer_scope', 'unmapped_opaque_section', 'pool_alias'])
def test_cow_refuses_every_closure_counterexample(name):
    result = cow._prepare_candidate(CASES[name], INTENT, seed=SEED)
    assert type(result) is cow.BlockedCOW and result.blockers


def test_cow_on_a_closed_snapshot_retains_objects_and_stays_closed():
    result = cow._prepare_candidate(CASES['resolved'], INTENT, seed=SEED)
    assert type(result) is not cow.BlockedCOW
    before = build_graph(CASES['resolved']).to_dict()['albums']
    after = build_graph(result.candidate_bytes).to_dict()['albums']
    assert len(after) == len(before) + 1
    assert {a['pid'] for a in before} <= {a['pid'] for a in after}
    assert closure.reference_closure(result.candidate_bytes).closed


def test_conservative_scan_needs_a_tag_hint_to_separate_self_slot_from_alias():
    result = cow._prepare_candidate(CASES['resolved'], INTENT, seed=SEED)
    library = Library.from_bytes(result.candidate_bytes)
    assert references.possible_reference(library, OLD_ALBUM_PID) is True
    assert references.possible_reference(library, OLD_ALBUM_PID, identity_tag=b'mith') is False


def test_proposal_declares_its_unproved_obligations():
    assert closure.UNPROVED and all(isinstance(x, str) and x for x in closure.UNPROVED)
    assert set(closure.CLASSES) >= {'R' + str(i) for i in range(1, 12)}
    assert closure.reference_closure(CASES['resolved']).complete_semantic is False
