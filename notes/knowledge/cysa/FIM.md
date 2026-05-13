# FIM — File Integrity Monitoring

## What it is

In **Subnautica**, the moment you build a base on the seafloor, you start watching the hull integrity number in the top corner of every room. A leak from a Reaper headbutt drops it. A bad pressure rating drops it. A breach you didn't notice because you were AFK eating Peepers will eventually drown the whole habitat. The integrity number doesn't tell you *why* — it tells you *something changed and the structure is no longer what you built*. You then swim around with the Repair Tool looking for the bubbles.

That's exactly what **File Integrity Monitoring (FIM)** does. It doesn't care why a file changed. It tells you the file is no longer what you built, and now you go find the bubbles.

**Technical definition:** FIM is a security control that establishes a cryptographic baseline (typically SHA-256 hashes) of files, directories, registry keys, and configuration objects, then continuously or periodically re-hashes them to detect **unauthorized changes**. When the current hash diverges from the baseline, FIM raises an alert. It is the canonical control for detecting [[file system changes or anomalies]] and [[registry changes or anomalies]] — two of the CS0-003 1.2 indicators you must recognize on exam day.

FIM is mandated by **PCI DSS Requirement 11.5**, referenced in **NIST SP 800-53 SI-7**, and shows up in HIPAA, SOX, and FedRAMP audits. Commercial implementations include Tripwire, OSSEC/Wazuh, Tanium, and the FIM modules inside most EDR platforms.

## Why it matters

FIM is one of the only detections that catches attackers **after** they've slipped past prevention — the post-exploitation moment when they drop a webshell into `/var/www/html/`, swap a binary in `C:\Windows\System32\`, or plant a registry Run key for persistence. Antivirus might miss the dropper. EDR might not flag the process tree if the attacker is using living-off-the-land binaries. But the file on disk changed, and FIM saw it.

**Exam relevance:** Objective **CS0-003 1.2** asks you to analyze indicators of potentially malicious activity. FIM is the direct detection mechanism for:

