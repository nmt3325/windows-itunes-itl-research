"""Bounded phase03 optimization guard checks; never rerun the old full QA."""
if not __debug__:
    raise SystemExit('ITL4_OPTIMIZATION_UNSUPPORTED: run this test driver without optimization')

import argparse, ast, hashlib, json, os, subprocess, sys
from pathlib import Path

MARKER='ITL4_OPTIMIZATION_UNSUPPORTED'
SCRIPTS=('acquire.py','corpus.py','qa.py')
MODES=(('flag-O',['-O'],'0',1),('flag-OO',['-OO'],'0',2),('env-1',[],'1',1),('env-2',[],'2',2))
AUDIT_PRELUDE=r'''
import sys,json
path=sys.argv[1]
with open(path,'rb') as f: source=f.read()
code=compile(source,path,'exec')
sys.argv=[path]+sys.argv[2:]
events=[]
active=True
def hook(event,args):
    if active and event!='exec':
        events.append(event)
        raise RuntimeError('Operational audit event before optimization refusal: '+event)
sys.addaudithook(hook)
reason=None
try:
    exec(code,{'__name__':'__main__','__file__':path})
except SystemExit as exc:
    reason=str(exc)
finally:
    active=False
print(json.dumps({'reason':reason,'events':events,'optimize':sys.flags.optimize,'debug':__debug__,'window':'target source loaded/compiled before hook; all target module-body operations audited'}))
'''

def require(ok,message):
    if not ok:raise RuntimeError(message)
