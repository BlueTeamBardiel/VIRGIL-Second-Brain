#!/bin/bash
# setup.sh — VIRGIL first-time setup wizard
#
# Checks prerequisites, prompts for configuration, creates vault structure,
# installs crontab entries, and adds shell aliases.
#
# Usage: bash scripts/setup.sh
# Works on: Ubuntu/Debian, macOS (with Homebrew)

set -euo pipefail

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
YEL='\033[1;33m'
GRN='\033[0;32m'
BLU='\033[0;34m'
CYN='\033[0;36m'
BOLD='\033[1m'
RST='\033[0m'

ok()   { echo -e "${GRN}  ✓${RST}  $*"; }
warn() { echo -e "${YEL}  ⚠${RST}  $*"; }
err()  { echo -e "${RED}  ✗${RST}  $*"; }
info() { echo -e "${BLU}  →${RST}  $*"; }
hdr()  { echo -e "\n${BOLD}${CYN}$*${RST}"; }

# Script's own directory (repo root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ── Banner ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${CYN}╔══════════════════════════════════════════════════╗${RST}"
echo -e "${BOLD}${CYN}║          V I R G I L  —  Setup Wizard           ║${RST}"
echo -e "${BOLD}${CYN}╚══════════════════════════════════════════════════╝${RST}"
echo ""
echo "  This wizard will:"
echo "    • Check your system for required tools"
echo "    • Configure your API key and vault location"
echo "    • Create the Obsidian vault directory structure"
echo "    • Install crontab automation (with your approval)"
echo "    • Add virgil-* shell aliases"
echo "    • Run a connectivity test"
echo ""
read -rp "  Press Enter to begin, or Ctrl+C to cancel..."

# ── 1. Detect OS ──────────────────────────────────────────────────────────────
hdr "Step 1 — Checking your system"

OS="linux"
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
    ok "macOS detected"
else
    ok "Linux detected"
fi

MISSING_HARD=()
MISSING_SOFT=()

check_cmd() {
    local cmd="$1" label="${2:-$1}" required="${3:-hard}"
    if command -v "$cmd" &>/dev/null; then
        ok "$label found: $(command -v "$cmd")"
    else
        if [[ "$required" == "hard" ]]; then
            err "$label not found — required"
            MISSING_HARD+=("$label")
        else
            warn "$label not found — optional (some features may not work)"
            MISSING_SOFT+=("$label")
        fi
    fi
}

check_cmd python3 "Python 3"
check_cmd curl    "curl"
check_cmd git     "git"
check_cmd pandoc  "pandoc (for URL ingest)" soft
check_cmd pdftotext "pdftotext / poppler-utils (for PDF ingest)" soft
check_cmd obsidian  "Obsidian" soft

# Python version check
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    if python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)'; then
        ok "Python $PY_VER (≥3.9 required)"
    else
        err "Python $PY_VER is too old — need 3.9+"
        MISSING_HARD+=("Python ≥3.9")
    fi
fi

# Python packages
for pkg in feedparser requests; do
    if python3 -c "import $pkg" 2>/dev/null; then
        ok "Python package: $pkg"
    else
        warn "Python package '$pkg' not installed — run: pip3 install feedparser requests"
        MISSING_SOFT+=("pip3: $pkg")
    fi
done

