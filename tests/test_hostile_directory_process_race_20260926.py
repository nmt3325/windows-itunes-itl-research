import json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];SCRIPT=ROOT/"scripts/research/audit_hostile_directory_process_race_20260926.py";REPORT=ROOT/"evidence/research/20260926/hostile-directory-process-race/report.json"
def test_retained_report_records_witnesses_without_closing_u17():
 r=json.loads(REPORT.read_text());assert r["status"]=="bounded_independent_process_witnesses_u17_open"
 assert r["summary"]=={"case_scenarios":3,"spoof_publication_witnesses":2,"stable_controls":1,"unexpected_anomalies":0,"writer_child_processes":3}
 assert r["methodology"]["writer_and_mutator_are_separate_processes"] is True
 assert sum(c["observed"].get("destination_matches_parent_spoof") is True for c in r["cases"])==2
 assert r["bounds"]["power_loss_operations"]==0 and r["bounds"]["network_filesystem_operations"]==0
 assert r["claim_boundaries"]["u17_closed"] is False and r["claim_boundaries"]["universal_atomicity"] is False
def test_two_fresh_roots_reproduce_retained_report(tmp_path):
 outputs=[]
 for i in range(2):
  out=tmp_path/f"report-{i}.json";scratch=tmp_path/f"scratch-{i}"
  p=subprocess.run([sys.executable,"-B",str(SCRIPT),"--scratch-root",str(scratch),"--output",str(out)],cwd=tmp_path,capture_output=True,text=True,env={"PYTHONDONTWRITEBYTECODE":"1","PYTHONIOENCODING":"utf-8"})
  assert p.returncode==0,p.stderr;assert not scratch.exists();outputs.append(out.read_bytes())
 assert outputs[0]==outputs[1]==REPORT.read_bytes()
