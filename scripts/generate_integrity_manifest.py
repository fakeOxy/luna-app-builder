#!/usr/bin/env python3
"""Generate integrity-manifest.json deterministically from repository files."""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "integrity-manifest.json"
TEMPORARY_REFRESH_WORKFLOW = ROOT / ".github/workflows/refresh-manifest.yml"
IGNORED_PARTS = {".git", "__pycache__", ".pytest_cache", ".mypy_cache"}


def ignored(path: Path) -> bool:
    return any(part in IGNORED_PARTS for part in path.parts)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


creator = json.loads((ROOT / "creator.json").read_text(encoding="utf-8"))
files = []
for path in sorted(ROOT.rglob("*"), key=lambda item: item.relative_to(ROOT).as_posix()):
    if not path.is_file() or path in {MANIFEST, TEMPORARY_REFRESH_WORKFLOW} or ignored(path):
        continue
    files.append(
        {
            "path": path.relative_to(ROOT).as_posix(),
            "sha256": sha256(path),
            "size": path.stat().st_size,
        }
    )

payload = {
    "product": "Luna App Builder",
    "version": creator["version"],
    "creator": creator["creator"],
    "officialRepository": creator["officialRepository"],
    "algorithm": "sha256",
    "files": files,
    "note": (
        "Questo manifesto rileva differenze rispetto alla release. "
        "La prova forte dell’origine richiede tag o release firmati dal creatore."
    ),
}
MANIFEST.write_text(
    json.dumps(payload, ensure_ascii=False, separators=(",", ":")) + "\n",
    encoding="utf-8",
    newline="\n",
)
print(f"Manifesto aggiornato: {len(files)} file")