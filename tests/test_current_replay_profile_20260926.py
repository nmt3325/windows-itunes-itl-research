import json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def test_current_profile_requirements_match_receipt_and_keep_history_open():
 report=json.loads((ROOT/'evidence/research/20260926/current-replay-profile/report.json').read_text())
 text=(ROOT/'scripts/static/current-replay-requirements-win-py312.txt').read_text()
 rows={m.group(1):(m.group(2),m.group(3)) for m in re.finditer(r'^([a-z0-9]+)==([^ ]+) --hash=sha256:([0-9a-f]{64})$',text,re.M)}
 assert len(rows)==4
 for package in report['packages']:assert rows[package['name']]==(package['version'],package['sha256'])
 assert report['target']=={'platform':'win_amd64','python':'CPython 3.12'}
 assert report['receipt_generation']['network_downloads']==4
 assert report['claim_boundaries']['historical_dependency_versions_recovered'] is False
 assert report['claim_boundaries']['u18_closed'] is False
