#!/bin/bash
# deploy-machine.sh — Deploy VIRGIL to any machine in the your-lab fleet
#
# Usage:
#   ./scripts/deploy-machine.sh [user@]host
#
# Examples:
#   ./scripts/deploy-machine.sh abaddon
#   ./scripts/deploy-machine.sh your-username@YOUR_HOST_IP
#
# Prerequisites on this machine:
#   - SSH access to the target (key in ~/.ssh/config or agent)
#   - ANTHROPIC_API_KEY and SLACK_WEBHOOK_URL set in environment, or you will be prompted
#   - GitHub SSH key or HTTPS credentials configured on the target for the VIRGIL repo

set -euo pipefail

# ── Args ──────────────────────────────────────────────────────────────────────
TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
    echo "Usage: $0 [user@]host"
    echo "Example: $0 abaddon"
    echo "         $0 your-username@YOUR_HOST_IP"
    exit 1
fi

VIRGIL_REPO="git@github.com:Morpheus6669/VIRGIL.git"
REMOTE_DIR="${REMOTE_DIR:-$HOME/VIRGIL}"

# ── Collect secrets ───────────────────────────────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    read -rsp "ANTHROPIC_API_KEY: " ANTHROPIC_API_KEY
    echo
fi

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
    read -rsp "SLACK_WEBHOOK_URL (leave blank to skip): " SLACK_WEBHOOK_URL
    echo
fi

echo
echo "==> Deploying VIRGIL to $TARGET"
echo "    Repo  : $VIRGIL_REPO"
echo "    Path  : $REMOTE_DIR"
echo

# ── Build env header ─────────────────────────────────────────────────────────
# printf '%q' shell-escapes values so special characters (!, $, etc.) survive.
ENV_HEADER=$(cat <<EOF
export ANTHROPIC_API_KEY=$(printf '%q' "$ANTHROPIC_API_KEY")
export SLACK_WEBHOOK_URL=$(printf '%q' "${SLACK_WEBHOOK_URL:-}")
export VIRGIL_REPO=$(printf '%q' "$VIRGIL_REPO")
export REMOTE_DIR=$(printf '%q' "$REMOTE_DIR")
EOF
)

# ── Stream env header + remote script into bash over SSH ─────────────────────
# No -t: pseudo-TTY breaks stdin piping (TTY wins over pipe).
{
    echo "$ENV_HEADER"
    cat <<'REMOTE_SCRIPT'

# ── Per-step status tracking ──────────────────────────────────────────────────
PASS=()
FAIL=()

ok()   { PASS+=("$1"); echo "  ✅ $1"; }
fail() { FAIL+=("$1: $2"); echo "  ❌ $1 — $2"; }

echo "══════════════════════════════════════════════════"
echo "  VIRGIL Deploy — $(hostname)"
echo "══════════════════════════════════════════════════"
echo

# ── 1. Node.js ────────────────────────────────────────────────────────────────
echo "── 1. Node.js ──────────────────────────────────"
if command -v node >/dev/null 2>&1; then
    ok "Node.js already installed ($(node --version))"
else
    echo "  Node.js not found — attempting install"
    installed=false

    # Try nvm first (user-level, avoids sudo)
    if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
        # shellcheck disable=SC1091
        source "$HOME/.nvm/nvm.sh"
        if nvm install --lts >/dev/null 2>&1; then
            installed=true
            ok "Node.js installed via nvm ($(node --version))"
        fi
    fi

    # Fall back to apt
    if [[ "$installed" == false ]]; then
        if command -v apt-get >/dev/null 2>&1; then
            if sudo apt-get install -y nodejs npm >/dev/null 2>&1; then
                installed=true
                ok "Node.js installed via apt ($(node --version))"
            else
                fail "Node.js" "apt install failed"
            fi
        else
            fail "Node.js" "no nvm and no apt — install manually"
        fi
    fi
fi

# ── 2. npm global prefix ──────────────────────────────────────────────────────
echo "── 2. npm global prefix ────────────────────────"
if command -v npm >/dev/null 2>&1; then
    NPM_GLOBAL=$(npm config get prefix 2>/dev/null || echo "$HOME/.npm-global")
    export PATH="$NPM_GLOBAL/bin:$HOME/.local/bin:$PATH"
    ok "npm available (prefix: $NPM_GLOBAL)"
else
    fail "npm" "not found — claude code install will likely fail"
fi

# ── 3. Claude Code ────────────────────────────────────────────────────────────
echo "── 3. Claude Code ──────────────────────────────"
if command -v claude >/dev/null 2>&1; then
    ok "Claude Code already installed ($(claude --version 2>/dev/null || echo 'version unknown'))"
else
    echo "  Claude Code not found — installing via npm"
    if npm install -g @anthropic-ai/claude-code >/dev/null 2>&1; then
        if command -v claude >/dev/null 2>&1; then
            ok "Claude Code installed ($(claude --version 2>/dev/null || echo 'ok'))"
        else
            fail "Claude Code" "installed but not in PATH — add $NPM_GLOBAL/bin to PATH"
        fi
    else
        fail "Claude Code" "npm install failed"
    fi
fi

# ── 4. Clone / pull VIRGIL repo ───────────────────────────────────────────────
echo "── 4. VIRGIL repo ──────────────────────────────"
mkdir -p "$(dirname "$REMOTE_DIR")"

if [[ -d "$REMOTE_DIR/.git" ]]; then
    echo "  Repo exists — pulling latest"
    if git -C "$REMOTE_DIR" pull; then
        ok "VIRGIL repo up to date"
    else
        fail "VIRGIL repo" "git pull failed"
    fi
else
    echo "  Cloning $VIRGIL_REPO"
    if git clone "$VIRGIL_REPO" "$REMOTE_DIR"; then
        ok "VIRGIL repo cloned"
    else
        fail "VIRGIL repo" "git clone failed — check SSH key / HTTPS credentials on this host"
    fi
fi

# ── 5. Permissions ───────────────────────────────────────────────────────────
echo "── 5. Permissions ──────────────────────────────"
chmod +x "$REMOTE_DIR/hooks/"*.sh  2>/dev/null || true
chmod +x "$REMOTE_DIR/scripts/"*.sh 2>/dev/null || true
ok "hooks/ and scripts/ marked executable"

# ── 6. Runtime directories ────────────────────────────────────────────────────
echo "── 6. Runtime directories ──────────────────────"
for d in daily-logs weekly-summaries notes; do
    mkdir -p "$REMOTE_DIR/$d"
    ok "$d/ exists"
done

# ── 7. ~/.claude/settings.json ───────────────────────────────────────────────
echo "── 7. Claude hooks (settings.json) ─────────────"
SETTINGS_DIR="$HOME/.claude"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"
mkdir -p "$SETTINGS_DIR"

SESSION_START="$REMOTE_DIR/hooks/session-start.sh"
SESSION_END="$REMOTE_DIR/hooks/session-end.sh"

if [[ -f "$SETTINGS_FILE" ]]; then
    # Non-destructive: check if hooks already reference VIRGIL
    if grep -q "session-start\|session-end" "$SETTINGS_FILE" 2>/dev/null; then
        ok "settings.json already has VIRGIL hooks — skipped"
    else
        echo "  settings.json exists but lacks VIRGIL hooks"
        echo "  Manual action: add SessionStart/Stop hooks pointing to:"
        echo "    $SESSION_START"
        echo "    $SESSION_END"
        fail "settings.json" "exists without VIRGIL hooks — add manually"
    fi
else
    cat > "$SETTINGS_FILE" <<SETTINGS_EOF
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "${SESSION_START}"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "${SESSION_END}"
          }
        ]
      }
    ]
  }
}
SETTINGS_EOF
    ok "settings.json written with SessionStart/Stop hooks"
