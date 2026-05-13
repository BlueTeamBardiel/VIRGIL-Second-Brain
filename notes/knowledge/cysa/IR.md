# IR — Incident Response

## What it is

In **Fallout 4**, the moment you walk out of Vault 111 the Pip-Boy starts blinking. Radiation count rising. Geiger ticks getting faster. You don't ignore it — you pull RadAway, you find shelter, you figure out *what* irradiated you, and then you decide whether to keep moving or fall back to Sanctuary and reset. If you panic and chug every Stimpak in your inventory, you waste resources and you still don't know where the radiation source is. If you ignore the ticks, you're a ghoul by morning.

That's exactly what **incident response** is — a disciplined sequence for detecting a hostile event, containing the damage, removing the cause, and getting back to operational baseline without burning every resource you have in the first ten minutes.

**Technical definition (CS0-003):** Incident Response (IR) is the structured process by which an organization detects, analyzes, contains, eradicates, and recovers from a [[cybersecurity incident]], followed by post-incident review to harden against recurrence. The CompTIA-aligned framework is **NIST SP 800-61 Rev. 2**, which defines four phases:

1. **Preparation**
2. **Detection and Analysis**
3. **Containment, Eradication, and Recovery**
4. **Post-incident Activity**

A formal IR function is typically delivered by a **[[CSIRT]]** (Computer Security Incident Response Team) or a **[[CERT]]** (Computer Emergency Response Team). Same idea, different org chart.

## Why it matters

A SOC that detects an intrusion but has no IR playbook is just an expensive alarm system. The CISO doesn't get fired because something got in — something always gets in. The CISO gets fired because **scope was unknown for six days, evidence wasn't preserved, legal wasn't looped in before the 72-hour GDPR window closed, and the recovery plan was a wiki page last edited in 2021**.

On the exam, IR is the spine of Domain 3.0 and shows up everywhere in 1.4 because [[threat intelligence]] feeds *into* detection and *out of* lessons learned. CompTIA tests phase boundaries, containment trade-offs, [[chain of custody]], and which artifact belongs to which phase. Get the phases wrong and you fail the whole domain.

In the war room, IR is the difference between "we contained it in four hours" and "we're on day twelve and the lawyers are here."

*Detection without response is just expensive surveillance.*

## Key facts

### The NIST four-phase lifecycle

| Phase | What happens | War-room beat |
|---|---|---|
| **Preparation** | Playbooks, tooling, tabletops, IR team rosters, jump bags, BC/DR plans, hardened logging, comms trees | The pre-raid setup — buffs, consumables, role assignments |
| **Detection and Analysis** | Alert triage, IoC validation, scope determination, evidence acquisition, **NTP-synchronized log correlation**, severity classification | "What hit us, when, and how bad?" |
| **Containment, Eradication, and Recovery** | Isolate affected hosts, remove the threat (malware, accounts, persistence), rebuild from known-good, restore service, monitor for re-entry | Soft res, kill the adds, clean the room, reset for next pull |
| **Post-incident Activity** | Root cause analysis, lessons learned, playbook updates, metric reporting (MTTD/MTTR), [[threat intelligence]] enrichment | The retro where someone gets called out for standing in the fire |

> **CompTIA exam trap:** Configuring NTP across the fleet *feels* like Preparation because you do it before any incident. It's actually **Detection and Analysis**. The phase is determined by what the action *enables* — and synchronized clocks enable log correlation during analysis. CompTIA will dangle Preparation as the obvious-looking answer. Don't bite.

### Detection and Analysis — the timestamps lie sometimes

When firewall logs and host logs disagree on the order of events, your first hypothesis isn't "advanced attacker" — it's **NTP drift**. If host B shows a compromise at 07:15 and host A shows the pivot at 08:02, but the ruleset only allows A → B on TCP/22, then B cannot have been the source. Clock skew is the parsimonious answer.

*If the timeline contradicts the network architecture, suspect the clock before you suspect the adversary.*

This is why NIST puts NTP under Detection and Analysis. Without synchronized time, you cannot reconstruct sequence. Without sequence, you cannot prove causation. Without causation, your IR report is a guess in a Word document.

### Containment trade-offs

Containment is not one action — it's a decision tree:

- **Isolation (segmentation)** — pull the host off the production VLAN onto a quarantine network. Preserves the host for forensic acquisition. Threat can't pivot further.
- **Removal** — physically disconnect or power down. Fast, brutal, destroys volatile memory and live attacker state. Use when active exfil is happening and forensics is a secondary concern.
- **Sandboxing** — let the malware run in an instrumented environment to observe behavior. Analysis tool, not a production containment strategy.

For APT cases where you need to preserve the host to study the adversary's TTPs, **isolation > removal**. You can't recover volatile memory from a powered-off box, and APT operators leave the best evidence in RAM — injected processes, decrypted C2 beacons, in-memory credentials.

> **CompTIA exam trap:** "Removal" and "isolation" are not interchangeable. Removal destroys forensic value. Isolation preserves it. If the question mentions APT, forensic examination, or evidence preservation — pick isolation.

