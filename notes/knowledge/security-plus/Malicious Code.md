# Malicious Code

## What it is

In Resident Evil, the T-Virus doesn't just kill you — it rewrites you. A scientist gets infected, becomes a Licker, and now the lab's own staff are the threat patrolling the hallways. The code that ran the facility is the code that's hunting you. That's exactly what malicious code does — it's hostile instructions running inside systems that were supposed to be yours.

**Malicious code** (malware) is any software, script, or executable instruction designed to compromise the **confidentiality, integrity, or availability** of a system without authorized consent.

## Why it matters

Malicious code is the delivery mechanism for nearly every breach you'll see on the exam — ransomware extortion, credential theft, data exfiltration, lateral movement. A single executed payload can trigger regulatory penalties (HIPAA, PCI DSS, GDPR), halt operations, and burn customer trust. SY0-701 Objective 2.4 explicitly enumerates the malware types below, and CompTIA loves the trap of confusing **worm vs. virus** (self-propagation vs. host-dependent), **trojan vs. rootkit** (deception vs. persistence/privilege), and **logic bomb vs. backdoor** (trigger vs. access path). Know the *behavior*, not just the name.

## Key facts

### Malware types (Objective 2.4)

| Type | Behavior | Resident Evil parallel |
|---|---|---|
| [[Virus]] | Attaches to host file; requires user execution to spread | T-Virus needs a host to mutate |
| [[Worm]] | Self-replicating, self-propagating across networks; no host needed | Outbreak spreading through Raccoon City unaided |
| [[Trojan]] | Disguised as legitimate software; user willingly runs it | Umbrella's "pharmaceutical company" cover |
| [[Ransomware]] | Encrypts data, demands payment for decryption key | Locked door demanding the right emblem |
| [[Spyware]] | Covertly collects user activity, keystrokes, screen captures | Surveillance cameras throughout the mansion |
| [[Rootkit]] | Operates at kernel/firmware level; hides processes and files | The mansion's hidden labs beneath the foundation |
| [[Keylogger]] | Captures keystrokes; hardware or software | Recording every code you punch into a keypad |
| [[Logic bomb]] | Dormant code triggered by condition (date, event, user action) | Self-destruct sequence on a 4-minute timer |
| [[Bloatware]] | Unwanted preinstalled software; expands attack surface | |

### Sub-categories worth knowing

- **[[Crypto-malware]]** — subset of ransomware that specifically encrypts files (e.g., **WannaCry**, **Ryuk**, **LockBit**).
- **[[Cryptojacking]]** — hijacks CPU/GPU to mine cryptocurrency. Symptom: thermal throttling, sluggish systems.
- **[[Fileless malware]]** — lives in memory, abuses **PowerShell**, **WMI**, or **LOLBins** (Living-Off-the-Land Binaries). No disk artifact = signature-based AV blind.
- **[[Polymorphic malware]]** — mutates its code on each infection to evade signature detection.
- **[[Remote Access Trojan]] (RAT)** — trojan + backdoor; gives attacker interactive control. Examples: **DarkComet**, **njRAT**.
- **[[Backdoor]]** — undocumented access path; often planted by trojans or rootkits.
- **[[Bot]] / [[Botnet]]** — infected hosts under **C2** (command-and-control) used for **DDoS**, spam, or proxying.

### Indicators of compromise (IoCs)

- Unexpected outbound traffic to unknown IPs (C2 beaconing)
- New scheduled tasks, services, or registry **Run** keys
- Disabled security tools, AV, or logging
- Unsigned drivers loading at boot (rootkit)
- High CPU with no visible workload (cryptojacker)
- Encrypted files with extensions like `.locked`, `.encrypted`, plus a ransom note
- Lateral SMB/RDP traffic from non-admin hosts (worm propagation)

### Defenses

| Control | Function |
|---|---|
| [[EDR]] / [[XDR]] | Behavioral detection, rollback, telemetry |
| [[Antivirus]] / [[Anti-malware]] | Signature + heuristic scanning |
| [[Application allowlisting]] | Only approved binaries execute |
| [[Patch management]] | Closes the vulnerability the malware needs |
| [[Email filtering]] / [[sandboxing]] | Detonates attachments before delivery |
| [[Network segmentation]] | Limits worm blast radius |
| [[Backups]] (3-2-1, immutable) | The actual ransomware answer |
| [[User awareness training]] | Stops the trojan at the click |
| [[MFA]] | Limits stolen-credential damage |

### Exam traps

- **Worm ≠ virus.** Worms self-propagate; viruses need a host file and user action.
- **Rootkit ≠ backdoor.** Rootkit = stealth + persistence at low level; backdoor = the access door itself.
- **Ransomware defense = backups.** Not antivirus, not training — backups are the recovery answer.
- **Fileless malware** evades signature AV. Answer is **EDR** with behavioral analytics.
- **Logic bomb** is triggered code, often from an **insider threat** (the disgruntled admin scenario).

## Related concepts

[[Threat actors]] · [[Attack vectors]] · [[Indicators of compromise]] · [[EDR]] · [[Phishing]] · [[Command and control]] · [[Privilege escalation]] · [[Persistence mechanisms]] · [[Incident response]]

---
*Source: VIRGIL knowledge base — 2026-05-08*