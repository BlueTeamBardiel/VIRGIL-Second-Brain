# HIDS — Host-based Intrusion Detection System

## What it is

In **Stardew Valley**, you wake up and walk through your farmhouse before heading out. The TV's on the same channel. The shipping bin has yesterday's count. The cat's where you left it. Then one morning you notice the fence-post by the coop is broken, a chicken's missing, and there are footprints leading north toward the bus stop. You didn't see the raccoon. But the *farm itself* told you something got in overnight — because you knew exactly what "normal" looked like and the deviation screamed.

That's exactly what a HIDS does — it lives on the host, knows what "normal" looks like for that single machine, and screams when something on that machine deviates.

**Host-based Intrusion Detection System (HIDS)** is a software agent installed on an individual endpoint — workstation, server, VM, container host — that monitors local activity for signs of compromise. It watches the things only a resident can see: file integrity, registry changes, local process trees, system call patterns, local log entries, user logons, and config-file drift. Unlike a [[NIDS]] which sniffs the wire, a HIDS lives inside the OS and sees what the network never will — what happens *after* the encrypted tunnel terminates.

CompTIA wants you to know HIDS as a detection control inside the broader system and network architecture stack, alongside [[EDR]], [[SIEM]], log ingestion, and [[system hardening]].

## Why it matters

Network sensors go blind the moment traffic is TLS-encrypted end-to-end, and that's most traffic now. If the attacker drops a payload over HTTPS, decrypts it in memory, and executes it locally, the [[NIDS]] sees a TLS handshake and a byte count. The HIDS sees `powershell.exe` spawning from `winword.exe` at 02:14, writing a DLL to `C:\Users\Public\`, and registering a scheduled task.

That's the gap HIDS fills. It's the detection layer that survives encryption, network segmentation, and cloud workloads where you don't own the pipe.

Exam relevance: **Objective CS0-003 1.1** — system and network architecture. HIDS shows up under host-based controls, log sources for [[SIEM]] ingestion, and as a foundational detection capability in any defense-in-depth design.

## Key facts

### What a HIDS actually monitors

| Source | What it catches |
|---|---|
| **File Integrity Monitoring (FIM)** | Unauthorized changes to system binaries, config files, web roots. Tripwire-style hashing. |
| **Windows Registry** | New `Run` keys, service installations, persistence mechanisms (`HKLM\Software\Microsoft\Windows\CurrentVersion\Run`) |
| **System processes** | Parent-child anomalies (`winword.exe → powershell.exe`), unsigned binaries, processes from `%TEMP%` |
| **Local logs** | Windows Event Log (4624 logons, 4688 process creation, 4720 account creation), Linux `/var/log/auth.log`, `/var/log/audit/audit.log` |
| **Configuration file locations** | `/etc/passwd`, `/etc/shadow`, `/etc/ssh/sshd_config`, IIS `applicationHost.config`, Apache `httpd.conf` |
| **System calls** | `execve`, `ptrace`, raw socket creation — kernel-level visibility on Linux via auditd or eBPF |
| **User behavior** | Off-hours logons, privilege escalations, sudo abuse, [[PAM]] vault bypasses |

### Detection methods

**Signature-based** — pattern matching against known bad. Hash of a malware binary. Specific registry key written by a known RAT. Fast, low false-positive, useless against novel attacks.

**Anomaly-based / behavioral** — baseline what's normal on this host, alert on deviation. The farm method. High coverage of unknown threats, higher false-positive rate, requires a stable baseline period. CompTIA loves the signature-vs-anomaly distinction.

**Heuristic** — rule-based logic combining indicators. "If unsigned binary writes to System32 AND modifies a Run key AND opens an outbound socket within 60 seconds → alert."

### HIDS vs HIPS vs EDR — the trap CompTIA loves

- **HIDS** — detects and alerts. Read-only posture. Calls for help.
- **HIPS** (Host Intrusion *Prevention* System) — detects and *blocks*. Active posture, kills the process, drops the connection.
- **[[EDR]]** (Endpoint Detection and Response) — the modern evolution. HIDS + HIPS + telemetry forwarding + remote response (isolate host, kill process, pull file) + threat hunting interface. EDR superset of HIDS.

Practically, "HIDS" on a CySA+ question usually means the detection-only role. EDR is what you actually deploy in 2026.

### File structure and OS concepts the HIDS depends on

A HIDS only works if it understands the **file structure** and **OS concepts** of its host. On Windows that means [[Windows Registry]] hives, NTFS alternate data streams, scheduled tasks, services, WMI subscriptions. On Linux: cron, systemd units, SUID binaries, kernel modules, `/proc` mounts. On macOS: LaunchDaemons, LaunchAgents, kernel extensions.

Persistence mechanisms differ by OS. A HIDS tuned only for Windows misses Linux persistence entirely. This is why **hardware architecture** awareness matters — your HIDS deployment must cover x86, ARM, virtualized hosts, and containers (where you need a different model entirely — see below).

### HIDS in modern infrastructure

