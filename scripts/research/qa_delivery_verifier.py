"""Bounded offline tests for the strict delivery verifier; no native application imports."""
from pathlib import Path
import copy
import hashlib
import importlib.util
import json
import sys


def main():
    verifier, scratch = Path(sys.argv[1]), Path(sys.argv[2])
    if scratch.exists():
        raise SystemExit('Use a new scratch directory')
    scratch.mkdir(parents=True)
    spec = importlib.util.spec_from_file_location('strict_verifier', verifier)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    results = []
    def test(name, change, expect_ok=False):
        root = scratch / name
        root.mkdir()
        content = b'hello\n'
        (root / 'sample.txt').write_bytes(content)
        rows = [{'path': 'sample.txt', 'bytes': len(content), 'sha256': hashlib.sha256(content).hexdigest()}]
        change(root, rows)
        (root / module.MANIFEST).write_text(json.dumps(rows), encoding='utf-8')
        error = None
        try:
            module.verify(root)
        except (OSError, ValueError, TypeError, KeyError) as exc:
            error = str(exc)
        if (error is None) != expect_ok:
            raise AssertionError((name, expect_ok, error))
        results.append({'name': name, 'passed': True, 'refused': error is not None, 'reason': error})
    test('valid', lambda r, x: None, True)
    test('git-directory-excluded', lambda r, x: ((r / '.git').mkdir(), (r / '.git/config').write_text('test')), True)
    test('git-pointer-excluded', lambda r, x: (r / '.git').write_text('gitdir: elsewhere'), True)
    test('unlisted-extra', lambda r, x: (r / 'extra.txt').write_text('extra'))
    test('missing-file', lambda r, x: (r / 'sample.txt').unlink())
    test('size-mismatch', lambda r, x: (r / 'sample.txt').write_text('short'))
    test('same-size-tamper', lambda r, x: (r / 'sample.txt').write_bytes(b'HELLO\n'))
    test('duplicate-exact', lambda r, x: x.append(copy.deepcopy(x[0])))
    test('casefold-alias', lambda r, x: x.append(dict(x[0], path='SAMPLE.TXT')))
    test('traversal', lambda r, x: x[0].update(path='../sample.txt'))
    test('backslash', lambda r, x: x[0].update(path='dir\\sample.txt'))
    test('absolute-posix', lambda r, x: x[0].update(path='/sample.txt'))
    test('drive-relative', lambda r, x: x[0].update(path='C:sample.txt'))
    test('alternate-stream', lambda r, x: x[0].update(path='sample.txt:secret'))
    test('dot-component', lambda r, x: x[0].update(path='./sample.txt'))
    test('empty-component', lambda r, x: x[0].update(path='dir//sample.txt'))
    test('reserved-device', lambda r, x: x[0].update(path='CON.txt'))
    test('trailing-dot', lambda r, x: x[0].update(path='sample.txt.'))
    test('trailing-space', lambda r, x: x[0].update(path='sample.txt '))
    test('boolean-size', lambda r, x: x[0].update(bytes=True))
    test('bad-digest', lambda r, x: x[0].update(sha256='z' * 64))
    test('self-entry', lambda r, x: x[0].update(path=module.MANIFEST))
    test('git-entry', lambda r, x: x[0].update(path='.git/config'))
    result = {'status': 'passed', 'checks': len(results), 'cases': results, 'native_actions': False, 'verifier_sha256': hashlib.sha256(verifier.read_bytes()).hexdigest()}
    (scratch / 'report.json').write_text(json.dumps(result, indent=2), encoding='utf-8')
    print(json.dumps({'status': result['status'], 'checks': result['checks'], 'native_actions': False}))


if __name__ == '__main__':
    main()
