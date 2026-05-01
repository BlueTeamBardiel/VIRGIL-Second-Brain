#!/usr/bin/env bash
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  VIRGIL — Second Brain Installer                                            │
# │  https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain                       │
# │                                                                             │
# │  Quick install (interactive — keeps stdin attached to terminal):            │
# │    bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/    │
# │                        VIRGIL-Second-Brain/main/scripts/install.sh)         │
# │                                                                             │
# │  Download and verify before running (recommended):                          │
# │    curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/            │
# │             VIRGIL-Second-Brain/main/scripts/install.sh -o virgil-install.sh│
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
VIRGIL_VERSION="1.9.2"
VIRGIL_REPO="https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain.git"
VIRGIL_RAW="https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main"
VIRGIL_RELEASES="https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain/releases"
VIRGIL_CHECKSUM_URL="https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/checksums.sha256"
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

verify_checksums() {
  local src_dir="${1:-}"
  if ! command -v sha256sum &>/dev/null; then
    warn "sha256sum not available — skipping checksum verification"
    return 0
  fi
  info "Verifying file checksums..."
  if curl -fsSL "$VIRGIL_CHECKSUM_URL" -o /tmp/virgil-checksums.sha256 2>/dev/null; then
    if [[ -n "$src_dir" && -d "$src_dir" ]]; then
      if (cd "$src_dir" && sha256sum --check /tmp/virgil-checksums.sha256 --quiet 2>/dev/null); then
        ok "Checksums verified ✓"
      else
        echo ""
        echo "  ✗ FATAL: Checksum verification failed"
        echo "  The installer files may have been modified or corrupted."
        echo "  Do not proceed. Download VIRGIL again from:"
        echo "  https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain"
        echo ""
        exit 1
      fi
    else
      warn "No source directory for checksum verification — skipping"
    fi
    rm -f /tmp/virgil-checksums.sha256
  else
    warn "Could not fetch checksums — skipping verification"
  fi
}

# ── Flag parsing ──────────────────────────────────────────────────────────────
FAST_MODE=false
DRY_RUN=false
DOCKER_MODE=false

for arg in "$@"; do
    case "$arg" in
        --fast)    FAST_MODE=true ;;
        --dry-run) DRY_RUN=true; FAST_MODE=true ;; # dry-run uses defaults, no tty needed
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
    echo "      ghcr.io/blueteambardiel/virgil-second-brain:latest"
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
echo "  Welcome to VIRGIL — your cybersecurity study companion."
echo ""
echo "  VIRGIL is a local AI-powered second brain for cybersecurity learners."
echo "  It lives entirely on your machine, learns what you study, tracks what"
echo "  you struggle with, and helps you get exam-ready — one topic at a time."
echo "  No cloud. No subscriptions. Everything stays here."
echo ""
echo "  Here's what we'll set up together:"
echo ""
echo "    • Check your machine has the tools VIRGIL needs (we'll install anything missing)"
echo "    • Download VIRGIL onto your machine from GitHub"
echo "    • Create your vault — the folder where all your notes will live"
echo "    • Set up a private config file for your API key (optional, never shared)"
echo "    • Ask if you'd like VIRGIL to run automatically each day (you can say no)"
echo "    • Add study commands to your terminal (virgil-quiz, virgil-rss, etc.)"
echo "    • Run a quick test so you can see VIRGIL working before you close this window"
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

if $IS_WSL; then
    echo ""
    echo -e "${BOLD}${CYN}  ── Windows / WSL2 ─────────────────────────────────────────${RST}"
    info "VIRGIL scripts and vault install here, inside WSL2. ✓"
    info "Obsidian: install on Windows (native app) — NOT inside WSL"
    info "  open-vault path:  \\\\wsl.localhost\\Ubuntu\\home\\${USER}\\VIRGIL"
    info "Claude Code: requires WSL2 on Windows — you are already in the right place. ✓"
    info "Cron: add  [boot] command=service cron start  to /etc/wsl.conf"
    info "Full WSL2 guide: see GETTING-STARTED.md → Windows (via WSL2)"
    echo ""
fi

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
OBSIDIAN_FOUND=false
if command -v obsidian &>/dev/null; then
    ok "Obsidian: $(command -v obsidian)"
    OBSIDIAN_FOUND=true
