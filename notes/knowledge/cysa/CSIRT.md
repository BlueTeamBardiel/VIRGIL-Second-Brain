# CSIRT — Computer Security Incident Response Team

## What it is

In **Stardew Valley**, when a meteorite lands in your field or the Junimos go quiet during a Community Center bundle, you don't handle it solo. You walk to Robin for carpentry, Clint for geology, Pierre for the seeds, the Wizard for the weird stuff, and Lewis when the town needs to make it official. Each one has a role, each one has a phone in the bus stop directory, and you already know who to call before the crisis hits — because Pelican Town runs on a quiet roster of specialists who show up when their skill is needed. That's exactly what a CSIRT is — a pre-assembled, pre-authorized roster of specialists who get the call when something is on fire.

Technical definition: a **Computer Security Incident Response Team (CSIRT)** is a formally chartered group inside an organization responsible for receiving, triaging, and responding to [[cybersecurity incidents]]. It owns the incident lifecycle end-to-end: detection handoff, analysis, containment, eradication, recovery, and post-incident reporting. CSIRT membership is defined *before* the incident — you don't recruit a forensic analyst at 3am.

CompTIA also wants you to know **CERT** — Computer Emergency Response Team. CERT and CSIRT are functionally similar; "CERT" is the older term (originally CERT/CC at Carnegie Mellon, 1988, after the Morris Worm) and is trademarked, which is why most private orgs use "CSIRT." On the exam, treat them as synonyms unless the question specifies the national-level coordination body (US-CERT, now CISA).

## Why it matters

Without a CSIRT, an incident becomes a hallway argument about who owns it. Legal thinks IT owns it. IT thinks the SOC owns it. The SOC is busy and thinks the on-call engineer owns it. Meanwhile the threat actor is finishing exfil. A chartered CSIRT collapses that argument into a phone tree.

CompTIA tests CSIRT under **Objective 1.4** (threat intelligence and threat hunting concepts) and again under **Domain 3.0** (Incident Response and Management). The exam expects you to know who sits on the team, what authority they have, and where they sit in the escalation chain. Expect at least one scenario question where the "right" answer is *"escalate to the CSIRT lead"* and the wrong answers are technically plausible individual actions.

In career terms: CSIRT membership is the line between L1 analyst (you triage, you escalate) and L2/L3 (you *are* who gets escalated to). Knowing the structure is knowing where you're going.

## Key facts

### Core vs extended membership

The CSIRT has a small permanent core and a larger on-call extended roster. The core runs every incident. The extended roster gets pulled in based on incident type.

| Role | Core or Extended | What they do during an incident |
|---|---|---|
| **CSIRT lead / IR manager** | Core | Owns the incident, makes the call, briefs executives |
| **SOC analysts (L1/L2/L3)** | Core | Detection, triage, evidence acquisition, [[IoC]] hunting |
| **Forensic / malware analyst** | Core | Disk imaging, memory analysis, reverse engineering |
| **Security engineering** | Core | Containment actions, firewall changes, EDR isolation |
| **IT operations / sysadmins** | Extended | Re-imaging, account resets, backup restoration |
| **Legal counsel** | Extended | Breach notification thresholds, evidence handling, regulator contact |
| **HR** | Extended | [[Insider threat]] cases, employee suspension, interviews |
| **Public relations / communications** | Extended | External statements, customer notification language |
| **Executive leadership (CISO, CEO)** | Extended | Authority for high-impact decisions (pulling production, paying ransom) |
| **Law enforcement (FBI, Secret Service)** | Extended | Nation-state, organized crime, ransomware involving wire fraud |
| **External IR retainer (Mandiant, CrowdStrike, etc.)** | Extended | When in-house can't scale or independence is required |

The core lives in the SOC. The extended team lives on a contact list with primary, secondary, and after-hours numbers.

### What a CSIRT must have to function

These four are non-negotiable. Without them, the team is a group chat.

- **Clear authority** — written into a charter signed by an executive. The CSIRT can isolate hosts, disable accounts, pull production services, and seize endpoints *without asking permission mid-incident*. If they have to file a ticket to act, the attacker wins.
- **Defined escalation paths** — who calls whom, at what threshold, in what order. Severity 1 wakes the CISO. Severity 3 waits for business hours. The matrix exists on paper, not in someone's head.
- **Management support** — budget, headcount, tooling, and air cover when a containment action breaks a production service. The CISO has to back the analyst who pulled the e-commerce server during Black Friday because it was the right call.
- **Pre-built playbooks** — ransomware, BEC, insider exfil, [[supply chain]] compromise, DDoS, web app compromise. Each playbook names the lead, the escalation path, the evidence required, and the regulatory clock.

### CSIRT focus areas (CompTIA framing)

CompTIA wants you to know the team operates across these areas, not just "responds to alerts":

