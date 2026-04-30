# VIRGIL Private vs VIRGIL Second Brain — Feature Comparison
*Last updated: 2026-04-27*

VIRGIL exists in two forms. The **private install** is a full homelab AI stack tightly integrated with a specific multi-machine lab environment — local GPU inference, fleet management, Ansible/Semaphore automation, and a three-tier LLM fallback chain. The **Second Brain public repo** is the sanitized, general-purpose release: the same knowledge pipeline and automation, stripped of hardware-specific dependencies so anyone can clone it and run it with nothing more than an Anthropic API key and a Linux machine.

If you're starting out, use Second Brain. If you eventually want the full private stack, the migration path is at the bottom of this document.

---

## Feature Comparison

| Feature | VIRGIL (Private) | Second Brain (Public) | Notes |
|---|---|---|---|
| **INGEST** | | | |
| RSS feeds | ✅ 22 feeds | ✅ Configurable | Private has curated security list |
| CVE ingestion | ✅ NVD API v2 | ✅ Same | Identical |
| PDF chunking | ✅ | ✅ | Identical |
| URL ingestion | ✅ | ✅ Fixed | SSRF validation added in public |
| ChatGPT import | ✅ /ingest-chatgpt | 🔜 Pending port | In progress |
| Claude.ai import | ✅ /ingest-chat | 🔜 Pending port | In progress |
| NIST ingestion | ✅ | ✅ | Identical |
| Personal notes | ✅ | ✅ | Identical |
| **LLM STACK** | | | |
| Local inference | ✅ gpt-oss:20b (GPU) | ❌ API only | Requires Ollama + GPU |
| Three-tier fallback | ✅ Local→Backup→API | ⚠️ Single API | Private multi-node |
| GPU acceleration | ✅ RX 9070 XT | ❌ | Hardware-specific |
| OpenWebUI | ✅ Port 3000 | ❌ | Private only |
| RAG/ChromaDB | ✅ 7868 chunks | ✅ | Both support RAG |
| **MEMORY** | | | |
| Structured memory tree | ✅ facts/decisions/lessons/questions | ✅ | Identical |
| Auto-reflect | ✅ 23:55 cron | ✅ | Identical |
| Promote pipeline | ✅ | ✅ | Identical |
| Weekly rollup | ✅ | ✅ | Identical |
| Quiz system | ✅ virgil-quiz | ✅ | Identical |
| Session tracking | ✅ Claude Code hooks | ✅ | Identical |
| **AUTOMATION** | | | |
| Slack approval gate | ✅ Socket Mode bot | ✅ | Identical |
| Nightly cron | ✅ | ✅ | Identical |
| USB backup | ✅ Nebuchadnezzar | ⚠️ Generic path | Public uses env vars |
| Config backup | ✅ Ansible | ❌ | Private only (homelab) |
| Semaphore/Ansible | ✅ Fleet mgmt | ❌ | Private only |
| **SECURITY** | | | |
| Secret management | ✅ .env + chmod 600 | ✅ .env | Both fixed |
| Crontab eval removed | ✅ Batch 3 | 🔜 Partial | Public still has some |
| Pre-commit scanning | 🔜 Planned | 🔜 Planned | Neither yet |
| Audit completed | ✅ 4-source audit | ✅ 4-source audit | Both audited |
| Known vulns patched | ✅ 14 fixed | ✅ 4 fixed this commit | Private more complete |
| **SETUP** | | | |
| One-line install | ⚠️ deploy-machine.sh | ⚠️ Manual steps | Both need improvement |
| Docker support | ❌ | ✅ | Public has Docker |
| Hardware requirements | High (GPU recommended) | Low (API only) | Public more accessible |
| Technical skill | Expert | Intermediate | Public easier |
| Estimated setup time | 4–8 hours | 2–3 hours | Public faster |
| **TARGET** | | | |
| Who it's for | One specific operator | Any security learner | Different audiences |
| Use case | Full homelab AI stack | Study automation | Different scope |
| Support | Self-supported | Community/GitHub | Different model |

