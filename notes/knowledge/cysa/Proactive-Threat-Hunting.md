# Proactive Threat Hunting

## What it is

In **Among Us**, the body hasn't been reported yet. Nobody called an emergency meeting. The reactor isn't melting down. But you saw Purple vent in Electrical two rounds ago, and Purple's task bar didn't move when it should have, and now Purple is suspiciously alone with Yellow in Medbay. You don't have a corpse. You have a pattern. So you start watching Purple — following them, checking their task completion against the bar, waiting for the moment they slip up. That's threat hunting. You're not waiting for the body. You're working a hypothesis built from anomalies and chasing it until you either confirm a kill or clear your suspect.

**Plain English:** threat hunting is the SOC actively going looking for adversaries that are already inside, *before* any alarm has fired. The SIEM didn't catch it. The EDR didn't flag it. The hunter assumes the attacker is already past the perimeter and starts hunting on a hypothesis.

**Technical (CS0-003):** Proactive threat hunting is a hypothesis-driven, human-led analytical process that searches enterprise telemetry for the signs of adversary activity that automated detection has missed. It's triggered by new threat intelligence, new tooling, emerging TTPs, or a gut call from an analyst who saw something weird in the logs. Output: new detections, hardened configs, or a confirmed incident handed off to IR.

## Why it matters

Detection-and-response is reactive by design. The alarm fires, you triage. That model assumes your detections cover the attacker's behavior. They don't. Dwell time — the gap between initial compromise and detection — still averages weeks for sophisticated intrusions, and months for nation-state actors who deliberately stay quiet. Threat hunting is how you close that gap.

For CySA+, this is **Objective 1.4** — compare and contrast threat intelligence and threat hunting. CompTIA tests the distinction hard. Threat intelligence is the **input** (what adversaries are doing in the wild). Threat hunting is the **action** (looking for them in your own environment). They are not the same activity and CompTIA will write a question where the obvious answer conflates them.