| Environment | HIDS reality |
|---|---|
| **On-premises** | Classic deployment. Agent on every endpoint, logs forward to [[SIEM]]. |
| **Cloud** (IaaS — EC2, Azure VMs) | Agent still works. Cloud-provider native options (AWS GuardDuty, Defender for Cloud) supplement. |
| **Hybrid** | Same agent, log forwarding crosses the boundary. [[Time synchronization]] becomes critical — NTP drift across cloud and on-prem destroys correlation. |
| **Containerization** | Traditional HIDS agents don't fit. Use runtime security tools (Falco, Sysdig) that hook into the container runtime and watch syscalls per container. |
| **Serverless** | No host to install on. You lose HIDS entirely. Falls back to cloud-provider telemetry and function-level logging. |
| **[[Zero trust]] architectures** | HIDS is core — every host is assumed potentially hostile, telemetry feeds continuous verification. |

### Logging levels and ingestion

A HIDS produces logs. Those logs need somewhere to go — typically [[SIEM]] via syslog, Windows Event Forwarding, or a vendor cloud connector.

**Logging levels** matter. Crank everything to DEBUG and you'll drown the SIEM, blow the licensing budget, and bury real signal in noise. Default tuning per CompTIA-style guidance:

- **INFO** for routine state (service start/stop, scheduled scans complete)
- **WARNING** for suspicious-but-not-confirmed (unsigned binary executed, FIM change on non-critical file)
- **ERROR / CRITICAL** for confirmed-bad (signature match, known persistence mechanism)

**Time synchronization** is non-negotiable. If the HIDS host clock drifts 90 seconds from the [[SIEM]] and the firewall, your timeline correlation is broken. NTP to an authoritative source. Stratum-2 minimum in production.

### CompTIA exam traps

> **CompTIA exam trap:** HIDS vs NIDS placement. HIDS lives *on the host*. NIDS lives *on the network segment*. If the question says "monitors traffic between segments" → NIDS. If it says "detects unauthorized changes to system files on a server" → HIDS. Don't overthink it; CompTIA writes these to test the boundary.

> **CompTIA exam trap:** HIDS does not decrypt network traffic for you. That's a [[TLS inspection]] / SSL inspection appliance or [[SASE]] / [[CASB]] function. HIDS sees the *result* of decryption once data hits the host — the process that opens the file, the binary that runs — but it's not breaking the encryption itself.

> **CompTIA exam trap:** Detection ≠ prevention. A pure HIDS *detects and alerts only*. If the question describes "automatic blocking of the malicious process," that's HIPS or EDR with response actions enabled. CompTIA will offer HIDS as a distractor when the right answer is HIPS.

> **CompTIA exam trap:** HIDS is a log source, not a log aggregator. The aggregator is [[SIEM]]. CompTIA will write a question where you need to identify what *produces* the host telemetry (HIDS) versus what *correlates* it across the environment (SIEM).

### Hardening the HIDS itself

The first thing a smart attacker does after landing on a box is try to kill the HIDS agent. Defenses:

- Run the agent as a protected process (Windows PPL, Linux capability restrictions)
- Tamper protection — agent self-monitors and re-installs if killed
- Forward logs *immediately* off-host, so killing the agent doesn't erase what already shipped
- Use [[PKI]]-signed agent communications so an attacker can't spoof "all clear" beacons to the management console
- Alert on agent silence — a host that stops checking in is a host you investigate

*The HIDS that goes silent is louder than the one that screams. Build your SIEM to alert on missing heartbeats, not just on detections.*

### Privacy and data sensitivity

HIDS agents see everything on the host — including [[PII]], [[CHD]], PHI, and the CEO's email drafts. That makes the HIDS data store itself a regulated asset. Encryption at rest, access controls via [[IAM]] and [[MFA]], retention policies aligned to GDPR / CCPA / PCI DSS. A leaky HIDS console is its own breach.

## SOC reality

- **The 3am alert:** FIM trips on a domain controller. `ntds.dit` was accessed by a non-service-account process. Your stomach drops — that's the AD database. L1 acknowledges, pivots to [[SIEM]] to correlate the parent process, the logon session, the source workstation. Escalates to L2 within five minutes.

- **What the IR lead asks:** "Is the agent still reporting? When did it last check in? Do we have the process tree before the host got isolated? Is the log shipping confirmed in the SIEM, or are we trusting local logs that the attacker may have already wiped?"

- **What the L1 actually does first:** Confirms the alert isn't a known false positive (vuln scanner, backup agent, patch deployment). 70% of FIM alerts on busy servers are legitimate change activity nobody told the SOC about. The other 30% are why you have a job.

- **What never to promise leadership:** "The HIDS would have caught it." HIDS misses fileless attacks living entirely in memory, signed-binary abuse (LOLBins like `certutil.exe`, `regsvr32.exe`), and any technique below its detection layer. The HIDS is a layer, not the wall.

- **The handoff:** L1 triage → L2 enrichment with threat intel → IR team containment (isolate host via EDR, preserve memory image, pull disk) → forensics → legal if [[PII]]/[[CHD]] touched → exec brief once scope is known. Never brief execs on scope before you have it. They'll quote you back at the post-incident.

## Related concepts

[[NIDS]] · [[EDR]] · [[SIEM]] · [[FIM]] · [[HIPS]] · [[Windows Registry]] · [[System hardening]] · [[Log ingestion]] · [[Time synchronization]] · [[Zero trust]] · [[PAM]] · [[CASB]] · [[SASE]] · [[Containerization]] · [[Serverless]] · [[PKI]] · [[MFA]] · [[IAM]] · [[DLP]] · [[PII]] · [[CHD]]

*Source: VIRGIL knowledge base — 2026-05-11*