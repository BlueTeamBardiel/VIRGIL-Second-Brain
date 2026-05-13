# Increases in Resource Usage

## What it is

In **Destiny**, when you're running a Nightfall and the Warlock's Well of Radiance is suddenly burning through Super energy twice as fast as the build's supposed to allow, you don't shrug — something is wrong. Maybe the strike modifier is draining you. Maybe a Champion's aura is leeching. Maybe your fireteam picked up a debuff nobody noticed. The number on the HUD is the symptom; the cause is upstream and hostile. That's exactly what a resource usage spike on a host is — the HUD telling you something is consuming more than the build allows, and you need to find the source before the wipe.

In plain English: when a server, endpoint, or network link starts burning more CPU, memory, disk, or bandwidth than its baseline, something changed. Could be a legitimate workload. Could be a misbehaving app. Could be an attacker mining crypto, exfiltrating data, running a brute-force, or staging tools on your box.

Technical definition: **Increases in resource usage** are a category of host-based and network-based **indicators of compromise (IoC)** where measurable consumption — CPU%, RAM, disk I/O, disk space, network throughput, database read/write volume, process count — deviates significantly above an established **baseline**. CompTIA classifies these under detection and analysis indicators in objective 3.2.

## Why it matters

Resource spikes are one of the most common — and most ignored — early signals of compromise. Cryptojacking is the obvious case: an attacker drops XMRig on a hypervisor and the CPU pegs at 95% across the cluster. But the same indicator class catches data exfiltration (outbound bandwidth climbing), ransomware staging (disk I/O spikes as files get enumerated and encrypted), credential stuffing (DB read volume going vertical), and tool staging (memory consumption climbing on a workstation that should be idle at 2am).

For the CySA+ exam, these fall under [[Indicators of Compromise]] in detection and analysis (Objective 3.2). You will see scenario questions where a chart shows a CPU graph climbing and you have to pick the most likely cause — or where you're given four log snippets and asked which one correlates with the resource anomaly. The exam wants you to know that **a spike alone is not an incident** — it's a trigger to investigate.

Career-wise, this is L1 SOC bread and butter. You will spend more hours of your career staring at resource graphs than at flashy malware reports. Get good at reading them or get out of the chair.

## Key facts

### The four resource classes you watch

| Resource | What spikes look like | Common malicious cause |
|---|---|---|
| **CPU** | Sustained 80%+ on a host that idles at 10% | Cryptojacking, password cracking, malware unpacking |
| **Memory** | RAM consumption climbing without process correlation | Memory-resident malware, process injection, data staging |
| **Disk** | I/O spikes, free space dropping | Ransomware encryption, exfil staging, log tampering |
| **Network** | Outbound bandwidth above baseline, especially off-hours | C2 beaconing, data exfiltration, DDoS participation |

Database read/write volume gets its own bucket in enterprise — a SQL server doing 10x its normal read volume at 3am is either a backup job nobody told you about or someone enumerating tables before they dump them.

### Why baselines are everything

You cannot detect a deviation without knowing normal. A baseline is the recorded average and variance of resource usage across time — by host, by hour-of-day, by day-of-week. The web server that hits 70% CPU every Tuesday at 9am because of the weekly report job isn't an incident; it's Tuesday. The same 70% on a Sunday at 4am is a ticket.

*If your environment has no baselines, you don't have detection — you have guessing with extra steps.*

Baselines come from:
- **EDR/XDR telemetry** rolled up over 30–90 days
- **SIEM aggregation** of performance counters
- **APM (application performance monitoring)** tools like the ones the app team already runs
- **Hypervisor metrics** for VM environments
- **NetFlow / IPFIX / sFlow** for bandwidth baselines

### Correlation is mandatory

A spike by itself is noise. A spike correlated with other [[Indicators of Compromise]] is signal. The pairings that matter:

- **CPU spike + unknown process** = cryptojacking or unpacker. Pull the process tree.
- **Memory spike + suspicious parent-child relationship** (e.g., winword.exe spawning powershell.exe) = injection or LOLBin abuse.
- **Disk I/O spike + mass file rename events** = ransomware encryption pass. Pull the plug.
- **Outbound bandwidth spike + beaconing intervals** = exfil or active C2. Capture the flow.
- **DB read spike + failed login bursts** = credential stuffing followed by dump.

The L1 mistake is treating the spike as the incident. The spike is the alarm. The incident is whatever is causing it.

### What the analyst actually does — the triage flow

1. **Acknowledge the alert** in the SIEM/EDR console. Stop the clock for [[MTTD]].
2. **Compare to baseline** — is this host normally this busy at this hour? Pull the 30-day chart.
3. **Identify the top consumer** — `top`, `htop`, Task Manager, Process Explorer, Sysinternals, or the EDR process view. Get the PID, the binary path, the parent process, the command line.
4. **Hash and reputation-check** the binary. VirusTotal, internal threat intel, [[STIX/TAXII]] feeds.
5. **Check network connections** the process owns — `netstat -anob`, `ss -tnp`, EDR network view. Any external IPs? Any beaconing pattern?
6. **Correlate in SIEM** — what else fired on this host in the last 24 hours? Logon events, scheduled task creation, registry modifications, AV alerts?
7. **Decide**: false positive (legit workload), tune the rule, or escalate to L2/IR.

