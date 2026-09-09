"""Bounded, hash-pinned native observation. Metadata mismatches never become acceptance.
No setters or UpdateInfoFromFile. A scoped negative observation is saved and closed
normally so its second cycle can be measured without adopting the failed values.
"""
import argparse, copy, datetime, hashlib, json, pathlib, re, struct, subprocess, sys, time, traceback, zlib

def digest(data):
    return hashlib.sha256(data).hexdigest()

def write_json(path, data):
    temp = path.with_name(path.name + '.tmp')
    temp.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding='utf-8')
    temp.replace(path)

def load(path):
    return json.loads(path.read_text(encoding='utf-8'))

def facts(path):
    s = path.stat()
    return {'path': str(path), 'bytes': s.st_size, 'mtime_ns': s.st_mtime_ns,
            'sha256': digest(path.read_bytes()), 'file_attributes': getattr(s, 'st_file_attributes', None)}

def envelope(path, target=None):
    from Crypto.Cipher import AES
    raw = path.read_bytes()
    assert raw[:4] == b'hdfm' and len(raw) >= 144
    header = struct.unpack_from('>I', raw, 4)[0]
    assert 144 <= header <= len(raw)
    enc, comp, cap = raw[0x41], raw[0x43], struct.unpack_from('>I', raw, 0x5c)[0]
    body = raw[header:]
    if enc == 0: n = 0
    elif enc == 1: n = len(body) & ~15
    elif enc == 2: n = min(len(body), cap) & ~15
    else: raise ValueError('Unknown encryption flag')
    decoded = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(body[:n]) + body[n:]
    if comp == 1:
        dz = zlib.decompressobj(); plain = dz.decompress(decoded, 32 * 1024 * 1024)
        assert dz.eof and not dz.unused_data and not dz.unconsumed_tail
    elif comp == 0: plain = decoded
    else: raise ValueError('Unknown compression flag')
    out = {'file_bytes':len(raw), 'file_sha256':digest(raw), 'header_bytes':header,
           'encryption_flag':enc, 'compression_flag':comp, 'cap':cap,
           'body_bytes':len(body), 'encrypted_bytes':n, 'clear_tail_bytes':len(body)-n,
           'expanded_bytes':len(plain), 'expanded_sha256':digest(plain),
           'decoded_body_sha256':digest(decoded), 'header_hex':raw[:header].hex()}
    pos = 0
    while pos < len(plain):
        assert plain[pos:pos+4] == b'msdh'
        hs, size, kind = struct.unpack_from('<III', plain, pos+4)
        assert hs >= 16 and size >= hs and pos+size <= len(plain)
        if kind == 1:
            q = pos+hs; assert plain[q:q+4] == b'mlth'
            q += struct.unpack_from('<I', plain, q+4)[0]
            while q < pos+size:
                assert plain[q:q+4] == b'mith'
                th, ts = struct.unpack_from('<II', plain, q+4)
                assert th >= 0x88 and ts >= th and q+ts <= pos+size
                pid = f'{struct.unpack_from("<Q",plain,q+0x80)[0]:016X}'
                if pid == target:
                    out['target_persisted_record'] = {'persistent_id':pid,
                        'raw_0x6d':plain[q+0x6d], 'raw_0xee':plain[q+0xee],
                        'raw_0x290_u32':struct.unpack_from('<I',plain,q+0x290)[0] if th >= 0x294 else None,
                        'header_bytes':th, 'record_bytes':ts, 'record_sha256':digest(plain[q:q+ts])}
                q += ts
        pos += size
    return out

def filtered(state, observe_only):
    out = copy.deepcopy(state)
    for tr in out['tracks']:
        for field in observe_only: tr.pop(field, None)
    return out

def compare_state(expected, actual, observe_only):
    from verify_native_matrix import compare
    return compare(filtered(expected, observe_only), actual)