elif [[ "$OS" == "macos" ]] && [[ -d "/Applications/Obsidian.app" ]]; then
    ok "Obsidian: /Applications/Obsidian.app"
    OBSIDIAN_FOUND=true
fi

if ! $OBSIDIAN_FOUND; then
    echo ""
    info "Obsidian is the app you use to read and navigate your VIRGIL vault."
    info "Think of it as a browser for your notes — it connects them, shows you the"
    info "knowledge graph, and makes search actually useful."
    info "Download free at: https://obsidian.md"
    echo ""

    if $IS_WSL; then
        warn "Install Obsidian on Windows (native app) — NOT inside WSL"
    elif [[ "$OS" == "linux" ]] && ! $FAST_MODE && ! $DRY_RUN; then
        ask "Download and install the Obsidian AppImage now? [y/N]"
        echo "  An AppImage is a single self-contained app file on Linux — no package"
        echo "  manager, no install wizard. You download it, mark it executable, and"
        echo "  run it. The Obsidian AppImage is about 100 MB. It installs to"
        echo "  ~/.local/bin/Obsidian.AppImage (your home directory). Nothing goes"
        echo "  into system directories; uninstalling is just deleting the file."
        echo "  Say no if you want to install Obsidian yourself later."
        read -r -p "  " INSTALL_OBS </dev/tty
        if [[ "${INSTALL_OBS,,}" == "y" ]]; then
            OBS_VER="1.7.7"
            OBS_URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBS_VER}/Obsidian-${OBS_VER}.AppImage"
            OBS_DEST="$HOME/.local/bin/Obsidian.AppImage"
            mkdir -p "$HOME/.local/bin"
            info "Downloading Obsidian ${OBS_VER} AppImage..."
            if curl -fsSL --max-time 120 -o "$OBS_DEST" "$OBS_URL"; then
                chmod +x "$OBS_DEST"
                ok "Installed: $OBS_DEST"
                info "Launch with: $OBS_DEST   (or add ~/.local/bin to PATH)"
                OBSIDIAN_FOUND=true
            else
                warn "Download failed — install manually from https://obsidian.md"
            fi
        else
            info "Skipping Obsidian install — grab it later from https://obsidian.md"
        fi
    else
        warn "Obsidian not found — install it from https://obsidian.md when ready"
    fi
    echo ""
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
            # Ensure pip is available before trying to install packages
            if ! python3 -m pip --version &>/dev/null 2>&1; then
                info "pip not found — installing python3-pip..."
                if [[ "$PKG_MANAGER" == "apt" ]]; then
                    sudo apt-get install -y python3-pip -qq
                elif [[ "$OS" == "macos" ]] && command -v brew &>/dev/null; then
                    brew install python &>/dev/null
                else
                    warn "Cannot auto-install pip — install python3-pip manually, then re-run"
                fi
            fi
            info "Installing Python packages: ${PIP_PKGS[*]}"
            # Try normal install first; fall back to --break-system-packages for PEP 668 systems
            # (Ubuntu 24.04+ blocks user installs without this flag on externally-managed envs)
            if ! python3 -m pip install --quiet --user "${PIP_PKGS[@]}" 2>/dev/null; then
                python3 -m pip install --quiet --user --break-system-packages "${PIP_PKGS[@]}"
            fi
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
IS_LOCAL_CLONE=false
if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "-" && \
      "${BASH_SOURCE[0]}" != "/dev/stdin" && -f "${BASH_SOURCE[0]}" ]]; then
    _CANDIDATE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    if [[ -f "$_CANDIDATE/README.md" ]] && \
       grep -q "VIRGIL-Second-Brain" "$_CANDIDATE/README.md" 2>/dev/null && \
       [[ -d "$_CANDIDATE/.git" ]] && \
       git -C "$_CANDIDATE" remote -v 2>/dev/null | grep -q "BlueTeamBardiel/VIRGIL-Second-Brain"; then
        IS_LOCAL_CLONE=true
        INSTALL_SRC="$_CANDIDATE"
        info "Using local clone: $INSTALL_SRC"
    fi
fi

if ! $IS_LOCAL_CLONE; then
    INSTALL_SRC="/tmp/virgil-src-$$"
    if $DRY_RUN; then
        info "[dry-run] Would clone $VIRGIL_REPO → $INSTALL_SRC"
    else
        info "Cloning VIRGIL repository..."
        git clone --quiet --depth 1 "$VIRGIL_REPO" "$INSTALL_SRC"
        ok "Cloned to $INSTALL_SRC"
    fi
