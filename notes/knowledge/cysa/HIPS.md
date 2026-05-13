# HIPS — Host-based Intrusion Prevention System

## What it is

In **The Legend of Zelda: Breath of the Wild**, when you walk into a shrine, the Sheikah Slate's runes are already on Link's wrist — Magnesis, Stasis, Cryonis, the bomb runes. The shrine throws a Guardian Scout at you, and Link doesn't wait for Impa to send help from Kakariko. He parries on the spot. The defense lives on Link, travels with Link, and works whether you're in Hyrule Field or the bottom of a Divine Beast where no signal reaches.

That's exactly what a HIPS does — it's a security agent that lives **on the host itself**, watches what the host is doing in real time, and **blocks** malicious behavior locally without waiting for a network-edge appliance to make the call.

Technical definition: a **Host-based Intrusion Prevention System** is a software agent installed on an endpoint or server that inspects local activity — system calls, process behavior, registry writes, file modifications, memory operations, and inbound/outbound network traffic at the host's NIC — against signatures, heuristics, and behavioral rules. Unlike its passive cousin [[HIDS]] (Host-based Intrusion Detection System), which only **alerts**, a HIPS can **drop the packet, kill the process, quarantine the file, or block the syscall** before the action completes. It is preventive, inline, and enforces policy at the host kernel or user-mode hook layer.

Most modern endpoint agents — Defender for Endpoint, CrowdStrike Falcon, SentinelOne, Carbon Black — bundle HIPS capability into the broader [[EDR]] / [[XDR]] stack. Pure-play HIPS as a standalone product is rare in 2026; the function survives inside the agent.

## Why it matters

HIPS is the last meaningful control before an attacker owns the host. The [[Firewall]] failed (or wasn't relevant — it's an insider, or it's encrypted traffic the firewall can't see). The [[NIPS]] missed it (or the traffic was lateral and never touched the perimeter). The user clicked. Now the host is on its own, and the HIPS agent is the only thing standing between a malicious macro and a domain-admin token.

For CySA+ **Objective 1.1**, HIPS sits inside the **infrastructure concepts** and **system hardening** topics, and it's one of the controls you list when an exam question asks how you'd harden an endpoint, what enforces a [[zero trust]] posture at the device layer, or what generates the host-level telemetry your [[SIEM]] is ingesting. Expect questions that contrast HIPS with HIDS, with NIPS, and with [[EDR]] — and questions that ask which control would have **prevented** versus only **detected** a given attack.

Career-wise: as an L1/L2 analyst you will spend real chunks of your week tuning HIPS rules, chasing false positives that blocked a finance macro at month-end, and writing exceptions for the one legacy app whose installer the agent keeps killing because it injects into explorer.exe. Knowing how the agent actually decides matters more than memorizing the marketing slide.

## Key facts

### What a HIPS actually inspects

A HIPS agent hooks into the operating system at multiple layers. On Windows, that means kernel callbacks, minifilter drivers for the filesystem, the [[Windows Registry]] notification API, ETW providers, and AMSI for script content. On Linux it means eBPF programs, auditd, LSM hooks (SELinux/AppArmor integration), and syscall tracing.

