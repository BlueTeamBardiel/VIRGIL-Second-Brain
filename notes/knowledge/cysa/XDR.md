# XDR — Extended Detection and Response

## What it is

In **Sekiro: Shadows Die Twice**, the Sculptor's Idol isn't just a checkpoint — it's a correlation engine. When you die to the Guardian Ape, Sekiro doesn't just respawn; the game tracks Dragonrot spreading through NPCs, your Unseen Aid percentage dropping, Emma's dialogue shifting, Kuro's coughing fits getting worse. One death event ripples across the entire world state, and the game stitches those signals together so you can see the *systemic* consequence, not just the corpse. EDR sees the corpse. XDR sees the Dragonrot.

That's exactly what XDR does — it pulls telemetry from endpoint, network, email, identity, and cloud into one correlation layer so a single attack chain shows up as one story instead of five disconnected alerts.

**Technical definition:** Extended Detection and Response is a unified security platform that ingests, normalizes, and correlates telemetry across multiple control planes — endpoint, network, identity, email, cloud workload, SaaS — and produces high-fidelity, context-rich detections plus orchestrated response actions. XDR is the evolution of EDR (which only sees endpoint) and is adjacent to but distinct from SIEM (which is log-centric and analyst-driven). XDR is detection-centric and vendor-curated.

## Why it matters

**Career relevance:** Every modern SOC job description lists XDR. CrowdStrike Falcon, Microsoft Defender XDR, Palo Alto Cortex XDR, SentinelOne Singularity — these are the platforms L1 and L2 analysts live inside. If you can't pivot from an endpoint alert to the identity sign-in to the lateral SMB connection to the exfil to the inbox rule that started it, you're slower than the attacker.

**Real-world stakes:** Mean dwell time for unmanaged intrusions still runs in weeks. XDR collapses that because correlation kills the "alert fatigue" problem — instead of 400 endpoint alerts, you get one incident graph showing root cause, blast radius, and affected identities. The 2020 SolarWinds intrusion is the textbook case for *why* siloed detection fails: endpoint AV was clean, but identity + network + cloud signals together told the story.

**Exam relevance:** CySA+ CS0-003 Objective 3.2 (incident response activities) is the home objective. XDR touches detection and analysis, scope determination, containment via host isolation, evidence acquisition, data and log analysis. Expect XDR vs EDR vs SIEM distinction questions, plus scenarios where you pick the right tool for scoping an incident.

## Key facts

### XDR vs EDR vs SIEM vs MDR

| Tool | Scope | Primary input | Primary user | Strength |
|------|-------|---------------|--------------|----------|
| **EDR** | Endpoint only | Process, file, registry, kernel telemetry | SOC analyst | Deep endpoint visibility, host isolation |
| **XDR** | Endpoint + network + identity + email + cloud | Normalized cross-domain telemetry | SOC analyst | Cross-domain correlation, incident graphs |
| **SIEM** | Everything you feed it | Raw logs (syslog, CEF, JSON) | SOC analyst / engineer | Custom rules, compliance, long retention |
| **MDR** | Whatever the vendor watches | Service-delivered, varies | Outsourced SOC | 24x7 humans + tooling for orgs without a SOC |
| **SOAR** | Workflow on top of detections | API actions, playbooks | SOC engineer | Automation, response orchestration |

> **CompTIA exam trap:** XDR is **not** "SIEM with a new name." SIEM is log-storage-and-query, vendor-agnostic, analyst-built rules. XDR is **vendor-curated correlation across a defined telemetry set**, with detections shipped by the vendor. If the question asks about long-term log retention for compliance — that's SIEM. If it asks about correlating an endpoint detonation with a suspicious sign-in and a malicious inbox rule — that's XDR.

### Telemetry sources XDR stitches together

- **Endpoint** — process trees, command lines, file writes, registry changes, parent-child relationships, EDR detections
- **Network** — NetFlow/IPFIX, DNS queries, TLS metadata, firewall connection logs, IDS/IPS hits
- **Identity** — Entra ID / Okta sign-ins, MFA prompts, risky-user scoring, conditional access decisions, Kerberos events
- **Email** — phishing detections, attachment detonation results, URL clicks, inbox rule creation (a classic BEC IoC)
- **Cloud workload** — CloudTrail, Azure activity logs, Kubernetes audit logs, container runtime events
- **SaaS** — OAuth grants, file sharing, admin role changes, anomalous API usage

*The value isn't any one signal. It's the join.*

### Native XDR vs Open / Hybrid XDR

- **Native XDR** — single vendor stack (Microsoft Defender XDR, CrowdStrike Falcon). Tight integration, fast deployment, vendor lock-in.
- **Open / Hybrid XDR** — vendor-neutral correlation layer that ingests third-party telemetry. More flexible, more integration work, more places things break.

CompTIA doesn't require you to memorize vendors but does test the concept that XDR can be single-vendor or multi-vendor architecture.

### How XDR maps to the IR lifecycle (NIST SP 800-61)

**1. Preparation**
- XDR sensors deployed across endpoints, identity provider, mail, network
- Detection content tuned, playbooks built, response actions tested
- *If you didn't onboard the domain controller telemetry before the incident, you don't get to onboard it during the incident.*

**2. Detection and Analysis**
- Cross-domain alerts surface as a single **incident** with an attack graph
- Analyst pivots through the graph: which endpoint, which user, which network destination, which email
- **Data and log analysis** happens inside the platform — search across all sources at once
- **Scope** determined by the graph: how many hosts, how many identities, what blast radius
- **Impact** assessed: data accessed, credentials stolen, persistence established

