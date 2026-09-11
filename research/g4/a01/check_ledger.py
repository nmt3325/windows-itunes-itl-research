#!/usr/bin/env python3
"""a01 self-check for docs/g4/a01/g3-provenance.md.

Verifies the ledger is well formed markdown and that every section carries an
evidence-class label, plus the required provenance anchors. Recovered command streams are referenced
by the sanitized pseudonyms S1-S5, not by runner command identifiers, which are
withheld from the published record.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[3]
DOC = ROOT / "docs" / "g4" / "a01" / "g3-provenance.md"

CLASS_RE = re.compile(r"class A|class B|class C|missing", re.IGNORECASE)
ANCHORS = [
    "baseline - S1 (exit 0, 1419 B)",
    "red-fix-green-full - S2 (exit 0, 2350 B)",
    "- S3 (exit 1, 1029 B)",
    "- S4 (exit 0, 1050 B)",
    "- S5 (exit 1, 912 B)",
    "hardening/itl-20260910-g3-review",
    "5d72aea15cbded646e62b33f050bfff7c3bc8fc67d00c223b6c57ede11bc06df",
    "1e1211061e461551ba7765bf87725158b0360c47076595403b724e08058d5523",
    "dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3",
    "1bb05edc2494abc9aa9b59cd2392026f830615a2",
]
FORBIDDEN = ["TODO", "TBD", "FIXME", "XXX"]

failures = []

if not DOC.is_file():
    print("FAIL doc-exists %s" % DOC)
    sys.exit(2)

text = DOC.read_text(encoding="utf-8")
lines = text.splitlines()
print("OK   doc-exists %s (%d bytes, %d lines)" % (DOC, len(text.encode("utf-8")), len(lines)))

fences = [i for i, ln in enumerate(lines) if ln.startswith("```")]
if len(fences) % 2 != 0:
    failures.append("unbalanced code fences: %d fence lines" % len(fences))
else:
    print("OK   fences-balanced %d fence lines, %d blocks" % (len(fences), len(fences) // 2))

h1 = [ln for ln in lines if ln.startswith("# ")]
if len(h1) != 1:
    failures.append("expected exactly one H1, found %d" % len(h1))
else:
    print("OK   single-h1 %s" % h1[0])

in_fence = False
sections = []
current = None
for ln in lines:
    if ln.startswith("```"):
        in_fence = not in_fence
    if not in_fence and ln.startswith("## "):
        current = [ln[3:].strip(), []]
        sections.append(current)
    elif current is not None:
        current[1].append(ln)

if not sections:
    failures.append("no level-2 sections found")
for name, body in sections:
    blob = "\n".join(body)
    if CLASS_RE.search(blob) or CLASS_RE.search(name):
        print("OK   class-labelled section: %s" % name)
    else:
        failures.append("section without evidence class: %s" % name)

for anchor in ANCHORS:
    if anchor in text:
        print("OK   anchor %s" % anchor)
    else:
        failures.append("missing anchor: %s" % anchor)

for bad in FORBIDDEN:
    if bad in text:
        failures.append("placeholder left in ledger: %s" % bad)

if failures:
    for f in failures:
        print("FAIL %s" % f)
    sys.exit(1)

print("ALL CHECKS PASSED: %d sections, %d anchors" % (len(sections), len(ANCHORS)))
