# VIRGIL — Ingest Sources

Everything VIRGIL ingests automatically, every day.

---

## RSS Feeds — 22 Sources

Processed nightly by `ingest/rss-ingest.py`. Entries from the last 24 hours are collected, deduplicated, and synthesized by Claude Haiku into a structured daily digest at `notes/feeds/YYYY-MM-DD.md`.

### Threat Intelligence & News

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

### Vulnerability & Advisories

| Source | Category | What it covers |
|---|---|---|
| CISA Advisories | Official | ICS-CERT advisories, KEV additions, joint advisories |
| SANS ISC | Vulnerability | Diary entries, handler analysis, exploit traffic |
| Google Project Zero | Research | Zero-day research, exploitation techniques, patch analysis |

### Wired / Mainstream

| Source | Category | What it covers |
|---|---|---|
| Wired Security | Mainstream | Long-form investigations, policy, nation-state coverage |
| Ars Technica Security | Mainstream | Technical depth, vulnerability write-ups, privacy |

### Community & Homelab

| Source | Category | What it covers |
|---|---|---|
| r/netsec | Community | Practitioner discussion, tool releases, writeups |
| r/homelab | Community | Lab builds, hardware, self-hosted infrastructure |
| r/sysadmin | Community | Ops war stories, tooling, enterprise admin |
| r/blueteamsec | Community | Defensive research, detection rules, IR |

### Tools & Open Source

| Source | Category | What it covers |
|---|---|---|
| GitHub Security Lab | Research | CVE disclosures from GitHub's security team |
| CISA Known Exploited Vulnerabilities | Official | The KEV catalog — CVEs with confirmed active exploitation |

---

## CVE Ingestion — NVD API v2

Processed by `ingest/cve-ingest.py`.

| Property | Detail |
|---|---|
| Source | NIST National Vulnerability Database (NVD) API v2 |
| Default mode | `--recent --days 1` — last 24 hours of CVEs |
| Output | One note per CVE: `notes/cve/CVE-YYYY-NNNNN.md` |
| Volume | ~40–60 CVEs per day depending on disclosure activity |
| Content | CVSS v3 score + vector, description, affected products, ATT&CK technique mapping where applicable, reference links |
| Wikilinks | Auto-linked to relevant ATT&CK technique notes on ingestion |

Usage:
```bash
virgil-cve --recent           # last 24h
virgil-cve CVE-2024-12345     # specific CVE
virgil-cve --keyword log4j    # keyword search
```

---

## PDF Sources

Processed by `ingest/pdf-ingest.sh`. Documents over ~80,000 characters are auto-chunked into multiple notes.

| Document | Notes created | Location in vault |
|---|---|---|
| CCNA 200-301 Official Cert Guide Volume 1 | 29 chunks | `notes/knowledge/networking/` |
| CCNA 200-301 Official Cert Guide Volume 2 | 27 chunks | `notes/knowledge/networking/` |
| CompTIA Security+ Study Guide | chunked | `notes/knowledge/security/` |
| CySA+ CS0-003 Study Guide | chunked | `notes/knowledge/security/` |
| NIST SP 800-53 Rev 5 | chunked | `notes/knowledge/nist/` |

Add any PDF to the vault:
```bash
virgil-pdf /path/to/document.pdf
virgil-pdf /path/to/large-textbook.pdf --first-pages 50   # preview chunk
```

---

## MITRE ATT&CK Coverage

Ingested via `ingest/url-ingest.sh` — any ATT&CK URL is auto-routed to `notes/mitre/`.

Current coverage includes all major Enterprise technique categories:

| Category | Example techniques |
|---|---|
| Initial Access | T1190 Exploit Public-Facing Application, T1195 Supply Chain Compromise, T1199 Trusted Relationship |
| Execution | T1059 Command and Scripting Interpreter (PowerShell, cmd.exe), T1053 Scheduled Task |
| Persistence | T1098 Account Manipulation, T1112 Modify Registry |
| Privilege Escalation | T1055 Process Injection |
| Defense Evasion | T1497 Virtualization/Sandbox Evasion, T1218 System Binary Proxy Execution |
| Discovery | T1057 Process Discovery, T1069 Permission Groups, T1082 System Info, T1083 File/Dir Discovery, T1087 Account Discovery, T1201 Password Policy |
| Impact | T1486 Data Encrypted for Impact, T1489 Service Stop, T1490 Inhibit System Recovery, T1491 Defacement, T1496 Resource Hijacking, T1498 Network DoS, T1499 Endpoint DoS |

Plus major threat actors (APT28, APT29/Cozy Bear, APT41, Lazarus Group) and tools (Cobalt Strike, BloodHound, PsExec, Emotet, Ryuk).

Add any ATT&CK page:
```bash
virgil-url https://attack.mitre.org/techniques/T1059/001/
virgil-url https://attack.mitre.org/groups/G0016/
```

---

## Daily Digest Format

Each `notes/feeds/YYYY-MM-DD.md` is structured by Claude Haiku into:

```
## Top Stories
(2-3 most significant items across all feeds)

## CVE Watch
(Notable vulnerabilities from CISA/NVD/advisories)

## Homelab & Tooling
(r/homelab, r/sysadmin, GitHub Security Lab)

## CySA+ Relevant
(Items that map to CySA+ exam domains)

## Quick Hits
(Remaining items worth noting)
```

Items that don't pass relevance threshold are dropped. The digest is optimized for a 5-minute morning read.