fi

if ! $DRY_RUN && [[ -d "$INSTALL_SRC" ]]; then
    verify_checksums "$INSTALL_SRC"
fi

# ── 3. Wizard / fast-mode questions ──────────────────────────────────────────
hdr "Step 3 — Configuration"

# Defaults
USER_NAME="Learner"
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
        warn "ANTHROPIC_API_KEY not set — AI features will use local Ollama inference or be skipped"
        warn "To enable cloud fallback: export ANTHROPIC_API_KEY=sk-ant-... before running"
    fi
else
    # Q1: Name
    echo ""
    ask "What should I call you?"
    echo "  VIRGIL writes this name into CLAUDE.md — the config file that tells any"
    echo "  AI assistant working with your vault who you are. It's also used in your"
    echo "  daily session logs. Nothing is sent anywhere; it stays on this machine."
    read -r -p "  Your name: " NAME_INPUT </dev/tty
    if [[ -z "$NAME_INPUT" ]]; then
        ask "Please enter a name — even just your first name works:"
        read -r -p "  Your name: " NAME_INPUT </dev/tty
        USER_NAME="${NAME_INPUT:-Learner}"
    else
        USER_NAME="$NAME_INPUT"
    fi
    ok "Name set to: $USER_NAME"

    # Q2: API key
    echo ""
    ask "Paste your Anthropic API key (get one free at console.anthropic.com):"
    echo "  An API key is like a password that lets VIRGIL talk to Claude AI on your"
    echo "  behalf. VIRGIL uses it to turn raw vulnerability data and news headlines"
    echo "  into plain-English explanations you can actually learn from."
    echo ""
    echo "  With a key:    notes come out explained, connected, and tagged."
    echo "  Without a key: notes still save — as raw source data, no enrichment."
    echo ""
    echo "  Your key is stored only in ~/VIRGIL/.env (chmod 600, never logged)."
    echo "  You can add or change it later by editing that file."
    echo ""
    echo "  Cost: roughly \$3–5/month at typical homelab usage (Claude Haiku pricing)."
    echo "  Local alternative: skip this prompt and use Ollama — see GETTING-STARTED.md"
    echo ""
    if [[ -n "$API_KEY" ]]; then
        ok "ANTHROPIC_API_KEY already set in environment (${#API_KEY} chars)"
        read -r -p "  Use this key? [Y/n]: " USE_ENV </dev/tty
        if [[ "${USE_ENV,,}" == "n" ]]; then
            API_KEY=""
        fi
    fi
    if [[ -z "$API_KEY" ]]; then
        API_ATTEMPTS=0
        while true; do
            read -r -sp "  API key (or Enter to skip): " API_KEY </dev/tty
            echo ""
            if [[ -z "$API_KEY" ]]; then
                info "No problem — VIRGIL works without a key. Add one later by editing ~/VIRGIL/.env"
                info "AI-powered summaries will be available once you do."
                break
            fi
            API_ATTEMPTS=$((API_ATTEMPTS + 1))
            if [[ "$API_KEY" != sk-ant-* ]]; then
                err "Key doesn't start with sk-ant- — check and re-enter"
            elif [[ "${#API_KEY}" -lt 40 ]]; then
                err "Key looks too short (Anthropic keys are 100+ chars)"
            else
                ok "Key accepted (${#API_KEY} chars)"
                break
            fi
            if [[ $API_ATTEMPTS -ge 3 ]]; then
                API_KEY=""
                info "No problem — VIRGIL works without a key. Add one later by editing ~/VIRGIL/.env"
                info "AI-powered summaries will be available once you do."
                break
            fi
        done
    fi

    # Q3: Slack
    echo ""
    ask "Slack webhook URL for notifications? (press Enter to skip)"
    echo "  A Slack webhook is a private URL Slack gives you that any script can POST"
    echo "  a message to — it shows up as a chat message in the channel you pick."
    echo "  Think of it like a one-way mailbox: your scripts drop notes in, Slack"
    echo "  delivers them to you. VIRGIL uses this to ping you when a digest is ready,"
    echo "  a CRITICAL CVE shows up, or the weekly summary is written — so you don't"
    echo "  have to remember to check the vault."
    echo ""
    echo "  Leave blank if you don't use Slack or want to stay notification-free."
    echo "  Create a webhook at: https://api.slack.com/apps → Incoming Webhooks"
    read -r -sp "  Webhook URL: " SLACK_URL </dev/tty
    echo ""
    if [[ -n "$SLACK_URL" ]]; then
        ok "Slack webhook configured"
    else
        info "Slack notifications skipped — add a webhook later in ~/VIRGIL/.env"
    fi

    # Q4: Vault location
    echo ""
    ask "Where should your VIRGIL vault live?"
    echo "  A 'vault' is just a folder full of markdown (.md) files. Obsidian treats"
    echo "  any folder you point it at as a vault and lets you browse, link, and"
    echo "  search across the notes inside. Everything VIRGIL writes — CVEs, feeds,"
    echo "  daily logs, your own notes — goes here as plain text files you can read"
    echo "  with any editor, back up like any folder, and walk away from any time."
    echo ""
    echo "  Default is ~/VIRGIL (your home directory). Press Enter to accept, or"
    echo "  type a different path if you want it somewhere else (e.g. external drive)."
    while true; do
        read -r -e -i "$HOME/VIRGIL" vault_input </dev/tty
        VAULT_INPUT="${vault_input:-$HOME/VIRGIL}"
        VIRGIL_DIR="${VAULT_INPUT/#\~/$HOME}"
        if [[ ${#VIRGIL_DIR} -le 2 ]]; then
            echo "  Please enter a full path (e.g. ~/VIRGIL or /home/user/VIRGIL)"
            continue
        fi
        if [[ "$VIRGIL_DIR" != /* ]]; then
            echo "  Path must be absolute (start with / or ~)"
            continue
        fi
        break
    done
    ok "Vault: $VIRGIL_DIR"
    warn "Your vault lives on THIS machine only. Nothing syncs to a cloud service."
    warn "To use it across devices: Obsidian Sync (paid) or self-hosted Syncthing."

    # Q5: Knowledge track
    echo ""
    ask "Knowledge track — which feeds and starters should be enabled?"
    echo "  'Feeds' are RSS subscriptions — the same tech news sites you'd read in a"
    echo "  browser, except VIRGIL fetches them automatically each morning and turns"
    echo "  them into a digest note in your vault. Your pick here decides which"
    echo "  subjects VIRGIL pulls daily and which starter notes seed your vault."
    echo "  You can always add or remove feeds later by editing ingest/rss-ingest.py."
    echo ""
    echo "  (1) Security    — threat intel, CVEs, MITRE ATT&CK techniques, malware news"
    echo "  (2) Networking  — BGP, SDN, Cisco/Juniper gear, packet analysis"
    echo "  (3) Both        — full feed set (recommended if you're not sure)"
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
    echo "  Cron is the Linux/macOS tool that runs scripts on a schedule — like"
    echo "  setting recurring alarms, but for commands. Saying yes here adds 7"
    echo "  scheduled jobs that keep your vault up-to-date while you sleep."
    echo "  Saying no means nothing happens automatically — you run everything"
    echo "  manually (virgil-rss, virgil-cve, etc.) whenever you feel like it."
    echo ""
    echo "  Schedules installed:"
    echo "    6am daily   — RSS threat intel digest"
    echo "                  Pulls today's cybersecurity news headlines into your vault"
    echo "    7am daily   — CVE ingest from NVD"
    echo "                  Grabs new vulnerabilities from the National Vulnerability Database"
    echo "                  (NVD is the US government's public CVE database)"
    echo "    Mon 8am     — Inbox triage"
    echo "                  Sorts and tags new notes in notes/inbox/ automatically"
    echo "    11:30pm     — Wikilink injection"
    echo "                  Connects related notes with [[wikilinks]] (Obsidian's link format)"
    echo "    11:55pm     — Session auto-reflect"
    echo "                  VIRGIL summarizes what you learned today into your daily log"
    echo "    1am Mon–Sat — Daily log promotion"
    echo "                  Distills the best insights from today's log into permanent memory"
    echo "    1am Sunday  — Weekly digest"
    echo "                  Weekly summary of everything that came in this week"
    echo ""
    echo "  You can disable any of these later with: crontab -e"
    echo "  Entries you don't like? Delete the line. No other cron jobs are touched."
    echo ""
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
    step "Would copy 1,500+ notes to:   $VIRGIL_DIR/notes/"
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
    "$VIRGIL_DIR/daily-logs"
    "$VIRGIL_DIR/weekly-summaries"
    "$VIRGIL_DIR/scripts"
)

for d in "${VAULT_DIRS[@]}"; do mkdir -p "$d"; done
ok "Created ${#VAULT_DIRS[@]} directories under $VIRGIL_DIR"

# ── 5. Copy/install scripts ───────────────────────────────────────────────────
hdr "Step 5 — Installing scripts"

SCRIPTS_DEST="$VIRGIL_DIR/scripts"

for subdir in ingest hooks skills .claude; do
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
# VIRGIL — Student Profile

name: $USER_NAME
created: $(date '+%Y-%m-%d')

## Why I'm here
why:
# Examples: money, career change, curiosity, job requirement, gaming background

## Background
background:
# Examples: gaming, professional IT, career change, student, curiosity, money

## How I learn best
analogies:
# Examples: gaming, sports, cooking, cars, music, mechanical, visual

## Study pace
pace: medium
# Options: fast (push me), medium (balanced), slow (make sure I get it)

## Cert goals (in order)
certs: []
# Example: [A+, Security+, CCNA, CySA+]

## Current focus
current_cert:
current_chapter: 1
current_domain: 1
diagnostic_complete: false

## Notes
# VIRGIL reads this file at the start of every session.
# Edit any field to update your profile.
# Run /diagnose to set up your profile automatically.

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
CLAUDEEOF

ok "CLAUDE.md written with name: $USER_NAME"

# ── 8. Starter memory files ───────────────────────────────────────────────────
for mf in memory-working.md memory-episodic.md memory-semantic.md; do
    if [[ ! -f "$VIRGIL_DIR/$mf" ]]; then
        cat > "$VIRGIL_DIR/$mf" << MEMEOF
# $mf

_Created by VIRGIL installer on $(date '+%Y-%m-%d') — ${USER_NAME}_

---

MEMEOF
        ok "Created starter $mf"
    fi
done

# ── 9. Copy starter notes ─────────────────────────────────────────────────────
hdr "Step 8 — Starter notes"

if [[ -d "$INSTALL_SRC/starter-notes" ]]; then
    NOTE_COUNT=$(find "$VIRGIL_DIR/notes" -name "*.md" 2>/dev/null | wc -l)
    if [[ "$NOTE_COUNT" -lt 10 ]]; then
        info "Seeding notes vault..."
        cp -r "$INSTALL_SRC/starter-notes/." "$VIRGIL_DIR/notes/"
        [[ -d "$INSTALL_SRC/notes" ]] && cp -rn "$INSTALL_SRC/notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
        ok "Vault seeded — 1,500+ notes installed"
    else
        cp -rn "$INSTALL_SRC/starter-notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
        [[ -d "$INSTALL_SRC/notes" ]] && cp -rn "$INSTALL_SRC/notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
        ok "Vault notes synced (skipped existing files)"
    fi
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

# virgil-quiz depends on the RAG stack (ChromaDB query module + llm_client).
# Only wire the alias if both files are actually present on disk — otherwise
# the user would get a ModuleNotFoundError the first time they typed it.
QUIZ_ALIAS=""
if [[ -f "$INGEST/chroma-query.py" && -f "$HOOKS/llm_client.py" ]]; then
    QUIZ_ALIAS="alias virgil-quiz='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash $HOOKS/quiz.sh'"
    info "virgil-quiz: RAG deps present — alias will be installed"
else
    info "virgil-quiz requires ChromaDB (vector search) — set up later in GETTING-STARTED.md"
fi

ALIAS_BLOCK="
# ── VIRGIL aliases (added by install.sh $(date '+%Y-%m-%d')) ──────────────────
export VIRGIL_DIR=\"$VIRGIL_DIR\"
alias virgil-pdf='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/pdf-ingest.sh'
alias virgil-nist='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/nist-ingest.sh'
alias virgil-url='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/url-ingest.sh'
alias virgil-rss='VIRGIL_DIR=\"\$VIRGIL_DIR\" python3 \$VIRGIL_DIR/ingest/rss-ingest.py'
alias virgil-cve='VIRGIL_DIR=\"\$VIRGIL_DIR\" python3 \$VIRGIL_DIR/ingest/cve-ingest.py'
alias virgil-triage='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/triage-inbox.sh'
alias virgil-wikilink='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/wikilink-ingest.sh'
alias virgil-orphans='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/orphan-detect.sh'
alias virgil-workout='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/personal-ingest.sh workout'
alias virgil-study='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/personal-ingest.sh study'
alias virgil-progress='python3 \$VIRGIL_DIR/hooks/virgil-progress.py'
alias virgil-review='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/hooks/review.sh'
alias virgil-cert-ingest='VIRGIL_DIR=\"\$VIRGIL_DIR\" bash \$VIRGIL_DIR/ingest/cert-ingest.sh'
alias virgil-streak='python3 \$VIRGIL_DIR/hooks/streak.py show'
alias virgil-roadmap='python3 \$VIRGIL_DIR/hooks/cert-roadmap.py'
${QUIZ_ALIAS}
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
    if command -v crontab &>/dev/null; then
        EXISTING_CRON=$(crontab -l 2>/dev/null | \
            grep -v 'virgil\|VIRGIL\|ANTHROPIC_API_KEY\|SLACK_WEBHOOK_URL\|BASH_ENV.*VIRGIL\|rss-ingest\|cve-ingest\|triage-inbox\|wikilink-ingest\|auto-reflect\|promote\.sh\|weekly-rollup' \
            || true)

        {
            echo "$EXISTING_CRON"
            echo ""
            echo "# ── VIRGIL (installed $(date '+%Y-%m-%d')) ────────────────────────────────────"
            echo "# Load secrets from vault env file (never embedded here)"
            echo "BASH_ENV=\"$VIRGIL_DIR/.env\""
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
        warn "crontab not available on this system — skipping"
        info "Add schedules manually later: see GETTING-STARTED.md"
    fi
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

# ── 13. Demo CVE note (dynamic HIGH/CRITICAL fetch from NVD) ─────────────────
hdr "Step 12 — Demo CVE note"

TODAY=$(date '+%Y-%m-%d')
DEMO_DEST_DIR="$VIRGIL_DIR/notes/cve"
mkdir -p "$DEMO_DEST_DIR"

info "Fetching a recent HIGH/CRITICAL CVE from NVD..."

CVE_NOTE_PATH=$(VIRGIL_DEMO_DIR="$DEMO_DEST_DIR" VIRGIL_DEMO_TODAY="$TODAY" python3 <<'PYDEMO'
import json, os, sys, urllib.request
from datetime import datetime, timezone, timedelta
from pathlib import Path

DEST = Path(os.environ["VIRGIL_DEMO_DIR"])
TODAY = os.environ["VIRGIL_DEMO_TODAY"]

def fetch_latest_high_crit():
    now = datetime.now(timezone.utc)
    start = now - timedelta(days=7)
    base = "https://services.nvd.nist.gov/rest/json/cves/2.0"
    for sev in ("CRITICAL", "HIGH"):
        qs = (
            f"?pubStartDate={start.strftime('%Y-%m-%dT%H:%M:%S.000')}"
            f"&pubEndDate={now.strftime('%Y-%m-%dT%H:%M:%S.000')}"
            f"&cvssV3Severity={sev}"
            f"&resultsPerPage=20&startIndex=0"
        )
        try:
            req = urllib.request.Request(base + qs, headers={"User-Agent": "VIRGIL-installer/1.0"})
            with urllib.request.urlopen(req, timeout=15) as r:
                data = json.load(r)
            vulns = data.get("vulnerabilities", [])
            if vulns:
                vulns.sort(key=lambda v: v["cve"].get("published", ""), reverse=True)
                return vulns[0]["cve"]
        except Exception:
            continue
    return None

def cvss(cve):
    metrics = cve.get("metrics", {})
    for key in ("cvssMetricV31", "cvssMetricV30", "cvssMetricV40", "cvssMetricV2"):
        entries = metrics.get(key, [])
        if entries:
            d = entries[0].get("cvssData", {})
            return str(d.get("baseScore", "N/A")), (d.get("baseSeverity") or d.get("severity") or "N/A").upper()
    return "N/A", "N/A"

def render_dynamic(cve):
    cid = cve.get("id", "CVE-UNKNOWN")
    published = cve.get("published", "")[:10] or TODAY
    score, sev = cvss(cve)
    descs = cve.get("descriptions", [])
    en = next((d["value"] for d in descs if d.get("lang") == "en"), "No description available.")
    refs = [r.get("url", "") for r in cve.get("references", [])[:5] if r.get("url")]
    refs_md = "\n".join(f"- {u}" for u in refs) if refs else "- (none listed)"
    return cid, f"""# {cid}

> **CVSS {score}** ({sev}) | Published: {published} | Demo note installed by VIRGIL

## What is this?
{en}

## Why does it matter?
This is the most recent {sev.lower()}-severity vulnerability VIRGIL could find in the National Vulnerability Database at the time of install. A {sev.lower()} CVSS rating means exploitation typically leads to serious impact — remote code execution, privilege escalation, or significant data exposure — and often requires little or no user interaction.

## The attack
Read the description above for the specific mechanism. The pattern matters more than the instance: attackers watch the NVD feed daily, weaponize new CVEs within hours, and pivot to unpatched systems before defenders read their morning coffee emails.

## Defender takeaway
Track new CVEs daily. Map them to your inventory. Patch high-impact, internet-facing systems first. VIRGIL's `virgil-cve --recent` does the tracking part; you still have to do the mapping and the patching.

## References
{refs_md}

## Tags
cve, demo, {sev.lower()}-severity

---
_This note was installed by VIRGIL as a live demo. Replace it with real notes as your vault grows._
"""

FALLBACK_ID = "CVE-1999-0095"
FALLBACK = """# CVE-1999-0095 — Sendmail Debug RCE

> **CVSS N/A** | Published: 1999-12-30 | Demo note installed by VIRGIL

## What is this?
A mail server called Sendmail shipped with a debug mode accidentally left on. Anyone who could reach port 25 could use it to run commands as root — the most powerful user on the system.

## Why does it matter?
This is one of the first remote code execution vulnerabilities ever documented. The pattern — a debug feature left enabled in production — still causes breaches today. Same mistake, different decade.

## The attack
An attacker sends a crafted SMTP DEBUG command. The server executes it as root. Full system compromise in one packet.

## Real-world impact
Debug interfaces exposed to the internet have appeared in modern software as recently as 2022. The name changes. The mistake doesn't.

## Defender takeaway
Disable debug modes before production. Audit exposed services for developer features that were never meant to be public.

## Tags
cve, demo, rce, sendmail, historical

---
_This note was installed by VIRGIL as a live demo. Replace it with real notes as your vault grows._
"""

cve = fetch_latest_high_crit()
if cve:
    cid, body = render_dynamic(cve)
else:
    cid, body = FALLBACK_ID, FALLBACK

out = DEST / f"{cid}.md"
out.write_text(body)
print(out)
PYDEMO
)

if [[ -n "$CVE_NOTE_PATH" && -f "$CVE_NOTE_PATH" ]]; then
    ok "Wrote demo note → $CVE_NOTE_PATH"
else
    CVE_NOTE_PATH="$DEMO_DEST_DIR/CVE-1999-0095.md"
    warn "NVD fetch helper did not return a path — check $CVE_NOTE_PATH"
fi

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
if ! $OBSIDIAN_FOUND; then
    echo -e "${BOLD}${CYN}  📓 You'll need Obsidian to read your vault.${RST}"
    echo ""
    echo "  VIRGIL writes everything as plain text files in $VIRGIL_DIR."
    echo "  Obsidian is the free app that turns that folder into a connected"
    echo "  knowledge graph — search, links, tags, and a visual map of everything"
    echo "  you've learned. Without it, your vault is just a folder of files."
    echo ""
    echo "  Download free: https://obsidian.md"
    echo "  Once installed: File → Open Folder as Vault → select $VIRGIL_DIR"
    echo ""
fi
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
echo "       virgil-cve --recent"
echo "       virgil-rss"
echo "       virgil-url https://attack.mitre.org/techniques/T1059/"
echo ""
echo "    4. Install Claude Code — this is how you talk to VIRGIL:"
echo "       npm install -g @anthropic-ai/claude-code"
echo "       (requires Node.js — install from https://nodejs.org if needed)"
echo ""
echo "    5. Start your first study session:"
echo "       cd ~/VIRGIL && claude"
echo "       Then type: /secplus  (or /cysa if that's your cert)"
echo ""
echo "    6. Read GETTING-STARTED.md in your vault for the full guide."
echo ""
echo "  Docs:    $VIRGIL_RELEASES"
echo "  Issues:  https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain/issues"
echo ""

# ── 15. Guided wizard ─────────────────────────────────────────────────────────
if ! $FAST_MODE; then
    while true; do
        echo ""
        ask "What do you want to do right now?"
        echo "    (1) Show me my first CVE note"
        echo "    (2) How do I open this in Obsidian?"
        echo "    (3) Run my first RSS digest"
        echo "    (4) I'm done — show me the quick reference"
        echo ""
        read -r -p "  Choice [4]: " WIZ_CHOICE </dev/tty
        WIZ_CHOICE="${WIZ_CHOICE:-4}"

        case "$WIZ_CHOICE" in
            1)
                echo ""
                if [[ -f "$CVE_NOTE_PATH" ]]; then
                    cat "$CVE_NOTE_PATH"
                    echo ""
                    info "This is what VIRGIL writes for every CVE it ingests."
                    info "Add an API key or set up Ollama to get AI-enriched explanations automatically."
                else
                    warn "Demo note not found at $CVE_NOTE_PATH"
                fi
                ;;
            2)
                echo ""
                info "Obsidian is a free markdown editor that treats your vault as a web of notes."
                info "Download it at: https://obsidian.md"
                echo ""
                case "$OS" in
                    macos)
                        step "On macOS:"
                        echo "    1. Open Obsidian"
                        echo "    2. Click 'Open folder as vault'"
                        echo "    3. Select: $VIRGIL_DIR"
                        ;;
                    wsl2)
                        step "On Windows (with WSL2):"
                        echo "    1. Install Obsidian on Windows (NOT inside WSL)"
                        echo "    2. Open Obsidian → 'Open folder as vault'"
                        echo "    3. Paste this path into the folder picker:"
                        echo "       \\\\wsl.localhost\\Ubuntu\\home\\${USER}\\VIRGIL"
                        echo "       (adjust the distro name if you're not on Ubuntu)"
                        ;;
                    linux)
                        step "On Linux:"
                        echo "    1. Launch Obsidian (AppImage, Flatpak, Snap, or .deb)"
                        echo "    2. Click 'Open folder as vault'"
                        echo "    3. Select: $VIRGIL_DIR"
                        ;;
                esac
                echo ""
                warn "Your vault lives on THIS machine only. To sync across devices you need"
                warn "Obsidian Sync (paid) or a self-hosted solution like Syncthing."
                ;;
            3)
                echo ""
                echo "  →  Running your first RSS digest now..."
                echo "  →  This pulls today's security headlines into your vault."
                echo "  →  No API key needed for this step — raw headlines save automatically."
                echo "  →  Add a key later to get AI-enriched summaries."
                echo ""
                if command -v python3 &>/dev/null && [[ -f "$VIRGIL_DIR/ingest/rss-ingest.py" ]]; then
                    VIRGIL_DIR="$VIRGIL_DIR" python3 "$VIRGIL_DIR/ingest/rss-ingest.py" 2>&1 | tail -15
                else
                    echo "  ⚠  RSS ingest script not found — run virgil-rss from your terminal after sourcing ~/.bashrc"
                fi
                ;;
            4|*)
                echo ""
                echo -e "${BOLD}${CYN}── Quick Reference ─────────────────────────────────────────${RST}"
                echo ""
                step "Top 5 commands:"
                echo "    virgil-cve <CVE-ID>      Ingest a specific CVE into your vault"
                echo "    virgil-rss               Pull today's threat intel RSS digest"
                echo "    virgil-url <url>         Convert a web page into a note"
                echo "    virgil-triage            Sort and tag new inbox notes"
                echo "    virgil-wikilink          Connect related notes with [[wikilinks]]"
                echo ""
                step "Vault path:   $VIRGIL_DIR"
                step "Docs:         $VIRGIL_RELEASES"
                step "Config:       $VIRGIL_DIR/.env    (edit to change API key, Slack URL)"
                echo ""
                break
                ;;
        esac
    done
fi

# Clean up temp clone if we downloaded it
if [[ -d "/tmp/virgil-src-$$" ]]; then
    rm -rf "/tmp/virgil-src-$$"
fi
