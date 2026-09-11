#!/usr/bin/env python3
"""G4-B a07: byte-level dependency closure for msdh sections 4, 21 and 23.

Every perturbation is applied to an in-memory copy of a committed native
snapshot. Nothing is written to disk, no .itl file is produced, iTunes is never
invoked. The output states exactly which framed fields and byte spans change
when a given region is edited, which is what makes the predictions falsifiable
on a native Windows run.
"""
from __future__ import annotations

import argparse
import copy
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from itlkit.binary import put, uint  # noqa: E402
from itlkit.container import Container  # noqa: E402
from itlkit.library import Library  # noqa: E402
from itlkit.model import parse_sections  # noqa: E402


def node_list(sections):
    out = []

    def walk(node, path):
        out.append((path, node))
        for index, child in enumerate(node.children or ()):
            tag = child.tag.decode('latin-1', 'replace')
            walk(child, '%s/%s[%d]' % (path, tag, index))

    for index, section in enumerate(sections):
        walk(section, 'msdh[%d](type=%s)' % (index, section.section_type))
    return out


def changed_words(before, after):
    out = {}
    for off in range(0, min(len(before), len(after)) - 3, 4):
        a, b = uint(before, off, 4), uint(after, off, 4)
        if a != b:
            out['+0x%x' % off] = {'before': a, 'after': b}
    return out


def first_difference(before, after):
    limit = min(len(before), len(after))
    for index in range(limit):
        if before[index] != after[index]:
            return index
    return limit if len(before) != len(after) else None


def structural_diff(before_sections, after_sections):
    before, after = node_list(before_sections), node_list(after_sections)
    diffs = []
    if len(before) != len(after):
        diffs.append({'kind': 'node_count', 'before': len(before), 'after': len(after)})
    for (path_a, node_a), (path_b, node_b) in zip(before, after):
        if path_a != path_b:
            diffs.append({'kind': 'path', 'before': path_a, 'after': path_b})
            continue
        header_a, header_b = bytes(node_a.header), bytes(node_b.header)
        if header_a != header_b:
            diffs.append({'kind': 'header', 'path': path_a,
                          'header_len': [len(header_a), len(header_b)],
                          'word_changes': changed_words(header_a, header_b)})
        payload_a, payload_b = bytes(node_a.payload), bytes(node_b.payload)
        if payload_a != payload_b:
            diffs.append({'kind': 'payload', 'path': path_a,
                          'len': [len(payload_a), len(payload_b)],
                          'first_diff_offset': first_difference(payload_a, payload_b)})
    return diffs


def outer_header_diff(before, after):
    out = {}
    for off in range(0, min(len(before), len(after)) - 3, 4):
        a = int.from_bytes(before[off:off + 4], 'big')
        b = int.from_bytes(after[off:off + 4], 'big')
        if a != b:
            out['+0x%x' % off] = {'before': a, 'after': b}
    return out


def section_of(library, section_type):
    matches = [s for s in library.sections if s.section_type == section_type]
    if len(matches) != 1:
        raise SystemExit('expected exactly one section %d' % section_type)
    return matches[0]


def apply_and_measure(path, name, mutate, expectation):
    original = Library.read(path)
    before_payload = bytes(original.container.payload)
    before_header = bytes(original.container.header)
    before_sections = parse_sections(before_payload)
    candidate = Library.read(path)
    note = mutate(candidate)
    result = {'perturbation': name, 'note': note, 'expectation': expectation}
    try:
        data = candidate.to_bytes()
    except Exception as exc:  # noqa: BLE001
        result['accepted_by_itlkit'] = False
        result['error'] = type(exc).__name__ + ': ' + str(exc)
        return result
    rebuilt = Container.from_bytes(data)
    after_payload = bytes(rebuilt.payload)
    after_sections = parse_sections(after_payload)
    result['accepted_by_itlkit'] = True
    result['plaintext_bytes'] = {'before': len(before_payload), 'after': len(after_payload),
                                 'delta': len(after_payload) - len(before_payload)}
    result['outer_header_changes'] = outer_header_diff(before_header, bytes(rebuilt.header))
    result['structural_diff'] = structural_diff(before_sections, after_sections)
    result['unchanged_node_fraction'] = '%d/%d' % (
        len(node_list(before_sections)) - len({d.get('path') for d in result['structural_diff']
                                               if d.get('path')}),
        len(node_list(before_sections)))
    return result