---

## Architecture Comparison

```
PRIVATE VIRGIL                        SECOND BRAIN (PUBLIC)
─────────────────────────────         ─────────────────────────────
 YOUR-GPU-HOST (primary inference host)           Your machine
  ├── Ollama (gpt-oss:20b)              ├── Anthropic API (Claude Haiku)
  ├── OpenWebUI                         └── Obsidian vault
  └── ChromaDB RAG (:5000)
         ↕ Tailscale mesh             crontab → ingest → vault
 YOUR-BACKUP-HOST (backup + Slack bot)
  ├── Ollama (qwen2.5:14b)
  └── Slack approval gate
         ↕
 Fleet (your other machines)
  └── Ansible/Semaphore
```

The private stack has three LLM tiers: local GPU on the primary host → local GPU on the backup host → Anthropic API. A query never hits the API if either local node is up. The public version is API-only — simpler to run, higher per-query cost.

---

## Security Posture Comparison

**Private VIRGIL** has had four batches of security fixes applied: eval+crontab injection removed from nine files, secrets migrated to a permissions-locked `.env`, several race conditions and path injection vectors closed. It's materially more hardened than the public release.

**Second Brain** received four fixes in this commit (sanitization leaks, dependency pinning, URL validation, eval removal from url-ingest). The eval+crontab pattern still exists in some shell scripts (triage-inbox.sh, quiz-ingest.sh, nist-ingest.sh, pdf-ingest.sh) — these are on the fix backlog. The ChromaDB bridge, if enabled, has no authentication layer.

Honest verdict: both are homelab-grade security. Neither is production-hardened. The private install is ahead of the public release by roughly four months of security work.

---

## Target Audience

**Use Second Brain if:**
- You're learning security, studying for a cert, or building your first homelab
- You want automation without a dedicated GPU machine
- You're comfortable with Python and bash but don't want to manage a fleet

**Use private VIRGIL if:**
- You have a Linux machine with a discrete GPU you can dedicate to inference
- You want to reduce API costs by running local models
- You're comfortable with Tailscale, Ansible, and multi-host configuration
- You want full Slack approval gates for every automation action

---

## Migration Path

Going from Second Brain to a private VIRGIL-style stack:

1. **Local inference** — install Ollama on a Linux host with a GPU, pull your model of choice (`ollama pull <model>`)
2. **Three-tier fallback** — copy `hooks/llm-client.sh` and `hooks/llm_client.py` from private repo, configure `PRIMARY_OLLAMA_URL` and `BACKUP_OLLAMA_URL` for your hosts
3. **Tailscale mesh** — connect your machines (`tailscale up`), use MagicDNS hostnames instead of IPs
4. **Fleet deployment** — use `scripts/deploy-machine.sh` to push VIRGIL to additional hosts
5. **Slack approval gate** — deploy the Flask bot on your backup node, wire it into `hooks/virgil-approve.sh`
6. **OpenWebUI** — deploy via Docker, configure the ChromaDB RAG pipeline

Each step is independent — you can add them incrementally.

---

## Features Pending Port to Second Brain

These exist in private VIRGIL but haven't been released publicly yet:

- ChatGPT export ingestion (`/ingest-chatgpt` + `ingest/chatgpt-ingest.sh`)
- Claude.ai conversation ingestion (`/ingest-chat`)
- Three-tier LLM fallback documentation and setup guide
- `virgil-chat` headless alias for non-Claude Code usage
- `virgil-pause` / `virgil-resume` VRAM management aliases
- OpenWebUI pipeline setup guide
- ChromaDB RAG advanced setup and bridge configuration
- `VIRGIL_SAFE_MODE` env var for safety interlocks (Gemini suggestion)
- Spaced repetition system (highest ROI feature per audit)
- Mobile capture bridge (Telegram or Discord bot)
