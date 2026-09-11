"""Tests for scripts/g4_a12_reconcile.py (G4-B, task a12).

Every fixture string below mirrors output actually observed on the runner:
the subtest XML shape and the console summary lines are copies of real
pytest 9.1.1 output, and the historical arithmetic cases are the numbers
under audit.
"""

from __future__ import annotations

import importlib.util
import sys
from pathlib import Path

_MODULE_PATH = Path(__file__).resolve().parents[1] / "scripts" / "g4_a12_reconcile.py"
_SPEC = importlib.util.spec_from_file_location("g4_a12_reconcile", _MODULE_PATH)
rec = importlib.util.module_from_spec(_SPEC)
# dataclasses resolves annotations through sys.modules, so register first.
sys.modules[_SPEC.name] = rec
_SPEC.loader.exec_module(rec)


# Real pytest 9.1.1 output shape: three primary elements, tests=9, because
# five passing subtests and one failing subtest are counted in tests= but
# never receive an element of their own.
SUBTEST_XML = (
    "<testsuites name=\"pytest tests\"><testsuite name=\"pytest\" errors=\"0\" failures=\"1\""
    " skipped=\"0\" tests=\"9\" time=\"0.086\">"
    "<testcase classname=\"probe.test_subtest_probe.SubtestProbe\" name=\"test_all_subtests_pass\" time=\"0.008\" />"
    "<testcase classname=\"probe.test_subtest_probe.SubtestProbe\" name=\"test_one_subtest_fails\" time=\"0.063\">"
    "<failure message=\"AssertionError: 1 == 1\">trace</failure></testcase>"
    "<testcase classname=\"probe.test_subtest_probe\" name=\"test_plain_pass\" time=\"0.001\" />"
    "</testsuite></testsuites>"
)
SUBTEST_CONSOLE = "1 failed, 3 passed, 5 subtests passed in 0.14s"

ALL_FAILED_XML = (
    "<testsuites><testsuite name=\"pytest\" errors=\"0\" failures=\"2\" skipped=\"0\" tests=\"2\">"
    "<testcase classname=\"tests.test_phase\" name=\"test_one\"><failure message=\"boom\">t</failure></testcase>"
    "<testcase classname=\"tests.test_phase\" name=\"test_two\"><failure message=\"boom\">t</failure></testcase>"
    "</testsuite></testsuites>"
)

MIXED_XML = (
    "<testsuites><testsuite name=\"pytest\" errors=\"0\" failures=\"1\" skipped=\"1\" tests=\"3\">"
    "<testcase classname=\"tests.test_phase\" name=\"test_one\"><failure message=\"boom\">t</failure></testcase>"
    "<testcase classname=\"tests.test_phase\" name=\"test_two\" />"
    "<testcase classname=\"tests.test_phase.Klass\" name=\"test_three\">"
    "<skipped type=\"pytest.skip\" message=\"no COM oracle; structural test is separate\" /></testcase>"
    "</testsuite></testsuites>"
)

DUPLICATE_XML = (
    "<testsuites><testsuite name=\"pytest\" errors=\"0\" failures=\"0\" skipped=\"0\" tests=\"3\">"
    "<testcase classname=\"tests.test_dup\" name=\"test_same\" />"
    "<testcase classname=\"tests.test_dup\" name=\"test_same\" />"
    "<testcase classname=\"tests.test_dup\" name=\"test_other\" />"
    "</testsuite></testsuites>"
)


def _by_name(checks):
    return {check.name: check for check in checks}


def test_primary_elements_are_counted_separately_from_subtests():
    facts = rec.parse_junit(SUBTEST_XML)
    assert facts.primary_cases == 3
    assert facts.declared_tests == 9
    assert facts.subtest_inflation == 6
    assert facts.unique_case_ids == 3


def test_subtest_run_reconciles_against_its_console_summary():
    facts = rec.parse_junit(SUBTEST_XML)
    console = rec.parse_console_summary(SUBTEST_CONSOLE)
    checks = _by_name(rec.reconcile(facts, console))
    assert console.outcome_total() == facts.declared_tests == 9
    assert checks["tests_attribute_inflation"].ok
    assert checks["passed_count_matches_element_outcomes"].ok
    assert all(check.ok for check in checks.values())


def test_all_failed_phase_may_omit_the_passed_phrase():
    facts = rec.parse_junit(ALL_FAILED_XML)
    console = rec.parse_console_summary("=========== 2 failed in 0.31s ===========")
    checks = _by_name(rec.reconcile(facts, console))
    assert console.counts["passed"] is None
    assert checks["passed_phrase_absent_only_when_zero_expected"].ok
    assert all(check.ok for check in checks.values())


