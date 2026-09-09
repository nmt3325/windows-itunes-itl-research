"""Experimental, fixture-qualified cross-library import. Never native automation."""
import sys
if sys.flags.optimize or not __debug__:
    raise SystemExit('REFUSED: -O/-OO disables required checks; use normal Python')
sys.dont_write_bytecode=True
import json,hashlib,copy,zlib,collections,datetime,os,io,wave,re,stat,argparse
from pathlib import Path
class Refusal(ValueError):pass
def require(condition,message='experimental guard failed'):
    if not condition:raise Refusal(str(message))
HERE=Path(__file__).resolve().parent
VENDOR=HERE/'vendor'
core_manifest=json.loads((HERE/'core-manifest.json').read_text(encoding='utf-8'))
CORE_COMMIT=core_manifest['commit']
for name,digest in core_manifest['files'].items():
    require(hashlib.sha256((VENDOR/name).read_bytes()).hexdigest()==digest,'pinned core digest mismatch: '+name)
sys.path.insert(0,str(VENDOR))
from itlkit import Library
import itlkit
require(Path(itlkit.__file__).resolve().is_relative_to(VENDOR.resolve()),'another itlkit is preloaded')
from itlkit.binary import uint as u,put
from itlkit.library import read_text,Track
from itlkit.operations import Allocator,require_simple_library
from itlkit.trackops import _profile,_wave,_aux,_check_item,_rule_signature
from itlkit.io import write_new
from Crypto.Cipher import AES
MAX_BYTES=4*1024*1024
BASELINE_HASHES={'a93cbc94da00eb60d1f5a45ac70af55948d4ecbae2ea735744af04b7b46128e4','155e427ebaf820e177123c9787d878e1f6b655a5978db409ba742c8697675f81'}
DONOR_HASH='7edd4ea85ca937103165bb40a5656ba84cd9c08b73580beb2482d963f5728083'

def validate_bytes(data):
    require(0<len(data)<MAX_BYTES,'input file budget exceeded')
    independent(data)
    l=Library.from_bytes(data,max_plain_bytes=MAX_BYTES)
    _profile(l)
    require(0<len(l.tracks)<=64,'nonempty destination and at most64 tracks required')
    require([s.section_type for s in l.sections]==[16,12,9,11,1,13,23,2,14,21,4],'unknown section profile')
    for t in l.tracks:
        _wave(t)
        require(all(c.type_code in {2,3,4,5,6,8,11,12,13,27,30,31,32,33} for c in t.node.children),'opaque or unknown track metadata')
    for sec,tag in ((9,b'miah'),(11,b'miih')):
        for n in l._records(sec,tag):_aux(l,sec,u(n.header,16))
    registry(l);selected_playlists(l)
    return l

def read_snapshot(path):
    p=Path(path).resolve(strict=True)
    require(p.is_file() and p.suffix.lower()=='.itl','explicit regular ITL input required')
    with p.open('rb') as f:data=f.read(MAX_BYTES+1)
    require(len(data)<MAX_BYTES,'ITL exceeds4MiB budget')
    return p,data

def media_info(t,roots):
    raw_path=t.get('path')
    require(isinstance(raw_path,str) and not raw_path.startswith(('\\\\','//')),'local media only; UNC/network paths refused')
    p=Path(raw_path)
    require(p.is_absolute() and p.suffix.lower()=='.wav','absolute WAV Location required; no relocation')
    p=p.resolve(strict=True)
    require(any(p.is_relative_to(root) for root in roots),'media Location outside explicitly authorized roots')
    require(p.is_file(),'regular media file required')
    before=p.stat()
    with p.open('rb') as f:data=f.read(1024*1024+1)
    require(len(data)<1024*1024,'media exceeds bounded1MiB fixture profile')
    with wave.open(io.BytesIO(data),'rb') as w:shape={'channels':w.getnchannels(),'sample_rate':w.getframerate(),'sample_width':w.getsampwidth(),'frames':w.getnframes(),'compression':w.getcomptype()}
    require(shape['compression']=='NONE' and shape['sample_rate']==t.get('sample_rate') and len(data)==t.get('file_size'),'WAV does not match ITL size/rate')
    after=p.stat();require((before.st_size,before.st_mtime_ns)==(after.st_size,after.st_mtime_ns),'media changed during read')
    return {'path':str(p),'sha256':sha(data),'bytes':len(data),'mtime_ns':after.st_mtime_ns,'wave':shape}

