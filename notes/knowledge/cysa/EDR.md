# EDR — Endpoint Detection and Response

## What it is

In **DayZ**, you log into a fresh server and the first thing you do is listen. Not look — *listen*. A distant gunshot east. Footsteps on gravel two buildings over. A car engine idling at the treeline. You're not watching one threat; you're parsing every audio cue your character can hear, building a map of who's moving, where they came from, what they're carrying. The moment something deviates from the ambient hum of zombies and wind — a suppressed shot, a flashlight clicking on in a window — you mark it, you move, you decide whether to engage or melt into the woods. That ambient awareness, persistent and paranoid, running on every player on the server, is what **EDR** does on every endpoint in the fleet.

**Plain English:** EDR is the agent installed on every laptop, server, and workstation that watches process behavior, network connections, file changes, and registry edits in real time, ships that telemetry to a central console, flags suspicious patterns, and lets you respond — kill the process, isolate the host, pull a memory dump — without ever walking to the machine.

**Technical:** Endpoint Detection and Response is a host-based security platform that combines continuous endpoint telemetry collection, behavioral analytics, IoC matching, and remote response capabilities. Modern EDR fuses signature detection, heuristic analysis, and ML-driven behavior baselining to detect threats that bypass traditional AV, then exposes the endpoint to the responder via remote shell, file retrieval, network isolation, and process termination from the console.

## Why it matters

CompTIA puts EDR at the center of [[CS0-003 Objective 3.2]] — incident response activities. Every phase of the IR lifecycle touches it: detection and analysis happens *in* the EDR console, containment is a button labeled "isolate host," evidence acquisition pulls memory and disk artifacts through the agent, and post-incident scope hunts are EDR queries across the fleet.

Career relevance is blunt: if you cannot drive an EDR console — CrowdStrike Falcon, SentinelOne, Microsoft Defender for Endpoint, Carbon Black, Cortex XDR — you cannot work modern SOC. Tier 1 lives in the alert queue. Tier 2 pivots from alert to process tree to parent-of-parent to root cause. IR uses it to scope blast radius across 40,000 endpoints in twenty minutes instead of imaging machines one by one.

Real-world stakes: the gap between detection and containment is where ransomware encrypts the file server. EDR collapses that gap from hours to seconds.

## Key facts

### What EDR actually collects

