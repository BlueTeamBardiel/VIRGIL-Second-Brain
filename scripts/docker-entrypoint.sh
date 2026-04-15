#!/usr/bin/env bash
# docker-entrypoint.sh — VIRGIL container startup
# Scaffolds the vault on first run, then executes CMD (default: bash)

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-/vault}"
VIRGIL_SRC="/virgil"

# ── First-run scaffold ────────────────────────────────────────────────────────
if [[ ! -f "$VIRGIL_DIR/.virgil-installed" ]]; then
    echo ""
    echo "  VIRGIL — first-run setup (container)"
    echo ""

    # Create vault structure
    mkdir -p \
        "$VIRGIL_DIR/notes/inbox" \
        "$VIRGIL_DIR/notes/archive" \
        "$VIRGIL_DIR/notes/mitre" \
        "$VIRGIL_DIR/notes/cve" \
        "$VIRGIL_DIR/notes/feeds" \
        "$VIRGIL_DIR/notes/knowledge/security" \
        "$VIRGIL_DIR/notes/knowledge/networking" \
        "$VIRGIL_DIR/notes/knowledge/nist" \
        "$VIRGIL_DIR/notes/personal/workouts" \
        "$VIRGIL_DIR/notes/personal/study" \
        "$VIRGIL_DIR/notes/personal/nutrition" \
        "$VIRGIL_DIR/daily-logs" \
        "$VIRGIL_DIR/weekly-summaries" \
        "$VIRGIL_DIR/logs"

    # Copy starter notes (no-clobber)
    if [[ -d "$VIRGIL_SRC/starter-notes" ]]; then
        cp -rn "$VIRGIL_SRC/starter-notes/." "$VIRGIL_DIR/notes/" 2>/dev/null || true
    fi
    [[ -f "$VIRGIL_SRC/GETTING-STARTED.md" ]] && \
        cp -n "$VIRGIL_SRC/GETTING-STARTED.md" "$VIRGIL_DIR/" 2>/dev/null || true

    # Write CLAUDE.md
    cat > "$VIRGIL_DIR/CLAUDE.md" << CLAUDEEOF
# VIRGIL — Claude Code Configuration (Docker)

## Memory Files
- @memory-working.md — active pending tasks (cleared weekly)
- @memory-episodic.md — session history, promoted facts, completed work
- @memory-semantic.md — permanent facts: fleet, certs, architecture, key decisions

## Key Paths
- Vault: $VIRGIL_DIR/
- Ingest scripts: $VIRGIL_SRC/ingest/
- Hooks: $VIRGIL_SRC/hooks/
- Notes: $VIRGIL_DIR/notes/
- Daily logs: $VIRGIL_DIR/daily-logs/

## Conventions
- [[wiki links]] for all lab hosts, tools, protocols, concepts
- Run /reflect at end of each session
- Run /week on Fridays or Sundays for weekly digest

## Environment
- Container: $(hostname)
- Track: ${VIRGIL_TRACK:-both}
- Started: $(date '+%Y-%m-%d')
CLAUDEEOF

    # Starter memory files
    for mf in memory-working.md memory-episodic.md memory-semantic.md; do
        if [[ ! -f "$VIRGIL_DIR/$mf" ]]; then
            printf "# %s\n\n_Created in VIRGIL container on %s_\n\n---\n\n" \
                "$mf" "$(date '+%Y-%m-%d')" > "$VIRGIL_DIR/$mf"
        fi
    done

    # Write .env if key is set and .env doesn't exist
    if [[ -n "${ANTHROPIC_API_KEY:-}" && ! -f "$VIRGIL_DIR/.env" ]]; then
        {
            echo "# VIRGIL — generated in container $(date '+%Y-%m-%d %H:%M')"
            echo "ANTHROPIC_API_KEY=\"${ANTHROPIC_API_KEY}\""
            [[ -n "${SLACK_WEBHOOK_URL:-}" ]] && echo "SLACK_WEBHOOK_URL=\"${SLACK_WEBHOOK_URL}\""
            echo "VIRGIL_DIR=\"$VIRGIL_DIR\""
            echo "VIRGIL_TRACK=\"${VIRGIL_TRACK:-both}\""
        } > "$VIRGIL_DIR/.env"
        chmod 600 "$VIRGIL_DIR/.env"
    fi

    # Mark installed
    date '+%Y-%m-%dT%H:%M:%S' > "$VIRGIL_DIR/.virgil-installed"
    echo "  ✓ Vault scaffolded at $VIRGIL_DIR"
    echo ""
fi

# ── Start cron daemon (background) if schedules exist ────────────────────────
if [[ -f "$VIRGIL_DIR/.virgil-crontab" ]]; then
    crontab "$VIRGIL_DIR/.virgil-crontab"
    service cron start > /dev/null 2>&1 || true
fi

# ── Export VIRGIL_DIR for child processes ─────────────────────────────────────
export VIRGIL_DIR
export PATH="$VIRGIL_SRC/scripts:$VIRGIL_SRC/ingest:$VIRGIL_SRC/hooks:$PATH"

# ── Execute CMD ───────────────────────────────────────────────────────────────
exec "$@"
