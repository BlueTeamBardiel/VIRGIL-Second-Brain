# Incident Response Lifecycle Context

## What it is

In **Death Stranding**, Sam Porter Bridges doesn't just sprint to the destination. He plans the route at the terminal — checks BT zones, MULE camps, terrain elevation. He loads cargo with weight distribution in mind. He plants ladders and climbing anchors on the way out so the return trip is survivable. When timefall hits, he ducks into a shelter. When he loses cargo in a river, he doesn't keep going — he marks the location, recovers what he can, and logs the loss before pushing forward. Every delivery is a five-phase loop: prep the load, scan the terrain, handle what goes wrong, deliver the package intact, and update the network map for the next porter.

That's exactly what the **incident response lifecycle** is. Prep before the storm. Detect when it hits. Contain the spill. Recover the cargo. Update the map.

Technical definition: the incident response lifecycle is the structured, repeatable process a security team follows from before an incident occurs through after it's closed. CompTIA uses the **NIST SP 800-61** four-phase model:

1. **Preparation**
2. **Detection and Analysis**
3. **Containment, Eradication, and Recovery**
4. **Post-incident Activity**

This note focuses on **context** — how the middle and late phases hang together, what decisions get made where, and what each phase actually looks like in a war room. The CompTIA objective 3.2 items (scope, impact, chain of custody, legal hold, re-imaging, compensating controls, etc.) are activities that live inside specific phases. Knowing which phase owns which activity is half the exam.

## Why it matters

CySA+ Domain 3.0 is 20% of the exam, and objective 3.2 is the operational heart of it. CompTIA will give you a scenario — "an analyst observes encrypted outbound traffic to an unknown IP at 0300" — and ask what you do *next*. The right answer depends entirely on which phase you're in. Containment actions in the detection phase are premature. Eradication without scope is how you miss the second backdoor. Re-imaging before evidence acquisition destroys the case.

In the real SOC, the lifecycle is the difference between an incident that ends in a clean lessons-learned doc and one that ends in a regulator's inbox. Decisions made in containment determine downtime. Decisions made in eradication determine reinfection probability. Decisions made about legal hold determine whether your evidence is admissible six months from now when the lawsuit drops.

## Key facts

### The four phases in order

| Phase | What happens | Owns these activities |
|---|---|---|
| **1. Preparation** | Playbooks, tooling, training, tabletops, IR retainer contracts, jump bags | Runbooks, SIEM tuning baselines, comms trees, BC/DR plans |
| **2. Detection and Analysis** | Alert fires, analyst triages, scope and impact assessed, [[IoC]] correlation | Data and log analysis, evidence acquisition, scope, impact, validating data integrity, preservation, chain of custody, legal hold |
| **3. Containment, Eradication, and Recovery** | Stop the bleeding, remove the adversary, restore service | Isolation, compensating controls, remediation, re-imaging, malware removal, credential rotation, system restoration |
| **4. Post-incident Activity** | Root cause analysis, lessons learned, playbook updates, metrics | Forensic write-up, RCA, control improvements, [[MTTD]]/[[MTTR]] reporting |

CompTIA will scramble this order on the exam. Memorize it cold.

### Detection and Analysis — the triage phase

This is where the alert becomes an incident. The L1 analyst gets a SIEM hit, an [[EDR]] detection, a user report, or a threat intel match. The goal of this phase is to answer four questions:

- **Is it real?** (true positive vs tuned-out noise)
- **What's the scope?** How many hosts, accounts, network segments?
- **What's the impact?** Data confidentiality, system availability, regulatory exposure?
- **What evidence exists, and how do we preserve it?**

**Scope** means breadth — every asset touched by the adversary. You build it with pivot queries in the SIEM, [[EDR]] process trees, authentication logs, and [[NetFlow]]. Underscoping is how you contain one host while the attacker pivots from three others.

**Impact** means severity — what the adversary did or could do. CIA triad framing: did they read data (confidentiality), change data (integrity), break service (availability)? Impact drives the priority queue and the executive notification clock.

**Evidence acquisition** happens here, not later. Memory captures before isolation when possible (isolation may trigger malware self-destruct). Disk images using a [[write blocker]]. Log exports with timestamps and hash values. The order matters: volatile first (RAM, network connections, running processes), then non-volatile (disk, registry hives, file system).

**Validating data integrity** = hashing. MD5 or SHA-256 the image at acquisition, hash it again before analysis, document both. If the hashes match, you can prove in court the evidence wasn't tampered with. If they don't match, the evidence is dead.

**Chain of custody** = the paper trail. Every transfer of evidence — analyst to forensic lead, forensic lead to legal, legal to outside counsel — gets logged with timestamp, names, and a signature. Miss one transfer and a defense attorney will end your case.

**Preservation** and **legal hold** are related but distinct. Preservation is the technical act (snapshot the VM, image the disk, freeze the logs). Legal hold is the formal organizational order to stop normal data destruction — mailbox retention policies pause, backup rotation pauses, ticket auto-archival pauses. Counsel issues it; IT enforces it.

> **CompTIA exam trap:** Evidence acquisition lives in **Detection and Analysis**, not Containment. CompTIA tests this because in real life it feels like containment work. The principle: you preserve before you change anything. Once you isolate the host or re-image it, evidence is altered or gone. Acquire first, contain second.

