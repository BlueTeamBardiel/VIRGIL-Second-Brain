# memory-semantic.md

Permanent facts about your setup and study progress. Update this manually when something changes. VIRGIL reads this during `/reflect` and `/week` to give you context-aware responses.

---

## Lab Setup

- **Primary server**: Desktop workstation, 24 cores, 30GB RAM — runs Ollama, Docker, primary VIRGIL pipelines
- **Backup node**: Secondary machine, 8 cores, 16GB RAM — runs Slack bot, backup Ollama inference
- **Network**: All homelab traffic on dedicated VLAN; management interfaces not exposed to untrusted networks
- **SIEM**: Wazuh deployed on primary server, ingesting auth logs from all nodes
- **IDS**: Suricata on network gateway, ET Open ruleset + custom rules for lab traffic
- **Monitoring**: Grafana dashboards for system metrics; alerting wired to Slack

## AI Stack

- **Primary inference**: Ollama on primary server — `qwen2.5:14b` for enrichment tasks
- **Fallback inference**: Ollama on backup node — same model
- **Cloud fallback**: Anthropic API (Claude) — only used when both local nodes are down
- **Approval gate**: All AI pipeline writes go through Slack approve/deny before touching the vault

## Certs in Progress

- **CompTIA Security+ SY0-701** — target exam date: 2026-01-15
  - Current focus: Domain 2 (Threats, Vulnerabilities, Mitigations)
  - Strong areas: network attacks, malware taxonomy, cryptography basics
  - Weak areas: PKI implementation details, wireless security protocols
- **CompTIA CySA+ CS0-003** — after Security+
  - Pre-reading ongoing via VIRGIL knowledge notes

## Study Approach

- Feynman sessions via `/cysa` — explain concept, VIRGIL finds the gap, repeat until solid
- 1h study minimum per session; log in daily-logs after
- Link every concept studied to at least one CVE note in the vault
- Weekly review via `/week` on Sundays — identify what's not sticking

## Homelab Goals

- Get Wazuh correlation rules tuned before Security+ exam (so I can explain SIEM queries in interviews)
- Stand up TheHive for incident response practice
- Complete Hack The Box "Starting Point" path — currently: 6/12 machines done

---

## Promoted — 2025-10-31

**Key Decisions:**
- Adopted three-tier LLM fallback: local primary → local backup → Anthropic API
- All pipeline writes require Slack approval — no auto-execute on AI output
- Daily logs are append-only and never touched by automation

**Lessons Learned:**
- Running inference locally on CPU is fast enough for single-document enrichment; GPU is worth it for batch jobs
- Slack Socket Mode avoids the need for a public HTTPS endpoint — preferred for homelab deployments

**Important Facts:**
- VIRGIL vault initialized with 847 notes at time of promotion
- RSS pipeline pulling 22 feeds daily; CVE ingest running at 6am via cron
- Wikilink injection running nightly at 11:30pm

---

## Promoted — 2025-11-12

**Key Decisions:**
- `qwen2.5:14b` selected as primary model after benchmarking — best structured output for VIRGIL's enrichment format
- `llama3.1:8b` rejected for memory promotion (formatting drift too frequent)

**Lessons Learned:**
- Model selection matters for structured tasks: smaller models produce shorter, less consistent notes
- CPU inference on a modern desktop (24 threads) handles 14B model in ~45 seconds — acceptable for background jobs

**Important Facts:**
- LLM client wrapper (`llm-client.sh` / `llm_client.py`) deployed with three-tier fallback
- Slack approval bot running on backup node; all pipeline approvals routed through it
- 12 remaining VIRGIL scripts still calling Anthropic API directly — porting in progress