def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--experimental',action='store_true',help='explicitly opt in to the bounded research transform')
    parser.add_argument('--baseline',required=True)
    parser.add_argument('--donor',required=True)
    parser.add_argument('--pid',action='append',required=True,help='16 hexadecimal digits; repeat in desired append order')
    parser.add_argument('--output',required=True,help='new .itl file; parent must already exist')
    parser.add_argument('--seed',default='experimental-cross-import-v1')
    parser.add_argument('--media-root',action='append',required=True,help='explicit allowlist for reading referenced synthetic WAVs; repeatable')
    a=parser.parse_args(argv)
    require(all(not str(x).startswith((chr(92)*2,'//')) for x in [a.baseline,a.donor,a.output,*a.media_root]), 'UNC/network path arguments are refused')
    require(a.experimental,'explicit --experimental opt-in is required')
    require(1<=len(a.seed)<=128 and all(ord(c)>=32 for c in a.seed),'seed must be1..128 printable characters')
    selected=[p.upper() for p in a.pid]
    require(all(re.fullmatch('[0-9A-F]{16}',p) and int(p,16)>0 for p in selected),'PID must be a positive16-digit hexadecimal value')
    require(1<=len(selected)<=32 and len(set(selected))==len(selected),'select1..32 unique PIDs')
    out=Path(a.output).absolute()
    require(out.suffix.lower()=='.itl' and out.parent.is_dir(),'new .itl output with existing parent required')
    require(not os.path.lexists(out),'output already exists; overwrite is forbidden')
    roots=[Path(p).resolve(strict=True) for p in a.media_root]
    require(all(p.is_dir() for p in roots),'media roots must be existing directories')
    bp,bd=read_snapshot(a.baseline);dp,dd=read_snapshot(a.donor)
    require(bp!=dp,'baseline and donor must be distinct inputs')
    data,report=transform(bd,dd,selected,a.seed)
    l=Library.from_bytes(data,max_plain_bytes=MAX_BYTES)
    report['media']=[media_info(t,roots) for t in l.tracks]
    require(read_snapshot(bp)[1]==bd and read_snapshot(dp)[1]==dd,'input changed during transformation')
    report.update({'output':str(out),'baseline':str(bp),'donor':str(dp),'experimental':True,'transaction':'new-file-only fsync+exclusive hard-link; no overwrite fallback','python':sys.version.split()[0],'zlib_runtime':zlib.ZLIB_RUNTIME_VERSION})
    receipt=json.dumps(report,indent=2,ensure_ascii=True)
    write_new(out,data)
    print(receipt)
    return 0


NS = {2: '178', 3: '1c0', 300: '1c0', 4: '208', 12: '208', 27: '208', 301: '208', 302: '208', 400: '208', 5: '328', 6: '370', 8: '400', 30: '1768', 31: '17b0', 32: '17f8', 33: '17f8', 34: '17f8', 401: '17f8'}

def sha(b):
    return hashlib.sha256(b).hexdigest()

def occurrences(l):
    for sec, tag in ((9, b'miah'), (11, b'miih'), (1, b'mith')):
        for n in l._records(sec, tag):
            for c in n.children or []:
                if c.tag == b'mhoh' and c.type_code in NS:
                    yield (sec, n, c)

