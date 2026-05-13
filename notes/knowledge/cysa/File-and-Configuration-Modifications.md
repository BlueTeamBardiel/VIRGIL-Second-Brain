# File and Configuration Modifications

## What it is

In **Escape from Tarkov**, after a raid you sit at the stash screen and check what changed. The PMC scav case is rearranged. There's a Roubles stack you didn't put there. A pistol slot you swore had a Makarov is empty. Someone — or some script — touched your gear between raids. The smart move isn't to start using the stash; it's to figure out *what* moved, *when*, and whether the account is still yours. That's the discipline.

That's exactly what file and configuration modifications are in incident response — the on-disk evidence that something with hands and intent has been in your environment. Files appear that shouldn't exist. Configuration values flip. Log files get shorter than they were yesterday. Patches roll back. Scheduled tasks show up with names that almost-but-don't-quite match legitimate ones.

**Technical definition:** File and configuration modifications are host-based indicators of compromise (IoCs) consisting of unauthorized creation, deletion, alteration, or timestamp manipulation of files, registry keys, configuration data, log records, or installed software state. They are detected primarily through file integrity monitoring (FIM), host-based intrusion detection systems (HIDS), and endpoint detection and response (EDR) baselining, and they are core artifacts in the Detection and Analysis phase of the NIST SP 800-61 incident response lifecycle.

## Why it matters

Attackers leave fingerprints on disk. Even fileless attacks eventually drop something — a registry Run key, a WMI subscription, a scheduled task XML, a modified service binary path. If your hosts have no idea what their baseline looks like, you can't see when it shifts. The SOC that catches intrusions early is the SOC that knows what `C:\Windows\System32` is supposed to contain and what `/etc/cron.d/` looked like at provisioning.

**Exam relevance:** CS0-003 Objective 3.2 hits this across Detection and Analysis (IoCs, data and log analysis), Evidence acquisition (validating data integrity, preservation, chain of custody), and Containment/Eradication/Recovery (isolation, remediation, re-imaging, compensating controls). CompTIA will ask you to identify a file modification IoC inside a log snippet, then ask the right next step — and the right next step is almost never "delete the file."

## Key facts

### What gets modified — and what it means