Career-wise: hunting is the L2/L3 analyst job. L1 watches the queue. Hunters write the hypotheses, run the queries, and either find nothing (which is fine — that's data too) or hand a confirmed compromise to IR.

## Key facts

### The hypothesis is the whole game

Hunts are not "let me poke around the logs." They are structured. The hypothesis comes first, in the form: *"If adversary X is in our environment using technique Y, we would expect to see Z in [data source]."*

Examples:
- *If an attacker is using DCSync against our domain controller, we'd see unusual replication requests from non-DC hosts in Windows Event 4662.*
- *If a supply-chain implant is beaconing out, we'd see periodic outbound DNS to a low-reputation domain at consistent intervals from a host that shouldn't initiate outbound DNS.*

No hypothesis, no hunt. Just a fishing trip. Hunts without hypotheses generate noise and burn analyst hours.

### What triggers a hunt

| Trigger | Example |
|---|---|
| **New threat intelligence** | A vendor publishes IoCs for a campaign targeting your sector |
| **New TTPs** | MITRE ATT&CK adds a technique under T1078 (Valid Accounts) |
| **New tooling** | You stood up Sysmon last week; now you can hunt parent-child process anomalies you couldn't see before |
| **Crown-jewel risk** | Quarterly hunt against business-critical assets — domain controllers, jump hosts, code-signing infrastructure |
| **Analyst intuition** | An L2 noticed three hosts beaconing on the same odd interval. No alert. Just weird. |
| **Post-incident** | After IR closes a case, hunt for the same TTPs elsewhere — attackers reuse infrastructure |

### Intelligence feeds the hunter

Threat hunting without intelligence is guessing. Sources feed hypotheses:

- **Open source (OSINT)** — vendor blogs, security Twitter/Mastodon, GitHub IoC repos, [[MITRE ATT&CK]] updates
- **Closed source / paid feeds** — Recorded Future, Mandiant, CrowdStrike Intel — curated, attributed, often sector-specific
- **Government bulletins** — CISA advisories, FBI Flash, NSA CSAs, sector-specific ISACs (FS-ISAC for finance, H-ISAC for health)
- **CERT/CSIRT advisories** — US-CERT, regional CERTs publish active campaign data
- **Information sharing organizations** — ISACs and ISAOs, formal channels for peer org sharing
- **Deep/dark web** — broker forums, leak sites, ransomware blogs (often where you learn you're a victim)
- **Social media, blogs, forums** — fastest signal, lowest reliability — verify before you hunt on it
- **Internal sources** — your own past incidents, your own honeypot hits, your own anomaly baselines

Evaluate every feed on four axes CompTIA loves: **timeliness** (is it fresh?), **relevancy** (does it apply to your stack and sector?), **accuracy** (is the IoC right?), and **confidence level** (how sure is the source — A1 through F6 in admiralty grading).

### The threat actor catalog

Your hypothesis depends on who you think is hunting you. CySA+ tests these distinctions:

| Actor | Motivation | Sophistication | Hunt focus |
|---|---|---|---|
| **Script kiddie** | Bragging rights | Low — public tools | Known exploits, scanner traffic, default creds |
| **Hacktivist** | Ideology | Low to medium | Web defacement, DDoS, data leaks |
| **Organized crime** | Money | Medium to high | Ransomware staging, credential theft, BEC infrastructure |
| **Insider threat** | Varies (intentional or unintentional) | Has legitimate access already | Data egress patterns, off-hours access, USB writes |
| **APT / nation-state** | Espionage, strategic | Very high — custom tooling, long dwell | Living-off-the-land binaries (LOLBins), zero-days, supply-chain implants |

The hunt against a script kiddie is noisy and easy. The hunt against an [[Advanced Persistent Threat]] is quiet, patient, and may take weeks of correlating low-signal events.

### Where you actually hunt

Hunt focus areas — what you point the queries at:

- **Business-critical assets** — DCs, code-signing infra, ERP, customer DBs, executive endpoints
- **Identity** — service accounts (rarely audited, often over-privileged), recent password changes, abnormal logon types (Type 3 to a workstation = lateral movement)
- **Process telemetry** — parent-child anomalies (Word spawning powershell.exe), command-line obfuscation, encoded commands
- **Network flows** — beaconing patterns, DNS tunneling, traffic to newly registered domains
- **Configurations/misconfigurations** — what changed in the last 30 days that shouldn't have
- **Application layer** — auth logs, API abuse, web shell artifacts
- **Supply chain** — third-party software updates, vendor remote access, SBOM drift
- **Isolated networks** — OT/ICS segments, dev environments that aren't supposed to talk to prod

### Active defense and honeypots

Threat hunting overlaps with active defense — making the environment hostile to adversaries who get in. [[Honeypot]]s, honey tokens, honey credentials. A service account named `svc-backup-admin` that nobody should ever use. The day it authenticates, you have a hunter's dream: zero false positives, a guaranteed hostile actor, and a starting point for the hunt.

### The hunt loop

1. **Hypothesis** — built from intel, TTPs, or analyst observation
2. **Collection** — pull the data sources that would prove or disprove (EDR telemetry, SIEM logs, NetFlow, DNS, auth)
3. **Analysis** — query, pivot, correlate. Stack rare events. Look for outliers.
4. **Outcome** — confirmed compromise (hand to IR), suspicious but inconclusive (extend hunt), or null (document and move on)
5. **Feedback** — every hunt produces either a new detection rule, a config hardening, or institutional knowledge. Null results that improve detection are still wins.

This is the continuous improvement loop. Hunts that don't feed back into detection engineering are wasted hunts.

### CompTIA exam traps

> **CompTIA exam trap:** Threat intelligence ≠ threat hunting. Intelligence is the *input* — knowledge about adversaries gathered from external and internal sources. Hunting is the *activity* — searching your environment for evidence of those adversaries. If the question says "subscribing to a paid feed of IoCs," that's intelligence collection, not hunting.

> **CompTIA exam trap:** Threat hunting is **proactive**, not reactive. If the scenario starts with "an alert fired" or "the SIEM detected" — that's incident response, not hunting. Hunting starts with a hypothesis, not an alarm.

> **CompTIA exam trap:** IoCs vs TTPs. IoCs (hashes, IPs, domains) are tactical, short-lived, easy to change. TTPs (techniques like "credential dumping via LSASS") are strategic, hard to change, and the better hunt target. CompTIA will ask which is more durable — TTPs always.

> **CompTIA exam trap:** Insider threat splits into **intentional** (malicious — disgruntled employee exfiltrating data) and **unintentional** (the user who clicked the phish). Both are insider threats. Hunting approach differs — intentional looks for evasion behavior, unintentional looks for compromise artifacts.

> **CompTIA exam trap:** Confidence levels matter. An IoC from a vendor blog with no attribution is not the same as one from a TLP:RED government bulletin. Don't hunt with equal urgency on unequal sources.

## SOC reality

- **The hunt board.** Every mature SOC has a backlog of hypotheses — some from intel, some from "remember when we found that weird DNS pattern?" L2/L3 analysts pull from the board on hunt days, not when the queue is on fire. Hunting and triage on the same shift = neither gets done well.
- **Most hunts find nothing. That's the job.** Out of ten hunts, eight return null, one finds a misconfig, one finds something real. The eight nulls are not failures — they're "we checked, we're clean on this hypothesis, here's a new detection rule so we don't have to check manually again."
- **What the CISO asks after a hunt:** "What did you look for, what data did you have, what would you have missed if it were there, and what are we doing about the gap?" Not "did you find a hacker." Hunting maturity is measured by coverage, not catches.
- **Never promise leadership your environment is clean.** A clean hunt result means "clean against this hypothesis, with this data, on this day." It does not mean "no adversary present." An APT that's good enough to bypass your detections is good enough to bypass your hunt query. *A null hunt is a snapshot, not a guarantee.*
- **The handoff.** Confirmed compromise during a hunt → immediately becomes an incident. Page IR, preserve evidence, do not start poking the box. Hunters who try to do containment themselves contaminate the scene. *Hunt, confirm, hand off — in that order.*

## Related concepts

[[Threat Intelligence]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Advanced Persistent Threat]] · [[Cyber Kill Chain]] · [[Honeypot]] · [[Incident Response Lifecycle]] · [[SIEM]] · [[EDR]] · [[Detection Engineering]] · [[Information Sharing Organizations]] · [[OSINT]] · [[Insider Threat]]

*Source: VIRGIL knowledge base — 2026-05-11*