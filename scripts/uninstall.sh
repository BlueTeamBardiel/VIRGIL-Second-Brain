#!/bin/bash
# uninstall.sh — Remove VIRGIL Second Brain
# Usage: bash scripts/uninstall.sh

set -euo pipefail

RED='\033[0;31m'
YEL='\033[1;33m'
GRN='\033[0;32m'
RST='\033[0m'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  VIRGIL Second Brain — Uninstaller"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
SHELL_RC=""
if [[ -f "$HOME/.zshrc" ]]; then SHELL_RC="$HOME/.zshrc"
elif [[ -f "$HOME/.bashrc" ]]; then SHELL_RC="$HOME/.bashrc"
fi

echo -e "${YEL}This will remove:${RST}"
echo "  - VIRGIL cron jobs"
echo "  - VIRGIL shell aliases from $SHELL_RC"
echo "  - VIRGIL config at ~/.config/virgil/"
echo ""
echo -e "${RED}The following will NOT be removed unless you choose:${RST}"
echo "  - Your vault at $VIRGIL_DIR (contains your notes)"
echo ""
read -rp "Continue? (y/N): " confirm </dev/tty
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }

# Remove cron jobs
echo "Removing cron jobs..."
if command -v crontab &>/dev/null; then
    crontab -l 2>/dev/null \
        | grep -v "VIRGIL\|virgil\|rss-ingest\|cve-ingest\|auto-reflect\|promote\.sh\|weekly-rollup\|BASH_ENV.*VIRGIL" \
        | crontab - || true
    echo "  ✓ Cron jobs removed"
else
    echo "  crontab not available — skipping"
fi

# Remove shell aliases
if [[ -n "$SHELL_RC" ]] && grep -q "VIRGIL" "$SHELL_RC" 2>/dev/null; then
    echo "Removing shell aliases from $SHELL_RC..."
    # Remove the VIRGIL alias block (from comment to end comment)
    python3 - "$SHELL_RC" <<'PYEOF'
import sys, re
path = sys.argv[1]
text = open(path).read()
text = re.sub(
    r'\n# ── VIRGIL aliases.*?# ── end VIRGIL ─+\n?',
    '\n',
    text,
    flags=re.DOTALL
)
open(path, 'w').write(text)
print(f"  ✓ Aliases removed from {path}")
PYEOF
else
    echo "  No VIRGIL aliases found in shell config — skipping"
fi

# Remove config
if [[ -d "$HOME/.config/virgil" ]]; then
    echo "Removing config..."
    rm -rf "$HOME/.config/virgil"
    echo "  ✓ Config removed"
fi

# Ask about vault
echo ""
echo -e "${YEL}Your vault at $VIRGIL_DIR contains all your notes.${RST}"
read -rp "Delete vault? This will permanently delete all your notes. (y/N): " delete_vault </dev/tty
if [[ "$delete_vault" =~ ^[Yy]$ ]]; then
    echo "Deleting vault..."
    rm -rf "$VIRGIL_DIR"
    echo "  ✓ Vault deleted"
else
    echo "  Vault preserved at $VIRGIL_DIR"
fi

echo ""
echo -e "${GRN}VIRGIL uninstalled.${RST}"
if [[ -n "$SHELL_RC" ]]; then
    echo "Reload your shell: source $SHELL_RC"
fi
echo ""