def registry(l):
    r = {}
    occ = []
    for sec, n, c in occurrences(l):
        require(len(c.header) == 24 and u(c.header, 20) == 0, 'profile/preservation guard failed')
        require(c.payload[8:16] == bytes(8) and len(c.payload) == 16 + u(c.payload, 4), 'profile/preservation guard failed')
        text = read_text(c)
        i = u(c.header, 16)
        require(i > 0 and text, ('unsupported empty/unkeyed global atom', sec, c.type_code, c.offset))
        key = (NS[c.type_code], i)
        v = text.encode('utf-16-le')
        require(key not in r or r[key] == v, ('conflicting scoped definition', key))
        r[key] = v
        occ.append((sec, n, c))
    return (r, occ)

def independent(data):
    require(len(data) < 4 * 1024 * 1024 and data[:4] == b'hdfm', 'profile/preservation guard failed')
    be = lambda off: int.from_bytes(data[off:off + 4], 'big')
    hs = be(4)
    require(hs == 144 and be(8) == len(data), 'profile/preservation guard failed')
    require(data[65] == 2 and data[67] == 1 and (data[82] == 1) and (be(92) == 102400), 'profile/preservation guard failed')
    n = min(len(data) - hs, be(92)) // 16 * 16
    comp = AES.new(b'BHUILuilfghuila3', AES.MODE_ECB).decrypt(data[hs:hs + n]) + data[hs + n:]
    dec = zlib.decompressobj()
    plain = dec.decompress(comp, 4 * 1024 * 1024 + 1)
    require(len(plain) <= 4 * 1024 * 1024 and dec.eof and (not dec.unused_data) and (not dec.unconsumed_tail), 'profile/preservation guard failed')

    def le(off, size=4):
        require(0 <= off and off + size <= len(plain), 'profile/preservation guard failed')
        return int.from_bytes(plain[off:off + size], 'little')
    sections = {}
    pos = 0
    record_count = 0
    while pos < len(plain):
        require(plain[pos:pos + 4] == b'msdh', 'profile/preservation guard failed')
        h, t, k = (le(pos + 4), le(pos + 8), le(pos + 12))
        require(h >= 16 and h <= t <= len(plain) - pos and (k not in sections), 'profile/preservation guard failed')
        sections[k] = (pos, h, t)
        pos += t
    require(pos == len(plain) and len(sections) == be(48), 'profile/preservation guard failed')

    def walk(start, end, depth=0):
        nonlocal record_count
        require(depth <= 8, 'profile/preservation guard failed')
        nodes = []
        while start < end:
            require(start + 12 <= end, 'profile/preservation guard failed')
            tag = plain[start:start + 4]
            h, t = (le(start + 4), le(start + 8))
            require(h >= 12 and h <= t <= end - start, 'profile/preservation guard failed')
            child = walk(start + h, start + t, depth + 1) if tag in (b'mith', b'miah', b'miih', b'miph', b'mtph') else []
            if tag == b'miph':
                require(le(start + 12) == sum((x[0] == b'mhoh' for x in child)) and le(start + 16) == sum((x[0] == b'mtph' for x in child)), 'profile/preservation guard failed')
            elif tag in (b'mith', b'miah', b'miih', b'mtph'):
                require(le(start + 12) == len(child), 'profile/preservation guard failed')
            nodes.append((tag, start, t, child))
            record_count += 1
            require(record_count < 10000, 'profile/preservation guard failed')
            start += t
        require(start == end, 'profile/preservation guard failed')
        return nodes
    roots = {}
    for k, tag in ((1, b'mlth'), (2, b'mlph'), (9, b'mlah'), (11, b'mlih'), (13, b'mlth'), (14, b'mlph'), (12, b'mhgh'), (21, b'mlsh')):
        s, h, t = sections[k]
        pos = s + h
        require(plain[pos:pos + 4] == tag, 'profile/preservation guard failed')
        hh = le(pos + 4)
        require(12 <= hh <= s + t - pos, 'profile/preservation guard failed')
        nodes = walk(pos + hh, s + t)
        require(le(pos + 8) == len(nodes), 'profile/preservation guard failed')
        roots[k] = nodes
    require(not roots[13] and (not roots[14]), 'profile/preservation guard failed')
    require(len(roots[21]) == 1, 'profile/preservation guard failed')
    tg, pp, ss, _ = roots[21][0]
    require(tg == b'msph' and le(pp + 4) == 48 and (ss == 967), 'profile/preservation guard failed')
    require(sha(plain[pp:pp + ss]) in {'a3e963debb07cb70454f280e255239db7827a7552c03fcc817212218ba04d940', '41323ba0156b1e6228fa96eb6101f93e8fc681612704088c2de538ea0b58e0fd'}, 'profile/preservation guard failed')
    m = sections[16][0] + sections[16][1]
    require(plain[m:m + 4] == b'mfdh' and le(m + 8) == len(plain) + hs and (le(m + 48) == len(sections)), 'profile/preservation guard failed')
    for off, k in ((68, 1), (72, 2), (76, 9), (84, 11)):
        require(le(m + off) == len(roots[k]) == be(off), 'profile/preservation guard failed')
    tracks = {}
    secondary = []
    pids = []
    for tag, p, _, _ in roots[1]:
        require(tag == b'mith', 'profile/preservation guard failed')
        tid = le(p + 16)
        pid = le(p + 128, 8)
        require(tid and tid not in tracks and pid and (pid not in pids), 'profile/preservation guard failed')
        tracks[tid] = p
        pids.append(pid)
        secondary.append(le(p + 500))
    require(len(set(secondary)) == len(secondary) and 0 not in secondary, 'profile/preservation guard failed')
    for k, tag, off in ((9, b'miah', 220), (11, b'miih', 480)):
        ids = [le(p + 16) for _, p, _, _ in roots[k]]
        pp = [le(p + 20, 8) for _, p, _, _ in roots[k]]
        require(0 not in ids and len(ids) == len(set(ids)) and (0 not in pp) and (len(pp) == len(set(pp))), 'profile/preservation guard failed')
        require(all((le(p + off) in ids for p in tracks.values())), 'profile/preservation guard failed')
    master = []
    plids = []
    plpids = []
    for tag, p, _, children in roots[2]:
        require(tag == b'miph', 'profile/preservation guard failed')
        plids.append(le(p + 3392))
        plpids.append(le(p + 440, 8))
        items = [q for tg, q, _, _ in children if tg == b'mtph']
        refs = [le(q + 24) for q in items]
        require(set(refs) <= set(tracks), 'profile/preservation guard failed')
        for vals in ([le(q + 16) for q in items], [le(q + 68, 8) for q in items]):
            require(0 not in vals and len(vals) == len(set(vals)), 'profile/preservation guard failed')
        if le(p + 20) & 65536:
            master.append(refs)
    require(all((0 not in a and len(a) == len(set(a)) for a in (plids, plpids))), 'profile/preservation guard failed')
    require(len(master) == 1 and collections.Counter(master[0]) == collections.Counter(tracks.keys()), 'profile/preservation guard failed')
    core = Library.from_bytes(data, max_plain_bytes=4 * 1024 * 1024)
    require(core.container.payload == plain and core.to_bytes() == data, 'profile/preservation guard failed')
    return {'framing_and_counts': True, 'independent_known_refs_and_identities': True, 'master_exactly_once': True, 'sections': len(sections), 'records_walked': record_count, 'tracks': len(tracks), 'playlists': len(roots[2]), 'albums': len(roots[9]), 'artists': len(roots[11]), 'plain_bytes': len(plain)}

