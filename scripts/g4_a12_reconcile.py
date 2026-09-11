#!/usr/bin/env python3
"""G4/a12 evidence reconciler (read-only).

Reconciles pytest JUnit XML evidence against per-phase console summaries.

Facts encoded here were reproduced on env win-r6qwbqfz on 2026-09-11 at base
commit dc4b1c7a9e84a7eefad501da3e1ed65d313cf9f3:

* pytest 9.1.1 counts unittest subTest outcomes in the JUnit tests= attribute
  but never emits a separate <testcase> element for them, therefore
  tests= == primary <testcase> elements + subtest reports.
* pytest 8.4.2 without pytest-subtests does not report subtests at all, so an
  8.x JUnit file of the same suite shows no such inflation.
* A phase in which every test failed legitimately omits the "N passed" phrase
  from its console summary line. Requiring that phrase unconditionally is a
  bug; it may be absent only when the expected pass count is exactly zero.

This module never executes pytest, never writes into the repository tree and
never publishes anything.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Dict, List, Optional, Sequence, Union

PHRASE_PATTERNS: Dict[str, str] = {
    "passed": r"(\d+)\s+passed",
    "failed": r"(\d+)\s+failed",
    "errors": r"(\d+)\s+errors?",
    "skipped": r"(\d+)\s+skipped",
    "xfailed": r"(\d+)\s+xfailed",
    "xpassed": r"(\d+)\s+xpassed",
    "deselected": r"(\d+)\s+deselected",
    "warnings": r"(\d+)\s+warnings?",
    "subtests_passed": r"(\d+)\s+subtests?\s+passed",
    "subtests_failed": r"(\d+)\s+subtests?\s+failed",
}

OUTCOME_KEYS: Sequence[str] = (
    "passed",
    "failed",
    "errors",
    "skipped",
    "xfailed",
    "xpassed",
    "subtests_passed",
    "subtests_failed",
)

_SUMMARY_TIME = re.compile(r"\bin\s+\d+(?:\.\d+)?\s*s\b")
_OUTCOME_WORDS = ("passed", "failed", "error", "skipped", "no tests ran")


def find_summary_line(text: str) -> Optional[str]:
    """Return the last pytest summary line of a console log, else None."""
    for raw in reversed((text or "").splitlines()):
        line = raw.strip().strip("=").strip()
        if not line or _SUMMARY_TIME.search(line) is None:
            continue
        if any(word in line for word in _OUTCOME_WORDS):
            return line
    return None


@dataclass
class ConsoleSummary:
    line: Optional[str]
    counts: Dict[str, Optional[int]]

    def value(self, key: str, default: int = 0) -> int:
        found = self.counts.get(key)
        return default if found is None else found

    def present(self, key: str) -> bool:
        return self.counts.get(key) is not None

    def outcome_total(self) -> int:
        return sum(self.value(key) for key in OUTCOME_KEYS)

    def to_dict(self) -> Dict[str, object]:
        return {"line": self.line, "counts": dict(self.counts)}


def parse_console_summary(text: str) -> ConsoleSummary:
    """Parse a pytest summary line, keeping absent phrases as None.

    Absent must stay distinguishable from zero: that distinction is exactly
    what the historical publication script got wrong.
    """
    line = find_summary_line(text)
    counts: Dict[str, Optional[int]] = dict.fromkeys(PHRASE_PATTERNS)
    if line is not None:
        for key, pattern in PHRASE_PATTERNS.items():
            match = re.search(pattern, line)
            if match is not None:
                counts[key] = int(match.group(1))
    return ConsoleSummary(line=line, counts=counts)


def module_of(classname: Optional[str]) -> str:
    """Map a JUnit classname to its test module, dropping unittest classes."""
    parts = [part for part in (classname or "").split(".") if part]
    for index in range(len(parts) - 1, -1, -1):
        if parts[index].startswith("test_"):
            return ".".join(parts[: index + 1])
    return classname or "<unknown>"


@dataclass
class JunitFacts:
    label: str
    declared: Dict[str, int]
    primary_cases: int
    passed_cases: int
    failed_cases: int
    error_cases: int
    skipped_cases: int
    failure_children: int
    error_children: int
    skipped_children: int
    unique_case_ids: int
    per_module: Dict[str, int]
    per_module_skipped: Dict[str, int]
    skip_reasons: List[Dict[str, object]]
    duplicates: List[Dict[str, object]]

    @property
    def declared_tests(self) -> int:
        return int(self.declared.get("tests", 0))

    @property
    def subtest_inflation(self) -> int:
        return self.declared_tests - self.primary_cases

    def to_dict(self) -> Dict[str, object]:
        data = asdict(self)
        data["declared_tests"] = self.declared_tests
        data["subtest_inflation"] = self.subtest_inflation
        return data


def parse_junit(source: Union[str, Path], label: Optional[str] = None) -> JunitFacts:
    """Parse a JUnit file path or an XML string into JunitFacts."""
    text = str(source)
    if isinstance(source, Path) or not text.lstrip().startswith("<"):
        root = ET.parse(str(source)).getroot()
        label = label or str(source)
    else:
        root = ET.fromstring(text)
        label = label or "<string>"
    suites = [root] if root.tag == "testsuite" else root.findall(".//testsuite")
    declared = {key: 0 for key in ("tests", "failures", "errors", "skipped")}
    for suite in suites:
        for key in declared:
            declared[key] += int(suite.get(key) or 0)
    cases = root.findall(".//testcase")
    per_module: Counter = Counter()
    per_module_skipped: Counter = Counter()
    skip_reasons: Counter = Counter()
    identities: Counter = Counter()
    passed = failed = errored = skipped = 0
    failure_children = error_children = skipped_children = 0
    for case in cases:
        module = module_of(case.get("classname"))
        per_module[module] += 1
        identities[(case.get("classname") or "", case.get("name") or "")] += 1
        failures = case.findall("failure")
        errors = case.findall("error")
        skips = case.findall("skipped")
        failure_children += len(failures)
        error_children += len(errors)
        skipped_children += len(skips)
        for skip in skips:
            reason = (skip.get("message") or "").strip()
            skip_reasons[(module, skip.get("type") or "", reason)] += 1
        if errors:
            errored += 1
        elif failures:
            failed += 1
        elif skips:
            skipped += 1
            per_module_skipped[module] += 1
        else:
            passed += 1
    duplicates = [
        {"classname": key[0], "name": key[1], "count": count}
        for key, count in sorted(identities.items())
        if count > 1
    ]
    reasons = [
        {"module": key[0], "type": key[1], "message": key[2], "count": count}
        for key, count in sorted(skip_reasons.items(), key=lambda item: (-item[1], item[0]))
    ]
    return JunitFacts(
        label=label,
        declared=declared,
        primary_cases=len(cases),
        passed_cases=passed,
        failed_cases=failed,
        error_cases=errored,
        skipped_cases=skipped,
        failure_children=failure_children,
        error_children=error_children,
        skipped_children=skipped_children,
        unique_case_ids=len(identities),
        per_module=dict(sorted(per_module.items())),
        per_module_skipped=dict(sorted(per_module_skipped.items())),
        skip_reasons=reasons,
        duplicates=duplicates,
    )


def explain_inflation(declared_tests: int, primary_cases: int,
                      console: Optional[ConsoleSummary] = None) -> Dict[str, int]:
    """Split a JUnit tests= attribute into primary elements plus subtests."""
    inflation = declared_tests - primary_cases
    subtests_passed = console.value("subtests_passed") if console is not None else 0
    subtests_failed = console.value("subtests_failed") if console is not None else 0
    return {
        "declared_tests": declared_tests,
        "primary_cases": primary_cases,
        "inflation": inflation,
        "console_subtests_passed": subtests_passed,
        "console_subtests_failed": subtests_failed,
        "unexplained": inflation - subtests_passed - subtests_failed,
    }


@dataclass
class Check:
    name: str
    ok: bool
    detail: str


def reconcile(facts: JunitFacts, console: Optional[ConsoleSummary] = None,
              expected_primary: Optional[int] = None,
              expected_subtests: Optional[int] = None) -> List[Check]:
    """Return every consistency check for one phase of evidence."""
    checks: List[Check] = []
    add = checks.append
    add(Check("suite_skipped_matches_elements",
              facts.declared.get("skipped", 0) == facts.skipped_cases,
              "testsuite skipped=%d, elements with <skipped>=%d"
              % (facts.declared.get("skipped", 0), facts.skipped_cases)))
    add(Check("suite_failures_matches_children",
              facts.declared.get("failures", 0) == facts.failure_children,
              "testsuite failures=%d, <failure> children=%d"
              % (facts.declared.get("failures", 0), facts.failure_children)))
    add(Check("suite_errors_matches_children",
              facts.declared.get("errors", 0) == facts.error_children,
              "testsuite errors=%d, <error> children=%d"
              % (facts.declared.get("errors", 0), facts.error_children)))
    add(Check("unique_case_identities",
              not facts.duplicates,
              "%d duplicate (classname, name) pair(s); %d unique of %d elements"
              % (len(facts.duplicates), facts.unique_case_ids, facts.primary_cases)))
    inflation = explain_inflation(facts.declared_tests, facts.primary_cases, console)
    unexplained = inflation["unexplained"]
    console_failed = console.value("failed") if console is not None else 0
    inflation_ok = unexplained == 0 or 0 < unexplained <= console_failed
    if console is None:
        # Without a console summary the inflation cannot be attributed to
        # subtests, so report it rather than judge it.
        inflation_ok = True
    detail = ("tests=%d minus %d primary elements = %d; console subtests passed=%d failed=%d; unexplained=%d"
              % (facts.declared_tests, facts.primary_cases, inflation["inflation"],
                 inflation["console_subtests_passed"], inflation["console_subtests_failed"], unexplained))
    if console is None and unexplained:
        detail += " (unattributed: no console summary was supplied)"
    elif inflation_ok and unexplained:
        detail += " (attributable to subtest failures, which pytest reports as plain failures)"
    add(Check("tests_attribute_inflation", inflation_ok, detail))
    if console is not None:
        add(Check("console_summary_line_found", console.line is not None,
                  console.line or "no summary line found"))
        total = console.outcome_total()
        add(Check("console_total_matches_tests_attribute",
                  total == facts.declared_tests,
                  "console outcome total=%d, testsuite tests=%d" % (total, facts.declared_tests)))
        expected_passed = (facts.primary_cases - facts.failed_cases
                           - facts.error_cases - facts.skipped_cases)
        if not console.present("passed"):
            add(Check("passed_phrase_absent_only_when_zero_expected",
                      expected_passed == 0,
                      "no 'N passed' phrase; expected passes=%d%s"
                      % (expected_passed,
                         " (legitimate for an all-failed phase)" if expected_passed == 0
                         else " (phrase missing although passes were expected)")))
        else:
            reported = console.value("passed")
            difference = reported - expected_passed
            ok = difference == 0 or difference == unexplained
            note = ""
            if difference and ok:
                note = " (difference equals the subtest failures counted by the console but not given their own element)"
            add(Check("passed_count_matches_element_outcomes", ok,
                      "console passed=%d, elements-derived expectation=%d%s"
                      % (reported, expected_passed, note)))
        for key, actual, source in (("failed", facts.failure_children, "<failure> children"),
                                    ("errors", facts.error_children, "<error> children"),
                                    ("skipped", facts.skipped_cases, "elements with <skipped>")):
            if console.present(key):
                add(Check("console_%s_matches_xml" % key,
                          console.value(key) == actual,
                          "console %s=%d, XML %s=%d" % (key, console.value(key), source, actual)))
            else:
                add(Check("console_%s_absent_means_zero" % key, actual == 0,
                          "'%s' phrase absent; XML %s=%d" % (key, source, actual)))
    if expected_primary is not None:
        add(Check("expected_primary_cases", facts.primary_cases == expected_primary,
                  "expected %d, observed %d" % (expected_primary, facts.primary_cases)))
    if expected_subtests is not None:
        add(Check("expected_subtests", facts.subtest_inflation == expected_subtests,
                  "expected %d, observed %d" % (expected_subtests, facts.subtest_inflation)))
    return checks


def per_module_delta(left: JunitFacts, right: JunitFacts) -> List[Dict[str, object]]:
    """Per-module element counts of two runs, with right minus left deltas."""
    modules = sorted(set(left.per_module) | set(right.per_module))
    rows: List[Dict[str, object]] = []
    for module in modules:
        before = left.per_module.get(module, 0)
        after = right.per_module.get(module, 0)
        rows.append({"module": module, "left": before, "right": after, "delta": after - before})
    return rows


def render(facts: JunitFacts, checks: Sequence[Check],
           console: Optional[ConsoleSummary] = None,
           delta: Optional[Sequence[Dict[str, object]]] = None) -> str:
    lines = ["evidence: %s" % facts.label,
             "  primary <testcase> elements : %d" % facts.primary_cases,
             "  declared tests=             : %d" % facts.declared_tests,
             "  subtest inflation           : %d" % facts.subtest_inflation,
             "  passed/failed/error/skipped : %d/%d/%d/%d"
             % (facts.passed_cases, facts.failed_cases, facts.error_cases, facts.skipped_cases),
             "  unique (classname, name)    : %d (duplicates: %d)"
             % (facts.unique_case_ids, len(facts.duplicates))]
    if console is not None:
        lines.append("console summary: %s" % (console.line or "<none found>"))
    lines.append("per-module element counts:")
    for module, count in facts.per_module.items():
        lines.append("  %6d  %-44s skipped=%d"
                     % (count, module, facts.per_module_skipped.get(module, 0)))
    if facts.skip_reasons:
        lines.append("skip reasons:")
        for reason in facts.skip_reasons:
            lines.append("  %6d  %s :: %s" % (reason["count"], reason["module"], reason["message"]))
    if delta:
        lines.append("per-module delta (right minus left):")
        for row in delta:
            if row["delta"]:
                lines.append("  %+6d  %-44s %d -> %d"
                             % (row["delta"], row["module"], row["left"], row["right"]))
    lines.append("checks:")
    for check in checks:
        lines.append("  [%s] %s: %s" % ("ok" if check.ok else "FAIL", check.name, check.detail))
    return "\n".join(lines)


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Reconcile pytest JUnit evidence with console summaries.")
    parser.add_argument("--junit", required=True, help="JUnit XML file to audit")
    parser.add_argument("--console", help="console log whose summary line belongs to that XML")
    parser.add_argument("--compare", help="second JUnit XML for a per-module delta table")
    parser.add_argument("--expect-primary", type=int, help="assert the primary element count")
    parser.add_argument("--expect-subtests", type=int, help="assert the subtest inflation")
    parser.add_argument("--json", help="write the machine readable report here")
    args = parser.parse_args(argv)
    facts = parse_junit(Path(args.junit))
    console = None
    if args.console:
        console = parse_console_summary(Path(args.console).read_text(encoding="utf-8", errors="replace"))
    checks = reconcile(facts, console, args.expect_primary, args.expect_subtests)
    delta = None
    if args.compare:
        delta = per_module_delta(facts, parse_junit(Path(args.compare)))
    print(render(facts, checks, console, delta))
    if args.json:
        payload = {
            "facts": facts.to_dict(),
            "console": console.to_dict() if console is not None else None,
            "checks": [asdict(check) for check in checks],
            "per_module_delta": delta,
        }
        Path(args.json).write_text(json.dumps(payload, indent=2), encoding="utf-8")
    return 0 if all(check.ok for check in checks) else 1


if __name__ == "__main__":
    sys.exit(main())
