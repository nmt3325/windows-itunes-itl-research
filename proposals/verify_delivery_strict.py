"""Independent stdlib manifest + complete file-set verifier (no native actions)."""
import argparse,hashlib,json,pathlib,sys

def verify(root):
 root=root.resolve();rows=json.loads((root/'DELIVERY-MANIFEST.json').read_text(encoding='utf-8-sig'));seen=set();issues=[]
 for row in rows:
  text=row['path'];rel=pathlib.PurePosixPath(text);p=root/text
  if rel.is_absolute() or pathlib.PureWindowsPath(text).drive or '..' in rel.parts or '\\' in text or p.is_symlink() or not p.resolve().is_relative_to(root):issues.append({'path':text,'issue':'unsafe_path'});continue
  if text.casefold() in seen:issues.append({'path':text,'issue':'duplicate_casefold_path'});continue
  seen.add(text.casefold())
  if not p.is_file():issues.append({'path':text,'issue':'missing_file'});continue
  h=hashlib.sha256();size=0
  with p.open('rb') as f:
   while block:=f.read(65536):h.update(block);size+=len(block)
  if size!=row['bytes'] or h.hexdigest()!=row['sha256']:issues.append({'path':text,'issue':'digest_or_size_mismatch'})
 actual={p.relative_to(root).as_posix() for p in root.rglob('*') if p.is_file() and '.git' not in p.relative_to(root).parts};expected={x['path'] for x in rows}|{'DELIVERY-MANIFEST.json'}
 issues.extend({'path':x,'issue':'unlisted_extra_file'} for x in sorted(actual-expected));issues.extend({'path':x,'issue':'listed_missing_file'} for x in sorted(expected-actual))
 return {'ok':not issues,'manifest_entries':len(rows),'complete_file_count':len(actual),'manifest_self_excluded':'DELIVERY-MANIFEST.json' not in {x['path'] for x in rows},'issues':issues}
if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('root',type=pathlib.Path);p.add_argument('--out',type=pathlib.Path);a=p.parse_args();r=verify(a.root);t=json.dumps(r,indent=2)+'\n'
 if a.out:
  with a.out.open('x',encoding='utf-8') as f:f.write(t)
 print(t,end='');sys.exit(0 if r['ok'] else 1)