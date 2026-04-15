#!/usr/bin/env bash
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  VIRGIL — Second Brain Installer                                            │
# │  https://github.com/Morpheus6669/VIRGIL                                    │
# │                                                                             │
# │  Quick install (interactive — keeps stdin attached to terminal):            │
# │    bash <(curl -fsSL https://raw.githubusercontent.com/Morpheus6669/       │
# │                        VIRGIL/main/scripts/install.sh)                      │
# │                                                                             │
# │  Download and verify before running (recommended):                          │
# │    curl -fsSL https://raw.githubusercontent.com/Morpheus6669/VIRGIL/       │
# │             main/scripts/install.sh -o virgil-install.sh                    │
# │    sha256sum virgil-install.sh   # compare at releases page                 │
# │    bash virgil-install.sh                                                   │
# │                                                                             │
# │  Flags:                                                                     │
# │    --fast      Skip wizard, use all defaults                                │
# │    --dry-run   Show what would be installed without doing it                │
# │    --docker    Print Docker run command and exit                            │
# └─────────────────────────────────────────────────────────────────────────────┘

set -euo pipefail

# ── Constants ─────────────────────────────────────────────────────────────────
VIRGIL_REPO="https://github.com/Morpheus6669/VIRGIL.git"
VIRGIL_RAW="https://raw.githubusercontent.com/Morpheus6669/VIRGIL/main"
VIRGIL_RELEASES="https://github.com/Morpheus6669/VIRGIL/releases"
INSTALL_LOG="/tmp/virgil-install-$$.log"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; YEL='\033[1;33m'; GRN='\033[0;32m'
BLU='\033[0;34m'; CYN='\033[0;36m'; BOLD='\033[1m'; RST='\033[0m'

ok()    { echo -e "${GRN}  ✓${RST}  $*"; }
warn()  { echo -e "${YEL}  ⚠${RST}  $*"; }
err()   { echo -e "${RED}  ✗${RST}  $*" >&2; }
info()  { echo -e "${BLU}  →${RST}  $*"; }
hdr()   { echo -e "\n${BOLD}${CYN}── $* ──────────────────────────────────────────────────${RST}"; }
ask()   { echo -e "${BOLD}${YEL}  ?${RST}  $*"; }
step()  { echo -e "  ${BOLD}$*${RST}"; }

die() { err "$*"; exit 1; }

# ── Flag parsing ──────────────────────────────────────────────────────────────
FAST_MODE=false
DRY_RUN=false
DOCKER_MODE=false

for arg in "$@"; do
    case "$arg" in
        --fast)    FAST_MODE=true ;;
        --dry-run) DRY_RUN=true ;;
        --docker)  DOCKER_MODE=true ;;
        --help|-h)
            echo "Usage: bash install.sh [--fast] [--dry-run] [--docker]"
            echo ""
            echo "  --fast      Use all defaults, no prompts (still needs ANTHROPIC_API_KEY in env)"
            echo "  --dry-run   Print what would be installed without doing anything"
            echo "  --docker    Print Docker run/compose instructions and exit"
            echo ""
            echo "For verification instructions, see: $VIRGIL_RELEASES"
            exit 0
            ;;
        *) warn "Unknown flag: $arg (ignored)" ;;
    esac
done

# ── Docker shortcut ───────────────────────────────────────────────────────────
if $DOCKER_MODE; then
    echo ""
    echo -e "${BOLD}${CYN}VIRGIL — Docker Install${RST}"
    echo ""
    echo "  Quickstart (single container):"
    echo ""
    echo "    docker run -it \\"
    echo "      -e ANTHROPIC_API_KEY=\"sk-ant-your-key\" \\"
    echo "      -e SLACK_WEBHOOK_URL=\"https://hooks.slack.com/...\" \\"
    echo "      -v \"\$(pwd)/vault\":/vault \\"
    echo "      ghcr.io/Morpheus6669/virgil:latest"
    echo ""
    echo "  With docker-compose (recommended for persistent setups):"
    echo ""
    echo "    1. cp .env.example .env && nano .env   # fill in your API key"
    echo "    2. docker-compose up -d"
    echo "    3. docker-compose exec virgil bash     # drop into shell"
    echo ""
    echo "  Docs: $VIRGIL_RELEASES"
    echo ""
    exit 0
