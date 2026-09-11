"""Task-local PROPOSAL prototype for whole-reference closure (subagent a04).

This is a proposal artifact. It is NOT production code, NOT an admission gate,
NOT a write permit, and NOT a proof. It is read-only: it composes existing
read-only checkers and names the reference classes they do not jointly close.

The opt-in auxiliary-identity master predicate (itlkit.admission) is a
NECESSARY condition here, never a sufficient one.
"""
from __future__ import annotations

from dataclasses import dataclass

from itlkit import Library
from itlkit.admission import require_complete_master
from itlkit.errors import FormatError, UnsupportedError
from itlkit.graph import build_graph
from itlkit.references import possible_reference

# Reference-class inventory. Every class is a distinct obligation; the opt-in
# predicate discharges only R1-R6 restricted to the primary sections 1/2/9/11.
CLASSES = {
    'R1': 'track -> album object reference (mith@0xdc -> album.local @16 of miah/88)',
    'R2': 'track -> artist object reference (mith@0x1e0 -> artist.local @16 of miih/100)',
    'R3': 'playlist item -> track reference (mtph@24 -> track.common_local mith@16)',
    'R4': 'master membership multiset (every primary track exactly once)',
    'R5': 'self-identity uniqueness per namespace (local + persistent, incl. playlist-scoped items)',
    'R6': 'file identity coherence (outer hdfm@0x34 big-endian == inner mfdh@0x34 little-endian)',
    'R7': 'shared-string pool consistency (wire_id -> text is a function per pool; canonical mhoh/24 consumer)',
    'R8': 'name-kind derived keys (miah 300/301/302 and miih 400 equal the key derived from the owning track)',
    'R9': 'secondary/duplicate consumer scopes (mith/miah/miih outside canonical sections 1/9/11)',
    'R10': 'opaque spans as possible edge carriers (unmapped sections, unmapped leaves, unmapped mhoh codes, compression trailer)',
    'R11': 'null-reference class (a zero-valued typed reference slot is treated as unset without proof)',
}

# Obligations this prototype CANNOT discharge. Stated so that a passing
# closure result is never mistaken for a guarantee.
UNPROVED = (
    'R10 non-carrier: no evidence proves an opaque span carries no reference; closure is only ever modulo the declared opaque set.',
    'R11 null semantics: no evidence proves that a zero reference slot means unset rather than a dangling edge.',
    'GC: known_unreachable is not proof of unreachable; retained objects may be reached through opaque spans.',
    'Scan: references.possible_reference is a conservative byte scan, so a negative result is bounded by the retained-byte set, and a positive result is not proof of a real edge.',
    'Pools: the pool map is static keyed-dispatch evidence; pool disjointness from unparsed sections is not proved.',
    'Native: nothing here implies native acceptance, persistence, or playback.',
)

_ISSUE_CLASS = {
    'missing_track_reference': 'R3',
    'master_count': 'R4',
    'master_membership_not_exactly_once': 'R4',
    'zero_or_duplicate_identity': 'R5',
    'file_pid_header_mismatch': 'R6',
    'pool_id_text_collision': 'R7',
    'external_id_not_positive_signed_int': 'R7',
    'duplicate_text_occurrence': 'R7',
    'resolving_but_wrong_album': 'R8',
    'resolving_but_wrong_artist': 'R8',
}


def _blocker_class(blocker):
    if blocker.startswith('noncanonical-string-consumer'):
        return 'R7'
    if blocker.startswith('unresolved:'):
        return 'R9'
    return 'R10'


@dataclass(frozen=True)
class ClosureReport:
    """A diagnostic proposal report. `closed` is never a write authorization."""

    closed: bool
    violations: tuple
    opaque_span_count: int
    unproved: tuple = UNPROVED
    complete_semantic: bool = False


def opt_in_master_accepts(data):
    """True when the existing opt-in predicate accepts the snapshot."""
    try:
        require_complete_master(Library.from_bytes(data))
    except (FormatError, UnsupportedError, TypeError):
        return False
    return True


def reference_closure(data, *, limits=None):
    """Proposed whole-reference closure predicate over one snapshot.

    Necessary conditions, in order: the opt-in master predicate, then every
    known typed reference class, then pool consistency, then scope and opaque
    declarations. Structural decode failures propagate; they are not closure.
    """
    violations = set()
    if not opt_in_master_accepts(data):
        violations.add(('C1', 'opt-in complete-master predicate rejects the snapshot'))
    graph = build_graph(data, limits=limits)
    document = graph.to_dict()
    for issue in document['issues']:
        code = issue['code']
        if code == 'missing_object_reference':
            name = 'R1' if issue.get('role') == 'album' else 'R2'
        else:
            name = _ISSUE_CLASS.get(code, 'R5')
        violations.add((name, 'graph issue: ' + code))
    for blocker in graph.coverage['pool_blockers']:
        violations.add((_blocker_class(blocker), 'coverage blocker: ' + blocker))
    for unknown in document['unknown']:
        violations.add(('R9', 'unresolved: ' + str(unknown.get('reason'))))
    for row in document['tracks']:
        for role, key in (('album', 'album_ref'), ('artist', 'artist_ref')):
            if not row[key]:
                violations.add(('R11', 'null ' + role + ' reference slot is an unproved class'))
    return ClosureReport(not violations, tuple(sorted(violations)), len(document['opaque_spans']))


def alias_scan(data, value, *, owner_tag):
    """Conservative scan pair: (default, self-identity-slot excluded).

    A differing pair means the only retained occurrence is the object's own
    self-identity slot. That is evidence about retained bytes only.
    """
    library = Library.from_bytes(data)
    return (possible_reference(library, value),
            possible_reference(library, value, identity_tag=owner_tag))
