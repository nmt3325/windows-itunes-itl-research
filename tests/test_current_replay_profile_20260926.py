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

def test_windows_validation_receipt_is_explicit_about_capstone_version_mismatch():
 report=json.loads((ROOT/'evidence/research/20260926/current-replay-profile/report.json').read_text())
 validation=report['windows_validation']
 assert validation['hash_checked_install_succeeded'] is True
 assert validation['python_entrypoint_help_checks_passed']==4
 assert validation['powershell_parse_passed'] is True
 assert validation['installed_distributions']['capstone']=='5.0.9'
 assert validation['runtime_module_versions']['capstone']=='5.0.7'
 assert validation['capstone_distribution_module_version_mismatch_observed'] is True
 assert validation['proprietary_binary_reads']==validation['itunes_launches']==validation['native_acceptance_operations']==0

def test_windows_synthetic_pe_probe_validates_portable_path_without_itunes_claim():
 report=json.loads((ROOT/'evidence/research/20260926/current-replay-profile/report.json').read_text())
 probe=report['windows_validation']['synthetic_pe_probe']
 assert probe['status']=='passed' and probe['fixture']=='fresh_minimal_mingw_x64_pe_not_retained'
 assert probe['sections']==16 and probe['exception_functions']==47 and probe['instructions_scanned']==2008
 assert probe['output_files']==['important_xrefs.json','pdata.json','pe_inventory.json','xrefs.sqlite']
 assert probe['itunes_binary_used'] is False
 assert probe['historical_analysis_reproduced'] is False
 assert probe['native_acceptance'] is False

def test_synthetic_ghidra_headless_receipt_is_successful_and_claim_limited():
 report=json.loads((ROOT/'evidence/research/20260926/current-replay-profile/report.json').read_text())
 ghidra=report['windows_validation']['synthetic_ghidra_headless']
 assert ghidra['status']=='passed' and ghidra['ghidra_version']=='12.1.3'
 assert ghidra['fixture_is_apple_itunes'] is False and ghidra['apple_itunes_binary_reads']==0
 assert ghidra['parameterized_run_headless_succeeded'] is True and ghidra['cookie_rva_argument']=='none'
 assert (ghidra['targets'],ghidra['decompilations_completed'],ghidra['decompilations_failed'])==(1,1,0)
 assert ghidra['output_files']==['00001000.c','summary.tsv']
 assert ghidra['proprietary_binary_reads_observed']==9
 assert ghidra['historical_binary_analysis_reproduced'] is False
 assert ghidra['ghidra_historical_project_recreated'] is False
