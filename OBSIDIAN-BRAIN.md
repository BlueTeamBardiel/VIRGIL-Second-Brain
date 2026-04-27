# VIRGIL — The Knowledge Graph

What the vault actually looks like after months of automated ingestion, and why the structure matters.

---

## Vault Stats (Approximate, mature installation)

| Metric | Value |
|---|---|
| Total notes | 2,000 – 4,000+ depending on CVE volume |
| ATT&CK technique notes | 200+ (Enterprise matrix coverage) |
| CVE notes | 1,000–2,000+ (50/day accumulates fast) |
| Feed digest notes | ~365/year (one per day) |
| CCNA notes | 56 chunks (Vol 1 + Vol 2) |
| CySA+ / Security+ notes | 40–80 domain guides |
| NIST notes | 20–50 (SP 800-53 control families + selected SPs) |
| Wikilinks per note (avg) | 3–8 after wikilink-ingest runs |
| Orphaned notes (target) | < 5% |

---

## Note Categories

```
notes/
│
├── mitre/          ATT&CK techniques, groups, software
│                   Format: T1059-powershell.md, apt29-cozy-bear.md
│                   Links: → CVEs that exploit technique, ← related techniques
│
├── cve/            Per-CVE notes from NVD
│                   Format: CVE-2024-12345.md
│                   Links: → ATT&CK techniques, → affected product notes
│
├── feeds/          Daily threat intel digests
│                   Format: 2026-04-17.md
│                   Links: → CVEs mentioned, → ATT&CK techniques referenced
│
├── knowledge/
│   ├── security/   CySA+, Security+, pentest, blue team guides
│   │               Links: → ATT&CK techniques, → NIST controls, ← feed digests
│   │
│   ├── networking/ CCNA Vol 1 + 2 chunks, network protocol notes
│   │               Links: → related concepts, ← CVEs for network protocols
│   │
│   └── nist/       NIST SP 800-53 control families, FIPS documents
│                   Links: → ATT&CK techniques they mitigate, ← CySA+ guides
│
├── inbox/          Drop zone (triage clears this Monday 8am)
│
└── personal/       Study logs, goals, job applications (gitignored, local only)
```

---

## The Wikilink Convention

All notes use Obsidian's `[[wikilink]]` syntax. The `wikilink-ingest.sh` script runs nightly and injects links automatically — you don't manage this by hand.

**How it works:**

1. A CVE note is written: "This vulnerability is exploited via `[[T1190 - Exploit Public-Facing Application]]`."
2. That ATT&CK note now has a backlink from the CVE.
3. Your CySA+ domain guide on Vulnerability Management mentions "public-facing application hardening."
4. Wikilink-ingest finds the match and injects `[[T1190 - Exploit Public-Facing Application]]`.
5. Now T1190 has backlinks from the CVE, the study guide, and any feed digest that mentioned it.

After six months, a note like T1059 (Command and Scripting Interpreter) will have 50+ backlinks — every CVE that used PowerShell for execution, every digest that covered a relevant campaign, every study note that discussed defensive controls.

**Conventions:**
- ATT&CK techniques: `[[T1059-001 - PowerShell]]` — ID and name
- Threat actors: `[[APT29 - Cozy Bear]]` — name with alias
- Tools: `[[Cobalt Strike]]`, `[[BloodHound]]`
- Concepts: `[[lateral movement]]`, `[[privilege escalation]]`

---

## The Knowledge Graph — Detailed ASCII Map

