#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'TXT'
Uso:
  install.sh [--scope user|project] [--project /percorso] [--run-doctor]
  install.sh [user|project] [/percorso]
TXT
}

SCOPE="user"
PROJECT="$(pwd)"
RUN_DOCTOR=false

if [[ $# -gt 0 && "$1" != --* ]]; then
  SCOPE="$1"
  PROJECT="${2:-$(pwd)}"
else
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --scope) SCOPE="${2:?Manca il valore di --scope}"; shift 2 ;;
      --project) PROJECT="${2:?Manca il valore di --project}"; shift 2 ;;
      --run-doctor) RUN_DOCTOR=true; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Argomento sconosciuto: $1" >&2; usage; exit 2 ;;
    esac
  done
fi

case "$SCOPE" in user|project) ;; *) echo "Scope non valido: $SCOPE" >&2; exit 2;; esac
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$(mkdir -p "$PROJECT" && cd "$PROJECT" && pwd)"
if [[ "$SCOPE" == user ]]; then TARGET="$HOME/.agents/skills"; else TARGET="$PROJECT/.agents/skills"; fi

mkdir -p "$TARGET"
for skill in "$ROOT"/skills/*; do
  name="$(basename "$skill")"
  rm -rf "$TARGET/$name"
  cp -R "$skill" "$TARGET/$name"
  echo "Installata: $name -> $TARGET/$name"
done

echo "Apri una nuova sessione Codex per caricare le skill."
if [[ "$RUN_DOCTOR" == true ]]; then
  "$ROOT/scripts/doctor.sh" --project "$PROJECT"
fi
