from importlib.util import module_from_spec,spec_from_file_location
import json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];SCRIPT=ROOT/"scripts/research/audit_atlas_c_hash_history_20260926.py";REPORT=ROOT/"evidence/research/20260926/atlas-c-hash-history/report.json"
spec=spec_from_file_location("atlas_hash_history",SCRIPT);audit=module_from_spec(spec);spec.loader.exec_module(audit)
def test_retained_report_is_exact_and_claim_limited():
 data=audit.report_bytes(audit.build_report(ROOT));assert REPORT.read_bytes()==data;r=json.loads(data)
 assert r["status"]=="completed_negative_provenance_audit_u18_open"
 assert (r["current_c_hash_matches"],r["current_c_hash_mismatches"])==(0,47)
 assert (r["introduction_commit_c_hash_matches"],r["introduction_commit_c_hash_mismatches"])==(0,47)
 assert r["atlas_hashes_matching_any_reachable_decompiled_c_blob"]==0
 assert r["atlas_hashes_without_reachable_decompiled_c_blob"]==47
 assert r["operations"]=={"ghidra":0,"itunes":0,"native_acceptance":0,"network":0,"proprietary_binary_reads":0,"unicorn":0}
 assert r["claim_boundaries"]["u18_closed"] is False and r["claim_boundaries"]["historical_c_bytes_recovered"] is False
def test_cli_check_report_from_unrelated_cwd(tmp_path):
 out=tmp_path/"out.json";r=subprocess.run([sys.executable,"-B",str(SCRIPT),"--repo-root",str(ROOT),"--output",str(out),"--check-report",str(REPORT)],cwd=tmp_path,capture_output=True,text=True)
 assert r.returncode==0,r.stderr;assert out.read_bytes()==REPORT.read_bytes()
