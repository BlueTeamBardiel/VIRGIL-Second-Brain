#!/bin/bash
# deploy-abaddon.sh — Deploy VIRGIL second brain to ABADDON
# Run from BEHEMOTH. SSHes into ABADDON, clones VIRGIL, sets up hooks and cron.
#
# Usage:
#   ./scripts/deploy-abaddon.sh
#
# Prerequisites on BEHEMOTH:
#   - SSH access to your-username@YOUR_HOST_IP (or via Tailscale: YOUR_TAILSCALE_IP)
#   - ANTHROPIC_API_KEY and SLACK_WEBHOOK_URL set in environment or prompted
#   - GitHub deploy key or HTTPS credentials configured on ABADDON for the VIRGIL repo

set -euo pipefail

ABADDON="${ABADDON:-YOUR_CONTROL_NODE_IP}"
ABADDON_USER="${ABADDON_USER:-your-username}"
VIRGIL_REPO="git@github.com:Morpheus6669/VIRGIL.git"
REMOTE_DIR="${REMOTE_DIR:-$HOME/VIRGIL}"

# ── Collect secrets (don't hardcode them here) ────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    read -rsp "ANTHROPIC_API_KEY: " ANTHROPIC_API_KEY
    echo
fi

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
    read -rsp "SLACK_WEBHOOK_URL: " SLACK_WEBHOOK_URL
    echo
fi

echo "==> Deploying VIRGIL to $ABADDON_USER@$ABADDON:$REMOTE_DIR"
echo "    Repo: $VIRGIL_REPO"
echo

# ── Build env header with properly shell-quoted values ───────────────────────
# printf '%q' produces a shell-escaped version safe to embed in any POSIX shell.
# This is prepended to the remote script before piping — no -t flag, no SSH
# positional VAR=value args (both are fragile with special characters).
ENV_HEADER=$(cat <<EOF
export ANTHROPIC_API_KEY=$(printf '%q' "$ANTHROPIC_API_KEY")
export SLACK_WEBHOOK_URL=$(printf '%q' "$SLACK_WEBHOOK_URL")
export VIRGIL_REPO=$(printf '%q' "$VIRGIL_REPO")
export REMOTE_DIR=$(printf '%q' "$REMOTE_DIR")
EOF
)

# ── Stream env header + remote script into bash over SSH ─────────────────────
# No -t: pseudo-TTY allocation breaks heredoc stdin piping (TTY wins over pipe).
# Remote script uses single-quoted 'REMOTE_SCRIPT' so no local expansion occurs.
{
    echo "$ENV_HEADER"
    cat <<'REMOTE_SCRIPT'

set -euo pipefail

echo "==> [ABADDON] Starting VIRGIL deployment"

# ── 1. Ensure parent directory exists ────────────────────────────────────────
mkdir -p "$(dirname "$REMOTE_DIR")"

# ── 2. Clone or update repo ───────────────────────────────────────────────────
if [ -d "$REMOTE_DIR/.git" ]; then
    echo "==> [ABADDON] Repo exists — pulling latest"
    git -C "$REMOTE_DIR" pull
else
    echo "==> [ABADDON] Cloning $VIRGIL_REPO"
    git clone "$VIRGIL_REPO" "$REMOTE_DIR"
fi

# ── 3. Make hooks and scripts executable ─────────────────────────────────────
echo "==> [ABADDON] Setting hook permissions"
chmod +x "$REMOTE_DIR/hooks/"*.sh
chmod +x "$REMOTE_DIR/scripts/"*.sh 2>/dev/null || true

# ── 4. Create runtime directories ────────────────────────────────────────────
mkdir -p "$REMOTE_DIR/daily-logs"
mkdir -p "$REMOTE_DIR/weekly-summaries"

# ── 5. Install Claude Code if not present ─────────────────────────────────────
if command -v claude >/dev/null 2>&1; then
    echo "==> [ABADDON] Claude Code already installed"
else
    echo "==> [ABADDON] Installing Claude Code via npm"
    # Use npm (available on ABADDON via Node). Avoids the install.sh | sh pattern
    # which can fail if the installer has bash-specific syntax.
    if command -v npm >/dev/null 2>&1; then
        npm install -g @anthropic-ai/claude-code
    else
        echo "WARNING: npm not found. Install Node.js first, then run: npm install -g @anthropic-ai/claude-code"
        echo "         Or after install: curl -fsSL https://claude.ai/install.sh | bash"
    fi
    export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
    if command -v claude >/dev/null 2>&1; then
        echo "==> [ABADDON] Claude Code installed successfully"
    else
        echo "WARNING: claude not in PATH. You may need: export PATH=\$HOME/.local/bin:\$PATH"
    fi
fi

# ── 6. Register Claude Code hooks in ~/.claude/settings.json ─────────────────
SETTINGS_DIR="$HOME/.claude"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"
mkdir -p "$SETTINGS_DIR"

if [ -f "$SETTINGS_FILE" ]; then
    echo "==> [ABADDON] $SETTINGS_FILE exists — skipping (review manually)"
    echo "    Hooks should reference: $REMOTE_DIR/hooks/session-{start,end}.sh"
else
    echo "==> [ABADDON] Writing $SETTINGS_FILE"
    cat > "$SETTINGS_FILE" <<SETTINGS_EOF
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "${REMOTE_DIR}/hooks/session-end.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "${REMOTE_DIR}/hooks/session-start.sh"
          }
        ]
      }
    ]
  }
}
SETTINGS_EOF
fi

# ── 7. Register cron jobs (preserve non-VIRGIL entries) ──────────────────────
echo "==> [ABADDON] Configuring crontab"
EXISTING=$(crontab -l 2>/dev/null | grep -v 'weekly-rollup\|promote\.sh\|ANTHROPIC_API_KEY\|SLACK_WEBHOOK_URL' || true)

crontab - <<CRON_EOF
ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"
SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL"
0 1 * * 0 ${REMOTE_DIR}/hooks/weekly-rollup.sh >> ${REMOTE_DIR}/hooks/weekly-rollup.log 2>&1
0 2 * * * ${REMOTE_DIR}/hooks/promote.sh >> ${REMOTE_DIR}/hooks/promote.log 2>&1
${EXISTING}
CRON_EOF

echo "==> [ABADDON] Crontab registered:"
crontab -l

# ── 8. Smoke test ─────────────────────────────────────────────────────────────
echo
echo "==> [ABADDON] Smoke test"
printf "  git:          "; git --version
printf "  python3:      "; python3 --version
printf "  curl:         "; curl --version | head -1
printf "  claude:       "; command -v claude >/dev/null 2>&1 && echo "installed" || echo "not found (install manually)"
printf "  promote.sh:   "; test -x "${REMOTE_DIR}/hooks/promote.sh"          && echo "executable" || echo "MISSING"
printf "  rollup.sh:    "; test -x "${REMOTE_DIR}/hooks/weekly-rollup.sh"    && echo "executable" || echo "MISSING"
printf "  VIRGIL dir:   "; ls "${REMOTE_DIR}" | tr '\n' ' '; echo

echo
echo "==> [ABADDON] Deployment complete."
echo "    First-time setup: run 'claude' and authenticate, then test with:"
echo "    ANTHROPIC_API_KEY=\$ANTHROPIC_API_KEY bash ${REMOTE_DIR}/hooks/promote.sh"

REMOTE_SCRIPT
} | ssh "$ABADDON_USER@$ABADDON" bash

echo
echo "==> Deploy finished. ABADDON is now running VIRGIL."
