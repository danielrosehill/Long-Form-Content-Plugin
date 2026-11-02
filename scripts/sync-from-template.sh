#!/usr/bin/env bash
# Refresh this plugin's vendored copy of the long-form workspace template.
#
# The template repo is canonical. This plugin vendors it so that `/lf-new` can
# scaffold a workspace locally when `gh` is unavailable. Only `commands/`,
# `agents/`, `skills/`, `.claude-plugin/` and this script are owned by the plugin.
#
# Vendored copies stay byte-identical. That is what makes --check meaningful: any
# difference is drift, and drift means somebody edited the wrong copy.
#
# Usage:
#   ./scripts/sync-from-template.sh                  pull from GitHub
#   ./scripts/sync-from-template.sh --from ../path   pull from a local checkout
#   ./scripts/sync-from-template.sh --check          report drift, write nothing

set -euo pipefail
cd "$(dirname "$0")/.."

UPSTREAM_REPO="danielrosehill/Long-Form-Content-Workspace-Template"
DEFAULT_LOCAL="$HOME/repos/github/ai-agents-and-prompts/Long-Form-Content-Workspace-Template"
VENDOR_DIR="template"

# Paths that exist in the template but must not be vendored: git metadata, build
# output, and anything a real project accumulates.
EXCLUDES=(--exclude=.git --exclude=dist --exclude=__pycache__ --exclude='*.pyc')

src=""
check_only=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --from)  src="$2"; shift 2 ;;
    --check) check_only=1; shift ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

tmp=""
# Must return 0: as the EXIT trap's last command its status becomes the
# script's exit status, so a bare [[ -n "$tmp" ]] test fails a clean run.
cleanup() { [[ -n "$tmp" ]] && rm -rf "$tmp"; return 0; }
trap cleanup EXIT

if [[ -z "$src" ]]; then
  if [[ -d "$DEFAULT_LOCAL" ]]; then
    src="$DEFAULT_LOCAL"
  else
    tmp="$(mktemp -d)"
    git clone --depth 1 "https://github.com/${UPSTREAM_REPO}.git" "$tmp/template" >/dev/null 2>&1
    src="$tmp/template"
  fi
fi

[[ -d "$src" ]] || { echo "source not found: $src" >&2; exit 1; }
[[ -f "$src/longform.toml" ]] || { echo "not a long-form workspace template: $src" >&2; exit 1; }

if [[ "$check_only" == 1 ]]; then
  if diff -r "${EXCLUDES[@]}" "$src" "$VENDOR_DIR" >/dev/null 2>&1; then
    echo "vendored template matches ${src}"
    exit 0
  fi
  echo "DRIFT — vendored template differs from ${src}:"
  diff -rq "${EXCLUDES[@]}" "$src" "$VENDOR_DIR" || true
  exit 1
fi

rm -rf "$VENDOR_DIR"
mkdir -p "$VENDOR_DIR"
rsync -a "${EXCLUDES[@]}" "$src"/ "$VENDOR_DIR"/

echo "vendored ${src} -> ${VENDOR_DIR}"
echo "review with: git diff --stat ${VENDOR_DIR}"
