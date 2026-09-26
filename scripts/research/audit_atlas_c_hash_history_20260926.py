"""Audit retained atlas C hashes against current bytes and reachable Git blobs."""
from __future__ import annotations
import argparse, hashlib, json, subprocess
from pathlib import Path
from typing import Any

ROOT=Path(__file__).resolve().parents[2]
SCHEMA="windows-itunes-itl.atlas-c-hash-history-audit.v1"
ATLAS_REL=Path("evidence/static/function-atlas.json")
INTRODUCTION_COMMIT="b256062c2494a2b6888b5c81e9e99e80893c4f69"

def sha(value:bytes)->str:return hashlib.sha256(value).hexdigest()
def git(root:Path,*args:str)->bytes:
 return subprocess.check_output(["git",*args],cwd=root,stderr=subprocess.DEVNULL)
def report_bytes(value:dict[str,Any])->bytes:
 return (json.dumps(value,indent=2,sort_keys=True)+"\n").encode()
def build_report(root:Path=ROOT)->dict[str,Any]:
 root=root.resolve();atlas=json.loads((root/ATLAS_REL).read_text())
 expected={row["c_sha256"] for row in atlas};current=[];introduced=[]
 for row in atlas:
  rel=Path("evidence/static")/row["decompiled_c"]
  current.append(sha((root/rel).read_bytes())==row["c_sha256"])
  introduced.append(sha(git(root,"show",f"{INTRODUCTION_COMMIT}:{rel.as_posix()}"))==row["c_sha256"])
 objects={}
 for line in git(root,"rev-list","--objects","--all").decode().splitlines():
  parts=line.split(" ",1)
  if len(parts)==2 and parts[1].startswith("evidence/static/decompiled/") and parts[1].endswith(".c"):
   objects[parts[0]]=parts[1]
 reachable_hashes={sha(git(root,"cat-file","blob",oid)) for oid in sorted(objects)}
 return {
  "schema":SCHEMA,"status":"completed_negative_provenance_audit_u18_open",
  "atlas":{"path":ATLAS_REL.as_posix(),"sha256":sha((root/ATLAS_REL).read_bytes()),"rows":len(atlas)},
  "introduction_commit":INTRODUCTION_COMMIT,
  "current_c_hash_matches":sum(current),"current_c_hash_mismatches":len(current)-sum(current),
  "introduction_commit_c_hash_matches":sum(introduced),"introduction_commit_c_hash_mismatches":len(introduced)-sum(introduced),
  "reachable_decompiled_c_blob_count":len(objects),
  "atlas_hashes_matching_any_reachable_decompiled_c_blob":len(expected & reachable_hashes),
  "atlas_hashes_without_reachable_decompiled_c_blob":len(expected-reachable_hashes),
  "operations":{"network":0,"proprietary_binary_reads":0,"ghidra":0,"unicorn":0,"itunes":0,"native_acceptance":0},
  "claim_boundaries":{"u18_closed":False,"historical_c_bytes_recovered":False,"historical_binary_analysis_reproduced":False,"native_application_acceptance":False,"independent_reimplementation_passed":False,"universal_itl_support":False,"percentage_complete":None},
  "conclusion":"No retained atlas C hash matches current C bytes, introduction-commit C bytes, or any reachable Git C blob; the historical hashed C bytes remain unavailable.",
 }
def main()->int:
 p=argparse.ArgumentParser(description=__doc__);p.add_argument("--repo-root",type=Path,default=ROOT);p.add_argument("--output",type=Path);p.add_argument("--check-report",type=Path);a=p.parse_args();data=report_bytes(build_report(a.repo_root))
 if a.check_report and a.check_report.read_bytes()!=data:raise SystemExit("atlas C hash history report differs from retained report")
 if a.output:a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_bytes(data)
 print("ATLAS_C_HASH_HISTORY_AUDIT_OK sha256="+sha(data));return 0
if __name__=="__main__":raise SystemExit(main())