| Layer | What it watches | Example block |
|---|---|---|
| **Network** | Inbound/outbound packets at the host NIC | Drop C2 beacon to known-bad IP |
| **Process** | Process creation, parent-child chains, command-line args | Kill `winword.exe` spawning `powershell.exe -enc` |
| **Filesystem** | File creates, writes, deletes, renames | Block ransomware mass-encrypting `\Users\*` |
| **Registry** | Writes to autorun keys, service keys, AppInit_DLLs | Block write to `HKLM\...\Run\` from a non-installer |
| **Memory** | Process injection, hollowing, reflective DLL load | Block `CreateRemoteThread` into `lsass.exe` |
| **Syscall / API** | Suspicious API sequences (token theft, credential dumping) | Block `OpenProcess` with `PROCESS_VM_READ` against LSASS |

### Detection methods

HIPS uses three engines in parallel — same model as anti-cheat in competitive games. Signatures catch known cheats. Heuristics catch families. Behavior catches the new wallhack nobody's seen yet.

- **Signature-based.** Hashes, YARA rules, byte patterns. Fast, low false positive, useless against unknown payloads. This is the floor.
- **Heuristic / static analysis.** Inspect the binary or script before execution — unusual entry points, packed sections, obfuscated PowerShell. Catches variants of known families.
- **Behavioral / anomaly.** Watch the running process. If `Outlook.exe` spawns `cmd.exe` which spawns `bitsadmin /transfer`, the agent doesn't need a signature — that chain is its own indictment.

### HIPS vs HIDS vs NIPS vs EDR — the comparison CompTIA will test

| Control | Scope | Action | Visibility |
|---|---|---|---|
| **HIDS** | Single host | **Detects only** — alerts | Host-local logs, FIM, syscalls |
| **HIPS** | Single host | **Detects + prevents** — inline block | Host-local, real-time enforcement |
| **NIDS** | Network segment | Detects only | Network traffic, span/tap |
| **NIPS** | Network segment | Detects + prevents | Inline network traffic |
| **EDR** | Single host + cloud telemetry | Detect, prevent, hunt, respond | Host + correlation across fleet |

EDR is HIPS plus a memory of every event, plus a cloud brain that correlates across your whole endpoint fleet, plus IR tooling (isolate host, pull file, run query). HIPS is one component of what EDR does. On the exam, if the question is about a single-host inline block of a malicious action, the answer is HIPS. If the question is about hunting across the fleet for an IoC seen yesterday, the answer is EDR.

### Where HIPS fits in the stack

- **System hardening.** A baseline HIPS policy enforces application allowlisting, blocks unsigned drivers, and prevents tampering with the agent itself. Pair it with [[GPO]] / MDM hardening and you've cut the endpoint attack surface in half.
- **Zero trust.** In a [[zero trust]] model, the host is not trusted just because it's on the corporate VLAN. HIPS is the agent that enforces device-level policy regardless of network location — works the same on the home Wi-Fi as on the office floor.
- **Log ingestion.** HIPS events are gold for the [[SIEM]]. Process creation events (Windows 4688, Sysmon Event ID 1), network connection events (Sysmon 3), registry events (Sysmon 12/13/14) are the backbone of host-side detection. Ingest them at **Information** level minimum; **Verbose** if you have storage and a reason.
- **Time sync.** HIPS events are useless for forensics if the host clock drifts. [[NTP]] sync against a hardened internal source is mandatory — otherwise your timeline reconstruction will put the malicious process *after* the file it dropped.
- **Cloud / hybrid / serverless.** Modern HIPS agents run inside cloud VMs, inside containers (as a sidecar or daemonset), and as runtime protection on Kubernetes nodes. **Serverless** (Lambda, Azure Functions) is where HIPS breaks down — you don't own the host, so runtime protection shifts to the cloud provider plus [[CASB]] / [[CWPP]] tooling.

### Configuration and tuning

A HIPS policy is a layered ruleset. You start in **monitor mode** (log only), live with the noise for two weeks, build the exception list, then flip to **enforce mode**. Skipping monitor mode is how you get paged at 2am because the agent killed the SQL Server service on a production database.

Common config file / policy locations:
- **Windows Defender ATP:** policy via Intune / GPO; local cache at `C:\ProgramData\Microsoft\Windows Defender\`
- **CrowdStrike Falcon:** policy pushed from cloud console; sensor at `C:\Windows\System32\drivers\CrowdStrike\`
- **OSSEC (open source HIDS/HIPS hybrid):** `/var/ossec/etc/ossec.conf`

Agent communication back to the cloud console rides TLS (typically [[SSL]]/TLS 1.2+, certificate-pinned via [[PKI]]). If the agent can't phone home, it falls back to local policy and queues events — but a sophisticated attacker will try to sever that channel first.

### CompTIA exam traps

> **CompTIA exam trap:** HIPS vs HIDS. HIDS **detects only** — it generates an alert and stops. HIPS **detects and prevents** — it takes inline action. CompTIA will give you a scenario where a host-local agent **blocked** a malicious process and ask what control did it. The answer is HIPS, not HIDS. The "P" is for prevention; that's the entire distinction.

> **CompTIA exam trap:** HIPS vs NIPS. Both prevent. The scope is the discriminator. HIPS is **on the host** — it sees encrypted traffic after TLS termination, sees local process behavior, follows the laptop home. NIPS is **on the network** — it sees traffic between hosts, doesn't see what happens inside the host, and goes blind on encrypted payloads it can't decrypt.

> **CompTIA exam trap:** HIPS vs EDR. EDR is the superset. If the question emphasizes **threat hunting, fleet-wide correlation, or post-incident investigation**, it's EDR. If it emphasizes **real-time block of a specific action on a specific host**, it's HIPS. They're not mutually exclusive — modern EDR agents *contain* HIPS functionality.

> **CompTIA exam trap:** False positives. HIPS in enforce mode against a noisy enterprise app **will break production**. The correct answer to "the agent is blocking a legitimate business process" is rarely "disable the agent" — it's "create a targeted exception and document it." CompTIA loves the disciplined answer.

## SOC reality

- The 3am alert reads: **"Falcon prevented execution: powershell.exe child of winword.exe on FINANCE-LT-042, user jdoe, command line base64-encoded."** Your first move is not to call the user. It's to check whether prevention actually fired (status: Killed) or whether the agent only logged it. Then you pivot to [[SIEM]] for the parent-of-parent — how did Word get the doc?
- The CISO does not ask "what did HIPS do?" The CISO asks **"is the host contained, what's the blast radius, and do we have the evidence?"** HIPS gave you containment for free on this one box. Your job is to confirm the malicious doc didn't already land in 400 inboxes.
- Never tell leadership "HIPS blocked it, we're fine." HIPS blocked **that execution attempt**. The implant may already be persistent via a registry run key the agent didn't catch, or via a scheduled task created before the policy update. *An agent block is a single denied action, not a clean host.*
- Tuning is the job. L1 owns triage, L2 owns exceptions and policy tuning. When finance complains the macro broke, you don't disable the rule fleet-wide — you scope the exception to the specific signed binary, the specific user group, the specific file path. Document it in the change ticket. Review quarterly.
- Handoff: HIPS prevention event with confirmed malicious indicator → escalate to IR. Repeated prevention events on the same host → escalate to threat hunt. Prevention event during a known [[penetration test]] window → close as expected, note in the after-action.

## Related concepts

[[HIDS]] · [[NIPS]] · [[NIDS]] · [[EDR]] · [[XDR]] · [[SIEM]] · [[Sysmon]] · [[File Integrity Monitoring]] · [[Application Allowlisting]] · [[System Hardening]] · [[Zero Trust]] · [[Windows Registry]] · [[AMSI]] · [[eBPF]] · [[Endpoint Logging]] · [[NTP]] · [[CASB]] · [[CWPP]]

*Source: VIRGIL knowledge base — 2026-05-11*