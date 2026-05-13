# Knowledge Base

Five certification tracks and a CVE corpus. 739 cert notes plus 239 audited CVEs at v2.0.0 day zero. All Feynman-style per `soul.md` — mechanism explained in plain English, why-it-matters tied to real consequence, no jargon without analogy.

## What's here

| Track | Notes | Exam | Focus |
|---|---|---|---|
| [CCNA](ccna/) | 154 | 200-301 | Routing, switching, network fundamentals |
| [A+](aplus/) | 136 | 220-1101/1102 | Hardware, OS, troubleshooting |
| [Network+](netplus/) | 66 | N10-009 | Network operations, security, troubleshooting |
| [Security+](security-plus/) | 120 | SY0-701 | Threats, governance, architecture, operations |
| [CySA+](cysa/) | 263 | CS0-003 | Threat hunting, IR, vulnerability management |
| [CVE corpus](cve/) | 239 | — | Curated vulnerability analyses with attacker scenario + remediation |

Total: 978 notes.

## How to use this directory

These notes are **reference material**. Read them, link from them in your own notes, quiz yourself with `/quiz`, point `/teach` at one to go deeper. Don't edit them in place — your edits will conflict the next time you `git pull` a release.

Your own notes go in your runtime vault outside this directory (anywhere under `~/VIRGIL/notes/` that isn't `knowledge/`). The pipelines write to runtime locations:

- CVE pipeline writes to `~/VIRGIL/notes/cve/` (your growing personal feed, gitignored)
- RSS pipeline writes to `~/VIRGIL/notes/feeds/` (daily digests, gitignored)
- Anything you author goes wherever you decide — `notes/personal/`, `notes/projects/`, `notes/daily-logs/` are common choices and all gitignored by default

The `knowledge/` directory itself stays clean. Updates arrive via `git pull`.

## Reading order

There is no canonical reading order. Pick the cert you're studying and start there. The notes use `[[wikilinks]]` heavily, so following a chain from any starting point will pull you into adjacent concepts — VLANs in CCNA links to network segmentation in Net+ which links to defense-in-depth in Sec+ which links to specific CVEs in the CVE corpus.

If you're brand new to the field, start with A+. If you have IT fundamentals and want security, start with Sec+. If you want network engineering, start with CCNA. If you're already a security analyst preparing for CySA+, you've probably got your own path.

## The CVE corpus

The 239 CVEs are not a comprehensive vulnerability database — they're a curated starter set covering:

- Famous historic vulnerabilities the exams reference (Conficker, Heartbleed, Log4Shell, EternalBlue, Zerologon, PrintNightmare, Spring4Shell, etc.)
- Recent 2025–2026 disclosures across web applications, IoT, and infrastructure
- Linux kernel and Windows component vulnerabilities
- WordPress plugin classes (XSS, auth bypass, RCE) — common in real-world incidents

The pipeline backfills new disclosures into your runtime vault every morning. The corpus here is your baseline; what you accumulate in `~/VIRGIL/notes/cve/` is yours. See [cve/README.md](cve/README.md) for the dual-directory rationale.

## What you won't find here

Per the scope rule (see [ARCHITECTURE.md §2](../../ARCHITECTURE.md#2-the-scope-rule)):

- No MITRE ATT&CK technique library (referenced inline in CVEs and CySA+ notes, but not a dedicated track)
- No NIST control library
- No curated tools index, OSINT how-tos, or homelab walkthroughs
- No threat actor profiles, malware family deep-dives, or DFIR procedures

If you want any of those, [fork VIRGIL](../../ARCHITECTURE.md#11-forking-virgil) and add them. The architecture supports it; the public repo doesn't ship it.
