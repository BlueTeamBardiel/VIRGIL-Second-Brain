---
domain: "Security Operations"
tags: [audit-logging, monitoring, compliance, siem, forensics, access-control]
---
# Audit Logging

**Audit logging** is the systematic process of recording events, actions, and changes within an information system to create a tamper-evident trail of activity that can be used for security monitoring, forensic investigation, and regulatory compliance. The **audit log** (also called an **audit trail**) captures *who* did *what*, *when*, and *from where*, providing accountability and visibility across users, systems, and applications. Audit logging is a core component of [[Security Monitoring]] and is foundational to frameworks such as [[SIEM]] solutions, [[Zero Trust Architecture]], and major compliance standards including [[PCI DSS]], [[HIPAA]], and [[SOX]].

---

## Overview

Audit logging exists because organizations need authoritative records of activity on their systems — records that can answer questions after a security incident, satisfy a compliance auditor, or provide legal admissibility in court proceedings. Without audit logs, determining the scope of a breach, identifying the responsible party, or proving that controls were operating effectively becomes nearly impossible. The concept traces its roots to mainframe security in the 1960s and 1970s, and today it is mandated by virtually every major security regulation and framework.

At its core, audit logging differs from ordinary system logging in scope and intent. General system logs (syslog, application logs) capture operational data like service starts, errors, and performance metrics. Audit logs, by contrast, are specifically designed to record *security-relevant events*: authentication attempts, privilege escalations, access to sensitive data, configuration changes, and object creation or deletion. They are designed to be complete (capturing all relevant events), accurate (timestamped and attributable), and protected (stored in a way that prevents unauthorized modification).

The lifecycle of an audit log event follows a consistent path. An event occurs — say, a user logs into a server. The operating system or application generates a structured log record containing event metadata: timestamp (ideally UTC-synchronized via [[NTP]]), source IP, username, event type, success or failure status, and the affected resource. That record is written to a local log file or sent in real time to a centralized [[Log Management]] system. From there, the log is indexed, retained for a defined period, and made available for query, alerting, and reporting.

Modern audit logging infrastructure is typically centralized. Rather than relying on logs stored on individual endpoints — which an attacker could modify or destroy — organizations forward events to a hardened central repository such as a [[SIEM]] platform (Splunk, IBM QRadar, Microsoft Sentinel, Elastic SIEM) or a dedicated log management solution (Graylog, Loki). Centralization provides resilience, correlation capability, and a single pane of glass for security analysts. It also means that even if an endpoint is compromised, the audit record may already be safely persisted elsewhere.

Audit logging is tightly coupled to concepts of accountability and non-repudiation. **Non-repudiation** means that a user cannot credibly deny having performed an action if that action is captured in a properly maintained audit log. This is especially critical in financial systems, healthcare environments, and any context where legally binding transactions occur. Audit logs that are cryptographically signed or stored in append-only, write-once media provide the strongest form of non-repudiation.

---

## How It Works

### Event Generation

Every major operating system, application, and network device has mechanisms to generate audit events. The event originates from a *source*, which can be:

- **Operating System** – kernel or OS-level subsystems (Windows Security Event Log, Linux Audit subsystem via `auditd`)
- **Application** – middleware, databases (SQL Server audit, Oracle Unified Auditing), web servers (Apache/nginx access logs)
- **Network Device** – firewalls, routers, switches sending NetFlow, syslog, or SNMP traps
- **Cloud Platform** – AWS CloudTrail, Azure Activity Log, GCP Cloud Audit Logs

### Windows Audit Logging

Windows uses the **Security Event Log** accessed via Event Viewer or `wevtutil`. Audit policy is controlled through Group Policy:

```
Computer Configuration > Windows Settings > Security Settings >
Advanced Audit Policy Configuration
```

Key event IDs for Security+ relevance:

| Event ID | Description |
|----------|-------------|
| 4624 | Successful logon |
| 4625 | Failed logon attempt |
| 4648 | Logon with explicit credentials (pass-the-hash indicator) |
| 4672 | Special privileges assigned to new logon |
| 4698 | Scheduled task created |
| 4720 | User account created |
| 4740 | User account locked out |
| 4776 | NTLM credential validation attempt |
| 7045 | New service installed (potential persistence) |

Enable auditing via PowerShell:

```powershell
# Enable auditing of logon events
auditpol /set /subcategory:"Logon" /success:enable /failure:enable

# View current audit policy
auditpol /get /category:*

# Query Security log for failed logons (Event ID 4625)
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} |
  Select-Object TimeCreated, Message |
  Format-List
```

### Linux Audit Logging with `auditd`

The Linux Audit Daemon (`auditd`) is the primary kernel-level audit subsystem. Rules are defined in `/etc/audit/audit.rules` and `/etc/audit/rules.d/`:

```bash
# Install auditd (Debian/Ubuntu)
sudo apt install auditd audispd-plugins

# Start and enable
sudo systemctl enable --now auditd

# Example audit rules - /etc/audit/rules.d/audit.rules
# Watch for changes to /etc/passwd
-w /etc/passwd -p wa -k user_modification

# Monitor sudo usage
-w /usr/bin/sudo -p x -k privilege_escalation

# Track changes to SSH authorized_keys
-w /root/.ssh/authorized_keys -p wa -k ssh_key_modification

# Monitor 32-bit system calls (often used by malware)
-a always,exit -F arch=b32 -S execve -k exec_32bit

# Reload rules
sudo augenrules --load
```

Query audit logs with `ausearch` and `aureport`:

```bash
# Search for failed login attempts
ausearch -m USER_LOGIN --success no

# Search by key
ausearch -k privilege_escalation

# Generate summary report
aureport --summary

# Report on authentication events
aureport -au

# Follow audit log in real time
sudo tail -f /var/log/audit/audit.log
```

### Syslog and Log Forwarding

Most systems forward logs using **syslog** (UDP/TCP port **514**) or the encrypted **syslog over TLS** (port **6514**). The `rsyslog` daemon is common on Linux:

```bash
# /etc/rsyslog.d/99-remote.conf
# Forward all logs to centralized SIEM over TLS
*.* @@(o)siem.homelab.local:6514

# Or forward via UDP (less reliable, no encryption)
*.* @192.168.1.50:514
```

**syslog severity levels** (RFC 5424) range from 0 (Emergency) to 7 (Debug). Security-relevant events typically fall at levels 0–4.

### Structured Logging and Timestamps

Modern audit systems favor **structured logging** (JSON, CEF — Common Event Format, LEEF — Log Event Extended Format) over free-text for machine parseability:

```json
{
  "timestamp": "2024-11-15T14:32:10.442Z",
  "event_id": "4625",
  "source_host": "WORKSTATION-07",
  "source_ip": "192.168.10.42",
  "user": "jsmith",
  "domain": "CORP",
  "logon_type": 3,
  "failure_reason": "Unknown user name or bad password",
  "category": "Logon/Logoff"
}
```

**Time synchronization is critical**: all devices must sync to a trusted [[NTP]] source so log timestamps across systems are consistent and correlation is possible. Without NTP, reconstructing a timeline across multiple log sources during incident response becomes unreliable.

---

## Key Concepts

- **Audit Trail**: The complete, chronological record of all events captured by audit logging; forms the evidentiary basis for forensic investigation and compliance audits. An unbroken audit trail is a core requirement of frameworks like [[PCI DSS]].

- **Non-Repudiation**: The property that ensures a subject cannot deny performing an action that is recorded in the audit log; achieved through cryptographic signing of log records, chain-of-custody documentation, and write-once storage.

- **Log Integrity**: The assurance that audit logs have not been tampered with after generation; implemented through hash chaining (each log record includes a hash of the previous one), write-once media (WORM), digital signatures, and centralized forwarding that removes logs from attacker reach before they can be modified.

- **Log Retention Policy**: An organization's documented requirement for how long audit logs must be kept; typically 90 days online (actively searchable) and 1 year archived under PCI DSS, 6 years under HIPAA, and 7 years under SOX. Failure to retain logs can constitute a compliance violation independent of any security incident.

- **Security Event vs. Audit Event**: Security events are all log entries generated by security-relevant activity; audit events are a deliberate subset selected by policy as having accountability or compliance value. Not every syslog entry is an audit event.

- **Log Aggregation**: The process of collecting logs from multiple disparate sources into a central repository to enable correlation, search, and alerting. Central aggregation prevents log loss from compromised endpoints and enables detection of multi-stage attacks that span systems.

- **Chain of Custody**: A documented, unbroken record proving that evidence (including log files) was collected, handled, and preserved in a manner that protects its integrity and admissibility; critical in legal proceedings and internal investigations.

- **Volatility Order**: In forensic collection, the principle that more volatile data (RAM, running processes) should be collected before less volatile data (disk images, logs); audit logs on disk are less volatile than memory but more volatile than archival backups.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Audit logging appears primarily in **Domain 4.0 – Security Operations** (monitoring, log management, incident response) and **Domain 5.0 – Security Program Management and Oversight** (compliance, accountability).

**Frequently Tested Concepts:**