### Roles — CSIRT vs CERT vs the SOC

- **SOC** — 24/7 detection and triage. L1/L2 analysts working the alert queue.
- **CSIRT (Computer Security Incident Response Team)** — the dedicated response unit, often pulled together per-incident from security, IT, legal, comms, and HR. Owns containment and recovery.
- **CERT (Computer Emergency Response Team)** — historically the term for national or sector-level coordination bodies (US-CERT, JPCERT). Some orgs use CERT internally as a synonym for CSIRT. CompTIA treats them as near-synonyms but expects you to recognize both.

### Threat actor mapping into IR

Different adversaries change your IR posture:

| Actor | Motivation | IR implication |
|---|---|---|
| **Script kiddie** | Notoriety, boredom | Loud, fast, easy to contain. Watch for piggyback actors. |
| **Hacktivist** | Ideology | Public exposure risk — loop comms/legal early. |
| **Organized crime** | Money (ransomware, fraud) | Ransom decision, insurance, FBI engagement. |
| **Nation-state / [[APT]]** | Espionage, sabotage | Long dwell time, deep persistence, requires extended hunt and likely full rebuild. |
| **Insider — intentional** | Revenge, money | HR, legal, evidence handling for prosecution. |
| **Insider — unintentional** | Mistakes, phishing victim | Training gap, not malice. Don't fire the victim. |
| **Supply chain** | Pivot via trusted vendor | Expand scope to third parties; review vendor access. |

### IoCs vs IoAs

- **[[Indicators of Compromise]] (IoCs)** — forensic artifacts that something *happened*. File hashes, malicious IPs, registry keys, specific filenames.
- **Indicators of Attack (IoAs)** — behavioral patterns that something *is happening*. Encoded PowerShell, unusual parent-child process trees, lateral SMB enumeration.

IoCs feed detection rules. IoAs drive [[threat hunting]]. Both are inputs to the Detection and Analysis phase.

### Intelligence feeding IR

The IR team consumes threat intel to enrich alerts and scope incidents:

- **Open source (OSINT)** — blogs, forums, social media, deep/dark web monitoring, government bulletins (CISA, NCSC)
- **Closed source / paid feeds** — vendor reports, ISAC sharing
- **Information sharing organizations** — ISACs (FS-ISAC, H-ISAC), ISAOs
- **Internal sources** — historical incidents, honeypot data, your own SIEM history

Evaluate every feed on: **timeliness, relevancy, accuracy, confidence level**. A six-month-old IoC is archaeology. A high-confidence IoC for a sector you're not in is noise.

### Active defense and honeypots

A [[honeypot]] is a decoy system planted to attract and study attackers. Honeynets are the network-scale version. They feed both detection (anything touching the honeypot is suspicious by definition) and intelligence (you see live TTPs against your own decoys). Active defense stops short of hacking back — that's still illegal in most jurisdictions.

### Metrics that matter

- **MTTD (Mean Time to Detect)** — alert generation to confirmed incident. Industry "good" is hours, not days.
- **MTTR (Mean Time to Respond)** — confirmed incident to containment. Hours for ransomware, minutes for active exfil.
- **MTTRem (Mean Time to Remediate)** — full eradication and recovery. Days to weeks for APT.

> **CompTIA exam trap:** MTTR is ambiguous — "respond" or "repair"? CompTIA usually means respond. MTTRem covers full remediation. If the answer choices include both, read the question stem for which lifecycle stage they care about.

## SOC reality

- **The 3am alert** looks like one line in the SIEM: `powershell.exe -NoP -W Hidden -Enc <base64 blob>` spawned by `winword.exe` on a finance workstation. That's not a finding — that's a containment decision in the next five minutes.
- **L1's first action** is acknowledge the alert in the queue, pull the host's recent process tree from EDR, check if the user is currently logged in, and decide: page L2, or tune as false positive. The wrong call in either direction costs you.
- **The IR lead's first question** is always the same three: *scope, impact, evidence preserved?* If you can't answer all three, stop talking and go find out.
- **Never promise containment until you've validated it.** "We isolated the host" doesn't mean contained — the attacker may already be on three other boxes. "We pulled the credential" doesn't mean contained — they may have minted a golden ticket. Report what you know. Flag what you don't.
- **The handoff chain**: L1 SOC → L2 SOC → IR lead → CSIRT activation → legal/comms/exec notification. Each hop has a defined trigger. If your org doesn't have that written down, that's a Preparation gap and you should fix it before the next incident, not during.

## Related concepts

[[Threat Intelligence]] · [[Threat Hunting]] · [[CSIRT]] · [[CERT]] · [[APT]] · [[Indicators of Compromise]] · [[Chain of Custody]] · [[NIST SP 800-61]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Honeypot]] · [[SIEM]] · [[EDR]] · [[Forensic Acquisition]] · [[Containment Strategies]] · [[Lessons Learned]] · [[MTTD]] · [[MTTR]] · [[Tabletop Exercise]] · [[Insider Threat]] · [[Supply Chain Attack]]

*Source: VIRGIL knowledge base — 2026-05-11*