| Modification type | What it looks like | What it usually means |
|---|---|---|
| **Configuration files** | `/etc/ssh/sshd_config` allows root login; `web.config` adds a new handler | Persistence or backdoor — attacker wants in next time |
| **Log files** | `wtmp` truncated, Security log cleared (Event ID 1102), gaps in syslog | Anti-forensics — covering the lateral movement |
| **System binaries** | `cmd.exe` hash differs from clean baseline; `ls` replaced on Linux | Rootkit / trojaned binary |
| **Registry (Windows)** | New `Run` / `RunOnce` key; `Image File Execution Options` debugger set | Persistence, privilege escalation hijack |
| **Scheduled tasks / cron** | New `\Microsoft\Windows\` task with base64 PowerShell; `/etc/cron.d/` entry | Persistence and beaconing |
| **Patch state** | KB rolled back, `apt` hold placed on critical package | Attacker keeping a known exploit path alive |
| **New / unexpected files** | Binary in `%TEMP%`, `.php` web shell in `/var/www/uploads/` | Implant or web shell |
| **Timestamp anomalies (timestomping)** | File modified yesterday claims `Created: 2009-07-14` to match `kernel32.dll` | Defense evasion — MITRE ATT&CK T1070.006 |

### Detection — what watches the disk

**File Integrity Monitoring (FIM)** is the category. Tools take a cryptographic hash (SHA-256, usually) of every file in a monitored set, store it, and re-hash on a schedule or on filesystem events. Any delta becomes an alert.

- **OSSEC / Wazuh** — open source HIDS with FIM, log analysis, rootkit detection
- **Tripwire** — the original, still the textbook answer
- **AIDE** (Advanced Intrusion Detection Environment) — Linux FIM, lighter weight
- **Windows native** — `auditpol`, Sysmon Event ID 11 (FileCreate), Event ID 4663 (object access)
- **EDR platforms** — CrowdStrike, SentinelOne, Defender for Endpoint all do behavioral FIM plus process lineage

**The baseline problem:** FIM is only as good as the baseline it was given. If you took the baseline *after* the attacker had already established persistence, you've baselined the compromise. Baselines come from gold images, not from running production hosts.

### Indicators of compromise — file/config edition

Tie what you see on disk to [[MITRE ATT&CK]] technique IDs. CompTIA loves IoC categorization.

- **T1070 — Indicator Removal** (log clearing, file deletion, timestomping)
- **T1547 — Boot or Logon Autostart Execution** (Registry Run keys, startup folder)
- **T1053 — Scheduled Task/Job** (cron, at, schtasks)
- **T1505.003 — Server Software Component: Web Shell** (`.aspx`, `.php`, `.jsp` in web root)
- **T1574 — Hijack Execution Flow** (DLL search order hijack, path interception)

### Data and log analysis workflow

When a FIM alert fires, the L1 → L2 flow:

1. **Triage the alert.** Is the modified file on the FIM allowlist? Patches, scheduled deployments, and admin-initiated changes generate FIM noise — tune them out or you'll burn out.
2. **Pull the artifact metadata.** Path, hash, size, timestamps (MAC times: Modified, Accessed, Created — plus Born/MFT entry on NTFS), owning process, parent process.
3. **Correlate.** Hash against [[Threat Intelligence]] feeds (VirusTotal, internal IoC database). Process lineage in EDR — what spawned it? Network egress around the timestamp.
4. **Decide:** false positive, suspicious-pending-investigation, or confirmed incident. The decision drives everything after.

### Evidence acquisition — touching it without breaking it

Once you've decided it's real, the host becomes evidence. The Tarkov player who immediately starts moving stash items after noticing the theft destroys the forensic state. Same here.

**Order of volatility** (RFC 3227) — capture most-volatile first:

1. CPU registers, cache
2. RAM (memory dump — `winpmem`, `LiME`, `AVML`)
3. Network state (`netstat`, ARP, routing)
4. Running processes
5. Disk (image with a write blocker for physical; `dd` / `dc3dd` / FTK Imager for logical)
6. Remote logs, archival media

**Validating data integrity:**
- Hash the source before acquisition. Hash the image after. SHA-256 minimum. MD5 is for legacy compatibility, not for trust.
- If hashes don't match, the image is not evidence. It's a coaster.
- Write blockers (hardware or software) prevent the acquisition tool from modifying the source disk.

**Chain of custody:**
- Every transfer logged: who handed off, who received, timestamp, purpose, storage location.
- One unlogged transfer can get the evidence thrown out at trial or in arbitration.
- This is the audit trail of the artifact itself.

**Preservation and legal hold:**
- Once counsel issues legal hold, normal retention policies are suspended for affected data. Auto-delete of mailboxes, logs, snapshots stops.
- Preservation includes the image, the original media, hash receipts, custody log, and analyst notes.

### Containment, eradication, recovery — the after-action

**Scope:** Which hosts have the modification? Pivot from the IoC. If `evil.dll` hash X is on one box, hunt that hash across the fleet. If a Run key with value `\Users\Public\update.exe` is on one host, query every endpoint for that registry path.

**Impact:** What did the modification enable? A modified `sshd_config` permitting root login is different from a single web shell on a DMZ box that can't reach internal. Tie impact to data classification and business function.

**Isolation:** Network-quarantine the host via EDR containment, VLAN move, or switchport disable. Keep it powered on if memory acquisition is still pending. Killing power destroys RAM.

**Remediation:** Two options, ranked by trust.
- **Re-imaging** — wipe to bare metal, redeploy from gold image, restore data from clean backup. *Re-imaging is the only remediation that returns the host to a known-good state. Everything else is a guess.*
- **Surgical removal** — delete the file, kill the persistence, patch the entry vector. Faster, but you're trusting that you found *all* of it. Attackers plant redundant persistence on purpose.

**Compensating controls** while you remediate:
- Block the C2 domain at the egress firewall
- Add an EDR custom IoC for the file hash across the fleet
- Force credential rotation for any account that touched the host
- Tighten egress filtering on the host's VLAN

### CompTIA exam traps

> **CompTIA exam trap:** When a file IoC is detected, the first action is **NOT** to delete the file. The first action is to **document, preserve, and acquire evidence**. Deleting destroys forensic state and may also tip the attacker that they've been spotted. The exam will offer "delete the malicious file" as a tempting wrong answer.

> **CompTIA exam trap:** Re-imaging vs. patching. If a host has confirmed persistence (rootkit, modified system binary, unknown scope), **re-image**. Patching the vulnerability that let them in doesn't remove what they already planted. CompTIA tests this distinction directly.

> **CompTIA exam trap:** Hash validation is **integrity**, not authenticity. Matching hashes prove the image equals the source at the moment of acquisition. They don't prove the file is benign or that no one tampered before acquisition. Don't confuse integrity controls with provenance.

> **CompTIA exam trap:** Order of volatility — RAM is captured **before** disk. CompTIA will offer a question where the analyst pulls the plug to "preserve" the disk. That destroys RAM, which is more volatile, and is the wrong answer.

## SOC reality

- **The 3am alert looks like:** `Wazuh - FIM - /etc/pam.d/sshd modified - user: root - process: vi`. Eight times out of ten it's an admin who didn't file the change ticket. The other two times, your career bends.
- **L1's first move:** check the change management system for an approved CR matching the host, file, and window. No CR? Escalate to L2 with the artifact hash, parent process, and the last login on that host. Don't touch the file.
- **What the IR lead asks:** "Scope, impact, evidence preserved? Have we contained without destroying state? When was the last known-good backup, and is it before or after the earliest IoC?"
- **What never to say to the CISO:** "We deleted it, we're fine." You don't know what else is on the box. *An EDR quarantine is not eradication. A deleted web shell is not a remediated server.*
- **The handoff:** L1 triages → L2 confirms IoC and pulls memory + disk image → IR lead owns containment and comms → forensics analyst owns timeline reconstruction → legal owns hold and external reporting (GDPR 72h, CIRCIA window, contractual obligations). Engineering owns re-imaging once IR signs off.

## Related concepts

[[Indicators of Compromise]] · [[File Integrity Monitoring]] · [[HIDS]] · [[Chain of Custody]] · [[Order of Volatility]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[MITRE ATT&CK]] · [[NIST SP 800-61]] · [[Re-imaging]] · [[Compensating Controls]] · [[Sysmon]] · [[Timestomping]] · [[Persistence Mechanisms]] · [[Memory Forensics]]

*Source: VIRGIL knowledge base — 2026-05-11*