### When it's actually an incident — IR phases applied

Once it's escalated past L1, the CompTIA [[Incident Response Lifecycle]] kicks in:

**Detection and analysis** — you've already done initial detection. Now you're deepening: pulling [[Memory Acquisition]] from the affected host, capturing volatile data first (RAM, network connections, running processes) before anything that touches disk. **Evidence acquisitions** must follow **chain of custody** — every transfer logged, every hash recorded. **Validating data integrity** means SHA-256 hashing the memory dump immediately and at every handoff so you can prove in court the image wasn't tampered with.

**Containment, eradication, and recovery** — for a resource-spike incident the containment options are:
- **Isolation** — yank the host from the network via EDR network containment or switch port shutdown. Don't power it off if you haven't grabbed memory yet.
- **Compensating controls** — if you can't isolate (it's a production DB that the business won't let you touch), put a network ACL upstream to block egress to the C2 IP, throttle the bandwidth, or proxy outbound through a forensic tap.
- **Preservation** — image the disk before you re-image. Bit-for-bit copy with a write blocker. The disk is evidence.
- **Re-imaging** — once you've preserved evidence and confirmed scope, wipe and rebuild from a known-good gold image. Don't try to "clean" a compromised host. You will miss something.
- **Remediation** — patch the vulnerability that let them in, rotate every credential that touched that host, push detections for the IoCs into the SIEM.

**Post-incident activity** — root cause analysis. Update the playbook so the next L1 catches it in 5 minutes instead of 50.

### Legal hold

If the incident touches regulated data, customer PII, or anything that might end up in litigation, **legal hold** triggers. That means: preserve everything, destroy nothing, document every action. The hypervisor snapshot stays. The SIEM logs get a retention extension. Re-imaging doesn't happen until legal says so. The L1 instinct to "just rebuild it and move on" is the wrong instinct when legal hold is in play.

### CompTIA exam traps

> **CompTIA exam trap:** A CPU spike on a host is NOT by itself a confirmed incident. The exam will give you a scenario where CPU jumps to 95% and ask the "best next step." The answer is almost never "contain the host" — it's investigate, correlate, identify the process. Containment without scope is operational malpractice and CompTIA tests this. Read the answers carefully — the one that says "isolate immediately" is usually the trap.

> **CompTIA exam trap:** **Scope** and **impact** are different. Scope = how many hosts, accounts, systems are affected. Impact = what's the business consequence (downtime, data loss, regulatory exposure). The exam will offer both as answer choices and the correct pick depends on whether the question asks "how big" (scope) or "how bad" (impact).

> **CompTIA exam trap:** Memory acquisition comes BEFORE disk acquisition. Order of volatility — RAM is volatile, disk is not. If you image the disk first and then power-cycle for RAM capture, the RAM is gone. The exam loves this ordering question.

> **CompTIA exam trap:** **Compensating controls** are not the same as remediation. A compensating control is a temporary mitigation when you can't fix the root cause yet (e.g., WAF rule because you can't patch the vuln app today). Remediation fixes the root cause. Exam will offer both; pick based on whether the scenario says "permanent fix" or "temporary mitigation."

## SOC reality

- The alert at 3am reads something like `HostCPU > 90% for 15min — SRV-FIN-04 — baseline 12%`. You acknowledge, pull the 30-day chart, see this host has never broken 40%, and your stomach drops a little.
- First action is never containment. First action is `tasklist /v` or the EDR process view to find the consumer. If it's `xmrig.exe`, `svchost.exe` in a weird path, or anything spawned by Office, you escalate. If it's the backup agent running late, you tune the rule and close the ticket.
- The IR lead will ask three questions in this order: "What's the scope?" "Is evidence preserved?" "Can we contain without breaking the business?" Have answers ready before you call.
- Never tell leadership "we've contained it" until network containment is confirmed AND you've validated no other hosts are showing the same IoCs. The L2 who says "contained" at minute 10 and finds five more infected hosts at minute 90 is the L2 who's writing the incident report at 6am.
- The handoff is L1 (triage, initial scoping) → L2 (deep analysis, correlation across hosts) → IR team (containment decisions, evidence chain) → legal/comms (if regulated data or external disclosure). Know which seat you're in and don't make decisions above your pay grade.

## Related concepts

[[Indicators of Compromise]] · [[Incident Response Lifecycle]] · [[Chain of Custody]] · [[Memory Acquisition]] · [[Order of Volatility]] · [[Beaconing]] · [[Cryptojacking]] · [[Data Exfiltration]] · [[SIEM]] · [[EDR XDR]] · [[NetFlow]] · [[Baseline Configuration]] · [[Legal Hold]] · [[Compensating Controls]] · [[Re-imaging]] · [[Scope and Impact]]

*Source: VIRGIL knowledge base — 2026-05-11*