def test_missing_passed_phrase_is_still_a_failure_when_passes_were_expected():
    facts = rec.parse_junit(MIXED_XML)
    console = rec.parse_console_summary("1 failed, 1 skipped in 0.20s")
    checks = _by_name(rec.reconcile(facts, console))
    assert checks["passed_phrase_absent_only_when_zero_expected"].ok is False


def test_absent_phrase_is_not_the_same_as_zero():
    absent = rec.parse_console_summary("2 failed in 0.30s")
    explicit = rec.parse_console_summary("0 passed, 2 failed in 0.30s")
    assert absent.counts["passed"] is None and absent.present("passed") is False
    assert explicit.counts["passed"] == 0 and explicit.present("passed") is True
    assert absent.value("passed") == explicit.value("passed") == 0


def test_observed_baseline_summary_lines_parse():
    ungated = rec.parse_console_summary(
        "1919 passed, 50 skipped, 4 warnings, 26 subtests passed in 20.56s")
    assert (ungated.value("passed"), ungated.value("skipped")) == (1919, 50)
    assert ungated.value("subtests_passed") == 26 and ungated.value("warnings") == 4
    assert ungated.outcome_total() == 1995
    gated = rec.parse_console_summary(
        "2075 passed, 56 skipped, 4 warnings, 36 subtests passed in 21.43s")
    assert gated.outcome_total() == 2167
    assert gated.value("passed") + gated.value("skipped") == 2131


def test_summary_line_is_found_past_trailing_log_noise():
    log = "\n".join([
        "-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html",
        "SKIPPED [55] tests/test_codec_native_profiles.py:127: no COM oracle",
        "2075 passed, 56 skipped, 4 warnings, 36 subtests passed in 21.43s",
        "pytest exit code: 0",
    ])
    console = rec.parse_console_summary(log)
    assert console.line == "2075 passed, 56 skipped, 4 warnings, 36 subtests passed in 21.43s"


def test_duplicate_case_identities_are_reported():
    facts = rec.parse_junit(DUPLICATE_XML)
    assert facts.primary_cases == 3 and facts.unique_case_ids == 2
    assert facts.duplicates == [{"classname": "tests.test_dup", "name": "test_same", "count": 2}]
    checks = _by_name(rec.reconcile(facts))
    assert checks["unique_case_identities"].ok is False


def test_historical_tests_attribute_arithmetic():
    console = rec.parse_console_summary("2125 passed, 6 skipped, 36 subtests passed in 30.00s")
    # The historical pair tests=2189 with 2153 elements is self consistent.
    assert rec.explain_inflation(2189, 2153, console)["unexplained"] == 0
    # The reproduced element count is 2131, which leaves 22 elements that the
    # historical tests= attribute cannot account for as subtests.
    assert rec.explain_inflation(2189, 2131, console)["unexplained"] == 22
    assert rec.explain_inflation(2167, 2131, console)["unexplained"] == 0


def test_module_of_drops_unittest_class_names():
    assert rec.module_of("tests.test_importer_v2.FreshSnapshotImporterTests") == "tests.test_importer_v2"
    assert rec.module_of("tests.test_admission_v2") == "tests.test_admission_v2"
    assert rec.module_of("") == "<unknown>"


def test_per_module_counts_and_skip_reason_inventory():
    facts = rec.parse_junit(MIXED_XML)
    assert facts.per_module == {"tests.test_phase": 3}
    assert facts.per_module_skipped == {"tests.test_phase": 1}
    assert facts.skip_reasons[0]["message"] == "no COM oracle; structural test is separate"
    assert facts.skip_reasons[0]["count"] == 1


def test_suite_attributes_are_cross_checked_against_elements():
    lying = MIXED_XML.replace("skipped=\"1\"", "skipped=\"3\"")
    checks = _by_name(rec.reconcile(rec.parse_junit(lying)))
    assert checks["suite_skipped_matches_elements"].ok is False


def test_per_module_delta_tabulates_collection_changes():
    left = rec.parse_junit(MIXED_XML)
    right = rec.parse_junit(DUPLICATE_XML)
    rows = {row["module"]: row for row in rec.per_module_delta(left, right)}
    assert rows["tests.test_phase"]["delta"] == -3
    assert rows["tests.test_dup"]["delta"] == 3


def test_expected_value_assertions_are_available_for_signed_off_numbers():
    facts = rec.parse_junit(SUBTEST_XML)
    checks = _by_name(rec.reconcile(facts, expected_primary=3, expected_subtests=6))
    assert checks["expected_primary_cases"].ok and checks["expected_subtests"].ok
    bad = _by_name(rec.reconcile(facts, expected_primary=4))
    assert bad["expected_primary_cases"].ok is False


def test_inflation_is_reported_but_unattributed_without_a_console():
    facts = rec.parse_junit(SUBTEST_XML)
    check = _by_name(rec.reconcile(facts))["tests_attribute_inflation"]
    assert check.ok is True
    assert "unattributed" in check.detail
    assert "= 6" in check.detail