def worker(spec_path, output, compare_fn=None):
    import pythoncom, win32com.client
    from native_worker import pid, items, file_interface, snapshot, guard, norm
    spec=load(spec_path); root=pathlib.Path(spec['root']); expected=spec['expected']; target=spec.get('target_track')
    comparer = compare_fn or compare_state
    result={'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),
            'spec':spec, 'samples':[], 'explicit_mutations':[], 'update_info_from_file_called':False}
    assert not output.exists()
    pythoncom.CoInitialize()
    try:
        app=win32com.client.dynamic.Dispatch('iTunes.Application')
        # Identity preflight precedes broad metadata reads.
        assert pid(app,app.LibraryPlaylist)==expected['library_persistent_id'], 'Wrong master PID / fallback'
        tracks=items(app.LibraryPlaylist.Tracks)
        assert len(tracks)==expected['track_count'], 'Wrong count / fallback'
        assert {pid(app,t) for t in tracks}=={t['persistent_id'] for t in expected['tracks']}, 'Wrong track PID set'
        def by_pid(key):
            return file_interface(app,next(t for t in items(app.LibraryPlaylist.Tracks) if pid(app,t)==key))
        def target_read():
            if target is None: return None
            tr=by_pid(target); d={'Name':tr.Name}
            for name in ['Unplayed','Rating','RatingKind','AlbumRating','AlbumRatingKind','PlayedCount','ModificationDate']:
                try: d[name]=norm(getattr(tr,name))
                except Exception as e: d[name]={'unavailable':str(e)}
            return d
        result['initial_target']=target_read()
        locations=[]
        for t in tracks:
            p=pathlib.Path(file_interface(app,t).Location).resolve()
            assert p.is_relative_to(root.resolve()), 'Non-synthetic media'
            locations.append(p)
        start=time.monotonic(); first=None; all_errors=[]
        targets=sorted(set([0.0, min(5.0,spec['dwell_seconds']), float(spec['dwell_seconds'])]))
        expected_target=next((t for t in expected['tracks'] if t['persistent_id']==target), {})
        if result['initial_target'] and 'Name' in expected_target and result['initial_target']['Name'] != expected_target['Name']:
            all_errors.append({'property':'initial_target_Name','expected':expected_target['Name'],'actual':result['initial_target']['Name']})
        for deadline in targets:
            while time.monotonic()-start < deadline:
                pythoncom.PumpWaitingMessages();time.sleep(min(.2, max(.001,deadline-(time.monotonic()-start))))
            state=snapshot(app);guard(state,root);fresh=target_read()
            errors=comparer(expected,state,spec['observe_only'])
            if fresh and 'Name' in expected_target and fresh['Name'] != expected_target['Name']:
                errors.append({'property':'fresh_target_Name','expected':expected_target['Name'],'actual':fresh['Name']})
            stability=[] if first is None else comparer(first,state,spec['observe_only'])
            if first is None: first=state
            media=[facts(p) for p in locations]
            sample={'elapsed_seconds':time.monotonic()-start, 'state':state,'fresh_target':fresh,
                    'expected_errors':errors,'stability_errors':stability,'media':media,
                    'library_file':facts(pathlib.Path(spec['live']))}
            try: sample['persisted_profile']=envelope(pathlib.Path(spec['live']),target)
            except Exception as e: sample['persisted_profile_error']=repr(e)
            result['samples'].append(sample);all_errors.extend(errors+stability);write_json(output,result)
        result['before']=result['samples'][0]['state'];result['after']=result['samples'][-1]['state']
        result['final_fresh_target']=target_read()
        if result['final_fresh_target'] and 'Name' in expected_target and result['final_fresh_target']['Name'] != expected_target['Name']:
            all_errors.append({'property':'pre_quit_Name','expected':expected_target['Name'],'actual':result['final_fresh_target']['Name']})
        result['media_unchanged']=result['samples'][0]['media']==result['samples'][-1]['media']
        result['accepted']=not all_errors;result['errors']=all_errors;result['observation_completed']=True
        write_json(output,result)
        # Saving a known synthetic negative result is deliberate, never a pass.
        app.Quit();result['quit_returned']=True;write_json(output,result)
        print(json.dumps({'accepted':result['accepted'],'samples':len(result['samples']),
                          'final_target':result['final_fresh_target'],'media_unchanged':result['media_unchanged']},ensure_ascii=True),flush=True)
    except Exception as e:
        result.update(observation_completed=False,error=str(e),traceback=traceback.format_exc());write_json(output,result);raise
    finally: pythoncom.CoUninitialize()

