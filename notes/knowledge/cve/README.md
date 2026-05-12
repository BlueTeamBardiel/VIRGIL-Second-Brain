# CVE Knowledge Corpus

This directory holds **239 curated CVE notes** that ship with VIRGIL v2.0.0. Each note follows the Feynman doctrine from `soul.md` — mechanism explained in plain English, real-world impact stated, attacker scenario walked through step by step, and remediation given with specific patch versions or commands when known.

These are reference material. They are not your personal CVE feed.

## Two directories, two purposes

VIRGIL uses two CVE directories with different lifecycles:

- **`notes/knowledge/cve/`** *(this directory — committed, shipped, curated)*
  - The 239 starter notes that ship with the public repo.
  - Audited for accuracy and leakage before publication.
  - Tracked in git. Updated periodically by the maintainer in versioned releases.
  - Don't edit these directly unless you know what you're doing — your edits will conflict with future updates from `git pull`.

- **`~/VIRGIL/notes/cve/`** *(your runtime directory — gitignored, grows over time)*
  - Created by `install.sh` and populated by `cve-ingest.py` running nightly.
  - Pulls recent CVEs from the NVD API, generates Feynman analysis, writes new notes here.
  - This is your personal CVE feed. Edit freely.
  - Not tracked by git — your CVE history is your own.

When you study, both directories are searchable from Claude Code. The graph view in Obsidian shows them together.

## Why the split

CVEs are a moving target. The vault you cloned shouldn't replace itself every time a new CVE drops — you'd lose track of which ones you've studied. By separating the **curated starter set** from your **living feed**, you can:

- Always know which CVEs are baseline study material (these)
- Track your own CVE accumulation separately (yours)
- `git pull` future releases without overwriting your work
- See the full corpus together in Obsidian's graph view

## What's in the starter corpus

The 239 ship-day CVEs span:

- Linux kernel vulnerabilities (the recent backfill batch is heavy on these)
- WordPress plugin XSS, RCE, and authentication bypass
- Network protocol flaws (NCI/NFC, DNS, SMB, RDP)
- Famous historic CVEs covered in CySA+ and Security+ exam content (Conficker, Log4Shell, Heartbleed, EternalBlue, Spring4Shell, PrintNightmare, and others)
- Recent 2025-2026 disclosures across web applications, IoT, and infrastructure

Coverage is breadth-first, not exhaustive. New CVEs land daily via the pipeline.

## Reading order suggestion

If you're new to CVE study, start with the famous ones — they're the patterns you'll see repeatedly under different names:

- `CVE-2008-4250` (Conficker — RPC buffer overflow, lateral movement)
- `CVE-2014-0160` (Heartbleed — memory disclosure, why bounds checking matters)
- `CVE-2017-0145` (EternalBlue — SMB exploitation, the NSA tool that became WannaCry)
- `CVE-2021-44228` (Log4Shell — JNDI injection, the vulnerability that broke the internet for a week)
- `CVE-2020-1472` (Zerologon — cryptographic flaw, instant domain admin)

The mechanism patterns in those five repeat across dozens of CVEs in this corpus. Once you've internalized them, the others click into place.