def field_offsets(path):
    """Absolute plaintext offsets of every length/count field the regions depend on."""
    library = Library.read(path)
    sections = library.sections
    out = {}
    for section in sections:
        if section.section_type == 16:
            root = section.children[0]
            out['mfdh.logical_size@+8'] = root.offset + 8
            out['mfdh.section_count@+0x30'] = root.offset + 0x30
        if section.section_type == 4:
            out['msdh(4).total@+8'] = section.offset + 8
            out['section4.url_span'] = [section.offset + len(section.header),
                                        section.offset + len(section.header) + len(section.payload)]
        if section.section_type == 23:
            out['msdh(23).total@+8'] = section.offset + 8
            out['stsh.header_len@+4'] = section.offset + len(section.header) + 4
            out['stsh.count@+8'] = section.offset + len(section.header) + 8
            out['stsh.body_span'] = [section.offset + len(section.header) + 16,
                                     section.offset + len(section.header) + len(section.payload)]
        if section.section_type == 21:
            root = section.children[0]
            msph = root.children[0]
            out['msdh(21).total@+8'] = section.offset + 8
            out['mlsh.count@+8'] = root.offset + 8
            out['msph.total@+8'] = msph.offset + 8
            out['msph.kind@+12'] = msph.offset + 12
            body = msph.offset + len(msph.header)
            out['mhoh800.total@+8'] = body + 8
            out['mhoh800.type_code@+12'] = body + 12
            out['mhoh800.xml_span'] = [body + 24, body + len(msph.payload)]
    return out


def mutate_section4_longer(library):
    section = section_of(library, 4)
    text = bytes(section.payload)
    section.payload = text[:-1] + b'X/'
    return 'insert one ASCII byte before the trailing slash of the media-folder URL'


def mutate_section4_shorter(library):
    section = section_of(library, 4)
    section.payload = bytes(section.payload)[:-2] + b'/'
    return 'delete one ASCII byte before the trailing slash of the media-folder URL'


def mutate_stsh_reserved_byte(library):
    section = section_of(library, 23)
    payload = bytearray(section.payload)
    payload[0x10] = 0x01
    section.payload = bytes(payload)
    return 'set the first reserved stsh byte (+0x10) to 1, length unchanged'


def mutate_stsh_count(library):
    section = section_of(library, 23)
    payload = bytearray(section.payload)
    put(payload, 8, 1)
    section.payload = bytes(payload)
    return 'declare stsh entry count 1 at +8 while the body stays 96 bytes'


def _rewrite_msph_xml(library, replace_from, replace_to):
    section = section_of(library, 21)
    msph = section.children[0].children[0]
    payload = bytes(msph.payload)
    head, xml = payload[:24], payload[24:]
    if replace_from not in xml:
        raise SystemExit('expected marker not found in msph800 XML')
    xml = xml.replace(replace_from, replace_to, 1)
    head = bytearray(head)
    put(head, 8, 24 + len(xml))
    msph.payload = bytes(head) + xml
    return len(xml)


def mutate_msph_title_longer(library):
    size = _rewrite_msph_xml(library, b'<string>Most Recent</string>',
                             b'<string>Most Recent XYZ</string>')
    return 'lengthen the msph800 title string by 4 bytes (xml now %d bytes)' % size


def mutate_msph_date(library):
    size = _rewrite_msph_xml(library, b'<date>2026-09-09T11:13:03Z</date>',
                             b'<date>2027-01-02T03:04:05Z</date>')
    return 'rewrite updatedDate in place, same length (xml stays %d bytes)' % size


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--snapshot',
                        default=str(ROOT / 'evidence/native/snapshots/001-one-track.itl'))
    parser.add_argument('--out', default=None)
    args = parser.parse_args()
    path = Path(args.snapshot)
    cases = [
        ('section4.url_plus_one_byte', mutate_section4_longer,
         'only the section-4 URL bytes and msdh(4) total move; every other node is byte-identical'),
        ('section4.url_minus_one_byte', mutate_section4_shorter,
         'mirror image of the previous case'),
        ('section23.reserved_byte_set', mutate_stsh_reserved_byte,
         'one byte inside the 96-byte stsh body changes; no length field moves'),
        ('section23.declared_count_1', mutate_stsh_count,
         'stsh +8 becomes 1 with no entry bytes; itlkit framing still validates'),
        ('section21.title_plus_four_bytes', mutate_msph_title_longer,
         'xml span plus mhoh800/msph/msdh(21) totals move; sections after 21 shift but keep content'),
        ('section21.updated_date_same_length', mutate_msph_date,
         'only XML bytes change; no length field moves'),
    ]
    document = {'schema': 'g4.a07.delta-closure.v1',
                'snapshot': path.name,
                'field_offsets_in_plaintext': field_offsets(path),
                'cases': [apply_and_measure(path, name, mutate, expectation)
                          for name, mutate, expectation in cases]}
    if args.out:
        Path(args.out).parent.mkdir(parents=True, exist_ok=True)
        Path(args.out).write_text(json.dumps(document, indent=1, sort_keys=True) + '\n',
                                  encoding='utf-8')
    print('snapshot:', path.name)
    print('field offsets:', json.dumps(document['field_offsets_in_plaintext'], indent=1, sort_keys=True))
    for case in document['cases']:
        print('\n===', case['perturbation'], '===')
        print(' note:', case['note'])
        print(' accepted_by_itlkit:', case['accepted_by_itlkit'])
        if not case['accepted_by_itlkit']:
            print(' error:', case['error'])
            continue
        print(' plaintext bytes:', case['plaintext_bytes'])
        print(' outer header changes:', json.dumps(case['outer_header_changes'], sort_keys=True))
        for diff in case['structural_diff']:
            print('  ', json.dumps(diff, sort_keys=True))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
