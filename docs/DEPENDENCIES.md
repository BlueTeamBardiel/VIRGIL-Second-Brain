# VIRGIL — Dependency Reference

All required and optional dependencies for VIRGIL. Run `scripts/check-deps.sh` to verify your system.

---

## Required (core functionality)

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| `bash` | 4.0+ | All shell scripts | Pre-installed on Linux/macOS |
| `python3` | 3.9+ | RSS ingest, CVE ingest, quiz, progress | `sudo apt install python3` |
| `pip3` / `pip` | any | Python package management | `sudo apt install python3-pip` |
| `curl` | any | URL fetch, API calls, installer | `sudo apt install curl` |
| `git` | any | Repo clone, version tracking | `sudo apt install git` |

---

## Required Python packages

| Package | Version | Purpose | Install |
|---------|---------|---------|---------|
| `feedparser` | 6.0+ | RSS feed parsing | `pip3 install feedparser` |
| `requests` | 2.28+ | HTTP requests in rss-ingest.py | `pip3 install requests` |

---

## Required: Claude Code

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| `claude` (Claude Code) | latest | Interactive study sessions, slash commands | `npm install -g @anthropic-ai/claude-code` |
| `node` / `npm` | 18+ | Required for Claude Code | https://nodejs.org |

---

## Optional (recommended)

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| `pandoc` | any | URL and HTML → markdown conversion | `sudo apt install pandoc` |
| `pdftotext` (poppler) | any | PDF text extraction for cert ingest | `sudo apt install poppler-utils` |
| `sha256sum` | any | Installer checksum verification | Pre-installed (GNU coreutils) |
| `cron` / `crontab` | any | Scheduled ingest automation | `sudo apt install cron` |
| `Obsidian` | 1.5+ | Vault viewer and knowledge graph | https://obsidian.md |

---

## Optional: Local inference (avoids API costs)

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| `ollama` | 0.2+ | Local LLM inference | https://ollama.com |
| `llama3.2` (model) | — | Default primary model (requires 4 GB RAM) | `ollama pull llama3.2` |
| `qwen2.5:14b` (model) | — | Higher quality (requires 16 GB RAM) | `ollama pull qwen2.5:14b` |

---

## Optional: RAG / vector search

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| `chromadb` | 0.4+ | Vector search over vault notes | `pip3 install chromadb` |
| `nomic-embed-text` (model) | — | Embedding model for ChromaDB | `ollama pull nomic-embed-text` |

---

## Optional: Notifications

| Tool | Version | Purpose |
|------|---------|---------|
| Slack webhook URL | — | Pipeline notifications (set `SLACK_WEBHOOK_URL` in `.env`) |

---

## Environment variables

| Variable | Required | Default | Description |
|----------|---------|---------|-------------|
| `ANTHROPIC_API_KEY` | No* | — | Anthropic API key for cloud LLM calls |
| `VIRGIL_DIR` | No | `$HOME/VIRGIL` | Path to your vault |
| `VIRGIL_LLM_BACKEND` | No | fallback chain | Force: `primary`, `secondary`, or `anthropic` |
| `VIRGIL_PRIMARY_OLLAMA_URL` | No | `http://localhost:11434` | Primary Ollama endpoint |
| `VIRGIL_SECONDARY_OLLAMA_URL` | No | — | Secondary Ollama endpoint (skip if unset) |
| `VIRGIL_PRIMARY_MODEL` | No | `llama3.2` | Model for primary Ollama |
| `VIRGIL_SECONDARY_MODEL` | No | `qwen2.5:14b` | Model for secondary Ollama |
| `SLACK_WEBHOOK_URL` | No | — | Slack webhook for pipeline notifications |

*`ANTHROPIC_API_KEY` is required if you don't have Ollama set up. VIRGIL can run entirely local with Ollama.

---

## Platform support

| Platform | Status | Notes |
|----------|--------|-------|
| Ubuntu 22.04 / 24.04 | ✅ Supported | Primary development platform |
| Debian 12 | ✅ Supported | |
| macOS (Apple Silicon / Intel) | ✅ Supported | Homebrew required for deps |
| Windows WSL2 | ✅ Supported | Obsidian runs on Windows; point it at the WSL vault path |
| Arch Linux | ✅ Supported | `pacman` auto-install in installer |
| Docker | ✅ Supported | See docs/DOCKER.md |
| Raspberry Pi (arm64) | ⚠️ Partial | Ollama unavailable; API key required |
| Native Windows | ❌ Not supported | Use WSL2 |