- **File system changes or anomalies** — new binary in a system path, modified config file
- **Registry changes or anomalies** — new Run key, modified service ImagePath, persistence mechanism
- **Unauthorized software** — a binary appeared that isn't in the gold image
- **Unauthorized scheduled tasks** — `schtasks.exe` writing a new XML to `\Windows\System32\Tasks\`
- **Abnormal OS process behavior** — `svchost.exe` changed on disk (it shouldn't, ever)

CompTIA will hand you a log snippet showing `/etc/passwd` modified at 03:14 UTC by a non-root process and expect you to name the control that caught it. The answer is FIM.

## Key facts

### How FIM actually works

| Stage | What happens |
|---|---|
| **Baseline** | Hash every monitored object (file, directory, registry key) with SHA-256. Store hash + metadata (size, ACL, owner, mtime) in a protected database. |
| **Monitoring** | Re-hash on a schedule (every 15min, hourly) or in real-time via kernel-level file system hooks (inotify on Linux, ETW/MiniFilter on Windows). |
| **Detection** | Current hash ≠ baseline hash → generate event. Include file path, old hash, new hash, user/process that made the change if available. |
| **Triage** | Analyst correlates the change against change management tickets. Expected change → close. Unexpected change → escalate. |
| **Baseline update** | After approved change, the baseline is re-hashed and stored. Without this step, every patch Tuesday detonates the alert queue. |

### What you monitor — and what you don't

**Monitor (high-signal, low-change):**
- OS binaries: `C:\Windows\System32\*.exe`, `/bin/`, `/sbin/`, `/usr/bin/`
- Boot files: bootloaders, kernel images, EFI partition
- Web roots: `/var/www/`, `C:\inetpub\wwwroot\` — webshell territory
- Config files: `/etc/passwd`, `/etc/shadow`, `/etc/sudoers`, `sshd_config`, `httpd.conf`
- Registry persistence keys: `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`, `RunOnce`, `Services`, `Image File Execution Options`
- Scheduled task definitions: `\Windows\System32\Tasks\`, `crontab`, `/etc/cron.*`
- Security-relevant logs (read-only — alerts on truncation/clearing)

**Don't monitor (high-change, low-signal — will drown you):**
- `/tmp`, `%TEMP%`, `/var/log/` (logs rotate — monitor the rotation config, not the log itself)
- User profile directories (`C:\Users\*\Documents\`)
- Browser caches, package manager working directories
- Database data files (constantly changing by design)

*Lesson learned the hard way: a junior analyst once pointed FIM at `C:\Users\` on a Citrix farm. The alert queue hit 40,000 events in 90 minutes. The actual webshell was lost in the noise.*

### The change-management dependency

FIM without a change management process is a noise generator. Every approved patch, every config push from Ansible, every Windows Update will trigger FIM. The only way to make FIM useful is the **expected vs unexpected** workflow:

1. Change ticket exists → change is in maintenance window → FIM alerts during window → analyst correlates ticket ID → close as expected
2. No change ticket → FIM alert outside window → **escalate as potential compromise**

This is why CompTIA pairs FIM with [[change management]] in scenario questions. The control is technical; the workflow is procedural.

### FIM vs adjacent detections

| Control | What it sees | What it misses |
|---|---|---|
| **FIM** | Disk state changes, registry changes | In-memory-only malware, fileless attacks |
| **EDR** | Process behavior, in-memory injection | Slow disk-only persistence after agent restart |
| **AV** | Known-malicious file signatures | Custom/unknown payloads |
| **SIEM** | Aggregated log events | Anything that doesn't log |
| **HIDS** (host IDS) | Host-level anomalies (FIM is a subset) | Network-borne attacks unless paired with NIDS |

FIM is complementary, not redundant. Modern endpoint stacks layer FIM under EDR so process telemetry and file-state telemetry correlate in the same console.

### CompTIA exam traps

> **CompTIA exam trap:** FIM detects the change; it does **not** prevent it. The exam will offer "FIM blocked the modification" as a distractor. Wrong. FIM is detective, not preventive. Application allowlisting (AppLocker, WDAC) prevents. FIM tells you something already happened.

> **CompTIA exam trap:** FIM alerts on **expected** changes constantly. The exam scenario where "FIM generates 200 alerts/hour after a patch deployment" is testing whether you know the baseline must be re-established post-patch. The answer is *update the baseline*, not *tune the rule to ignore the directory*.

> **CompTIA exam trap:** Hashing is the mechanism, not just timestamps or file size. The exam may offer "FIM compares last-modified timestamps" as the definition. Wrong — timestamps are trivially forged with `touch -r` or PowerShell `Set-ItemProperty`. SHA-256 (or stronger) is the integrity primitive.

> **CompTIA exam trap:** PCI DSS specifically requires FIM (Requirement 11.5, alerting on **critical** file changes at least weekly). Don't confuse this with HIPAA, which references integrity controls more generally without mandating FIM by name.

### What FIM-detected attacker behavior looks like

Map these back to the 1.2 indicator list — these are the events FIM will surface:

- **Webshell drop** (unauthorized software, file system change): `china.aspx` appears in `C:\inetpub\wwwroot\`. Hash unknown. Owner = IIS app pool identity. Time = 03:47 UTC.
- **Persistence via Run key** (registry change, unauthorized scheduled tasks adjacent): new value in `HKLM\...\Run` named `WindowsUpdateHelper` pointing to `%APPDATA%\svchost.exe`. Real `svchost.exe` lives in `System32`, never AppData.
- **SUID binary planted** (unauthorized privileges): new file in `/usr/local/bin/` with mode `4755` owned by root. Lateral-movement toolkit.
- **Sudoers modified** (introduction of new accounts / unauthorized privileges): `/etc/sudoers` hash changed. New line: `nobody ALL=(ALL) NOPASSWD: ALL`. Game over if missed.
- **Binary replacement** (abnormal OS process behavior): `/bin/ls` hash changed. Rootkit replacing core utilities to hide its own files. Classic.
- **Log tampering** (data exfiltration / cover tracks): `/var/log/auth.log` size dropped from 14MB to 2KB. FIM monitoring the log file itself flags truncation.
- **Scheduled task injection** (unauthorized scheduled tasks): new XML in `\Windows\System32\Tasks\` registering a task that runs `powershell.exe -enc <base64>` every 10 minutes — classic [[beaconing]] persistence.

### Tuning — where most FIM deployments die

Out of the box, FIM is noisy. The mature deployment looks like:

- **Tiered alerting** — critical paths (boot, kernel, sudoers, persistence keys) page immediately; medium paths (web roots, app configs) go to queue; low paths (rarely-changed user configs) batch daily
- **Change-window suppression** — FIM correlates with the CMDB; alerts during approved maintenance windows auto-tag as expected
- **Hash allowlist** — known-good hashes from vendor patches pre-loaded so a Patch Tuesday delta doesn't fire
- **Process attribution** — modern FIM (Wazuh, Tanium) tells you *which process* made the change, not just *that* it changed. Massive triage win.

## SOC reality

- **What the alert looks like at 3am:** `[FIM-CRIT] /etc/shadow modified on web-prod-04. Hash a3f1...→ 8c92.... Process: bash (PID 14883, parent sshd, user: deploy).` That `deploy` account shouldn't be touching `/etc/shadow`. Ever. You're now in [[incident response]].
- **L1 first move:** Check the change management system for an approved ticket against that host in that window. No ticket? Pull the auth log, identify the source IP of the `deploy` SSH session, snapshot the host, escalate to L2 within the SLA window. Do not log into the box and start poking — you'll trample [[chain of custody]].
- **What the IR lead asks:** "When did the hash change, what was the previous-known-good hash and when, what process owned the change, and is the host still talking to anything weird on the network?" FIM gives you the first three. NetFlow/EDR gives you the fourth.
- **Never promise:** "FIM would have caught it." FIM catches what's monitored. If the attacker dropped the payload in `/opt/customapp/uploads/` and nobody added that path to the FIM policy, the binary sat there for 60 days. Scope your coverage honestly.
- **The escalation path:** L1 confirms unexpected change → L2 correlates with EDR process tree and network telemetry → IR team scopes blast radius (was this host one of many?) → if confirmed compromise, legal/comms get the call for breach-notification clock ([[GDPR]] 72hr, CIRCIA, state law).

## Related concepts

[[EDR]] · [[SIEM]] · [[HIDS]] · [[Change management]] · [[Chain of custody]] · [[Indicators of compromise]] · [[Beaconing]] · [[Persistence mechanisms]] · [[Registry changes or anomalies]] · [[File system changes or anomalies]] · [[Unauthorized software]] · [[Application allowlisting]] · [[PCI DSS]] · [[NIST SP 800-53]] · [[Incident response]]

*Source: VIRGIL knowledge base — 2026-05-11*