- **What is the primary purpose of audit logs?** → Accountability and non-repudiation, not performance monitoring.
- **Which log would show a failed Windows login?** → Security Event Log, Event ID 4625.
- **What ensures log integrity?** → Write-once (WORM) storage, cryptographic hashing, and centralized log forwarding.
- **What is log aggregation used for?** → Centralizing logs from multiple sources for correlation and analysis, commonly done by a [[SIEM]].
- **What standard governs syslog?** → RFC 5424 (syslog protocol) and RFC 3164 (legacy BSD syslog).
- **What port does syslog use?** → UDP/TCP **514** (plaintext), TCP **6514** (TLS-encrypted).

**Common Gotchas:**

- Don't confuse *audit logs* (security accountability) with *event logs* (general operational logging) — they overlap but serve different purposes.
- The exam may present scenarios where audit logs were *not enabled* or *not retained long enough* — identify this as a *control gap* or *compliance failure*.
- Questions about an attacker *covering their tracks* often involve log deletion or modification — the defensive answer is almost always *centralized log forwarding* and *WORM storage*.
- **Time synchronization (NTP)** is frequently the answer when logs from multiple systems can't be correlated — unsynchronized clocks are a logging control weakness.
- Know the difference between **logging** (recording events) and **monitoring** (actively reviewing those records for anomalies); both are required for effective security operations.

---

## Security Implications

### Threat: Log Deletion and Tampering

After compromising a system, attackers routinely attempt to delete or modify audit logs to remove evidence of their intrusion. This is catalogued under MITRE ATT&CK as **T1070 – Indicator Removal on Host**, with sub-techniques including:
- **T1070.001** – Clear Windows Event Logs (`wevtutil cl Security`)
- **T1070.002** – Clear Linux/Mac system logs (`rm /var/log/auth.log`)
- **T1070.004** – File deletion to remove dropped tools

The **2020 SolarWinds SUNBURST** supply chain attack demonstrated sophisticated log evasion: the malware included a "job engine" that actively disabled Windows event logging for specific processes and deleted its own traces from event logs to remain dormant for months undetected.

### Threat: Log Flooding / Log Injection

Attackers can attempt to overwhelm a logging system with massive volumes of noise events, causing legitimate security events to be buried or dropped when the log pipeline hits capacity — a **log flooding** attack. Separately, **log injection** involves crafting malicious input that, when logged, inserts false records or exploits log parsers. For example, a web application that logs user input without sanitization may be vulnerable if an attacker injects newline characters to create spoofed log entries:

```
Username: admin\n2024-11-15 14:00:00 SUCCESS: admin logged in from 192.168.1.1
```

### Threat: Insufficient Logging (OWASP A09:2021)

The **OWASP Top 10 2021** lists **A09 – Security Logging and Monitoring Failures** as a major risk category. Insufficient logging means that breaches go undetected for extended periods. The industry average **mean time to detect (MTTD)** a breach has historically been over 200 days — largely because organizations fail to log critical events, monitor those logs, or alert on anomalous patterns.

### Threat: Privilege Abuse

Insider threats frequently rely on the absence of audit logging. The **2016 Bangladesh Bank SWIFT heist** ($81M stolen) succeeded partly because audit trails for SWIFT transactions were inadequate, delaying detection and complicating forensic attribution.

### CVE Reference

- **CVE-2021-44228 (Log4Shell)**: While primarily an RCE vulnerability in Apache Log4j, this CVE is directly relevant to logging infrastructure — the vulnerability was *triggered through log input*, meaning the logging system itself became an attack vector. Organizations that log user-controlled strings through Log4j without input sanitization were exploited through their own audit pipeline.

---

## Defensive Measures

### 1. Enable Comprehensive Audit Policies

**Windows**: Use Group Policy (or a GPO baseline like CIS Benchmarks) to enable audit policy for all security-relevant subcategories:

```powershell
# Apply CIS-recommended audit policy baseline
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Account Lockout" /success:enable /failure:enable
auditpol /set /subcategory:"Privilege Use" /success:enable /failure:enable
auditpol /set /subcategory:"Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Object Access" /success:enable /failure:enable
```

**Linux**: Deploy `auditd` with rules aligned to the **CIS Linux Benchmark** or **STIG** (Security Technical Implementation Guide).

### 2. Centralize Log Forwarding Immediately

Configure all hosts to forward logs in real time to a [[SIEM]] or centralized syslog server. A log still on the endpoint can be deleted by an attacker; a log already forwarded to a remote, hardened server cannot. Use **syslog over TLS** (port 6514) to protect log confidentiality and integrity in transit.

Tools: **rsyslog**, **Fluentd**, **NXLog**, **Elastic Beats (Winlogbeat, Filebeat)**

```bash
# Winlogbeat config snippet (Windows → Elasticsearch)
winlogbeat.event_logs:
  - name: Security
    event_id: 4624, 4625, 4648, 4672, 4698, 4720, 4740
  - name: System
output.