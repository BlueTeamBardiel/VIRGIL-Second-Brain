# Agent-Based vs Agentless

## What it is

In **Watch Dogs**, Aiden Pearce has two ways to know what's happening in Chicago. He can hack a single ctOS camera and sit on the feed — see what that one camera sees, in real time, even when nothing's moving, even when the network's quiet. Or he can pull the city-wide ctOS profiler as he walks past pedestrians and pings their phones from the street — broad sweep, gets a name and a stat block for everyone in range, but only when he's nearby and only what the network exposes from outside.

That's exactly the split between agent-based and agentless scanning. The camera is the agent — installed, persistent, sees everything that endpoint does. The profiler is agentless — reach out from the network, ask what's there, take what you get.

**Technical definition (CS0-003 Objective 2.1):** Vulnerability scanning collects asset state to identify exposures. **Agent-based scanning** uses a lightweight software component installed on the endpoint that collects local data continuously and reports findings to a central console. **Agentless scanning** uses a remote scanner that reaches the target over the network — credentialed or uncredentialed — and infers state from what's reachable. Same goal, two different delivery models with very different operational tradeoffs.

## Why it matters

This is the single architectural decision that defines your vulnerability management coverage. Pick wrong and you get one of two failure modes: agentless blindspots where assets disappear from inventory (laptops off the VPN, cloud VMs that auto-scale, OT segments you can't touch), or agent-based deployment hell where half your endpoints never get the agent and the other half drift out of policy.

CompTIA tests this directly under Objective 2.1, and it's adjacent to asset discovery, credentialed vs. uncredentialed scanning, and special considerations for OT/ICS. The exam loves to give you a scenario — remote workforce, hybrid cloud, SCADA segment, PCI cardholder zone — and ask which scanning model fits. The answer is almost never "one or the other." It's almost always "both, scoped by asset class."

## Key facts

### Agent-based scanning

A small persistent process runs on each endpoint. It enumerates installed software, missing patches, configuration drift, and local vulnerabilities. Data flows from endpoint → console on a schedule or in near-real-time.

| Property | Agent-based |
|---|---|
| Network dependency | Reports out when connected; collects offline |
| Credentials needed | None — runs locally with system privileges |
| Coverage of remote/mobile assets | Excellent — laptop on hotel Wi-Fi still reports |
| Visibility depth | Deep — local registry, file system, running processes, installed software |
| Deployment effort | High — packaging, MDM/SCCM rollout, exception handling |
| Impact on host | Continuous low-level CPU/memory; risk of conflicts with EDR |
| Works on unmanaged assets | No |
| Good fit for | Laptops, cloud VMs, servers, BYOD-adjacent corporate fleet |

The killer feature: **persistent local context**. The agent knows the host was running an unpatched Chrome version at 14:02 even if the host went offline at 14:03. Agentless can't see what's not on the network.

### Agentless scanning

A scanner — Nessus, Qualys, Rapid7, OpenVAS, whatever — reaches the target over the network. It can run **uncredentialed** (port scan, banner grab, version inference) or **credentialed** (logs in via SSH/WinRM/SMB and reads the same registry and package data an agent would).

| Property | Agentless |
|---|---|
| Network dependency | Total — asset must be reachable when the scan runs |
| Credentials needed | Optional but recommended (credentialed scans are deeper) |
| Coverage of remote/mobile assets | Poor — if it's off the VPN, it doesn't exist |
| Visibility depth | Shallow without creds, deep with creds (but never as deep as agent) |
| Deployment effort | Low — point the scanner at a subnet |
| Impact on host | Spike during scan window; can crash fragile services (OT, printers) |
| Works on unmanaged assets | Yes — that's the whole point |
| Good fit for | Network appliances, printers, OT/ICS (passive), discovery, third-party assets |

### Credentialed vs. uncredentialed

This is its own exam concept but it lives inside agentless. **Credentialed** scans authenticate to the target and read system state directly — they find the same vulnerabilities an agent would and have a fraction of the false-positive rate. **Uncredentialed** scans see only what an attacker on the network would see — open ports, service banners, exposed versions. Use uncredentialed when you want the attacker's view. Use credentialed when you want ground truth.

### Active vs. passive scanning

Adjacent concept worth knowing. **Active** scanning sends packets at the target — both agentless network scans and the agent itself qualify. **Passive** scanning watches network traffic without touching the asset, fingerprinting devices from observed traffic. Passive is what you use on **OT/ICS/SCADA** networks where an active scan can knock a PLC offline and stop a production line. The exam will pair "SCADA" or "critical infrastructure" with "passive scanning" — that's the trap.

### Special considerations by asset class

- **OT/ICS/SCADA** — agentless passive only. Agents don't exist for most PLCs and HMIs. Active scans crash them. This is non-negotiable.
- **Cloud VMs (auto-scaling)** — agent-based baked into the golden image, or agentless via cloud API integration. Pure network agentless misses ephemeral instances.
- **Containers** — neither traditional model fits well. Use image scanning (static analysis of the container image) plus runtime agents on the orchestrator nodes.
- **PCI DSS cardholder data environment** — quarterly external agentless scans by an ASV (Approved Scanning Vendor) are mandatory. Internal scans on top of that — your call on model, but coverage must be provable.
- **Air-gapped networks** — agent-based with offline reporting, or scheduled scanner appliances physically inside the segment.
- **BYOD / unmanaged** — agentless only. You can't install an agent on a device you don't own.

### Scheduling and performance

Agentless scans hit hard during the scan window. Schedule them for maintenance windows for production, off-hours for office networks, and **never** during business hours on OT. Agents spread the load continuously, which is gentler on the network but means you're trusting the endpoint not to lie about itself.

### Where each model maps to other CS0-003 concepts

- [[Asset discovery]] — agentless wins; agents only know about hosts you've already deployed to
- [[Device fingerprinting]] — agentless, often passive
- [[Security baseline scanning]] — agent-based, compared against [[CIS benchmarks]] or [[ISO 27000]] series controls
- [[Internal vs external scanning]] — orthogonal axis; either model can be internal or external
- [[Map scans]] — agentless network sweep (think nmap)
- [[Static vs dynamic analysis]] — different layer (application code), not host scanning
- [[Fuzzing]] and [[Reverse engineering]] — application security tooling, not host vulnerability scanning

### CompTIA exam traps

> **CompTIA exam trap:** "Which scanning method should be used on a SCADA network?" The obvious answer is "agentless" because you can't install agents on PLCs. The *correct* answer is "passive agentless" or "passive network monitoring." Active agentless scans crash industrial controllers. CompTIA pairs OT/ICS with passive every time.

> **CompTIA exam trap:** "Why does agent-based scanning produce fewer false positives than agentless?" Not because the tooling is smarter — because the agent has direct local read access and doesn't have to infer from banners or guess from open ports. Same reason credentialed agentless beats uncredentialed agentless.

> **CompTIA exam trap:** "A remote workforce uses laptops that frequently leave the corporate network. Which scanning approach provides the best coverage?" Agent-based. Agentless can't scan what isn't reachable. The trap distractor is "external agentless scanning" — that scans your perimeter, not your laptops.

> **CompTIA exam trap:** PCI DSS specifically requires **external scans by an ASV at least quarterly and after any significant change**. Internal scans are also required quarterly. The exam wants you to know "quarterly" and "ASV" — both terms.

## SOC reality

- The vuln management console shows two numbers in every standup: **agent check-in rate** and **scan coverage percentage**. If agent check-in drops below ~95%, something broke the rollout — a new GPO, an EDR conflict, an MDM push. If agentless coverage drops, somebody added a subnet to the network and didn't tell anyone.
- The 3am call is almost never "the scan found a critical." The 3am call is "the scan crashed the HMI on line 3 and the plant manager wants someone's head." That's why you have a maintenance window, a change ticket, and a rollback plan for every scanner change. *Production never gets touched without a written window — every time I've seen "just a quick scan" it ended with a postmortem.*
- The CISO question is always the same: "What's our coverage?" Not "how many criticals" — coverage. Because a critical you didn't find is worse than a critical you're tracking. Answer in two numbers: percentage of known assets under agent + percentage of network ranges under recurring agentless. If you can't say both, you don't know your coverage.
- The L1 triage move when a high-severity finding hits the queue: confirm the asset is real (cross-check with CMDB), confirm the finding is real (credentialed re-scan or pull the agent's raw output), confirm exposure (is it internet-facing, segmented, compensating controls in place?). Then escalate. CVSS 9.8 on an asset that doesn't exist anymore is the most common false-priority-one in the field.
- Never promise leadership "100% coverage." There is no such thing. There's always the printer in the lobby that nobody owns, the dev's personal Raspberry Pi on the guest VLAN, the SCADA segment you're not allowed to touch. *The honest answer is always a number with a caveat, never a number alone.*

## Related concepts

[[Asset discovery]] · [[Credentialed vs Uncredentialed Scanning]] · [[Active vs Passive Scanning]] · [[Internal vs External Scanning]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[OT and ICS Security]] · [[SCADA]] · [[Security Baseline Scanning]] · [[Device Fingerprinting]] · [[Vulnerability Scan Scheduling]] · [[CVSS]] · [[EDR]] · [[ISO 27000 Series]]

*Source: VIRGIL knowledge base — 2026-05-11*