```
  ╔══════════════════════════════════════════════════════════════════════╗
  ║                    VIRGIL KNOWLEDGE GRAPH                            ║
  ║                 (Obsidian graph view approximation)                  ║
  ╚══════════════════════════════════════════════════════════════════════╝

     FEEDS cluster              CVE cluster              NIST cluster
     (365 nodes/yr)             (1000+ nodes)            (50-80 nodes)
         o o o                   o o o o o               o   o   o
        o     o                 o         o             o  NIST   o
       o DAILY o               o   CVE    o            o  Controls o
       o DIGEST o─────────────►o  NOTES   o───────────►o    SP     o
        o     o                 o         o             o  800-53  o
         o o o                   o o o o o               o   o   o
            │                        │                        │
            │                        │                        │
            ▼                        ▼                        ▼
  ┌─────────────────────────────────────────────────────────────────┐
  │                                                                 │
  │                    ╔═══════════════════════╗                    │
  │     ┌──────────────╣    ATT&CK CORE HUB    ╠──────────────┐    │
  │     │              ╚═══════════════════════╝              │    │
  │     │                         │                           │    │
  │     │   ┌─────────────────────┼─────────────────────┐    │    │
  │     │   │                     │                     │    │    │
  │     ▼   ▼                     ▼                     ▼    ▼    │
  │  ┌───────────┐         ┌────────────┐         ┌───────────┐   │
  │  │ Execution │         │  Defense   │         │  Impact   │   │
  │  │ T1059.*   │         │  Evasion   │         │  T1486    │   │
  │  │ T1053     │         │  T1218     │         │  T1489    │   │
  │  │ (cmd/PS/  │         │  T1497     │         │  T1496    │   │
  │  │  sched)   │         │  T1055     │         │  (ransom/ │   │
  │  └─────┬─────┘         └─────┬──────┘         │  wiper)   │   │
  │        │                     │                └─────┬─────┘   │
  │        └──────────┬──────────┘                      │         │
  │                   │                                 │         │
  │                   ▼                                 │         │
  │           ┌───────────────┐                         │         │
  │           │  Threat Actor │◄────────────────────────┘         │
  │           │  Notes        │                                    │
  │           │  APT28/29/41  │                                    │
  │           │  Lazarus      │                                    │
  │           │  (tools used, │                                    │
  │           │   campaigns)  │                                    │
  │           └───────┬───────┘                                    │
  │                   │                                            │
  └───────────────────┼────────────────────────────────────────────┘
                      │
          ┌───────────┼────────────┐
          ▼           ▼            ▼
    ┌──────────┐ ┌──────────┐ ┌──────────┐
    │  CySA+   │ │   CCNA   │ │ Security+│
    │  Study   │ │  Notes   │ │  Notes   │
    │  Guides  │ │  Vol1+2  │ │  Domains │
    │  (domain │ │ (56 ch.) │ │          │
    │  guides) │ └──────────┘ └──────────┘
    └──────────┘
```

**Reading the graph:**

- **The ATT&CK core hub** sits at the center because everything links to it. CVEs link to the techniques they exploit. Feed digests link to techniques they describe. Study guides link to techniques they teach defenses for. NIST controls link to techniques they mitigate. This convergence is by design — ATT&CK is the common language of the graph.

- **CVE notes** are the most numerous. They form a dense cluster that mostly points inward (to ATT&CK techniques and affected product concepts). Few notes link to CVEs directly; many CVE notes link to ATT&CK.

- **Feed digests** are time-ordered. Each links out to techniques and CVEs mentioned that day. Over time they form a timeline of what mattered when. A CVE note with 20 backlinks from feed digests means it stayed relevant for three weeks.

- **Study guides** (CCNA, CySA+, Security+) form a satellite cluster. They are the learner's entry point — you start here and follow links into the denser territory. A CCNA note on VLANs links to the network segmentation NIST control, which links to T1021 (Remote Services), which links to the CVEs that exploited lateral movement in your study period.

- **Orphan nodes** (no links in or out) are flagged by `orphan-detect.sh` in the weekly rollup. They represent knowledge that hasn't been connected yet. The target is < 5%.

---

## How the Graph Grows

A new VIRGIL installation looks like scattered islands. After 90 days of automated ingestion, it looks like a solar system. After a year, it's a galaxy.

**Day 1:** Vault setup, starter notes, first PDF ingest. ~100 notes, sparse connections.

**Day 30:** ~1,500 CVE notes, 30 feed digests, CCNA chunks linked to NIST controls. The ATT&CK hub is forming.

**Day 90:** Dense core emerging. CVEs cross-reference techniques. Feed digests link back to CVEs. Study session notes link to everything touched that week. Graph view shows the first clear clusters.

**Day 365:** Mature graph. ATT&CK hub has 200+ inbound links. A search for `[[T1059]]` returns CVEs, feed digests, study notes, and campaign write-ups — the full operational and educational context of command execution in one place.

---

## Using the Graph View in Obsidian

```
Ctrl+G (or Cmd+G)   Open graph view
Ctrl+Shift+F        Full-text search across all notes
Ctrl+O              Quick switcher — jump to any note by name
Click any node      Open that note
Click any link      Follow to linked note
Right panel         Shows backlinks to current note
```

**Graph view filters worth setting:**
- Show tags: on (reveals note categories)
- Show orphans: off (reduces noise)
- Node size by connections: on (hub nodes become visually obvious)
- Filter by folder: `notes/mitre/` to see just the ATT&CK cluster

The graph is not decorative. It's the output of the system — a visual representation of what you've ingested, connected, and learned. If a cluster is sparse, you haven't ingested that area. If a node has no inbound links, you know something about it that nothing else does. The gaps in the graph are a map of what to study next.