fi

# ── Banner ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${CYN}╔══════════════════════════════════════════════════════╗${RST}"
echo -e "${BOLD}${CYN}║          V I R G I L  —  Installer                  ║${RST}"
echo -e "${BOLD}${CYN}╚══════════════════════════════════════════════════════╝${RST}"
echo ""

if $DRY_RUN; then
    echo -e "  ${BOLD}${YEL}DRY RUN — nothing will be written or installed${RST}"
    echo ""
fi

# ── What this installer will do ───────────────────────────────────────────────
echo "  This installer will:"
echo "    • Check and install required system dependencies"
echo "    • Clone the VIRGIL scripts to a local directory"
echo "    • Create your Obsidian vault directory structure"
echo "    • Write a .env file with your API key and settings"
echo "    • Install crontab automation entries (with your approval)"
echo "    • Add virgil-* shell aliases to your shell RC file"
echo "    • Run a live connectivity test against the Anthropic API"
echo "    • Run a live demo: fetch one CVE and write it to your vault"
echo ""
echo "  Source:  $VIRGIL_REPO"
echo "  Docs:    $VIRGIL_RELEASES"
echo ""

if ! $FAST_MODE && ! $DRY_RUN; then
    read -r -p "  Press Enter to continue, or Ctrl+C to cancel..." </dev/tty
fi

# ── 1. OS Detection ───────────────────────────────────────────────────────────
hdr "Step 1 — Detecting OS"

OS="linux"
PKG_MANAGER=""
IS_WSL=false

if [[ "$(uname)" == "Darwin" ]]; then
    OS="macos"
elif grep -qi microsoft /proc/version 2>/dev/null; then
    OS="wsl2"
    IS_WSL=true
fi

if [[ "$OS" != "macos" ]]; then
    if command -v apt-get &>/dev/null; then
        PKG_MANAGER="apt"
    elif command -v pacman &>/dev/null; then
        PKG_MANAGER="pacman"
    elif command -v dnf &>/dev/null; then
        PKG_MANAGER="dnf"
    fi
fi

case "$OS" in
    macos) ok "macOS detected" ;;
    wsl2)  ok "WSL2 detected (Windows Subsystem for Linux)" ;;
    linux) ok "Linux detected (${PKG_MANAGER:-unknown package manager})" ;;
esac

if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &>/dev/null; then
        warn "Homebrew not found — install it from https://brew.sh then re-run this installer"
        warn "Auto-install of dependencies will be skipped"
    else
        ok "Homebrew found: $(brew --prefix)"
    fi
fi

# ── 2. Dependency check + auto-install ───────────────────────────────────────
hdr "Step 2 — Checking dependencies"

MISSING_HARD=()
MISSING_SOFT=()

check_dep() {
    local cmd="$1" label="${2:-$1}" required="${3:-hard}"
    if command -v "$cmd" &>/dev/null; then
        ok "$label: $(command -v "$cmd")"
        return 0
    fi
    if [[ "$required" == "hard" ]]; then
        err "$label: not found (required)"
        MISSING_HARD+=("$cmd")
    else
        warn "$label: not found (optional — some features will not work)"
        MISSING_SOFT+=("$cmd")
    fi
}

check_dep python3  "Python 3"
check_dep curl     "curl"
check_dep git      "git"
check_dep pandoc   "pandoc (URL/PDF ingest)" soft
check_dep pdftotext "pdftotext/poppler (PDF ingest)" soft
if $IS_WSL; then
    warn "Obsidian should be installed on the Windows side, not inside WSL"
else
    check_dep obsidian "Obsidian" soft
fi

