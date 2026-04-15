# ─────────────────────────────────────────────────────────────────────────────
# VIRGIL — Second Brain
# https://github.com/Morpheus6669/VIRGIL
#
# Build:
#   docker build -t virgil .
#
# Run:
#   docker run -it \
#     -e ANTHROPIC_API_KEY="sk-ant-..." \
#     -v $(pwd)/vault:/vault \
#     virgil
#
# Or use docker-compose (recommended):
#   cp .env.example .env && nano .env
#   docker-compose up -d
# ─────────────────────────────────────────────────────────────────────────────

FROM python:3.12-slim

LABEL org.opencontainers.image.title="VIRGIL"
LABEL org.opencontainers.image.description="Second brain — threat intel, CVE ingest, knowledge management"
LABEL org.opencontainers.image.source="https://github.com/Morpheus6669/VIRGIL"

# ── System dependencies ───────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        pandoc \
        poppler-utils \
        cron \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ── Python dependencies ───────────────────────────────────────────────────────
RUN pip install --no-cache-dir feedparser requests

# ── VIRGIL scripts ────────────────────────────────────────────────────────────
WORKDIR /virgil

COPY ingest/   /virgil/ingest/
COPY hooks/    /virgil/hooks/
COPY skills/   /virgil/skills/
COPY scripts/  /virgil/scripts/
COPY starter-notes/ /virgil/starter-notes/
COPY GETTING-STARTED.md /virgil/

RUN find /virgil -name "*.sh" -o -name "*.py" | xargs chmod +x

# ── Vault volume ──────────────────────────────────────────────────────────────
# Mount your notes here: -v ./vault:/vault
VOLUME /vault

# ── Environment ───────────────────────────────────────────────────────────────
ENV VIRGIL_DIR=/vault
ENV ANTHROPIC_API_KEY=""
ENV SLACK_WEBHOOK_URL=""
ENV VIRGIL_TRACK="both"
ENV PYTHONUNBUFFERED=1

# ── Cron log directory ────────────────────────────────────────────────────────
RUN mkdir -p /vault/logs /vault/notes/cve /vault/notes/feeds /vault/daily-logs

# ── Entrypoint ────────────────────────────────────────────────────────────────
# Runs install.sh --fast (non-interactive) to scaffold vault, then drops to bash.
# Override CMD to run a specific ingest script directly:
#   docker run virgil python3 /virgil/ingest/rss-ingest.py

COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["bash"]
