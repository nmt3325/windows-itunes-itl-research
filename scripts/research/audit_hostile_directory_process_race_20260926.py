#!/usr/bin/env python3
"""Bounded two-process hostile-parent race witnesses for itlkit.io.write_new."""
from __future__ import annotations
import argparse, errno, hashlib, json, os, shutil, subprocess, sys
from pathlib import Path
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2];SCRIPT_REL="scripts/research/audit_hostile_directory_process_race_20260926.py";SOURCE_REL="itlkit/io.py"
PAYLOAD=(b"u17-independent-writer-process-payload\n"*257)+b"end\n";SPOOF=b"u17-parent-process-spoof\n";TIMEOUT=15
sys.path.insert(0,str(ROOT));import itlkit.io as output

def sha(b:bytes)->str:return hashlib.sha256(b).hexdigest()
def canon(v)->bytes:return (json.dumps(v,indent=2,sort_keys=True)+"\n").encode()
def send(fd:int,value:dict)->None:
 data=(json.dumps(value,sort_keys=True,separators=(",",":"))+"\n").encode();assert len(data)<4096 and os.write(fd,data)==len(data)
def recv_line(fd:int)->dict:
 import select
 ready,_,_=select.select([fd],[],[],TIMEOUT)
 if not ready:raise TimeoutError("writer did not reach link boundary")
 data=os.read(fd,4096)
 if data.count(b"\n")!=1:raise RuntimeError("malformed writer event")
 return json.loads(data)
def temp_files(p:Path)->list[Path]:return sorted(p.glob(".out.itlkit-*.tmp"))
def validate_root(p:Path)->Path:
 if not p.is_absolute():raise ValueError("scratch root must be absolute")
 if os.path.lexists(p):raise FileExistsError(errno.EEXIST,"scratch root must be fresh")
 parent=p.parent.resolve(strict=True);tmp=Path('/tmp').resolve(strict=True);candidate=parent/p.name
 if candidate==tmp or tmp not in candidate.parents:raise ValueError("scratch root must resolve below /tmp")
 p.mkdir(mode=0o700);return p.resolve(strict=True)
def child(mode:str,destination:Path,event_fd:int,release_fd:int)->int:
 real_link=output.os.link
 def paused_link(source,target,*args,**kwargs):
  send(event_fd,{"event":"before_native_link","mode":mode,"source_basename":Path(source).name,"writer_pid_recorded":True})
  token=os.read(release_fd,1)
  if token!=b"G":raise RuntimeError("invalid parent release token")
  return real_link(source,target,*args,**kwargs)
 with patch.object(output.os,"link",paused_link):output.write_new(destination,PAYLOAD)
 return 0
def child_command(mode:str,destination:Path,event_fd:int,release_fd:int)->list[str]:
 return [sys.executable,"-B",str(Path(__file__).resolve()),"--_child-mode",mode,"--_destination",str(destination),"--_event-fd",str(event_fd),"--_release-fd",str(release_fd)]
def run_writer(mode:str,destination:Path,mutate):
 event_r,event_w=os.pipe();release_r,release_w=os.pipe();proc=None
 try:
  env=dict(os.environ);env.update({"PYTHONDONTWRITEBYTECODE":"1","PYTHONIOENCODING":"utf-8"})
  proc=subprocess.Popen(child_command(mode,destination,event_w,release_r),cwd=ROOT,env=env,stdin=subprocess.DEVNULL,stdout=subprocess.PIPE,stderr=subprocess.PIPE,pass_fds=(event_w,release_r))
  os.close(event_w);event_w=-1;os.close(release_r);release_r=-1
  event=recv_line(event_r);mutate(event["source_basename"]);event["source_basename"]=".out.itlkit-<random>.tmp";os.write(release_w,b"G");os.close(release_w);release_w=-1
  stdout,stderr=proc.communicate(timeout=TIMEOUT)
  if proc.returncode!=0:raise AssertionError(f"writer failed rc={proc.returncode} stdout={stdout!r} stderr={stderr!r}")
  return event,{"writer_child_returncode":proc.returncode,"writer_child_exited_normally":True,"writer_child_reaped":True,"writer_stdout_bytes":len(stdout),"writer_stderr_bytes":len(stderr)}
 finally:
  for fd in (event_r,event_w,release_r,release_w):
   if fd>=0:
    try:os.close(fd)
    except OSError:pass
  if proc is not None and proc.poll() is None:proc.kill();proc.communicate()
def stable_control(root:Path)->dict:
 d=root/'stable_control';parent=d/'parent';parent.mkdir(parents=True);dest=parent/'out'
 event,process=run_writer('stable_control',dest,lambda _name:None)
 assert dest.read_bytes()==PAYLOAD and temp_files(parent)==[]
 return {"id":"stable_parent_control","schedule":"child paused immediately before real os.link; parent made no filesystem mutation","event":event,"process":process,"observed":{"destination_matches_payload":True,"temporary_count":0}}
