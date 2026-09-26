"""Bound U-18 dependency chronology without pretending to recover exact versions."""
from __future__ import annotations
import argparse, hashlib, json, re, subprocess, urllib.request
from datetime import datetime
from pathlib import Path
from typing import Any

ROOT=Path(__file__).resolve().parents[2]
INTRO="bd6944ec85a3993d731d65bcea530fa73320276e"
CUTOFF="2026-09-09T16:07:24Z"
PACKAGES=("capstone","pefile")
SNAPSHOT_REL=Path("evidence/research/20260926/historical-dependency-chronology/pypi-snapshot.json")
SCHEMA="windows-itunes-itl.historical-dependency-chronology.v1"
PIN_RE=re.compile(rb"(?i)\b(capstone|pefile)\s*==\s*([^\s;#]+)")

def sha(b:bytes)->str:return hashlib.sha256(b).hexdigest()
def canonical(v:Any)->bytes:return (json.dumps(v,indent=2,sort_keys=True)+"\n").encode()
def git(root:Path,*args:str)->bytes:return subprocess.check_output(["git",*args],cwd=root,stderr=subprocess.DEVNULL)
def dt(s:str)->datetime:return datetime.fromisoformat(s.replace("Z","+00:00"))

def refresh_snapshot()->dict[str,Any]:
 cutoff=dt(CUTOFF);packages={}
 for name in PACKAGES:
  url=f"https://pypi.org/pypi/{name}/json"
  with urllib.request.urlopen(url,timeout=30) as response: raw=response.read()
  source=json.loads(raw);releases=[]
  for version,files in source["releases"].items():
   uploaded=[]
   for f in files:
    value=f.get("upload_time_iso_8601") or f.get("upload_time")
    if value and dt(value)<=cutoff:uploaded.append(value)
   if uploaded:
    releases.append({"version":version,"first_upload":min(uploaded,key=dt),"last_upload":max(uploaded,key=dt),"eligible_file_count":len(uploaded)})
  releases.sort(key=lambda row:dt(row["last_upload"]),reverse=True)
  packages[name]={"url":url,"response_sha256":sha(raw),"releases_available_by_cutoff":releases}
 return {"schema":"windows-itunes-itl.pypi-chronology-snapshot.v1","cutoff":CUTOFF,"packages":packages,
  "scope":"Current PyPI JSON upload chronology snapshot; availability is not proof of installation, compatibility, or historical use."}

def introduction_tree(root:Path)->dict[str,Any]:
 paths=git(root,"ls-tree","-r","--name-only",INTRO).decode().splitlines();pins=[]
 configs=[]
 for path in paths:
  low=path.lower()
  if any(token in low for token in ("requirements","pyproject","pipfile","poetry","environment","lock")):configs.append(path)
  try:blob=git(root,"show",f"{INTRO}:{path}")
  except subprocess.CalledProcessError:continue
  for match in PIN_RE.finditer(blob):pins.append({"path":path,"package":match.group(1).decode().lower(),"version":match.group(2).decode(errors="replace")})
 introduced=[]
 for path in ("scripts/static/pe_probe.py","scripts/static/prepare_targets.py","scripts/static/rebuild_targets.py","evidence/static/phase2/prepare.py","evidence/static/phase3/prepare_targets.py","evidence/static/phase4/prepare_selected.py"):
  line=git(root,"log","--all","--diff-filter=A","--format=%H %cI","--",path).decode().splitlines()[-1]
  commit,when=line.split(" ",1);introduced.append({"path":path,"commit":commit,"commit_time":when})
 return {"commit":INTRO,"commit_time":git(root,"show","-s","--format=%cI",INTRO).decode().strip(),
  "ancestor_commit_count":int(git(root,"rev-list","--count",INTRO)),"dependency_configuration_paths":configs,
  "exact_capstone_or_pefile_pins":pins,"representative_static_entrypoint_introductions":introduced}

def latest(rows:list[dict[str,Any]],stable:bool)->dict[str,Any]:
 selected=[r for r in rows if (not stable or not re.search(r"[A-Za-z]",r["version"]))]
 return selected[0]

def build_report(root:Path=ROOT,snapshot_path:Path|None=None)->dict[str,Any]:
 root=root.resolve();sp=(snapshot_path or root/SNAPSHOT_REL);snap=json.loads(sp.read_text());packages={}
 for name in PACKAGES:
  rows=snap["packages"][name]["releases_available_by_cutoff"]
  packages[name]={"pypi_endpoint":snap["packages"][name]["url"],"pypi_response_sha256":snap["packages"][name]["response_sha256"],
   "release_count_available_by_cutoff":len(rows),"latest_release_by_upload_time":latest(rows,False),"latest_stable_release_by_upload_time":latest(rows,True),
   "candidate_versions_by_upload_time":[r["version"] for r in rows]}
 tree=introduction_tree(root)
 return {"schema":SCHEMA,"status":"chronology_bounded_exact_versions_unknown_u18_open","cutoff":CUTOFF,
  "introduction_tree":tree,"pypi_snapshot":{"path":SNAPSHOT_REL.as_posix(),"sha256":sha(sp.read_bytes()),"packages":packages},
  "findings":{"exact_capstone_version_recovered":False,"exact_pefile_version_recovered":False,
   "introduction_tree_exact_pin_count":len(tree["exact_capstone_or_pefile_pins"]),
   "current_profile_versions_were_available_by_cutoff":{"capstone":"5.0.9" in packages["capstone"]["candidate_versions_by_upload_time"],"pefile":"2024.8.26" in packages["pefile"]["candidate_versions_by_upload_time"]},
   "availability_proves_historical_installation":False,
   "conclusion":"Git proves when the retained scripts first appeared and the snapshot bounds versions PyPI exposed by then; neither source identifies the versions actually installed for historical executions."},
  "operations":{"network_during_snapshot_capture":2,"network_during_offline_report_rebuild":0,"proprietary_binary_reads":0,"ghidra":0,"unicorn":0,"itunes":0,"native_acceptance":0},
  "claim_boundaries":{"u18_closed":False,"historical_dependency_versions_recovered":False,"historical_binary_analysis_reproduced":False,"native_application_acceptance":False,"independent_reimplementation_passed":False,"universal_itl_support":False,"percentage_complete":None}}

def main()->int:
 p=argparse.ArgumentParser(description=__doc__);p.add_argument("--repo-root",type=Path,default=ROOT);p.add_argument("--snapshot",type=Path);p.add_argument("--refresh-snapshot",action="store_true");p.add_argument("--output",type=Path);p.add_argument("--check-report",type=Path);a=p.parse_args()
 root=a.repo_root.resolve();sp=a.snapshot or root/SNAPSHOT_REL
 if a.refresh_snapshot:sp.parent.mkdir(parents=True,exist_ok=True);sp.write_bytes(canonical(refresh_snapshot()))
 data=canonical(build_report(root,sp))
 if a.check_report and a.check_report.read_bytes()!=data:raise SystemExit("historical dependency chronology report differs from retained report")
 if a.output:a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_bytes(data)
 print("HISTORICAL_DEPENDENCY_CHRONOLOGY_OK sha256="+sha(data));return 0
if __name__=="__main__":raise SystemExit(main())