- **Detection and monitoring** — owns SIEM rule tuning, EDR alerting, threat hunting
- **Incident response** — the four NIST phases (Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-incident Activity)
- **[[Threat intelligence]] consumption** — ingests OSINT, paid feeds, ISAC bulletins, [[government bulletins]] (CISA advisories), and converts them into detection content
- **[[Threat hunting]]** — proactive search for adversaries that didn't trip an alert
- **[[Active defense]]** — honeypots, deception tech, controlled engagement (not "hack back" — that's illegal)
- **Vulnerability management coordination** — when a CVE drops, CSIRT helps prioritize based on threat intel
- **Information sharing** — outbound to ISACs (FS-ISAC, H-ISAC), MISP communities, peer organizations

### Sources the CSIRT actually consumes

| Source type | Examples | Trust level |
|---|---|---|
| **Open source (OSINT)** | Twitter/X infosec, Mastodon, [[blogs and forums]], GitHub PoCs, [[social media]] | Variable — verify before acting |
| **Closed source** | Vendor-specific portals (Microsoft Defender TI, Cisco Talos) | Higher confidence, narrower scope |
| **Paid feeds** | Recorded Future, Mandiant Advantage, CrowdStrike Falcon Intel | High confidence, premium cost |
| **Government bulletins** | CISA alerts, FBI Flash, NSA advisories, NCSC | High confidence, slower cadence |
| **ISAC / sharing orgs** | FS-ISAC (finance), H-ISAC (health), MS-ISAC (state/local gov) | High confidence, sector-specific |
| **Deep / dark web** | Forums, leak sites, ransomware blogs | Critical for early warning, requires tradecraft |
| **Internal sources** | Your own SIEM, EDR telemetry, honeypot data | Highest relevance — it's *your* environment |

### Evaluating intel before acting on it

CompTIA loves these four criteria for [[threat intelligence]] quality. The CSIRT applies them every time a new indicator lands:

- **Timeliness** — is this current, or are we hunting a campaign that ended in 2023?
- **Relevancy** — does this affect our stack, our region, our sector?
- **Accuracy** — has anyone else corroborated this, or is it one researcher's tweet?
- **Confidence level** — explicitly scored (often Admiralty Code or similar). Acting on low-confidence intel can break production for nothing.

### CompTIA exam traps

> **CompTIA exam trap:** CSIRT vs SOC vs IR team. The SOC is the 24/7 monitoring function (mostly L1/L2 analysts). The CSIRT is the incident-handling function that activates on declared incidents. The IR team is often a subset of the CSIRT focused purely on containment/eradication/recovery. Same people sometimes wear all three hats in a small org, but on the exam they're distinct functions. If the question asks who *responds to a declared incident*, the answer is CSIRT.

> **CompTIA exam trap:** CERT vs CSIRT. "CERT" is trademarked by Carnegie Mellon. Public-sector national-level teams use CERT (US-CERT/CISA, JPCERT, AusCERT). Private orgs use CSIRT to avoid the trademark. CompTIA may present "CERT" and "CSIRT" as if they're different things in a distractor — they're functionally the same role at different scales.

> **CompTIA exam trap:** Authority before action. A scenario describes an analyst who spots ransomware spreading and *waits for approval* to isolate the host. The right answer is *"the CSIRT charter should pre-authorize containment actions."* The trap answer is *"escalate to the CISO before acting."* Pre-authorization is the entire point of a chartered team.

> **CompTIA exam trap:** Legal counsel is *extended*, not core. Legal is critical for breach notification and evidence handling but is not on the daily roster. The trap question implies legal sits in the SOC. They don't — they're on the contact list.

## SOC reality

- **The alert doesn't say "incident."** At 3am the SIEM shows a Defender alert for `mimikatz.exe` on a finance laptop, a failed login spike from a Russian ASN, and a beacon to a domain registered six hours ago. L1 acknowledges, opens a ticket, runs the playbook — but doesn't declare an incident yet. The CSIRT lead declares. That's the threshold.

- **"Are we contained?" is the question that gets asked twelve times.** The CISO will ask at minute 10, minute 30, hour 2, and hour 6. The honest answer is almost never *yes* in the first two hours. *"We've isolated the known-compromised endpoints and are hunting for lateral movement"* is the right answer. Never promise containment you haven't verified — the second host you missed is the one that ruins your week.

- **The legal call is faster than the technical call.** If the incident touches PII, PHI, or cardholder data, legal joins within the first hour to start the regulatory clock. GDPR is 72 hours from awareness. The clock is on *awareness*, not *confirmation* — which is why "when did you know" is the question that ends careers.

- **The handoff order is muscle memory.** L1 detects → L2 triages → L3 / IR lead declares → CSIRT lead activates extended roster → executive briefing within 1 hour for SEV-1. If any link is fuzzy on a Tuesday, it'll be broken on a Saturday at 2am.

- **The post-incident report is where the team is actually built.** Lessons learned reveals which playbook had gaps, which alert was tuned out, which team didn't know they were on the roster. *The retro is more valuable than the response — the response saves this incident, the retro saves the next ten.*

## Related concepts

[[Incident Response]] · [[NIST SP 800-61]] · [[SOC]] · [[Threat Intelligence]] · [[Threat Hunting]] · [[Indicators of Compromise]] · [[Chain of Custody]] · [[Insider Threat]] · [[Supply Chain Risk]] · [[Active Defense]] · [[Honeypot]] · [[CISA]] · [[ISAC]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Tabletop Exercise]]

*Source: VIRGIL knowledge base — 2026-05-11*