def sha(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for b in iter(lambda:f.read(1048576),b''):h.update(b)
    return h.hexdigest()
def save(path,value):
    with path.open('x',encoding='utf-8',newline='\n') as f:
        json.dump(value,f,ensure_ascii=False,indent=2);f.write('\n')
def snapshot(root,phase):
    result={}
    for base in (root/'reports/media',root/'fixtures/media4',root/'tools/media'):
        for path in base.rglob('*'):
            if path.is_file() and not path.is_relative_to(phase):
                st=path.stat();result[path.relative_to(root).as_posix()]={'sha256':sha(path),'size_bytes':st.st_size,'mtime_ns':st.st_mtime_ns,'attributes':getattr(st,'st_file_attributes',None)}
    return result

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--root',required=True);args=ap.parse_args()
    root=Path(args.root).resolve();wt=root/'wt/media';phase=root/'reports/media/phase03';source=wt/'scripts/research/media20260910'
    require(Path.cwd().resolve()==wt,'Wrong assigned cwd')
    before=json.loads((phase/'preservation-before.json').read_text(encoding='utf-8'))
    require(snapshot(root,phase)==before,'Evidence changed before tests')
    out=phase/'test-run';out.mkdir(exist_ok=False)
    structure=[]
    for name in SCRIPTS:
        tree=ast.parse((source/name).read_text(encoding='utf-8'));first=tree.body[1]
        require(isinstance(tree.body[0],ast.Expr) and isinstance(tree.body[0].value,ast.Constant),'Missing module docstring')
        require(isinstance(first,ast.If) and isinstance(first.test,ast.UnaryOp) and isinstance(first.test.op,ast.Not) and isinstance(first.test.operand,ast.Name) and first.test.operand.id=='__debug__','Guard is not the first executable statement')
        require(len(first.body)==1 and isinstance(first.body[0],ast.Raise) and isinstance(first.body[0].exc,ast.Call) and isinstance(first.body[0].exc.func,ast.Name) and first.body[0].exc.func.id=='SystemExit','Guard does not unconditionally refuse')
        require(not first.orelse,'Unexpected guard else branch')
        structure.append({'script':name,'guard_before_imports_and_operations':True,'guard_line':first.lineno,'source_sha256':sha(source/name)})
    save(out/'first-statement-guards.json',structure)
    results=[]
    def run(label,argv,optimization,expected,audited=False):
        env=os.environ.copy();env.update(PYTHONOPTIMIZE=optimization,PYTHONDONTWRITEBYTECODE='1',PYTHONUTF8='1',PYTHONIOENCODING='utf-8',TEMP=str(phase/'tmp'),TMP=str(phase/'tmp'))
        done=subprocess.run(argv,stdin=subprocess.DEVNULL,capture_output=True,cwd=str(wt),env=env,timeout=15)
        stdout=done.stdout.decode('utf-8','replace');stderr=done.stderr.decode('utf-8','replace')
        record={'label':label,'argv':argv,'cwd':str(wt),'PYTHONOPTIMIZE':optimization,'exit_code':done.returncode,'stdout':stdout,'stderr':stderr}
        if audited:
            payload=json.loads(stdout);record['audit']=payload
            require(done.returncode==0 and payload['events']==[] and MARKER in (payload['reason'] or '') and payload['debug'] is False and payload['optimize']==expected,'Audited guard failed: '+label)
        elif expected=='refuse':require(done.returncode==1 and stdout=='' and stderr.strip().startswith(MARKER),'Wrong refusal: '+label)
        else:require(done.returncode==0 and ('usage:' in stdout if expected=='help' else 'SEAL_VERIFIED' in stdout),'Positive control failed: '+label)
        record['passed']=True;save(out/(label+'.json'),record);results.append({'label':label,'exit_code':done.returncode,'passed':True})
    for name in SCRIPTS:
        for label,flags,opt,level in MODES:
            stem=name[:-3];target=phase/('MUST_NOT_EXIST-'+stem+'-'+label)
            params=['--root',str(root)]
            if name=='acquire.py':params+=['--curl',str(phase/'FORBIDDEN_CURL_SENTINEL.exe')]
            if name=='corpus.py':params+=['--destination',str(target)]
            prefix=[sys.executable,'-B','-X','utf8',*flags]
            run(stem+'-'+label+'-cli',prefix+[str(source/name),*params],opt,'refuse')
            import_code='import sys; sys.path.insert(0,'+repr(str(source))+'); import '+stem
            run(stem+'-'+label+'-import',prefix+['-c',import_code],opt,'refuse')
            run(stem+'-'+label+'-audit',prefix+['-c',AUDIT_PRELUDE,str(source/name),*params],opt,level,True)
            require(not target.exists(),'Unexpected output directory created')
    for name in SCRIPTS:run(name[:-3]+'-normal-help',[sys.executable,'-B','-X','utf8',str(source/name),'--help'],'0','help')
    for label,destination in [('initial',root/'fixtures/media4/initial-02'),('reproduction',root/'reports/media/reproduction-01')]:
        run(label+'-normal-verify',[sys.executable,'-B','-X','utf8',str(source/'corpus.py'),'--root',str(root),'--destination',str(destination),'--verify'],'0','verify')
    after=snapshot(root,phase);save(phase/'preservation-after.json',after)
    require(after==before,'Old evidence/file set/hash/mtime/attributes changed')
    require(not list(source.rglob('__pycache__')),'Unexpected source bytecode cache')
    historical=json.loads((root/'fixtures/media4/initial-02/manifest.json').read_text(encoding='utf-8'))['generator_sha256']
    require(historical=='8394c0fdaa6867ec0963e8f65db0845342bf8ff918fc3dad4bd335584660c580','Historical generator SHA changed')
    require(sha(source/'corpus.py')!=historical,'Expected new source provenance missing')
    summary={'status':'passed','optimized_cli_refusals':12,'optimized_real_import_refusals':12,'audited_module_body_refusals':12,'normal_help_positive':3,'normal_seal_verify_positive':2,'checks':results,'audit_operational_events':0,'new_media_output_directories':0,'encoder_or_network_activity_in_module_audit':False,'protected_files_unchanged':len(before),'file_hashes_mtimes_attributes_and_file_set_unchanged':True,'historical_generator_sha256':historical,'new_generator_source_sha256':sha(source/'corpus.py'),'old_phase02_full_qa_rerun':False,'normal_generation_rerun':False,'audit_boundary':'Interpreter startup and source loading are outside the module-body audit; direct CLI/import tests independently verify real entrypoints.'}
    save(out/'report.json',summary)
    print(json.dumps({k:v for k,v in summary.items() if k!='checks'},indent=2))
if __name__=='__main__':main()