| Telemetry | Why it matters |
|---|---|
| Process creation (parent → child) | The whole [[kill chain]] lives in process trees. powershell.exe spawned by winword.exe is a macro detonation. |
| Command-line arguments | `-EncodedCommand`, `-nop -w hidden`, base64 blobs. The IoC is in the args, not the binary. |
| Network connections | Per-process, per-PID — which process talked to which IP on which port. [[Beaconing]] shows up here. |
| File system events | Writes to `\Users\Public\`, `\AppData\Roaming\`, `\Windows\Temp\`, unsigned binaries dropped in user-writable paths. |
| Registry modifications | `Run`, `RunOnce`, services, scheduled tasks — [[persistence]] mechanisms. |
| Module loads | DLLs loaded into processes. [[DLL injection]] and [[process hollowing]] surface here. |
| Authentication events | Lsass access, token manipulation, [[pass-the-hash]] artifacts. |
| Script content | PowerShell ScriptBlock logging, AMSI buffers, JavaScript executions. |

### EDR vs antivirus vs XDR

- **AV / EPP (Endpoint Protection Platform):** signature-based, blocks known-bad on execution. Necessary, insufficient. Cannot see fileless malware, LOLBINs ([[living off the land]]), or anything novel.
- **EDR:** behavior-based, records everything, queryable after the fact, supports remote response. Catches the unknown.
- **XDR:** EDR extended across endpoint + network + email + cloud + identity. One console, correlated telemetry.

> **CompTIA exam trap:** EDR is *not* a replacement for AV — it complements it. AV blocks known threats at execution; EDR detects behavior post-execution. If the exam asks which control detects fileless / LOLBin attacks, the answer is EDR, never AV.

### Mapping EDR to the IR lifecycle

CompTIA tests the NIST SP 800-61 four-phase lifecycle. Every phase has an EDR action.

**Preparation**
- Deploy agents to 100% of endpoints (the un-agented host is the breach).
- Tune detection policy — too aggressive and the L1 queue melts; too loose and you miss the intrusion.
- Build response playbooks tied to EDR actions: isolate, kill, retrieve, image.
- Define [[compensating controls]] for hosts where the agent can't run (legacy OS, OT/ICS, kiosks).

**Detection and Analysis**
- The EDR fires a detection: severity, MITRE ATT&CK technique ID, process tree, host, user.
- Analyst pivots: parent process, command line, network destination, file hash → VT lookup, reputation, threat intel match.
- Pull [[IoC]]s from the detection — hashes, IPs, domains, mutexes — and hunt across the fleet for the same artifacts. **Scope** is "how many other endpoints show this?"
- **Data and log analysis:** EDR query language (KQL in Defender, EAM in Falcon, PowerQuery in S1) is the muscle. Learn one fluently.

**Containment, Eradication, and Recovery**
- **Isolation:** network-isolate the host from the console — agent stays connected to EDR cloud, everything else blocked. The host is quarantined without walking to the desk.
- **Eradication:** kill the malicious process, delete the dropper, remove persistence (scheduled task, registry run key, service). Block the hash and the C2 domain fleet-wide.
- **Recovery:** [[re-imaging]] is the only trustworthy recovery for confirmed compromise. Restoring from backup is faster but inherits whatever persistence sat on the image.
- **Compensating controls:** if you can't patch or re-image immediately (production system, change freeze), tighten EDR policy to block the technique, add network ACL, or move the host to a segmented VLAN.

**Post-incident Activity**
- Threat hunt across 90 days of retained EDR telemetry — did this actor touch us before? Did they pivot anywhere we missed?
- Tune detection rules from the lessons learned. Permanent immunity.
- Feed IoCs to SIEM, firewall, email gateway. One incident, fleet-wide hardening.

### Evidence acquisition through EDR

EDR is now the primary forensic collection tool for live response.

| Artifact | EDR capability |
|---|---|
| Memory image | `memdump` / live response shell → RAM capture, shipped to console |
| Disk artifacts | File retrieval of specific paths: `$MFT`, prefetch, registry hives, event logs |
| Process memory | Dump a single PID's address space for malware analysis |
| Timeline | The EDR's own telemetry IS the timeline — every event timestamped server-side |

**Validating data integrity:** every artifact retrieved through EDR is hashed (SHA-256) at acquisition and again at the analyst workstation. Hash mismatch = the file changed in transit = the evidence is suspect. The EDR vendor's hash log is your provenance record.

**Chain of custody:** EDR consoles log every responder action — who isolated the host, who pulled the memory image, who killed which process, timestamped to the second. Export that audit log; it IS the chain of custody for any artifact pulled through the agent. If the case goes to court or arbitration, that log proves the evidence wasn't tampered with.

**Preservation and legal hold:** before re-imaging, snapshot the disk and pull memory. Once the host is wiped, the artifacts are gone. If legal has placed a hold on the user or asset, you do not re-image until counsel signs off in writing — preservation obligation overrides operational speed.

> **CompTIA exam trap:** the order is **preserve, then remediate**. Re-imaging a compromised host before evidence acquisition destroys the case. If the exam scenario says "ransomware on the CFO's laptop, what first?" the answer is acquire evidence (memory, disk image) before re-imaging, unless active harm forces immediate containment. Even then: isolate first, image second, re-image last.

### Scope and impact assessment

EDR is the scoping tool. After detection on one host, the next question is always the same: **where else?**

- IoC sweep: search the fleet for the same hash, IP, domain, mutex, named pipe.
- Behavioral sweep: search for the same technique pattern — any host where `winword.exe` spawned `powershell.exe -EncodedCommand` in the last 30 days.
- Identity pivot: any host where the compromised user authenticated. Lateral movement candidates.

**Impact** is what the actor accomplished: data accessed, credentials stolen, persistence established, lateral hops made. EDR's process and network telemetry answers most of these directly. What it doesn't answer — exfil volume, file content read — comes from DLP, proxy logs, and [[SIEM]] correlation.

### Known limitations

- **Tampering:** sophisticated actors disable the EDR agent first. Detection: tamper-protection events, agent heartbeat gaps, kernel callback unhooks.
- **Coverage gaps:** unmanaged BYOD, contractor laptops, legacy Windows 7, Linux servers running an unsupported agent build. The breach finds the gap.
- **Alert fatigue:** poorly tuned policy = 4,000 alerts/day = analyst tunes everything to low severity = real detection drowns. Tuning is half the job.
- **Cloud workload blind spots:** containers, serverless, ephemeral VMs that live shorter than the agent install takes.

*An EDR alert is not a contained host. A killed process is not an eradicated threat. A re-imaged laptop is not a closed incident until you've scoped the rest of the fleet.*

## SOC reality

- **3am alert** in Falcon: "Suspicious PowerShell — encoded command, parent process Outlook.exe, host FIN-LAPTOP-042, user j.martinez." L1 pulls the process tree, confirms it's not a known admin script, isolates the host from the console in under 90 seconds. That's the job.
- **First L1 action** is never "kill the process." It's: acknowledge the alert, confirm it's not a duplicate, pull the process tree screenshot, isolate the host, page L2. Killing the process tips the actor that they've been seen. Containment first, then decide on eradication timing.
- **The IR lead asks four questions, in order:** What's the scope (how many hosts)? What's the impact (what was accessed/exfiltrated)? Is evidence preserved (memory, disk, EDR timeline)? Are we contained (network isolation confirmed)? Have those answers ready before you brief.
- **Never tell the CISO "we've contained it"** until you've run the IoC sweep across the fleet and the results are clean. "We've isolated patient zero and the sweep is running" is honest. "We're contained" is a promise you can't yet keep.
- **Handoff path:** L1 triages and isolates → L2 scopes and acquires evidence → IR team leads eradication and recovery → legal gets pulled in if PII/regulated data is in scope → executive comms only after scope and impact are confirmed in writing.

## Related concepts

[[XDR]] · [[SIEM]] · [[SOAR]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[IoC]] · [[Chain of custody]] · [[Legal hold]] · [[Re-imaging]] · [[Compensating controls]] · [[Memory forensics]] · [[Living off the land]] · [[Beaconing]] · [[Persistence]] · [[Lateral movement]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*