# VIRGIL — Docker Setup

Docker lets you run VIRGIL without modifying your system: no pip installs, no cron entries, no shell aliases. Your notes are stored in a folder on your host machine and mounted into the container.

## Quickstart

```bash
# 1. Clone the repo
git clone https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain.git
cd VIRGIL-Second-Brain

# 2. Create your .env file
cp .env.example .env
nano .env   # set ANTHROPIC_API_KEY (required) and SLACK_WEBHOOK_URL (optional)

# 3. Start the container
docker-compose up -d

# 4. Drop into an interactive shell
docker-compose exec virgil bash
```

Your vault (notes, logs, daily digests) is stored in `./vault/` on your host machine. You can point Obsidian at that folder from outside the container.

---

## What lives where

| Location | Description |
|----------|-------------|
| `./vault/` (host) | Your notes — CVEs, feeds, knowledge base |
| `/vault/` (container) | Same folder, mounted inside the container |
| `/virgil/` (container) | VIRGIL scripts (read-only copy from the image) |
| `.env` (host) | API keys and config — never committed to git |

---

## Common commands

```bash
# Run today's RSS digest
docker-compose exec virgil python3 /virgil/ingest/rss-ingest.py

# Ingest a recent CVE
docker-compose exec virgil python3 /virgil/ingest/cve-ingest.py --recent

# Ingest a specific CVE
docker-compose exec virgil python3 /virgil/ingest/cve-ingest.py CVE-2024-1234

# Ingest a URL
docker-compose exec virgil bash /virgil/ingest/url-ingest.sh https://attack.mitre.org/techniques/T1059/

# Run a cert ingest (transcript)
docker-compose exec virgil bash /virgil/ingest/cert-ingest.sh transcript /vault/my-notes.txt "CCNA"

# View logs
docker-compose logs -f virgil
cat ./vault/logs/rss.log

# Stop
docker-compose down
```

---

## Single container (without docker-compose)

```bash
docker run -it \
  -e ANTHROPIC_API_KEY="sk-ant-your-key" \
  -e VIRGIL_DIR="/vault" \
  -v "$(pwd)/vault":/vault \
  ghcr.io/blueteambardiel/virgil-second-brain:latest \
  bash
```

---

## Build from source

```bash
docker build -t virgil .
docker run -it \
  -e ANTHROPIC_API_KEY="sk-ant-your-key" \
  -e VIRGIL_DIR="/vault" \
  -v "$(pwd)/vault":/vault \
  virgil bash
```

---

## Scheduled ingest with cron inside the container

The container includes `cron`. To enable scheduled ingest, uncomment the crontab entries in `scripts/docker-entrypoint.sh` or add your own inside the container:

```bash
docker-compose exec virgil bash
crontab -e
# Add: 0 6 * * * python3 /virgil/ingest/rss-ingest.py >> /vault/logs/rss.log 2>&1
```

---

## Using Ollama with Docker

To use a local Ollama instance instead of (or alongside) the Anthropic API:

```bash
# In your .env:
VIRGIL_PRIMARY_OLLAMA_URL=http://host.docker.internal:11434
VIRGIL_PRIMARY_MODEL=llama3.2
VIRGIL_LLM_BACKEND=primary
```

`host.docker.internal` resolves to your host machine from inside the container on Linux (with `--add-host=host.docker.internal:host-gateway`) and macOS/Windows Docker Desktop natively.

---

## Notes

- **Claude Code is not available inside the container.** The container is for running ingest pipelines, not interactive study sessions. For study sessions (`/secplus`, `/teach`, etc.), run `claude` in your vault directory on the host.
- **Your vault is just files.** The container writes plain markdown to `/vault/`. If you stop or delete the container, your notes stay on the host in `./vault/`.
- **No data leaves your machine** unless you configure `ANTHROPIC_API_KEY` (API calls to Anthropic) or `SLACK_WEBHOOK_URL` (Slack notifications).