fi

# ── 8. Symlinks ───────────────────────────────────────────────────────────────
echo "── 8. Symlinks ─────────────────────────────────"
mkdir -p "$HOME/.local/bin"

# ~/.claude/commands/ → VIRGIL/.claude/commands/
COMMANDS_SRC="$REMOTE_DIR/.claude/commands"
COMMANDS_DST="$HOME/.claude/commands"
mkdir -p "$COMMANDS_SRC"

if [[ -L "$COMMANDS_DST" ]]; then
    ok "~/.claude/commands symlink already exists"
elif [[ -d "$COMMANDS_DST" ]]; then
    echo "  ~/.claude/commands exists as a real dir — leaving intact"
    fail "~/.claude/commands" "real directory already exists, not replacing with symlink"
else
    ln -s "$COMMANDS_SRC" "$COMMANDS_DST"
    ok "~/.claude/commands → VIRGIL/.claude/commands/"
fi

# ~/.local/bin/sync-virgil → VIRGIL/scripts/sync-projects.sh
SYNC_SRC="$REMOTE_DIR/scripts/sync-projects.sh"
SYNC_DST="$HOME/.local/bin/sync-virgil"
if [[ -L "$SYNC_DST" ]] || [[ -f "$SYNC_DST" ]]; then
    ok "sync-virgil already exists in ~/.local/bin"
elif [[ -f "$SYNC_SRC" ]]; then
    ln -s "$SYNC_SRC" "$SYNC_DST"
    ok "~/.local/bin/sync-virgil → VIRGIL/scripts/sync-projects.sh"
else
    fail "sync-virgil" "sync-projects.sh not found in repo (will exist after push)"
fi

# ~/.local/bin/deploy-virgil → VIRGIL/scripts/deploy-machine.sh
DEPLOY_SRC="$REMOTE_DIR/scripts/deploy-machine.sh"
DEPLOY_DST="$HOME/.local/bin/deploy-virgil"
if [[ -L "$DEPLOY_DST" ]] || [[ -f "$DEPLOY_DST" ]]; then
    ok "deploy-virgil already exists in ~/.local/bin"
elif [[ -f "$DEPLOY_SRC" ]]; then
    ln -s "$DEPLOY_SRC" "$DEPLOY_DST"
    ok "~/.local/bin/deploy-virgil → VIRGIL/scripts/deploy-machine.sh"
