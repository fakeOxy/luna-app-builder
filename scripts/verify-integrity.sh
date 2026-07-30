#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
python3 - "$ROOT" <<'PY'
import json, hashlib, pathlib, sys
root=pathlib.Path(sys.argv[1]); m=json.loads((root/'integrity-manifest.json').read_text())
bad=0
for e in m['files']:
    p=root/e['path']
    if not p.is_file(): print('MISSING ', e['path']); bad+=1; continue
    h=hashlib.sha256(p.read_bytes()).hexdigest()
    if h!=e['sha256']: print('MODIFIED', e['path']); bad+=1
    else: print('OK      ', e['path'])
if bad: raise SystemExit(f'{bad} file mancanti o modificati')
print('Integrità checksum verificata. Senza firma, il manifesto può essere rigenerato da chi modifica i file.')
PY