**3. Containment, Eradication, and Recovery**
- **Isolation** — XDR triggers host isolation (network-quarantine via the EDR agent; host can still talk to the XDR cloud but nothing else)
- **Identity containment** — disable the account, revoke active sessions, force password reset, kill OAuth tokens
- **Email containment** — purge the phish from every inbox, block the sender, kill the inbox rule
- **Compensating controls** — if you can't patch the exploited vuln immediately, XDR can deploy a custom detection or block rule as a stopgap
- **Eradication** — kill the process, quarantine the binary, remove persistence (scheduled task, run key, service)
- **Remediation** — patch the CVE, rotate credentials, revoke certs
- **Re-imaging** — for confirmed compromise on a workstation, nuke and pave is faster and safer than surgical cleanup. XDR's role here is providing the *confidence* that re-imaging is necessary, by showing the full attack chain

**4. Post-incident Activity**
- XDR retains the incident graph as a forensic artifact
- Root cause analysis uses the timeline
- Detection gaps identified — what didn't fire, why, what content needs writing

### Evidence acquisition, chain of custody, integrity

XDR is a detection and response platform. It is **not** a forensic acquisition tool in the strict sense. CompTIA loves this distinction.

- **Evidence acquisition** — XDR captures process telemetry, command lines, network connections, file hashes. For deep forensic work (memory image, full disk image), you still need dedicated tools (KAPE, FTK Imager, Velociraptor, magnet RAM capture).
- **Validating data integrity** — XDR-collected artifacts are hashed (SHA-256 typically) and signed; the platform maintains tamper-evident logs. When you export, document the hash before and after transfer.
- **Preservation** — XDR retention varies by license tier (often 7–30 days hot, longer cold). For incidents heading to litigation, **export artifacts immediately** — don't trust the default retention window.
- **Chain of custody** — every export from XDR must be logged: who pulled it, when, what hash, where it went, who received it. The platform's audit log is part of the chain.
- **Legal hold** — when counsel issues a hold, XDR retention policies must be overridden for the scoped users/hosts. Most enterprise XDR platforms support a legal-hold flag; if yours doesn't, export everything relevant *now*.

> **CompTIA exam trap:** XDR-collected telemetry is **evidence**, and the chain of custody starts the moment it's queried for an investigation, not when it's exported. If the analyst pulls a process tree, screenshots it, and pastes it into a Teams chat — chain of custody is already compromised. Use the platform's official export, document hash, store in evidence locker.

### IoCs XDR catches that single-domain tools miss

- **Phish → endpoint detonation → identity compromise → lateral movement → exfil** as one chain
- **Impossible-travel sign-in** correlated with a malicious OAuth grant correlated with a new mail-forwarding rule (textbook BEC)
- **Process spawning powershell.exe with encoded command** correlated with the user's risky sign-in 12 minutes earlier
- **Internal SMB beaconing** from a host that just received a phish attachment 30 minutes ago
- **Service account suddenly authenticating from an interactive session** — single-source it's noise, correlated it's pass-the-hash

## CompTIA exam traps

> **Trap 1: XDR vs SIEM.** SIEM is logs + analyst-built rules + long retention + compliance. XDR is curated cross-domain detection + response actions. Don't confuse them on the exam.

> **Trap 2: "Containment" via XDR is not "eradication."** Host isolation contains. Killing the process and removing persistence eradicates. Re-imaging is part of recovery. CompTIA asks the order.

> **Trap 3: Compensating controls.** When the question says "the vulnerability cannot be patched immediately due to a vendor dependency, what should the analyst do?" — the answer is a compensating control (XDR custom detection, network segmentation, application allowlist), not "accept the risk."

> **Trap 4: Re-imaging vs cleaning.** For confirmed compromise with persistence mechanisms you can't fully enumerate — re-image. CompTIA wants you to choose re-imaging over surgical cleanup when scope is uncertain.

## SOC reality

- **The 3am page** — XDR fires a high-severity incident: "Suspicious process execution + risky sign-in + outbound C2 traffic, host WIN10-FIN-04, user jdoe." You don't get five tickets; you get one graph. First action: acknowledge, pull the graph, decide if isolation is warranted before you finish your coffee.

- **L1's first move** — open the incident, walk the attack chain end-to-end, confirm it's not a known false positive (red team exercise, legitimate admin tool, vendor patch deployment). If real: isolate the host via XDR, disable the user, escalate to L2.

- **What the IR lead asks** — "Scope? How many hosts? Which identities? Evidence preserved? Is legal hold needed?" Have the answers ready from the XDR graph before the bridge call starts.

- **What you never promise** — "We've contained it." Not until the graph stops expanding and you've validated no new alerts for the same chain across 24 hours. *An isolated host is not a contained incident if the attacker already pivoted to identity.*

- **Handoff** — L1 isolates and disables. L2 scopes and eradicates. IR team owns re-imaging decision and external communication. Legal owns hold and notification timelines. XDR is the shared map everyone's reading from.

## Related concepts

[[EDR]] · [[SIEM]] · [[SOAR]] · [[MDR]] · [[Incident Response Lifecycle]] · [[Host Isolation]] · [[Chain of Custody]] · [[Compensating Controls]] · [[Re-imaging]] · [[Legal Hold]] · [[IoC]] · [[MITRE ATT&CK]] · [[Threat Hunting]] · [[Cloud Workload Protection]] · [[Identity Threat Detection and Response]]

*Source: VIRGIL knowledge base — 2026-05-11*