else
    fail "deploy-virgil" "deploy-machine.sh not found in repo"
fi

# ── 9. virgil alias in ~/.bashrc ──────────────────────────────────────────────
echo "── 9. virgil alias ─────────────────────────────"
ALIAS_LINE="alias virgil='cd ~/Documents/Cocytus/VIRGIL && claude'"
if grep -qF "$ALIAS_LINE" "$HOME/.bashrc" 2>/dev/null; then
    ok "virgil alias already in ~/.bashrc"
else
    echo "" >> "$HOME/.bashrc"
    echo "# VIRGIL — Claude Code second brain" >> "$HOME/.bashrc"
    echo "$ALIAS_LINE" >> "$HOME/.bashrc"
    ok "virgil alias added to ~/.bashrc"
fi

# PATH entry for npm global bin (idempotent)
NPM_PATH_LINE='export PATH="$HOME/.npm-global/bin:$PATH"'
if ! grep -qF ".npm-global/bin" "$HOME/.bashrc" 2>/dev/null; then
    echo "$NPM_PATH_LINE" >> "$HOME/.bashrc"
    ok "npm-global PATH added to ~/.bashrc"
fi

# ── 10. Crontab ──────────────────────────────────────────────────────────────
echo "── 10. Crontab ─────────────────────────────────"

# Strip any existing VIRGIL cron lines so we can re-register cleanly
EXISTING_CRON=$(crontab -l 2>/dev/null | grep -v \
    -e 'weekly-rollup' \
    -e 'promote\.sh' \
    -e 'nebuchadnezzar' \
    -e 'ANTHROPIC_API_KEY' \
    -e 'SLACK_WEBHOOK_URL' \
    || true)

crontab - <<CRON_EOF
ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
SLACK_WEBHOOK_URL="${SLACK_WEBHOOK_URL:-}"

# VIRGIL — weekly digest (Sunday 1am)
0 1 * * 0 ${REMOTE_DIR}/hooks/weekly-rollup.sh >> ${REMOTE_DIR}/hooks/weekly-rollup.log 2>&1
# VIRGIL — nightly promote (daily 2am)
0 2 * * * ${REMOTE_DIR}/hooks/promote.sh >> ${REMOTE_DIR}/hooks/promote.log 2>&1
# VIRGIL — nebuchadnezzar USB backup (daily 2:05am + Sunday 1:05am)
5 2 * * * ${REMOTE_DIR}/hooks/nebuchadnezzar.sh >> ${REMOTE_DIR}/hooks/nebuchadnezzar.log 2>&1
5 1 * * 0 ${REMOTE_DIR}/hooks/nebuchadnezzar.sh >> ${REMOTE_DIR}/hooks/nebuchadnezzar.log 2>&1

${EXISTING_CRON}
CRON_EOF

ok "Crontab registered (promote, weekly-rollup, nebuchadnezzar)"

# ── 11. Smoke test ────────────────────────────────────────────────────────────
echo
echo "── Smoke test ──────────────────────────────────"
printf "  git:          "; git --version 2>/dev/null || echo "NOT FOUND"
printf "  node:         "; node --version 2>/dev/null || echo "NOT FOUND"
printf "  npm:          "; npm --version 2>/dev/null || echo "NOT FOUND"
printf "  python3:      "; python3 --version 2>/dev/null || echo "NOT FOUND"
printf "  curl:         "; curl --version 2>/dev/null | head -1 || echo "NOT FOUND"
printf "  claude:       "; command -v claude >/dev/null 2>&1 && echo "$(command -v claude)" || echo "NOT FOUND"
printf "  promote.sh:   "; [[ -x "${REMOTE_DIR}/hooks/promote.sh" ]]       && echo "ok" || echo "MISSING"
printf "  rollup.sh:    "; [[ -x "${REMOTE_DIR}/hooks/weekly-rollup.sh" ]]  && echo "ok" || echo "MISSING"
printf "  nebuch.sh:    "; [[ -x "${REMOTE_DIR}/hooks/nebuchadnezzar.sh" ]] && echo "ok" || echo "MISSING"
echo

# ── Final report ──────────────────────────────────────────────────────────────
echo "══════════════════════════════════════════════════"
echo "  REPORT — $(hostname)"
echo "══════════════════════════════════════════════════"
echo "  PASSED: ${#PASS[@]}"
for p in "${PASS[@]}"; do echo "    ✅ $p"; done
echo
if [[ ${#FAIL[@]} -gt 0 ]]; then
    echo "  FAILED: ${#FAIL[@]}"
    for f in "${FAIL[@]}"; do echo "    ❌ $f"; done
    echo
    echo "  Deployment completed with errors. Review failures above."
else
    echo "  All steps passed."
    echo
    echo "  Next: SSH to $(hostname) and run 'virgil' to start Claude Code."
fi
echo "══════════════════════════════════════════════════"

REMOTE_SCRIPT
} | ssh "$TARGET" bash

echo
echo "==> deploy-machine.sh done."
