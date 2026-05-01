#!/bin/bash
# check-deps.sh — Verify VIRGIL dependencies before install or troubleshooting
# Usage: bash scripts/check-deps.sh
# Exit code: 0 = all required deps present, 1 = missing required deps

set -euo pipefail

GRN='\033[0;32m'; YEL='\033[1;33m'; RED='\033[0;31m'; RST='\033[0m'
ok()   { printf "${GRN}  ✓${RST}  %-28s %s\n" "$1" "${2:-}"; }
warn() { printf "${YEL}  ⚠${RST}  %-28s %s\n" "$1" "${2:-}"; }
fail() { printf "${RED}  ✗${RST}  %-28s %s\n" "$1" "${2:-}"; }

MISSING_REQUIRED=0
MISSING_OPTIONAL=0

check() {
    local cmd="$1" label="${2:-$1}" required="${3:-required}" note="${4:-}"
    if command -v "$cmd" &>/dev/null; then
        local ver
        ver=$(${5:-"$cmd --version"} 2>&1 | head -1 | grep -oE '[0-9]+\.[0-9]+[^ ]*' | head -1 || echo "")
        ok "$label" "$ver $note"
    elif [[ "$required" == "required" ]]; then
        fail "$label" "NOT FOUND — required"
        MISSING_REQUIRED=$((MISSING_REQUIRED + 1))
    else
        warn "$label" "not found — optional"
        MISSING_OPTIONAL=$((MISSING_OPTIONAL + 1))
    fi
}

check_py_pkg() {
    local pkg="$1" label="${2:-$1}" required="${3:-required}"
    if python3 -c "import $pkg" 2>/dev/null; then
        local ver
        ver=$(python3 -c "import $pkg; print(getattr($pkg,'__version__','?'))" 2>/dev/null || echo "?")
        ok "python: $label" "$ver"
    elif [[ "$required" == "required" ]]; then
        fail "python: $label" "NOT FOUND — run: pip3 install $pkg"
        MISSING_REQUIRED=$((MISSING_REQUIRED + 1))
    else
        warn "python: $label" "not found — optional (pip3 install $pkg)"
        MISSING_OPTIONAL=$((MISSING_OPTIONAL + 1))
    fi
}

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  VIRGIL Dependency Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "── Required ─────────────────────────────────────"
check bash       "bash"          required "" "bash --version"
check python3    "python3 ≥3.9"  required "" "python3 --version"
check curl       "curl"          required "" "curl --version"
check git        "git"           required "" "git --version"
check_py_pkg feedparser "feedparser" required
check_py_pkg requests   "requests"   required

echo ""
echo "── Claude Code ─────────────────────────────────"
check claude     "claude (Claude Code)" required "" "claude --version"
check node       "node ≥18"           optional "" "node --version"

echo ""
echo "── Optional: ingest ─────────────────────────────"
check pandoc     "pandoc (URL ingest)"   optional
check pdftotext  "pdftotext (PDF ingest)" optional "" "pdftotext -v"
check sha256sum  "sha256sum (checksums)"  optional "" "sha256sum --version"
check crontab    "crontab (scheduling)"  optional "" "crontab --version"

echo ""
echo "── Optional: local inference ────────────────────"
check ollama     "ollama"                 optional "" "ollama --version"
if command -v ollama &>/dev/null; then
    if ollama list 2>/dev/null | grep -q "llama3\|qwen\|nomic"; then
        ok "ollama models" "$(ollama list 2>/dev/null | grep -E 'llama3|qwen|nomic' | awk '{print $1}' | tr '\n' ' ')"
    else
        warn "ollama models" "no models pulled — run: ollama pull llama3.2"
    fi
fi

echo ""
echo "── Optional: RAG / vector search ───────────────"
check_py_pkg chromadb "chromadb" optional

echo ""
echo "── Environment ──────────────────────────────────"
[[ -n "${ANTHROPIC_API_KEY:-}" ]] && ok "ANTHROPIC_API_KEY" "set (${#ANTHROPIC_API_KEY} chars)" || warn "ANTHROPIC_API_KEY" "not set — local Ollama required"
[[ -n "${VIRGIL_DIR:-}" ]] && ok "VIRGIL_DIR" "$VIRGIL_DIR" || warn "VIRGIL_DIR" "not set — will use \$HOME/VIRGIL"
[[ -n "${SLACK_WEBHOOK_URL:-}" ]] && ok "SLACK_WEBHOOK_URL" "set" || warn "SLACK_WEBHOOK_URL" "not set — Slack notifications disabled"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [[ "$MISSING_REQUIRED" -gt 0 ]]; then
    printf "${RED}  %d required dep(s) missing — install before running VIRGIL${RST}\n" "$MISSING_REQUIRED"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    exit 1
else
    printf "${GRN}  All required deps present${RST}"
    [[ "$MISSING_OPTIONAL" -gt 0 ]] && printf " — %d optional missing (see above)" "$MISSING_OPTIONAL"
    printf "\n"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    exit 0
fi