def run_cycle(case, number, previous_sha):
    from native_driver import EXE, wait_ready
    from native_acceptance import require_stopped
    root=pathlib.Path(case['root']); report=pathlib.Path(case['report']);live=pathlib.Path(case['live'])
    out=report/'runs'/(case['name']+'-reload'+str(number));out.mkdir(parents=True,exist_ok=False)
    result={'name':case['name'],'cycle':number,'ui':[],'active_library':str(live)};proc=None
    try:
        require_stopped();assert facts(live)['sha256']==previous_sha
        result['prelaunch']=facts(live);result['profile_before']=envelope(live,case.get('target_track'))
        media_paths={pathlib.Path(t['Location']).resolve() for t in case['expected']['tracks']}
        assert all(p.is_relative_to(root.resolve()) for p in media_paths)
        result['media_prelaunch']=[facts(p) for p in sorted(media_paths)]
        proc=subprocess.Popen([str(EXE)],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
        result['itunes_pid']=proc.pid;write_json(out/'result.json',result);wait_ready(proc,result['ui'])
        spec=dict(case);spec['dwell_seconds']=case['dwell'][number-1]
        write_json(out/'spec.json',spec)
        cmd=[sys.executable,'-B','-u',str(pathlib.Path(__file__).resolve()),'worker','--spec',str(out/'spec.json'),'--out',str(out/'com.json')]
        result['worker_command']=cmd
        with (out/'worker.log').open('w',encoding='utf-8') as log:
            w=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,timeout=spec['dwell_seconds']+90)
        result['worker_exit_code']=w.returncode
        if w.returncode: raise RuntimeError('Observation worker failed; inspect saved evidence before recovery')
        proc.wait(timeout=45);result['itunes_exit_code']=proc.returncode
        assert proc.returncode==0;require_stopped();time.sleep(.3)
        saved=root/'phase2/snapshots'/(case['name']+'-reload'+str(number)+'.itl');saved.parent.mkdir(parents=True,exist_ok=True)
        with saved.open('xb') as f:f.write(live.read_bytes())
        result['saved']=facts(saved);result['profile_after']=envelope(saved,case.get('target_track'))
        com=load(out/'com.json');result['accepted']=com['accepted'];result['observation_completed']=True
        result['errors']=com['errors'];result['final_target']=com['final_fresh_target'];result['com_evidence']=str(out/'com.json')
        write_json(out/'result.json',result);print(json.dumps({k:result[k] for k in ['name','cycle','accepted','itunes_exit_code','worker_exit_code','final_target']},ensure_ascii=True),flush=True)
        return result
    except Exception as e:
        result.update(observation_completed=False,error=repr(e),traceback=traceback.format_exc())
        if proc: result['itunes_poll']=proc.poll()
        write_json(out/'result.json',result);raise

def batch(manifest):
    from native_acceptance import require_stopped
    cases=load(manifest);summary=[]
    for case in cases:
        assert re.fullmatch('[A-Za-z0-9_-]+',case['name'])
        require_stopped();root=pathlib.Path(case['root']);live=pathlib.Path(case['live']);rep=pathlib.Path(case['report'])
        assert live.resolve().is_relative_to(root.resolve())
        raw=pathlib.Path(case['candidate']).read_bytes();assert digest(raw)==case['sha256']
        pins=root/'phase2/candidates';pins.mkdir(parents=True,exist_ok=True);pin=pins/(case['name']+'.itl')
        with pin.open('xb') as f:f.write(raw)
        out=rep/'cases'/case['name'];out.mkdir(parents=True,exist_ok=False)
        with (out/'pretest-library.itl').open('xb') as f:f.write(live.read_bytes())
        write_json(out/'case.json',case)
        tmp=live.with_name(live.name+'.phase2.tmp')
        with tmp.open('xb') as f:f.write(raw)
        require_stopped();tmp.replace(live);previous=case['sha256'];results=[]
        for number in [1,2]:
            value=run_cycle(case,number,previous);results.append(value);previous=value['saved']['sha256']
        entry={'name':case['name'],'sha256':case['sha256'],'accepted':all(x['accepted'] for x in results),'cycles':results}
        write_json(out/'result.json',entry);summary.append(entry);write_json(rep/(manifest.stem+'-results.json'),summary)
    require_stopped()
    print(json.dumps({'completed_cases':len(summary),'accepted_cases':sum(x['accepted'] for x in summary)},ensure_ascii=True),flush=True)

def main():
    p=argparse.ArgumentParser();s=p.add_subparsers(dest='mode',required=True)
    w=s.add_parser('worker');w.add_argument('--spec',type=pathlib.Path,required=True);w.add_argument('--out',type=pathlib.Path,required=True)
    b=s.add_parser('batch');b.add_argument('--manifest',type=pathlib.Path,required=True)
    a=p.parse_args()
    if a.mode=='worker':worker(a.spec,a.out)
    else:batch(a.manifest)
if __name__=='__main__':main()
