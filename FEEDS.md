# VIRGIL — RSS Feed List

The 22 RSS sources `ingest/rss-ingest.py` pulls each morning. Entries from the last 24 hours are deduplicated and synthesized by the configured LLM (Ollama or Anthropic API, per `VIRGIL_BACKEND`) into one daily digest at `~/VIRGIL/notes/feeds/YYYY-MM-DD.md`.

To add a feed, append a row to the appropriate table below — the script reads the feed names from this file at runtime. To remove a feed, delete the row.

---

## Threat Intelligence & News

| Source | Category | What it covers |
|---|---|---|
| The Hacker News | Threat Intel | Breaking infosec news, APT campaigns, malware |
| Krebs on Security | Threat Intel | Deep-dive investigations, cybercrime, fraud |
| Bleeping Computer | Threat Intel | Ransomware, vulnerability disclosures, breach news |
| Schneier on Security | Analysis | Policy, cryptography, security fundamentals |
| Dark Reading | Industry | Enterprise security, SOC operations, vendor news |
| SecurityWeek | Industry | ICS/OT security, conferences, M&A |
| Threatpost | Threat Intel | Exploits, malware campaigns, patch Tuesday coverage |
| Malwarebytes Labs | Malware | Malware analysis, threat actor tracking |
| Troy Hunt | Privacy/Breaches | Breach investigations, Have I Been Pwned data |
| InfoSecurity Magazine | Industry | Compliance, risk management, CISO perspective |
| PortSwigger Daily Swig | AppSec | Web vulnerabilities, bug bounty, AppSec research |

## Vulnerability & Advisories

| Source | Category | What it covers |
|---|---|---|
| CISA Advisories | Official | ICS-CERT advisories, KEV additions, joint advisories |
| SANS ISC | Vulnerability | Diary entries, handler analysis, exploit traffic |
| Google Project Zero | Research | Zero-day research, exploitation techniques, patch analysis |

## Wired / Mainstream

| Source | Category | What it covers |
|---|---|---|
| Wired Security | Mainstream | Long-form investigations, policy, nation-state coverage |
| Ars Technica Security | Mainstream | Technical depth, vulnerability write-ups, privacy |

## Community & Homelab

| Source | Category | What it covers |
|---|---|---|
| r/netsec | Community | Practitioner discussion, tool releases, writeups |
| r/homelab | Community | Lab builds, hardware, self-hosted infrastructure |
| r/sysadmin | Community | Ops war stories, tooling, enterprise admin |
| r/blueteamsec | Community | Defensive research, detection rules, IR |

## Tools & Open Source

| Source | Category | What it covers |
|---|---|---|
| GitHub Security Lab | Research | CVE disclosures from GitHub's security team |
| CISA Known Exploited Vulnerabilities | Official | The KEV catalog — CVEs with confirmed active exploitation |

---

## Digest format

Each `notes/feeds/YYYY-MM-DD.md` is structured into sections — top stories, CVE highlights, mainstream coverage, community items, quick hits. The exact section headings live in the synthesis prompt inside `ingest/rss-ingest.py`. Edit the prompt to retune the sections.

Items that don't clear the relevance threshold are dropped. The digest is sized for a five-minute morning read, not a comprehensive log.

---

## Related ingest

CVE notes come from a separate pipeline — `ingest/cve-ingest.py` pulls from the NVD API. See [ingest/README.md](ingest/README.md) and [ARCHITECTURE.md §8.2](ARCHITECTURE.md#82-cve-ingest).
