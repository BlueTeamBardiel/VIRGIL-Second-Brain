# ingest/

> [[VIRGIL]] knowledge ingestion pipeline — automated scripts for pulling PDFs, threat feeds, CVEs, and personal logs into Obsidian notes

All scripts write to `notes/` subdirectories and optionally notify Slack. The pipeline runs automatically on [[your-control-node]] via cron; scripts can also be run manually via aliases on [[your-workstation]] or YOUR-CONTROL-NODE.

---

## Scripts

### pdf-ingest.sh
**Purpose:** Convert a PDF to a structured Obsidian knowledge note via [[Claude]] API (claude-haiku). Handles large documents by chunking.
**Output:** `notes/knowledge/<subdir>/<slug>.md`

```bash
pdf-ingest.sh [--first-pages N] <path-to-pdf> [output-subdir]

# Examples:
virgil-pdf ~/Desktop/book.pdf networking
virgil-pdf --first-pages 50 ~/Desktop/bigbook.pdf ccna
```

**Chunking behaviour:**
- `< 80k chars` → single API call, max_tokens 4096
- `≥ 80k chars` → split at 60k-char paragraph boundaries, summarise each chunk (max_tokens 2048), synthesise all summaries into final note (max_tokens 8192)
- Progress logged per-chunk: `Chunk N/M — X chars`

**Alias:** `virgil-pdf`
**Log:** `ingest/pdf-ingest.log`

---

### nist-ingest.sh
**Purpose:** NIST-specialised wrapper over the pdf-ingest pattern. Uses a [[CySA+]]-oriented prompt that extracts control families, exam relevance, and actionable blue team takeaways.
**Output:** `notes/knowledge/nist/<slug>.md`

```bash
virgil-nist ~/Downloads/nist-sp-800-53.pdf
```

**Alias:** `virgil-nist`

---

### rss-ingest.py
**Schedule:** `0 6 * * *` — daily at 6:00 AM on [[your-control-node]]
**Purpose:** Fetch 22 threat intel RSS feeds, filter to items from the past 24 hours, call [[Claude]] API to synthesise a structured digest (Top Stories / Homelab / [[CySA+]] / Quick Hits), write to `notes/feeds/`.
**Output:** `notes/feeds/YYYY-MM-DD.md`, Slack

```bash
virgil-rss               # run digest for last 24h
virgil-rss --hours 48    # extend lookback window
virgil-rss --dry-run     # fetch feeds, print item count, no API call
```

**Feeds include:** Krebs on Security, The Hacker News, [[Wazuh]] blog, BleepingComputer, CISA alerts, SANS ISC, Project Zero, r/netsec, r/blueteamsec, and 12 more.
**Alias:** `virgil-rss`
**Log:** `ingest/rss-ingest.log`

---

### cve-ingest.py
**Schedule:** `0 7 * * *` — daily at 7:00 AM on [[your-control-node]] (`--recent` mode)
**Purpose:** Query [[NVD]] API v2 for CVE data. Three modes: specific CVE lookup, recent CVEs by date range, or keyword search. Writes a per-CVE Obsidian note with CVSS score, description, CWE, affected products, and references.
**Output:** `notes/cve/CVE-YYYY-NNNNN.md` (one file per CVE), Slack summary

```bash
virgil-cve CVE-2024-1234              # single lookup
virgil-cve CVE-2024-1234 CVE-2024-5678  # batch lookup
virgil-cve --recent                   # last 24h from NVD
virgil-cve --recent --days 7          # last 7 days
virgil-cve --keyword "openssh"        # keyword search
```

**Rate limiting:** 0.7s delay between requests (NVD unauthenticated limit).
**Alias:** `virgil-cve`
**Log:** `ingest/cve-ingest.log`

---

### personal-ingest.sh
**Purpose:** Personal logging — workouts, meals, goals, and study sessions. No Slack notifications (private data).
**Output:** Subcommand-dependent (see below)

```bash
virgil-workout "5x5 squat 185lb, 3x8 RDL 135lb"   # → notes/personal/workouts/YYYY-MM-DD.md
virgil-meal    "chicken rice broccoli, ~650 cal"    # → notes/personal/nutrition/YYYY-MM-DD.md
virgil-goal    "finish CCNA Vol 2 chapters 1-3"     # → notes/personal/goals.md (appended)
virgil-study   "CCNA: VLANs and STP — 2h"          # → notes/personal/study/YYYY-MM-DD.md
```

If no inline notes are provided, opens `$EDITOR` for longer entries.
**Aliases:** `virgil-workout`, `virgil-meal`, `virgil-goal`, `virgil-study`
**Log:** `ingest/personal-ingest.log`

---

## Cron Schedule (YOUR-CONTROL-NODE)

| Time | Script | Output |
|------|--------|--------|
| Daily 06:00 | `rss-ingest.py` | `notes/feeds/YYYY-MM-DD.md` |
| Daily 07:00 | `cve-ingest.py --recent` | `notes/cve/*.md` |

PDF and personal ingestion are manual (alias-driven).

---

## Output Directory Map

```
notes/
├── knowledge/
│   ├── ccna/          ← virgil-pdf ... ccna
│   ├── nist/          ← virgil-nist
│   ├── networking/    ← virgil-pdf ... networking
│   └── general/       ← virgil-pdf (default)
├── feeds/             ← virgil-rss (daily digests)
├── cve/               ← virgil-cve (per-CVE notes)
└── personal/
    ├── workouts/      ← virgil-workout
    ├── nutrition/     ← virgil-meal
    ├── study/         ← virgil-study
    └── goals.md       ← virgil-goal
```

---

## Related

- [[VIRGIL]] — second brain system this pipeline feeds
- [[your-control-node]] — cron host for automated ingestion
- [[your-workstation]] — manual ingestion via aliases
- [[Claude]] — API used for synthesis (claude-haiku-4-5-20251001)
- [[NVD]] — CVE data source for cve-ingest.py
- [[CySA+]] — primary study context for nist-ingest and rss digests
- [[CCNA]] — primary study context for pdf-ingest
