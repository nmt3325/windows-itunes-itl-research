"""Offline tests. Inputs and output directory are explicit; no native calls."""
import sys,argparse,json,copy,contextlib,io,ast
from pathlib import Path
sys.dont_write_bytecode=True
p=argparse.ArgumentParser();p.add_argument('--baseline',required=True);p.add_argument('--recipient37',required=True);p.add_argument('--donor',required=True);p.add_argument('--output-dir',required=True);p.add_argument('--media-root',action='append',required=True);a=p.parse_args()
HERE=Path(__file__).resolve().parent;sys.path.insert(0,str(HERE));import experimental_import as E
from itlkit.errors import FormatError,UnsupportedError
from itlkit.model import Node
B=Path(a.baseline).read_bytes();D=Path(a.donor).read_bytes();G=Path(a.recipient37).read_bytes();O=Path(a.output_dir);O.mkdir(exist_ok=True)
PIDS=['E95DD2B085330A12','0EA4623DE17EC6F6'];T=[]
def check(name,fn,reject=False):
 try:value=fn()
 except (ValueError,OSError,RuntimeError) as e:
  if not reject:raise
  T.append({'name':name,'passed':True,'refusal':type(e).__name__,'message':str(e)});return
 if reject:raise AssertionError('Expected refusal: '+name)
 T.append({'name':name,'passed':True})
def yes(v):
 if not v:raise AssertionError('positive check failed')

def cli_args(output='new.itl'):
 v=['--experimental','--baseline',a.baseline,'--donor',a.donor,'--pid',PIDS[0],'--output',str(O/output),'--seed','crud3-cross-one-003']
 for r in a.media_root:v+=['--media-root',r]
 return v

def run(args):
 with contextlib.redirect_stdout(io.StringIO()) as out:E.main(args)
 return json.loads(out.getvalue())

one,one_report=E.transform(B,D,PIDS[:1],'crud3-cross-one-003')
check('exact replay of native-qualified one-track candidate',lambda:yes(E.sha(one)=='60c5f1541981ddedd457f3e78ca07c63a8d71e3b8e42f3211b175aad2a8facaa'))
check('repeat same inputs ordered PIDs seed',lambda:yes(E.transform(B,D,PIDS[:1],'crud3-cross-one-003')[0]==one))
group,group_report=E.transform(G,D,PIDS,'crud3-cross-shared-two-037')
check('exact replay of offline shared-group candidate',lambda:yes(E.sha(group)=='2bf00425a238492c427e07108638fb7e6317ccdbbc62cadb6c4499b656c08ee1'))
l=E.Library.from_bytes(group);t1,t2=[l.track(persistent_id=i) for i in PIDS]
check('both incoming tracks share one cloned album and artist',lambda:yes(t1.get('album_id')==t2.get('album_id') and t1.get('artist_id')==t2.get('artist_id')))
changed,changed_report=E.transform(B,D,PIDS[:1],'different-seed')
def seed_diff():
 x=E.Library.from_bytes(one);y=E.Library.from_bytes(changed);yes(one!=changed)
 for s,t in zip(x.sections,y.sections):
  if s.section_type!=2:yes(s.to_bytes()==t.to_bytes())
 for p,q in zip(x.playlists,y.playlists):
  yes(p.node.header==q.node.header)
  for n,m in zip(p.node.children,q.node.children):
   if n.tag==b'mtph':E.mask(n.header,m.header,[(68,76)]);yes(n.payload==m.payload)
   else:yes(n.to_bytes()==m.to_bytes())
check('different seed changes only new membership PID slots in plaintext',seed_diff)
check('duplicate PID selection refused',lambda:E.transform(B,D,[PIDS[0],PIDS[0]],'x'),True)
check('unknown selected PID refused',lambda:E.transform(B,D,['FFFFFFFFFFFFFFFF'],'x'),True)
check('same-lineage public API guard retained',lambda:E.Library.from_bytes(B).add_track_from(E.Library.from_bytes(D),PIDS[0]),True)
check('same-lineage inputs refused by experimental profile gate',lambda:E.transform(B,B,PIDS[:1],'x'),True)
base=E.Library.from_bytes(B)
def mutate(fn,which=B):
 q=E.Library.from_bytes(which);fn(q);return E.validate_bytes(q.to_bytes())
for name,nodes,offset,size in [
 ('track local',lambda q:[t.node for t in q.tracks],16,4),('track PID',lambda q:[t.node for t in q.tracks],0x80,8),('secondary',lambda q:[t.node for t in q.tracks],0x1f4,4),
 ('album local',lambda q:q._records(9,b'miah'),16,4),('album PID',lambda q:q._records(9,b'miah'),20,8),('artist local',lambda q:q._records(11,b'miih'),16,4),('artist PID',lambda q:q._records(11,b'miih'),20,8),
 ('playlist local',lambda q:[x.node for x in q.playlists],0xd40,4),('playlist PID',lambda q:[x.node for x in q.playlists],0x1b8,8),('item local',lambda q:q.playlists[0].items,16,4),('item PID',lambda q:q.playlists[0].items,68,8)]:
 check('duplicate '+name,lambda n=nodes,o=offset,s=size:mutate(lambda q:E.put(n(q)[1].header,o,E.u(n(q)[0].header,o,s),s)),True)