### Containment, Eradication, and Recovery — the war-room phase

Three distinct activities bundled into one phase.

**Containment** = stop the spread. Options scale with impact:

- **Isolation** — network-level (VLAN quarantine, [[EDR]] host isolation that kills all traffic except the EDR console), physical (yank the cable), or account-level (disable credentials, revoke tokens, kill sessions)
- **Segmentation** — move affected systems into a contained network zone
- **[[Compensating controls]]** — when you can't fix the root cause immediately, add a control that reduces risk. Example: critical legacy app can't be patched, so you put a [[WAF]] in front and increase logging. Compensating controls are temporary by design but tend to live forever.

Containment is a tradeoff. Aggressive containment (isolate everything) maximizes safety but kills business operations. Soft containment (monitor and contain only confirmed compromise) preserves uptime but risks the adversary moving faster than you. The IR lead, not the L1 analyst, owns this call.

**Eradication** = remove the adversary. Kill malicious processes, delete persistence mechanisms (scheduled tasks, registry run keys, services, WMI subscriptions), rotate compromised credentials (every credential that touched a compromised host, not just the obvious one), revoke certificates, patch the exploited vulnerability. If you eradicate without complete scope, you'll be back here in two weeks.

**Recovery** = restore service.

- **Re-imaging** — wipe the host, install from a known-good gold image, restore data from a backup that predates compromise. This is the default for any host with confirmed kernel-level or persistence-mechanism compromise. You cannot "clean" a compromised endpoint with confidence; you re-image it.
- **Restoration validation** — bring the system back online in a monitored state. Watch for re-infection signals. Confirm the patch took. Confirm the credentials rotated cleanly.
- **Gradual return to production** — don't dump 200 re-imaged endpoints back onto the network at 9am Monday. Stagger, monitor, verify.

> **CompTIA exam trap:** Recovery is **not** post-incident. Recovery means *bringing systems back online*. Post-incident means *lessons learned after everything is back*. CompTIA will offer "conduct lessons-learned meeting" as a recovery option — it isn't. It's phase four.

### Post-incident Activity — the retro

The phase most teams skip and pay for later. Activities:

- **Root cause analysis** — not "the user clicked a link" but *why* the link reached the user, why the EDR missed the payload, why the lateral movement wasn't detected for 11 days
- **Lessons learned meeting** — within two weeks of incident closure, all responders attend
- **Playbook updates** — every detection gap and process gap from this incident becomes a runbook change
- **Control improvements** — new SIEM rules, new EDR exclusions tuned, new awareness training topics
- **Metrics reporting** — [[MTTD]] (how long from compromise to detection), [[MTTR]] (how long from detection to containment), [[MTTRem]] (how long from detection to full remediation)

This phase is where the organization actually gets stronger. Without it, you respond to the same incident next quarter.

### How the activities map to phases (the cheat sheet)

| Activity | Phase |
|---|---|
| Scope determination | Detection and Analysis |
| Impact assessment | Detection and Analysis |
| Evidence acquisition | Detection and Analysis |
| Chain of custody | Detection and Analysis (and beyond) |
| Validating data integrity (hashing) | Detection and Analysis |
| Preservation | Detection and Analysis |
| Legal hold | Detection and Analysis |
| Isolation | Containment |
| Compensating controls | Containment |
| Remediation / patching | Eradication |
| Credential rotation | Eradication |
| Re-imaging | Recovery |
| Lessons learned | Post-incident |
| RCA | Post-incident |

> **CompTIA exam trap:** Compensating controls live in **Containment**, not Preparation. Preparation builds the baseline controls. Compensating controls are added *in response to a specific incident* when the root cause can't be fixed yet. The exam will offer "implement a compensating control" as a prep answer — it's a containment answer.

## SOC reality

- At 3am, the alert is a Splunk notable event that says "PowerShell EncodedCommand from finance-ws-042." The L1's first action is *not* to isolate. It's to pull process tree, parent process, and command-line decode in the EDR, then check authentication logs for lateral attempts. You decide isolation after you have scope.
- The IR lead's first three questions: "What's the scope? What's the impact? Is evidence preserved?" If you can't answer any of them, your next 20 minutes is answering them.
- Never tell the CISO "we've contained it" until you've validated no outbound C2, no new persistence, and no lateral attempts for an observation window appropriate to the threat. Premature containment claims are how careers end. *"Contained" is a status with a clock attached — say "containment actions complete, monitoring for residual activity" instead.*
- Legal hold is not the SOC's call. The moment an incident looks like it might involve litigation, regulator notification, or insurance claims, legal gets pulled in. The SOC's job is to preserve everything until legal says otherwise.
- The post-incident meeting is where the org actually pays for the incident. Skip it and the same misconfiguration that caused this one will cause the next one. *The wipe is data. The retro is wisdom.*

## Related concepts

[[Incident Response]] · [[Preparation Phase]] · [[Detection and Analysis]] · [[Containment]] · [[Eradication]] · [[Recovery]] · [[Post-incident Activity]] · [[Chain of Custody]] · [[Legal Hold]] · [[Evidence Acquisition]] · [[Compensating Controls]] · [[Re-imaging]] · [[MTTD]] · [[MTTR]] · [[NIST SP 800-61]] · [[IoC]] · [[EDR]]

*Source: VIRGIL knowledge base — 2026-05-11*