def mask(a, b, allowed):
    require(len(a) == len(b), 'profile/preservation guard failed')
    diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
    require(all((any((lo <= i < hi for lo, hi in allowed)) for i in diff)), ('unexpected byte changes', diff))
    return diff

def selected_playlists(l):
    rr = {}
    for p in l.playlists:
        k = 0 if p.is_master else u(p.node.header, 568)
        if not p.is_master and k not in (16640, 1024):
            continue
        require(k not in rr and len(p.node.header) == 3500 and (u(p.node.header, 24) == 65543), 'profile/preservation guard failed')
        codes = [n.type_code for n in p.node.children if n.tag == b'mhoh']
        require(codes == {0: [100, 105, 105, 108], 16640: [100, 102, 101, 105, 105, 108], 1024: [100, 102, 101, 105, 105, 108, 109]}[k], 'profile/preservation guard failed')
        require(collections.Counter(p.track_ids) == collections.Counter((t.track_id for t in l.tracks)), 'profile/preservation guard failed')
        for n in p.items:
            _check_item(n)
        rr[k] = p
    require(set(rr) == {0, 16640, 1024}, 'profile/preservation guard failed')
    return rr

def derived_pid(allocator, case, label):
    for i in range(100):
        pid = int.from_bytes(hashlib.sha256((case + '/' + label + '/' + str(i)).encode()).digest()[:8], 'big')
        try:
            return allocator.persistent(pid)
        except ValueError:
            pass
    raise AssertionError('no deterministic PID available')