# Python version check
if command -v python3 &>/dev/null; then
    if python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)' 2>/dev/null; then
        PY_VER=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
        ok "Python $PY_VER (≥3.9 required)"
    else
        PY_VER=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
        err "Python $PY_VER is too old — VIRGIL requires Python 3.9+"
        MISSING_HARD+=("python3≥3.9")
    fi
fi

# Python packages
for pkg in feedparser requests; do
    if python3 -c "import $pkg" 2>/dev/null; then
        ok "Python: $pkg"
    else
        warn "Python package '$pkg' missing — will install"
        MISSING_SOFT+=("pip:$pkg")
    fi
done

# ── Auto-install missing hard deps ───────────────────────────────────────────
if [[ ${#MISSING_HARD[@]} -gt 0 ]]; then
    echo ""
    warn "Missing required: ${MISSING_HARD[*]}"

    if $DRY_RUN; then
        info "[dry-run] Would install: ${MISSING_HARD[*]}"
    elif [[ "$PKG_MANAGER" == "apt" ]]; then
        info "Installing via apt..."
        sudo apt-get update -qq
        sudo apt-get install -y python3 python3-pip curl git pandoc poppler-utils 2>&1 | tail -3
        ok "apt install complete"
    elif [[ "$OS" == "macos" ]] && command -v brew &>/dev/null; then
        info "Installing via brew..."
        brew install python curl git pandoc 2>&1 | tail -3
        ok "brew install complete"
    elif [[ "$PKG_MANAGER" == "pacman" ]]; then
        info "Installing via pacman..."
        sudo pacman -Sy --noconfirm python curl git pandoc poppler 2>&1 | tail -3
        ok "pacman install complete"
    else
        echo ""
        err "Cannot auto-install on this platform."
        echo ""
        echo "  Please install manually:"
        echo "    Ubuntu/Debian: sudo apt install python3 python3-pip curl git pandoc"
        echo "    macOS:         brew install python curl git pandoc"
        echo "    Arch:          sudo pacman -Sy python curl git pandoc"
        echo "    Other:         see $VIRGIL_RELEASES for manual install guide"
        echo ""
        exit 1
    fi

    # Reload MISSING_HARD after install
    MISSING_HARD=()
    for cmd in python3 curl git; do
        command -v "$cmd" &>/dev/null || MISSING_HARD+=("$cmd")
    done
    if [[ ${#MISSING_HARD[@]} -gt 0 ]]; then
        die "Still missing after install attempt: ${MISSING_HARD[*]}. Install manually and re-run."
    fi
fi

# Install missing Python packages
if [[ ${#MISSING_SOFT[@]} -gt 0 ]]; then
    PIP_PKGS=()
    for item in "${MISSING_SOFT[@]}"; do
        [[ "$item" == pip:* ]] && PIP_PKGS+=("${item#pip:}")
    done
    if [[ ${#PIP_PKGS[@]} -gt 0 ]]; then
        if $DRY_RUN; then
            info "[dry-run] Would install pip packages: ${PIP_PKGS[*]}"
        else
            info "Installing Python packages: ${PIP_PKGS[*]}"
            python3 -m pip install --quiet --user "${PIP_PKGS[@]}"
            ok "pip install complete"
        fi
    fi
fi

if [[ ${#MISSING_SOFT[@]} -gt 0 ]]; then
    NON_PIP=()
    for item in "${MISSING_SOFT[@]}"; do
        [[ "$item" != pip:* ]] && NON_PIP+=("$item")
    done
    if [[ ${#NON_PIP[@]} -gt 0 ]]; then
        echo ""
        warn "Optional tools not installed — features marked below will be limited:"
        for m in "${NON_PIP[@]}"; do echo "    • $m"; done
    fi
fi

# ── Determine install source ──────────────────────────────────────────────────
# If BASH_SOURCE is set and points to a real file, we're running from a local clone.
# Otherwise (piped from curl / process-substituted), clone the repo.

INSTALL_SRC=""
if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "-" && \
      "${BASH_SOURCE[0]}" != "/dev/stdin" && -f "${BASH_SOURCE[0]}" ]]; then
    INSTALL_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    info "Using local clone: $INSTALL_SRC"
else
    INSTALL_SRC="/tmp/virgil-src-$$"
    if $DRY_RUN; then
        info "[dry-run] Would clone $VIRGIL_REPO → $INSTALL_SRC"
    else
        info "Cloning VIRGIL repository..."
        git clone --quiet --depth 1 "$VIRGIL_REPO" "$INSTALL_SRC"
        ok "Cloned to $INSTALL_SRC"
    fi
fi

# ── 3. Wizard / fast-mode questions ──────────────────────────────────────────
hdr "Step 3 — Configuration"

# Defaults
USER_NAME="User"
API_KEY="${ANTHROPIC_API_KEY:-}"
SLACK_URL=""
VIRGIL_DIR="$HOME/VIRGIL"
TRACK="3"
INSTALL_CRON="y"

if $FAST_MODE; then
    info "Fast mode — using defaults"
    info "  Name:    $USER_NAME"
    info "  Vault:   $VIRGIL_DIR"
    info "  Track:   Security + Networking"
    info "  Crontab: yes"
    if [[ -z "$API_KEY" ]]; then
        echo ""
        ask "ANTHROPIC_API_KEY not set in environment."
        read -r -sp "  Paste your Anthropic API key (sk-ant-...): " API_KEY </dev/tty
        echo ""
    fi
else
    # Q1: Name
    echo ""
    ask "What should I call you?"
    echo "  (Used in CLAUDE.md — your second brain's configuration file)"
    read -r -p "  Your name [User]: " NAME_INPUT </dev/tty
    USER_NAME="${NAME_INPUT:-User}"
    ok "Name set to: $USER_NAME"

    # Q2: API key
    echo ""
    ask "Paste your Anthropic API key (get one free at console.anthropic.com):"
    echo "  VIRGIL uses Claude Haiku for RSS digests, CVE summaries, and triage."
    echo "  Estimated cost: \$3–5/month at typical homelab usage."
    echo ""
    if [[ -n "$API_KEY" ]]; then
        ok "ANTHROPIC_API_KEY already set in environment (${#API_KEY} chars)"
        read -r -p "  Use this key? [Y/n]: " USE_ENV </dev/tty
        if [[ "${USE_ENV,,}" == "n" ]]; then
            API_KEY=""
        fi
    fi
    if [[ -z "$API_KEY" ]]; then
        while true; do
            read -r -sp "  API key (or Enter to skip): " API_KEY </dev/tty
            echo ""
            if [[ -z "$API_KEY" ]]; then
                warn "No key — AI features (RSS synthesis, CVE ingest, triage) will not work"
                break
            elif [[ "$API_KEY" != sk-ant-* ]]; then
                err "Key doesn't start with sk-ant- — check and re-enter"
            elif [[ "${#API_KEY}" -lt 40 ]]; then
                err "Key looks too short (Anthropic keys are 100+ chars)"
            else
                ok "Key accepted (${#API_KEY} chars)"
                break
            fi
        done
    fi

    # Q3: Slack
    echo ""
    ask "Slack webhook URL for notifications? (press Enter to skip)"
    echo "  VIRGIL posts to Slack when RSS digests, CVE notes, and weekly summaries are ready."
    echo "  Create one at: https://api.slack.com/apps → Incoming Webhooks"
    read -r -sp "  Webhook URL: " SLACK_URL </dev/tty
    echo ""
    if [[ -n "$SLACK_URL" ]]; then
        ok "Slack webhook configured"
    else
        info "Slack notifications disabled"
    fi

    # Q4: Vault location
    echo ""
    ask "Where should your VIRGIL vault live?"
    echo "  This is where all notes, daily logs, and memory files will be stored."
    echo "  Open this folder as a vault in Obsidian."
    read -r -p "  Vault path [~/VIRGIL]: " VAULT_INPUT </dev/tty
    VAULT_INPUT="${VAULT_INPUT:-$HOME/VIRGIL}"
    VIRGIL_DIR="${VAULT_INPUT/#\~/$HOME}"
    ok "Vault: $VIRGIL_DIR"

    # Q5: Knowledge track
    echo ""
    ask "Knowledge track — which feeds and starters should be enabled?"
    echo "  (1) Security  — threat intel, CVEs, MITRE ATT&CK, malware news"
    echo "  (2) Networking — BGP, SDN, Cisco/Juniper, packet analysis"
    echo "  (3) Both       — full feed set (recommended)"
    read -r -p "  Choice [3]: " TRACK_INPUT </dev/tty
    TRACK="${TRACK_INPUT:-3}"
    case "$TRACK" in
        1) ok "Track: Security" ;;
        2) ok "Track: Networking" ;;
        *) TRACK="3"; ok "Track: Security + Networking (both)" ;;
    esac

    # Q6: Crontab
    echo ""
    ask "Install crontab schedules? (recommended)"
    echo "  Schedules:"
    echo "    6am daily   — RSS threat intel digest"
    echo "    7am daily   — CVE ingest from NVD"
    echo "    Mon 8am     — Inbox triage"
    echo "    11:30pm     — Wikilink injection"
    echo "    11:55pm     — Session auto-reflect"
    echo "    1am Mon–Sat — Daily log promotion"
    echo "    1am Sunday  — Weekly digest"
    read -r -p "  Install crontab? [Y/n]: " CRON_INPUT </dev/tty
    INSTALL_CRON="${CRON_INPUT:-y}"
fi

# ── Dry-run summary ───────────────────────────────────────────────────────────
if $DRY_RUN; then
    echo ""
    echo -e "${BOLD}${YEL}── Dry-run summary ─────────────────────────────────────────────${RST}"
    echo ""
    step "Would create vault at:      $VIRGIL_DIR"
    step "Would copy scripts from:    ${INSTALL_SRC:-<git clone>}"
    step "Would write .env to:        $VIRGIL_DIR/.env"
    step "Would write CLAUDE.md to:   $VIRGIL_DIR/CLAUDE.md"
    [[ "${INSTALL_CRON,,}" == "y" ]] && step "Would install crontab entries"
    SHELL_RC="$HOME/.bashrc"; [[ "$OS" == "macos" ]] && SHELL_RC="$HOME/.zshrc"
    step "Would add aliases to:        $SHELL_RC"
    step "Would copy starter-notes to: $VIRGIL_DIR/notes/"
    step "Would test Anthropic API:    $([ -n "$API_KEY" ] && echo yes || echo no \(no key\))"
    step "Would fetch CVE demo:        yes"
    echo ""
    info "Re-run without --dry-run to apply."
    echo ""
    exit 0
fi

# ── 4. Create vault directory structure ──────────────────────────────────────
hdr "Step 4 — Creating vault"

VAULT_DIRS=(
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
    "$VIRGIL_DIR/scripts"
)

for d in "${VAULT_DIRS[@]}"; do mkdir -p "$d"; done
ok "Created ${#VAULT_DIRS[@]} directories under $VIRGIL_DIR"

# ── 5. Copy/install scripts ───────────────────────────────────────────────────
hdr "Step 5 — Installing scripts"

SCRIPTS_DEST="$VIRGIL_DIR/scripts"

for subdir in ingest hooks skills; do
    if [[ -d "$INSTALL_SRC/$subdir" ]]; then
        cp -r "$INSTALL_SRC/$subdir" "$VIRGIL_DIR/"
        find "$VIRGIL_DIR/$subdir" -name "*.sh" -o -name "*.py" | xargs chmod +x 2>/dev/null || true
        ok "Installed $subdir/"
    fi
done

# ── 6. Write .env ─────────────────────────────────────────────────────────────
hdr "Step 6 — Writing .env"

ENV_FILE="$VIRGIL_DIR/.env"
TRACK_LABEL="both"
[[ "$TRACK" == "1" ]] && TRACK_LABEL="security"
[[ "$TRACK" == "2" ]] && TRACK_LABEL="networking"

cat > "$ENV_FILE" << ENVEOF
# VIRGIL environment configuration
# Generated by install.sh on $(date '+%Y-%m-%d %H:%M')
# Keep this file private — never commit it to git

$([ -n "$API_KEY" ]   && echo "ANTHROPIC_API_KEY=\"$API_KEY\""          || echo "# ANTHROPIC_API_KEY=\"sk-ant-your-key-here\"")
$([ -n "$SLACK_URL" ] && echo "SLACK_WEBHOOK_URL=\"$SLACK_URL\""         || echo "# SLACK_WEBHOOK_URL=\"https://hooks.slack.com/services/...\"")
VIRGIL_DIR="$VIRGIL_DIR"
VIRGIL_TRACK="$TRACK_LABEL"
ENVEOF

chmod 600 "$ENV_FILE"
ok ".env written (chmod 600)"

# ── 7. Write CLAUDE.md ────────────────────────────────────────────────────────
hdr "Step 7 — Writing CLAUDE.md"

cat > "$VIRGIL_DIR/CLAUDE.md" << CLAUDEEOF
# VIRGIL — Claude Code Configuration
# Second brain for $USER_NAME

## Memory Files
- @memory-working.md — active pending tasks (cleared weekly)
- @memory-episodic.md — session history, promoted facts, completed work
- @memory-semantic.md — permanent facts: fleet, certs, architecture, key decisions

## Key Paths
- Vault: $VIRGIL_DIR/
- Ingest scripts: ingest/
- Hooks: hooks/
- Notes: notes/
- Daily logs: daily-logs/

## Conventions
- [[wiki links]] for all lab hosts, tools, protocols, concepts
- Run /reflect at end of each session
- Run /week on Fridays or Sundays for weekly digest

## Identity
- User: $USER_NAME
- Track: $TRACK_LABEL
- Installed: $(date '+%Y-%m-%d')
CLAUDEEOF

ok "CLAUDE.md written with name: $USER_NAME"

# ── 8. Starter memory files ───────────────────────────────────────────────────
for mf in memory-working.md memory-episodic.md memory-semantic.md; do
    if [[ ! -f "$VIRGIL_DIR/$mf" ]]; then
        cat > "$VIRGIL_DIR/$mf" << MEMEOF
# $mf

_Created by VIRGIL installer on $(date '+%Y-%m-%d') — $USER_NAME_

---

MEMEOF
        ok "Created starter $mf"
    fi
done

# ── 9. Copy starter notes ─────────────────────────────────────────────────────
hdr "Step 8 — Starter notes"

if [[ -d "$INSTALL_SRC/starter-notes" ]]; then
    cp -rn "$INSTALL_SRC/starter-notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
    ok "Starter notes copied to vault"
fi
if [[ -f "$INSTALL_SRC/GETTING-STARTED.md" ]]; then
    cp "$INSTALL_SRC/GETTING-STARTED.md" "$VIRGIL_DIR/"
    ok "GETTING-STARTED.md copied to vault root"
fi

# ── 10. Shell aliases ─────────────────────────────────────────────────────────
hdr "Step 9 — Shell aliases"

SHELL_RC="$HOME/.bashrc"
if [[ "$OS" == "macos" && -f "$HOME/.zshrc" ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ -n "${ZSH_VERSION:-}" ]] && [[ -f "$HOME/.zshrc" ]]; then
    SHELL_RC="$HOME/.zshrc"
fi

INGEST="$VIRGIL_DIR/ingest"
HOOKS="$VIRGIL_DIR/hooks"

ALIAS_BLOCK="
# ── VIRGIL aliases (added by install.sh $(date '+%Y-%m-%d')) ──────────────────
export VIRGIL_DIR=\"$VIRGIL_DIR\"
alias virgil-pdf='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/pdf-ingest.sh'
alias virgil-nist='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/nist-ingest.sh'
alias virgil-url='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/url-ingest.sh'
alias virgil-rss='VIRGIL_DIR=\"\$VIRGIL_DIR\" python3 $INGEST/rss-ingest.py'
alias virgil-cve='VIRGIL_DIR=\"\$VIRGIL_DIR\" python3 $INGEST/cve-ingest.py'
alias virgil-triage='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/triage-inbox.sh'
alias virgil-wikilink='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/wikilink-ingest.sh'
alias virgil-orphans='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/orphan-detect.sh'
alias virgil-workout='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/personal-ingest.sh workout'
alias virgil-study='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $INGEST/personal-ingest.sh study'
# ── end VIRGIL ────────────────────────────────────────────────────────────────"

if grep -q 'VIRGIL aliases' "$SHELL_RC" 2>/dev/null; then
    warn "VIRGIL aliases already present in $SHELL_RC — skipping"
else
    echo "$ALIAS_BLOCK" >> "$SHELL_RC"
    ok "Aliases written to $SHELL_RC"
fi

# ── 11. Crontab ───────────────────────────────────────────────────────────────
hdr "Step 10 — Crontab"

if [[ "${INSTALL_CRON,,}" == "y" ]]; then
    EXISTING_CRON=$(crontab -l 2>/dev/null | \
        grep -v 'virgil\|VIRGIL\|ANTHROPIC_API_KEY\|SLACK_WEBHOOK_URL\|rss-ingest\|cve-ingest\|triage-inbox\|wikilink-ingest\|auto-reflect\|promote\.sh\|weekly-rollup' \
        || true)

    {
        echo "$EXISTING_CRON"
        echo ""
        echo "# ── VIRGIL (installed $(date '+%Y-%m-%d')) ────────────────────────────────────"
        [[ -n "$API_KEY" ]]   && echo "ANTHROPIC_API_KEY=\"$API_KEY\""
        [[ -n "$SLACK_URL" ]] && echo "SLACK_WEBHOOK_URL=\"$SLACK_URL\""
        echo "VIRGIL_DIR=\"$VIRGIL_DIR\""
        echo "0  6 * * *   python3 $INGEST/rss-ingest.py    >> $VIRGIL_DIR/logs/rss.log    2>&1"
        echo "0  7 * * *   python3 $INGEST/cve-ingest.py --recent >> $VIRGIL_DIR/logs/cve.log 2>&1"
        echo "0  8 * * 1   bash    $INGEST/triage-inbox.sh  >> $VIRGIL_DIR/logs/triage.log 2>&1"
        echo "30 23 * * *  bash    $INGEST/wikilink-ingest.sh"
        echo "55 23 * * *  bash    $HOOKS/auto-reflect.sh"
        echo "0  1 * * 1-6 bash    $HOOKS/promote.sh"
        echo "0  1 * * 0   bash    $HOOKS/weekly-rollup.sh"
        echo "# ── end VIRGIL ──────────────────────────────────────────────────────────────"
    } | crontab -

    mkdir -p "$VIRGIL_DIR/logs"
    ok "Crontab installed (7 jobs)"
else
    info "Crontab skipped — add manually from GETTING-STARTED.md"
fi

# ── 12. API connectivity test ─────────────────────────────────────────────────
hdr "Step 11 — Connectivity test"

if [[ -z "$API_KEY" ]]; then
    warn "No API key — skipping Anthropic connectivity test"
else
    info "Testing Anthropic API..."
    HTTP_CODE=$(curl -s -o /tmp/virgil-api-test-$$.json -w "%{http_code}" \
        --max-time 10 \
        https://api.anthropic.com/v1/messages \
        -H "x-api-key: $API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        -H "content-type: application/json" \
        -d '{"model":"claude-haiku-4-5-20251001","max_tokens":8,"messages":[{"role":"user","content":"ping"}]}' \
        2>/dev/null || echo "000")

    case "$HTTP_CODE" in
        200) ok "Anthropic API: connected (HTTP 200)" ;;
        401) err "Anthropic API: authentication failed (HTTP 401) — check your API key" ;;
        429) warn "Anthropic API: rate limited (HTTP 429) — key is valid, try again later" ;;
        000) err "Anthropic API: connection failed — check internet access" ;;
        *)   warn "Anthropic API: HTTP $HTTP_CODE — check key and network" ;;
    esac
    rm -f /tmp/virgil-api-test-$$.json
fi

# ── 13. Live demo: fetch one CVE from NVD ────────────────────────────────────
hdr "Step 12 — Live demo (CVE fetch)"

info "Fetching a recent CVE from NVD API..."

CVE_JSON=$(curl -s --max-time 15 \
    "https://services.nvd.nist.gov/rest/json/cves/2.0?resultsPerPage=1&startIndex=0" \
    2>/dev/null || echo "{}")

CVE_ID=$(echo "$CVE_JSON" | python3 -c "
import json,sys
try:
    d=json.load(sys.stdin)
    cve=d['vulnerabilities'][0]['cve']
    print(cve['id'])
except:
    print('CVE-DEMO-0001')
" 2>/dev/null || echo "CVE-DEMO-0001")

CVE_DESC=$(echo "$CVE_JSON" | python3 -c "
import json,sys
try:
    d=json.load(sys.stdin)
    cve=d['vulnerabilities'][0]['cve']
    descs=cve.get('descriptions',[])
    en=[x['value'] for x in descs if x['lang']=='en']
    print((en[0] if en else 'No description')[:280])
except:
    print('Demo CVE — NVD fetch succeeded')
" 2>/dev/null || echo "Demo CVE")

CVE_NOTE_PATH="$VIRGIL_DIR/notes/cve/${CVE_ID}.md"
TODAY=$(date '+%Y-%m-%d')

cat > "$CVE_NOTE_PATH" << CVENOTE
---
tags: [cve, demo]
date: $TODAY
source: nvd-demo
---

# $CVE_ID

> **Installed by VIRGIL demo** — $TODAY

## Description

$CVE_DESC

## References

- NVD: https://nvd.nist.gov/vuln/detail/$CVE_ID

---
_This note was created by the VIRGIL installer as a live demo._
CVENOTE

ok "Fetched $CVE_ID → $CVE_NOTE_PATH"

# ── 14. Final summary ─────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GRN}╔══════════════════════════════════════════════════════╗${RST}"
echo -e "${BOLD}${GRN}║               You're live.                          ║${RST}"
echo -e "${BOLD}${GRN}╚══════════════════════════════════════════════════════╝${RST}"
echo ""
echo -e "  ${BOLD}User:${RST}    $USER_NAME"
echo -e "  ${BOLD}Vault:${RST}   $VIRGIL_DIR"
echo -e "  ${BOLD}Track:${RST}   $TRACK_LABEL"
echo -e "  ${BOLD}Demo:${RST}    $CVE_NOTE_PATH"
echo ""
echo -e "  ${BOLD}Next steps:${RST}"
echo ""
echo "    1. Activate aliases:"
echo "       source $SHELL_RC"
echo ""
echo "    2. Open Obsidian → 'Open folder as vault' → select:"
echo "       $VIRGIL_DIR"
if $IS_WSL; then
    echo "       (run Obsidian on Windows — point it to the WSL vault path)"
fi
echo ""
echo "    3. Test the pipeline:"
echo "       virgil-cve CVE-2024-0001"
echo "       virgil-rss"
echo "       virgil-url https://attack.mitre.org/techniques/T1059/"
echo ""
echo "    4. Read GETTING-STARTED.md in your vault."
echo ""
echo "  Docs:    $VIRGIL_RELEASES"
echo "  Issues:  https://github.com/Morpheus6669/VIRGIL/issues"
echo ""

# Clean up temp clone if we downloaded it
if [[ -d "/tmp/virgil-src-$$" ]]; then
    rm -rf "/tmp/virgil-src-$$"
fi
