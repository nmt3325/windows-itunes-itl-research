from importlib.util import module_from_spec,spec_from_file_location
import json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];SCRIPT=ROOT/"scripts/research/audit_historical_dependency_chronology_20260926.py";REPORT=ROOT/"evidence/research/20260926/historical-dependency-chronology/report.json";SNAPSHOT=ROOT/"evidence/research/20260926/historical-dependency-chronology/pypi-snapshot.json"
spec=spec_from_file_location("dependency_chronology",SCRIPT);audit=module_from_spec(spec);spec.loader.exec_module(audit)
def test_retained_report_rebuilds_offline_and_remains_claim_limited():
 data=audit.canonical(audit.build_report(ROOT,SNAPSHOT));assert REPORT.read_bytes()==data;r=json.loads(data)
 assert r["status"]=="chronology_bounded_exact_versions_unknown_u18_open"
 assert r["cutoff"]=="2026-09-09T16:07:24Z" and r["introduction_tree"]["commit"]==audit.INTRO
 assert r["introduction_tree"]["exact_capstone_or_pefile_pins"]==[]
 assert r["pypi_snapshot"]["packages"]["capstone"]["latest_stable_release_by_upload_time"]["version"]=="5.0.9"
 assert r["pypi_snapshot"]["packages"]["pefile"]["latest_stable_release_by_upload_time"]["version"]=="2024.8.26"
 assert r["findings"]["availability_proves_historical_installation"] is False
 assert r["claim_boundaries"]["historical_dependency_versions_recovered"] is False and r["claim_boundaries"]["u18_closed"] is False
def test_cli_offline_check_from_unrelated_cwd(tmp_path):
 out=tmp_path/"out.json";r=subprocess.run([sys.executable,"-B",str(SCRIPT),"--repo-root",str(ROOT),"--snapshot",str(SNAPSHOT),"--output",str(out),"--check-report",str(REPORT)],cwd=tmp_path,capture_output=True,text=True)
 assert r.returncode==0,r.stderr;assert out.read_bytes()==REPORT.read_bytes()