FIELDS = {'Name': 'name', 'Artist': 'artist', 'Album': 'album', 'AlbumArtist': 'album_artist', 'Composer': 'composer', 'Genre': 'genre', 'Comment': 'comment', 'SortName': 'sort_name', 'SortArtist': 'sort_artist', 'SortAlbum': 'sort_album', 'SortAlbumArtist': 'sort_album_artist', 'Rating': 'rating', 'PlayedCount': 'play_count', 'SkippedCount': 'skip_count', 'TrackNumber': 'track_number', 'TrackCount': 'track_count', 'DiscNumber': 'disc_number', 'DiscCount': 'disc_count', 'Year': 'year', 'Compilation': 'compilation', 'SampleRate': 'sample_rate', 'BitRate': 'bit_rate', 'Size': 'file_size'}

def expected_track(t):
    d = {k: t.get(v) if t.get(v) is not None else '' for k, v in FIELDS.items()}
    d['persistent_id'] = f'{t.persistent_id:016X}'
    d['Location'] = str(Path(t.get('path')))
    d['Duration'] = t.get('total_time') / 1000
    return d

def transform(baseline_data, donor_data, selected, case):
    d = validate_bytes(donor_data)
    b = validate_bytes(baseline_data)
    require(1 <= len(selected) <= 32 and len(selected) == len(set(selected)), 'select1..32 unique PIDs')
    require(sha(baseline_data) in BASELINE_HASHES and sha(donor_data) == DONOR_HASH, 'unqualified input snapshot: only the documented synthetic profiles are supported')
    require(d.persistent_id != b.persistent_id, 'profile/preservation guard failed')
    _profile(d)
    _profile(b)
    dr, docc = registry(d)
    br, bocc = registry(b)
    require(set(selected) <= {f'{t.persistent_id:016X}' for t in d.tracks}, 'selected PID absent from donor')
    src = [d.track(persistent_id=p) for p in selected]
    for t in src:
        _wave(t)
    require(not {t.persistent_id for t in src} & {t.persistent_id for t in b.tracks}, 'profile/preservation guard failed')
    try:
        copy.deepcopy(b).add_track_from(d, selected[0])
    except Exception as exc:
        require('same library lineage' in str(exc), 'profile/preservation guard failed')
        production_refusal = str(exc)
    else:
        raise AssertionError('production cross-lineage guard unexpectedly absent')
    target = copy.deepcopy(b)
    alloc = Allocator(target)
    initial_next = alloc.next_id
    pidmap = {}
    localmap = {}
    new = []
    objects = {}
    patches = []
    for sec, tag, ref in ((9, b'miah', 'album_id'), (11, b'miih', 'artist_id')):
        for oldid in dict.fromkeys((t.get(ref) for t in src)):
            old = _aux(d, sec, oldid)
            clone = copy.deepcopy(old)
            pid = u(old.header, 20, 8)
            alloc.persistent(pid)
            newid = alloc.local()
            put(clone.header, 16, newid)
            objects[sec, oldid] = clone
            localmap[f'{tag.decode()}:{oldid}'] = newid
            new.append((sec, old, clone))
    for t in src:
        alloc.persistent(t.persistent_id)
        clone = copy.deepcopy(t.node)
        newid = alloc.local()
        second = alloc.local()
        put(clone.header, 16, newid)
        put(clone.header, 500, second)
        put(clone.header, 220, u(objects[9, t.get('album_id')].header, 16))
        put(clone.header, 480, u(objects[11, t.get('artist_id')].header, 16))
        localmap[f'mith:{t.track_id}'] = newid
        localmap[f'secondary:{u(t.node.header, 500)}'] = second
        new.append((1, t.node, clone))
        pidmap[t.persistent_id] = newid
    reserved = collections.defaultdict(set)
    for pool, i in br:
        reserved[pool].add(i)
    atommap = {}
    for sec, old, clone in new:
        for a, c in zip(old.children or [], clone.children or []):
            if c.type_code not in NS:
                require(a.to_bytes() == c.to_bytes(), 'profile/preservation guard failed')
                continue
            key = (NS[c.type_code], u(c.header, 16))
            require(key in dr, 'profile/preservation guard failed')
            if key not in atommap:
                i = max(reserved[key[0]] | {0}) + 1
                require(0 < i < 100000, 'profile/preservation guard failed')
                reserved[key[0]].add(i)
                atommap[key] = i
            put(c.header, 16, atommap[key])
            require(a.payload == c.payload, 'profile/preservation guard failed')
            mask(a.header, c.header, [(16, 20)])
            patches.append({'owner_tag': clone.tag.decode(), 'source_owner_offset': old.offset, 'type': c.type_code, 'pool': key[0], 'old_id': key[1], 'new_id': atommap[key], 'text_utf16_sha256': sha(dr[key])})
        mask(old.header, clone.header, [(16, 20), (220, 224), (480, 484), (500, 504)] if sec == 1 else [(16, 20)])
        target._root(sec).children.append(clone)
    destpl = selected_playlists(b)
    sourcepl = selected_playlists(d)
    membership = []
    for kind, old in destpl.items():
        require(_rule_signature(old) == _rule_signature(sourcepl[kind]), ('system rules differ', kind))
        dest = target.playlist(old.persistent_id)
        for t in src:
            require(sourcepl[kind].track_ids.count(t.track_id) == 1, 'profile/preservation guard failed')
            item = copy.deepcopy(old.items[0])
            lid = alloc.local()
            pid = derived_pid(alloc, case, f'member/{old.persistent_id:x}/{t.persistent_id:x}')
            put(item.header, 16, lid)
            put(item.header, 24, pidmap[t.persistent_id])
            put(item.header, 32, lid)
            put(item.header, 68, pid, 8)
            dest.node.children.append(item)
            membership.append({'playlist_pid': f'{old.persistent_id:016X}', 'kind_word': kind, 'track_pid': f'{t.persistent_id:016X}', 'item_local_id': lid, 'item_pid': f'{pid:016X}', 'token': lid})
    data = target.to_bytes(compression_level=1)
    check = independent(data)
    result = Library.from_bytes(data, max_plain_bytes=4 * 1024 * 1024)
    registry(result)
    require(len(result.tracks) == len(b.tracks) + len(src), 'profile/preservation guard failed')
    require(result.persistent_id == b.persistent_id, 'profile/preservation guard failed')
    preserved = []
    for t in b.tracks:
        q = result.track(persistent_id=t.persistent_id)
        require(q.node.to_bytes() == t.node.to_bytes(), 'profile/preservation guard failed')
        preserved.append({'persistent_id': f'{t.persistent_id:016X}', 'record_sha256': sha(t.node.to_bytes())})
    for sec, tag in ((9, b'miah'), (11, b'miih')):
        by = {u(n.header, 16): n for n in result._records(sec, tag)}
        for n in b._records(sec, tag):
            require(by[u(n.header, 16)].to_bytes() == n.to_bytes(), 'profile/preservation guard failed')
    for p in b.playlists:
        q = result.playlist(p.persistent_id)
        if p.persistent_id in {x.persistent_id for x in destpl.values()}:
            require([n.to_bytes() for n in q.node.children[:len(p.node.children)]] == [n.to_bytes() for n in p.node.children], 'profile/preservation guard failed')
            mask(p.node.header, q.node.header, [(8, 12), (16, 20)])
        else:
            require(p.node.to_bytes() == q.node.to_bytes(), 'profile/preservation guard failed')
    by = {s.section_type: s for s in result.sections}
    changes = []
    unchanged = []
    for s in b.sections:
        q = by[s.section_type]
        if s.to_bytes() != q.to_bytes():
            changes.append(s.section_type)
        else:
            unchanged.append({'section': s.section_type, 'sha256': sha(s.to_bytes())})
    require(set(changes) == {1, 2, 9, 11, 16}, 'profile/preservation guard failed')
    mask(b.container.header, result.container.header, [(8, 12), (68, 72), (76, 80), (84, 88)])
    mask(b._root(16).header, result._root(16).header, [(8, 12), (68, 72), (76, 80), (84, 88)])
    for k in (1, 2, 9, 11):
        mask(b._root(k).header, result._root(k).header, [(8, 12)])
    from itlkit.atoms import assert_pool_bindings
    assert_pool_bindings(result)
    for x, y in zip(b.sections, result.sections):
        mask(x.header, y.header, [(8, 12)])
    for t in src:
        q = result.track(persistent_id=t.persistent_id)
        mask(t.node.header, q.node.header, [(16, 20), (220, 224), (480, 484), (500, 504)])
        require(len(t.node.children) == len(q.node.children), 'incoming child count drift')
        for x, y in zip(t.node.children, q.node.children):
            require(x.type_code == y.type_code and x.payload == y.payload, 'incoming payload changed')
            mask(x.header, y.header, [(16, 20)] if x.type_code in NS else [])
    id_to_pid = {t.track_id: f'{t.persistent_id:016X}' for t in result.tracks}
    expected = {'file_persistent_id': f'{result.persistent_id:016X}', 'library_persistent_id': f'{next((p for p in result.playlists if p.is_master)).persistent_id:016X}', 'track_count': len(result.tracks), 'serialized_playlist_count': len(result.playlists), 'tracks': [expected_track(t) for t in result.tracks], 'raw_tracks': [t.to_dict() for t in result.tracks], 'all_serialized_playlists': [{'persistent_id': f'{p.persistent_id:016X}', 'kind_word': u(p.node.header, 568), 'is_master': p.is_master, 'is_plain': p.is_plain, 'member_pids_physical_order': [id_to_pid[i] for i in p.track_ids]} for p in result.playlists], 'dates': 'raw fields retained; no runtime timezone conversion', 'observe_only': ['RatingKind', 'AlbumRatingKind', 'AlbumRating', 'TrackID', 'TrackDatabaseID', 'PlayOrderIndex']}
    return (data, {'expected': expected, 'new_track_pids': selected, 'seed': case, 'preserved_existing_tracks': preserved, 'local_id_map': localmap, 'atom_header_patches': patches, 'new_memberships': membership, 'validation': check, 'production_API_refusal_preserved': production_refusal, 'baseline_sha256': sha(baseline_data), 'donor_sha256': sha(donor_data), 'candidate_sha256': sha(data), 'candidate_bytes': len(data), 'core_commit': CORE_COMMIT, 'native_acceptance': 'not asserted by this invocation', 'unknowns': ['Only the documented source hashes are qualified.', 'Native raw14 and grouping/high-water behavior are separate gates.', 'No media creation, relocation, COW or public API extension.']})

if __name__=='__main__':
    try:raise SystemExit(main())
    except (Refusal,ValueError,OSError,RuntimeError) as exc:
        print('REFUSED/ERROR: '+str(exc)+'; if publication IO failed, inspect the output before retrying.',file=sys.stderr)
        raise SystemExit(2)