for off in (0xdc,0x1e0):check('missing index '+hex(off),lambda off=off:mutate(lambda q:E.put(q.tracks[0].node.header,off,0x7ffffffe)),True)
check('missing playlist track reference',lambda:mutate(lambda q:E.put(q.playlists[0].items[0].header,24,0x7ffffffe)),True)
def atom_conflict(q):
 n=next(c for c in q.tracks[1].node.children if c.type_code==2);E.put(n.header,16,1)
check('same-pool ID unequal-string collision',lambda:mutate(atom_conflict),True)
def empty(q):
 for k in (1,9,11):q._root(k).children.clear()
 for pl in q.playlists:pl.node.children=[n for n in pl.node.children if n.tag!=b'mtph']
check('empty destination',lambda:mutate(empty),True)
check('unknown track field',lambda:mutate(lambda q:E.put(q.tracks[0].node.children[0].header,12,999)),True)
check('opaque track field1',lambda:mutate(lambda q:E.put(q.tracks[0].node.children[0].header,12,1)),True)
check('unsupported grouped/system playlist flags',lambda:mutate(lambda q:E.put(q.playlists[0].node.header,0x18,65544)),True)
check('unknown system kind',lambda:mutate(lambda q:E.put(q.playlists[1].node.header,0x238,0x9999)),True)
check('unknown system metadata',lambda:mutate(lambda q:E.put(q.playlists[0].node.children[0].header,12,999)),True)
def opaque_settings(q):
 n=q._root(21).children[0];v=bytearray(n.payload);v[-1]^=1;n.payload=bytes(v)
check('unknown opaque settings digest',lambda:mutate(opaque_settings),True)
def bad_aux(q):q._records(9,b'miah')[0].children[0].payload+=b'unknown'
check('unknown auxiliary suffix',lambda:mutate(bad_aux,D),True)
def unknown_snapshot():
 q=E.Library.from_bytes(B);h=bytearray(q.container.header);h[-1]^=1;q.container.header=bytes(h);return E.transform(q.to_bytes(),D,PIDS[:1],'x')
check('otherwise parseable unqualified snapshot refused',unknown_snapshot,True)
check('explicit experimental opt-in required',lambda:run(cli_args()[1:]),True)
args=cli_args();args[args.index('--pid')+1]='not-hex'
check('PID syntax refused',lambda:run(args),True)
args=cli_args();args+=['--pid',PIDS[0]]
check('CLI duplicate PID refused',lambda:run(args),True)
check('media root allowlist enforced',lambda:E.media_info(base.tracks[0],[O.resolve()]),True)
class Fake:
 def get(self,key):return '\\\\untrusted.invalid\\private\\a.wav'
check('network media refused before opening',lambda:E.media_info(Fake(),[O.resolve()]),True)
existing=O/'existing.itl';existing.write_bytes(b'SENTINEL')
check('existing output refused',lambda:run(cli_args('existing.itl')),True)
check('existing bytes unchanged',lambda:yes(existing.read_bytes()==b'SENTINEL'))
r=run(cli_args('repeat.itl'))
check('actual CLI writes only byte-exact complete new file',lambda:yes((O/'repeat.itl').read_bytes()==one))
check('CLI output path excluded from identity seed',lambda:yes(r['candidate_sha256']==E.sha(one)))
check('transaction has no leftover temp files',lambda:yes(not list(O.glob('.*.tmp'))))
check('source inputs unchanged',lambda:yes(Path(a.baseline).read_bytes()==B and Path(a.donor).read_bytes()==D and Path(a.recipient37).read_bytes()==G))
check('runtime script has no assert statements',lambda:yes(not any(isinstance(n,ast.Assert) for n in ast.walk(ast.parse((HERE/'experimental_import.py').read_text(encoding='utf-8'))))))
check('runtime has no fixed environment/root dependency',lambda:yes('RUNNER-G4A2-WIN' not in (HERE/'experimental_import.py').read_text(encoding='utf-8')))
for n,data,receipt in [('group-replay',group,group_report),('different-seed',changed,changed_report)]:
 E.write_new(O/(n+'.itl'),data);(O/(n+'.json')).write_text(json.dumps(receipt,indent=2),encoding='utf-8')
result={'passed':len(T),'failed':0,'tests':T,'native_actions':0,'core_commit':E.CORE_COMMIT,'python':sys.version,'input_hashes':{'baseline':E.sha(B),'recipient37':E.sha(G),'donor':E.sha(D)},'reproduced':{'one':E.sha(one),'group':E.sha(group)},'changed_seed':{'sha256':E.sha(changed),'explained_by':'only new mtph+0x44..0x4b PID bytes in plaintext; compressed envelope length/content consequently differs'}}
(O/'test-results.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print(json.dumps({'passed':len(T),'failed':0,'reproduced':result['reproduced']}))