if [[ ${#MISSING_HARD[@]} -gt 0 ]]; then
    echo ""
    err "Missing required tools: ${MISSING_HARD[*]}"
    echo ""
    if [[ "$OS" == "macos" ]]; then
        info "Install with Homebrew: brew install python curl git"
    else
        info "Install with apt: sudo apt install python3 python3-pip curl git pandoc poppler-utils"
    fi
    echo ""
    read -rp "  Continue anyway? (y/N): " CONTINUE_ANYWAY
    [[ "${CONTINUE_ANYWAY,,}" == "y" ]] || { echo "Aborting."; exit 1; }
fi

if [[ ${#MISSING_SOFT[@]} -gt 0 ]]; then
    echo ""
    warn "Optional tools missing — you can install them later:"
    for m in "${MISSING_SOFT[@]}"; do echo "    • $m"; done
    echo ""
fi

# ── 2. ANTHROPIC_API_KEY ──────────────────────────────────────────────────────
hdr "Step 2 — Anthropic API Key"

echo "  VIRGIL uses Claude Haiku (Anthropic's smallest model) for:"
echo "    • Synthesizing daily RSS feed digests"
echo "    • Generating weekly summaries"
echo "    • Triaging inbox notes"
echo "    • Converting PDFs to structured notes"
echo ""
echo "  Cost: roughly \$1–5/month at typical usage."
echo "  Get your key at: https://console.anthropic.com"
echo ""

EXISTING_KEY="${ANTHROPIC_API_KEY:-}"

if [[ -n "$EXISTING_KEY" ]]; then
    ok "ANTHROPIC_API_KEY already set in environment (${#EXISTING_KEY} chars)"
    read -rp "  Use this key? (Y/n): " USE_EXISTING
    if [[ "${USE_EXISTING,,}" != "n" ]]; then
        API_KEY="$EXISTING_KEY"
    else
        EXISTING_KEY=""
    fi
fi

if [[ -z "$EXISTING_KEY" ]]; then
    while true; do
        read -rsp "  Enter your Anthropic API key (starts with sk-ant-): " API_KEY
        echo ""
        if [[ -z "$API_KEY" ]]; then
            warn "No key entered — skipping (RSS/CVE ingest and AI features will not work)"
            API_KEY=""
            break
        elif [[ "${#API_KEY}" -lt 40 ]]; then
            err "Key looks too short. Anthropic keys are typically 100+ characters."
        else
            ok "Key accepted (${#API_KEY} chars)"
            break
        fi
    done
fi

# ── 3. SLACK_WEBHOOK_URL ──────────────────────────────────────────────────────
hdr "Step 3 — Slack Webhook (optional)"

echo "  VIRGIL can post notifications to Slack when:"
echo "    • Your daily RSS digest is ready"
echo "    • Your weekly summary is written"
echo "    • A PDF or URL is ingested"
echo ""
echo "  To create a webhook:"
echo "    1. Go to https://api.slack.com/apps"
echo "    2. Create an app → Incoming Webhooks → Add New Webhook"
echo "    3. Copy the webhook URL (starts with https://hooks.slack.com/services/)"
echo ""
echo "  Leave blank to skip — all scripts fail silently without it."
echo ""

read -rsp "  Slack webhook URL (or Enter to skip): " SLACK_URL
echo ""
if [[ -n "$SLACK_URL" ]]; then
    ok "Slack webhook configured"
else
    info "Slack notifications disabled"
fi

# ── 4. VIRGIL_DIR ─────────────────────────────────────────────────────────────
hdr "Step 4 — Vault Location"

DEFAULT_VAULT="$HOME/Documents/VIRGIL"
echo "  Where should your VIRGIL vault live?"
echo "  This is where all your notes, daily logs, and memory files will be stored."
echo "  It will be opened as an Obsidian vault."
echo ""
read -rp "  Vault path [${DEFAULT_VAULT}]: " VAULT_INPUT
VIRGIL_DIR="${VAULT_INPUT:-$DEFAULT_VAULT}"

# Expand ~ if needed
VIRGIL_DIR="${VIRGIL_DIR/#\~/$HOME}"
ok "Vault directory: $VIRGIL_DIR"

# ── 5. Write .env ─────────────────────────────────────────────────────────────
hdr "Step 5 — Writing configuration"

ENV_FILE="$SCRIPT_DIR/.env"

{
    echo "# VIRGIL environment configuration"
    echo "# Generated by setup.sh on $(date '+%Y-%m-%d %H:%M')"
    echo ""
    [[ -n "$API_KEY" ]]   && echo "ANTHROPIC_API_KEY=\"$API_KEY\""    || echo "# ANTHROPIC_API_KEY=\"your-key-here\""
    [[ -n "$SLACK_URL" ]] && echo "SLACK_WEBHOOK_URL=\"$SLACK_URL\""   || echo "# SLACK_WEBHOOK_URL=\"\""
    echo "VIRGIL_DIR=\"$VIRGIL_DIR\""
} > "$ENV_FILE"

chmod 600 "$ENV_FILE"
ok ".env written to $ENV_FILE"

# ── 6. Create vault structure ─────────────────────────────────────────────────
hdr "Step 6 — Creating vault directory structure"

DIRS=(
    "$VIRGIL_DIR/notes/inbox"
    "$VIRGIL_DIR/notes/archive"
    "$VIRGIL_DIR/notes/mitre"
    "$VIRGIL_DIR/notes/cve"
    "$VIRGIL_DIR/notes/feeds"
    "$VIRGIL_DIR/notes/knowledge/security"
    "$VIRGIL_DIR/notes/knowledge/networking"
    "$VIRGIL_DIR/notes/knowledge/nist"
    "$VIRGIL_DIR/notes/personal/workouts"
    "$VIRGIL_DIR/notes/personal/study"
    "$VIRGIL_DIR/notes/personal/nutrition"
    "$VIRGIL_DIR/daily-logs"
    "$VIRGIL_DIR/weekly-summaries"
    "$VIRGIL_DIR/ingest"
)

for d in "${DIRS[@]}"; do
    mkdir -p "$d"
done
ok "Created $(echo "${DIRS[@]}" | tr ' ' '\n' | wc -l | tr -d ' ') vault directories under $VIRGIL_DIR"

# Copy README stubs into vault
if [[ -d "$SCRIPT_DIR/starter-notes" ]]; then
    cp -rn "$SCRIPT_DIR/starter-notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
    ok "Copied starter notes into vault"
fi

if [[ -f "$SCRIPT_DIR/GETTING-STARTED.md" ]]; then
    cp "$SCRIPT_DIR/GETTING-STARTED.md" "$VIRGIL_DIR/"
    ok "Copied GETTING-STARTED.md to vault root"
fi

# Starter memory files
for mf in memory-working.md memory-episodic.md memory-semantic.md; do
    if [[ ! -f "$VIRGIL_DIR/$mf" ]]; then
        cat > "$VIRGIL_DIR/$mf" << MEMEOF
# $mf

_Created by setup.sh on $(date '+%Y-%m-%d')_

---

MEMEOF
        ok "Created starter $mf"
    fi
done

# ── 7. Make scripts executable ─────────────────────────────────────────────────
hdr "Step 7 — Making scripts executable"

chmod +x "$SCRIPT_DIR/hooks/"*.sh 2>/dev/null || true
chmod +x "$SCRIPT_DIR/ingest/"*.sh 2>/dev/null || true
chmod +x "$SCRIPT_DIR/ingest/"*.py 2>/dev/null || true
chmod +x "$SCRIPT_DIR/scripts/"*.sh 2>/dev/null || true
ok "Scripts are executable"

# ── 8. Shell aliases ─────────────────────────────────────────────────────────
hdr "Step 8 — Shell aliases"

SHELL_RC="$HOME/.bashrc"
[[ "$OS" == "macos" && -f "$HOME/.zshrc" ]] && SHELL_RC="$HOME/.zshrc"

echo "  Adding virgil-* aliases to $SHELL_RC"

ALIAS_BLOCK="
# ── VIRGIL aliases ──────────────────────────────────────────────────────────
export VIRGIL_DIR=\"$VIRGIL_DIR\"
alias virgil-pdf='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/pdf-ingest.sh'
alias virgil-nist='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/nist-ingest.sh'
alias virgil-url='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/url-ingest.sh'
alias virgil-rss='VIRGIL_DIR=\"$VIRGIL_DIR\" python3 $SCRIPT_DIR/ingest/rss-ingest.py'
alias virgil-cve='VIRGIL_DIR=\"$VIRGIL_DIR\" python3 $SCRIPT_DIR/ingest/cve-ingest.py'
alias virgil-triage='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/triage-inbox.sh'
alias virgil-wikilink='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/wikilink-ingest.sh'
alias virgil-orphans='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/orphan-detect.sh'
alias virgil-workout='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/personal-ingest.sh workout'
alias virgil-study='VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/personal-ingest.sh study'
# ── end VIRGIL ───────────────────────────────────────────────────────────────"

# Only add if not already present
if grep -q 'VIRGIL aliases' "$SHELL_RC" 2>/dev/null; then
    warn "VIRGIL aliases already in $SHELL_RC — skipping"
else
    echo "$ALIAS_BLOCK" >> "$SHELL_RC"
    ok "Aliases added to $SHELL_RC"
fi

# ── 9. Crontab ────────────────────────────────────────────────────────────────
hdr "Step 9 — Crontab automation"

echo "  VIRGIL can run automatically on a schedule:"
echo ""
echo "    6am daily   — RSS threat intel digest (22 feeds → Claude synthesis)"
echo "    7am daily   — CVE ingest from NVD"
echo "    Mon 8am     — Inbox triage (route notes to correct category)"
echo "    11:30pm     — Wikilink injection (auto-link modified notes)"
echo "    11:55pm     — Auto-fill session summaries"
echo "    1am Mon–Sat — Daily log promotion (update task lists)"
echo "    1am Sunday  — Weekly digest synthesis"
echo ""
read -rp "  Add crontab entries now? (y/N): " CRON_CONFIRM

if [[ "${CRON_CONFIRM,,}" == "y" ]]; then
    EXISTING_CRON=$(crontab -l 2>/dev/null | \
        grep -v 'virgil\|VIRGIL\|ANTHROPIC_API_KEY\|SLACK_WEBHOOK_URL\|rss-ingest\|cve-ingest\|triage-inbox\|wikilink-ingest\|auto-reflect\|promote\.sh\|weekly-rollup' \
        || true)

    {
        echo "$EXISTING_CRON"
        echo ""
        echo "# ── VIRGIL ─────────────────────────────────────────────────────────────────"
        [[ -n "$API_KEY" ]]   && echo "ANTHROPIC_API_KEY=\"$API_KEY\""
        [[ -n "$SLACK_URL" ]] && echo "SLACK_WEBHOOK_URL=\"$SLACK_URL\""
        echo "0  6 * * *   VIRGIL_DIR=\"$VIRGIL_DIR\" python3 $SCRIPT_DIR/ingest/rss-ingest.py >> $SCRIPT_DIR/ingest/rss-ingest.log 2>&1"
        echo "0  7 * * *   VIRGIL_DIR=\"$VIRGIL_DIR\" python3 $SCRIPT_DIR/ingest/cve-ingest.py --recent >> $SCRIPT_DIR/ingest/cve-ingest.log 2>&1"
        echo "0  8 * * 1   VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/triage-inbox.sh"
        echo "30 23 * * *  VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/ingest/wikilink-ingest.sh"
        echo "55 23 * * *  VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/hooks/auto-reflect.sh"
        echo "0  1 * * 1-6 VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/hooks/promote.sh"
        echo "0  1 * * 0   VIRGIL_DIR=\"$VIRGIL_DIR\" bash $SCRIPT_DIR/hooks/weekly-rollup.sh"
        echo "# ── end VIRGIL ──────────────────────────────────────────────────────────────"
    } | crontab -
    ok "Crontab updated"
else
    info "Skipped — add crontab entries manually using the schedule in README.md"
fi

# ── 10. Connectivity test ─────────────────────────────────────────────────────
hdr "Step 10 — API connectivity test"

if [[ -z "$API_KEY" ]]; then
    warn "No API key configured — skipping connectivity test"
else
    info "Testing Anthropic API..."
    HTTP_CODE=$(curl -s -o /tmp/virgil-test-response.json -w "%{http_code}" \
        https://api.anthropic.com/v1/messages \
        -H "x-api-key: $API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        -H "content-type: application/json" \
        -d '{"model":"claude-haiku-4-5-20251001","max_tokens":16,"messages":[{"role":"user","content":"ping"}]}' \
        2>/dev/null || echo "000")

    if [[ "$HTTP_CODE" == "200" ]]; then
        ok "Anthropic API: connected (HTTP 200)"
    elif [[ "$HTTP_CODE" == "401" ]]; then
        err "Anthropic API: authentication failed (HTTP 401) — check your API key"
    elif [[ "$HTTP_CODE" == "000" ]]; then
        err "Anthropic API: connection failed — check your internet connection"
    else
        warn "Anthropic API: unexpected response (HTTP $HTTP_CODE)"
        cat /tmp/virgil-test-response.json 2>/dev/null | python3 -c "import json,sys; d=json.load(sys.stdin); print('  ', d.get('error',{}).get('message',''))" 2>/dev/null || true
    fi
    rm -f /tmp/virgil-test-response.json
fi

# ── 11. Done ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GRN}╔══════════════════════════════════════════════════╗${RST}"
echo -e "${BOLD}${GRN}║               You're ready.                     ║${RST}"
echo -e "${BOLD}${GRN}╚══════════════════════════════════════════════════╝${RST}"
echo ""
echo -e "  ${BOLD}Vault:${RST} $VIRGIL_DIR"
echo -e "  ${BOLD}Scripts:${RST} $SCRIPT_DIR"
echo ""
echo -e "  ${BOLD}First steps:${RST}"
echo ""
echo "    1. Open Obsidian → 'Open folder as vault' → select:"
echo "       $VIRGIL_DIR"
echo ""
echo "    2. Source your new aliases:"
echo "       source $SHELL_RC"
echo ""
echo "    3. Test the pipeline:"
echo "       virgil-url https://attack.mitre.org/techniques/T1059/"
echo "       virgil-rss"
echo "       virgil-cve --recent"
echo ""
echo "    4. Read GETTING-STARTED.md in your vault for the full workflow."
echo ""
echo "  Questions? → https://github.com/your-username/VIRGIL"
echo ""