def directory_swap(root:Path)->dict:
 d=root/'directory_swap';parent=d/'parent';moved=d/'moved-parent';parent.mkdir(parents=True);dest=parent/'out'
 def mutate(name):parent.rename(moved);parent.mkdir();(parent/name).write_bytes(SPOOF)
 event,process=run_writer('directory_swap',dest,mutate);moved_t=temp_files(moved)
 assert dest.read_bytes()==SPOOF and len(moved_t)==1 and moved_t[0].read_bytes()==PAYLOAD and temp_files(parent)==[]
 return {"id":"independent_parent_directory_swap_spoof","schedule":"writer child paused before real os.link; parent process renamed parent, made replacement parent, and spoofed source basename","event":event,"process":process,"observed":{"writer_returned_success":True,"destination_matches_requested_payload":False,"destination_matches_parent_spoof":True,"original_complete_temporary_retained":True,"replacement_parent_temporary_count":0}}
def symlink_retarget(root:Path)->dict:
 d=root/'symlink_retarget';first=d/'first';second=d/'second';alias=d/'parent-alias';first.mkdir(parents=True);second.mkdir();alias.symlink_to(first,target_is_directory=True);dest=alias/'out'
 def mutate(name):alias.unlink();alias.symlink_to(second,target_is_directory=True);(second/name).write_bytes(SPOOF)
 event,process=run_writer('symlink_retarget',dest,mutate);first_t=temp_files(first)
 assert dest.read_bytes()==SPOOF and len(first_t)==1 and first_t[0].read_bytes()==PAYLOAD and temp_files(second)==[]
 return {"id":"independent_parent_symlink_retarget_spoof","schedule":"writer child paused before real os.link; parent process retargeted parent symlink and spoofed source basename","event":event,"process":process,"observed":{"writer_returned_success":True,"destination_matches_requested_payload":False,"destination_matches_parent_spoof":True,"original_complete_temporary_retained":True,"retargeted_parent_temporary_count":0}}
def filesystem_type(path:Path)->str:
 return subprocess.check_output(["stat","-f","-c","%T",str(path)],text=True).strip()
def campaign(root:Path)->dict:
 cases=[stable_control(root),directory_swap(root),symlink_retarget(root)]
 return {"schema":"windows-itunes-itl.hostile-directory-process-race.v1","status":"bounded_independent_process_witnesses_u17_open",
  "production_source":{"path":SOURCE_REL,"sha256":sha((ROOT/SOURCE_REL).read_bytes())},"generator":{"path":SCRIPT_REL,"sha256":sha((ROOT/SCRIPT_REL).read_bytes())},
  "environment":{"platform":"linux-posix","scratch_filesystem_type":filesystem_type(root)},"summary":{"case_scenarios":3,"writer_child_processes":3,"stable_controls":1,"spoof_publication_witnesses":2,"unexpected_anomalies":0},
  "methodology":{"writer_and_mutator_are_separate_processes":True,"boundary_control":"child hook pauses immediately before the production pathname-based os.link; parent performs real filesystem syscalls then releases child","final_link_syscalls_are_native":True,"random_temporary_basename_normalized_out":True,"independent_experiments":False},
  "bounds":{"power_loss_operations":0,"network_filesystem_operations":0,"native_itunes_operations":0,"uncontrolled_scheduler_races":0,"hostile_directory_safety_claims":0,"directory_entry_durability_claims":0},
  "claim_boundaries":{"u17_closed":False,"power_loss_tested":False,"network_filesystem_tested":False,"universal_atomicity":False,"native_application_acceptance":False,"independent_reimplementation_passed":False,"universal_itl_support":False,"percentage_complete":None},
  "conclusion":"Separate-process witnesses reproduce pathname-rebinding spoof publication at the pre-link boundary. They strengthen the hostile-parent limitation; they do not prove arbitrary-race behavior, power-loss durability, network-filesystem behavior, or universal atomicity.","cases":cases}
def main()->int:
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--scratch-root',type=Path);p.add_argument('--output',type=Path);p.add_argument('--_child-mode');p.add_argument('--_destination',type=Path);p.add_argument('--_event-fd',type=int);p.add_argument('--_release-fd',type=int);a=p.parse_args()
 if a._child_mode:return child(a._child_mode,a._destination,a._event_fd,a._release_fd)
 if a.scratch_root is None:raise SystemExit('--scratch-root is required')
 root=validate_root(a.scratch_root)
 try:report=campaign(root);data=canon(report);print("HOSTILE_DIRECTORY_PROCESS_RACE_OK sha256="+sha(data));
 finally:shutil.rmtree(root,ignore_errors=True)
 if a.output:a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_bytes(data)
 return 0
if __name__=='__main__':raise SystemExit(main())
