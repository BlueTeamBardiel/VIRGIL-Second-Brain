---
domain: "governance-risk-compliance"
tags: [audit, logging, compliance, accountability, monitoring, forensics]
---

# Audit

An **audit** in cybersecurity and IT governance is a systematic, independent examination of systems, processes, logs, and controls to determine whether they conform to established policies, standards, regulations, or security requirements. **Audit trails** — chronological records of system activity — are the foundational artifact that makes accountability and forensic investigation possible. Auditing intersects deeply with [[Logging]], [[Access Control]], [[Compliance]], and [[Incident Response]].

---

## Overview

Auditing exists because security cannot be assumed — it must be verified. In any complex IT environment, users, administrators, applications, and systems are constantly performing actions that may be authorized, unauthorized, accidental, or malicious. Without a rigorous audit function, there is no reliable way to detect policy violations, satisfy regulatory requirements, or reconstruct the sequence of events following a security incident. Auditing transforms abstract security policies into concrete, measurable, and reviewable evidence.

There are two primary forms of auditing in cybersecurity contexts. **Technical audits** examine system configurations, log files, network traffic captures, and software behavior to verify that controls are functioning as intended. **Compliance audits** assess whether an organization's processes and documentation meet the requirements of specific frameworks such as [[PCI-DSS]], [[HIPAA]], [[SOC 2]], [[ISO 27001]], or [[NIST SP 800-53]]. Most mature security programs conduct both types on a regular, scheduled basis and also in response to incidents or control failures.

The concept of auditing is inseparable from the principle of **non-repudiation** — the cryptographic and procedural assurance that an action can be definitively attributed to a specific identity and cannot be denied. When a user logs into a system, executes a privileged command, or transfers a sensitive file, the audit system captures the who, what, when, where, and how. This data is then protected — ideally through write-once storage, cryptographic hashing, or centralized [[SIEM]] forwarding — so that neither the user who performed the action nor an attacker who compromised the account can erase the evidence.

Regulatory drivers for auditing are immense. The Sarbanes-Oxley Act (SOX) requires publicly traded companies to maintain accurate financial records and logs of changes to financial systems. HIPAA mandates audit controls for protected health information (PHI) in electronic health record systems. PCI-DSS Requirement 10 explicitly mandates logging and monitoring of all access to cardholder data environments, with log retention of at least one year (three months immediately available). GDPR requires organizations to demonstrate accountability for data processing, which inherently demands audit records. Failing an audit — internal or external — can result in fines, loss of certification, or mandatory remediation.

Internally, auditing supports a culture of **accountability**. When users know their actions are logged and reviewed, deterrence is created against both malicious insiders and careless behavior. Audit findings drive risk management decisions, budget allocations, and security roadmap priorities. A clean audit is not simply a compliance checkbox — it is evidence that security controls are working and that the organization understands its own risk posture.

---

## How It Works

### Audit Data Generation

Auditing begins at the point of action. Operating systems, applications, network devices, and security tools each generate log entries when significant events occur. The events selected for logging are defined by an **audit policy**, which specifies which event categories are recorded (e.g., logon events, privilege use, object access, process creation, policy changes).

**Windows Event Logging (Windows Audit Policy)**

Windows uses Group Policy or `auditpol.exe` to configure audit settings:

```powershell
# View current audit policy
auditpol /get /category:*

# Enable auditing of logon events (success and failure)
auditpol /set /subcategory:"Logon" /success:enable /failure:enable

# Enable object access auditing (required to audit file/folder access)
auditpol /set /subcategory:"File System" /success:enable /failure:enable

# Enable process creation logging (critical for threat hunting)
auditpol /set /subcategory:"Process Creation" /success:enable
```

Windows Security Event Log key Event IDs relevant to auditing:

| Event ID | Description |
|----------|-------------|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4648 | Logon using explicit credentials (Pass-the-Hash indicator) |
| 4672 | Special privileges assigned to new logon (admin) |
| 4688 | New process created |
| 4698 | Scheduled task created |
| 4720 | User account created |
| 4732 | Member added to security-enabled local group |
| 4771 | Kerberos pre-authentication failed |
| 7045 | New service installed |

**Linux Auditing with `auditd`**

Linux uses the `auditd` daemon, controlled via `auditctl` and configured in `/etc/audit/audit.rules`:

```bash
# Install auditd
sudo apt install auditd audispd-plugins

# Start and enable the service
sudo systemctl enable --now auditd

# Watch a sensitive file for reads and writes
sudo auditctl -w /etc/passwd -p rwa -k passwd_changes

# Monitor execution of sudo
sudo auditctl -w /usr/bin/sudo -p x -k sudo_exec

# Audit all failed authentication attempts (syscall level)
sudo auditctl -a always,exit -F arch=b64 -S open -F exit=-EACCES -k access_denied

# View audit logs in real time
sudo ausearch -k passwd_changes --interpret

# Generate a summary report
sudo aureport --summary

# View failed authentication events
sudo aureport --auth --failed
```

The audit log by default resides at `/var/log/audit/audit.log`. Entries include timestamp, syscall, PID, UID, GID, success/failure, and contextual data.

### Centralized Log Collection and SIEM Integration

Raw device logs are only useful if collected, protected, and analyzed. The standard architecture forwards logs to a centralized [[SIEM]] (Security Information and Event Management) platform such as [[Splunk]], [[Elastic SIEM]], or [[Wazuh]] using protocols such as:

- **Syslog** (UDP/TCP port 514, or TLS syslog on port 6514)
- **Windows Event Forwarding (WEF)** over WinRM (port 5985/5986)
- **Beats/Elastic Agent** (Filebeat, Winlogbeat) over port 5044 or 443
- **CEF/LEEF** (Common Event Format / Log Event Extended Format) for SIEM normalization

```bash
# Example rsyslog forwarding to central syslog server
# /etc/rsyslog.d/50-forward.conf
*.* @192.168.1.100:514        # UDP
*.* @@192.168.1.100:514       # TCP (reliable delivery)
```

### Audit Review Process

Once logs are collected, the audit review cycle typically follows this workflow:

1. **Define scope** — Which systems, time periods, and event categories are being reviewed?
2. **Extract relevant logs** — Query SIEM or log management system using filters (user, IP, event type, time range)
3. **Correlate events** — Cross-reference events across multiple sources to reconstruct activity timelines
4. **Compare against policy** — Identify deviations from expected behavior, authorized access lists, or configuration baselines
5. **Document findings** — Record anomalies, policy violations, and unresolved questions
6. **Report and remediate** — Present findings to stakeholders and drive corrective action
7. **Retain records** — Store audit logs per retention policy (commonly 1–7 years depending on regulation)

### Log Integrity Protection

Audit logs themselves are a high-value target for attackers attempting to cover their tracks. Protection mechanisms include:

```bash
# Make audit log append-only on Linux (prevents modification by root)
sudo chattr +a /var/log/audit/audit.log

# Verify log hash integrity (example using sha256sum)
sha256sum /var/log/auth.log > /secure/auth.log.sha256

# Configure auditd to lock configuration after rules are loaded
# In /etc/audit/audit.rules, add at the end:
-e 2
```

The `-e 2` flag locks the audit configuration and requires a reboot to change rules, preventing an attacker from disabling auditing even with root access.

---

## Key Concepts

- **Audit Trail**: A chronological, tamper-evident record of system events and user actions. Forms the primary evidence base for forensic investigation, compliance reporting, and accountability reviews.

- **Audit Policy**: A defined specification of which events, systems, and users are subject to logging. An overly broad policy generates unmanageable log volume; an overly narrow one creates blind spots. Effective policies are risk-based and tied to data classification.

- **Non-Repudiation**: The property ensuring that a party cannot deny having performed an action. Achieved through combination of strong authentication, audit logging, digital signatures, and log integrity controls. A cornerstone of [[PKI]] and legal admissibility of digital evidence.

- **Log Retention**: The period for which audit logs must be preserved. Varies by regulation: PCI-DSS requires 12 months; HIPAA suggests 6 years; NIST recommends risk-based determination. Retention policies must balance storage cost against investigation needs and legal requirements.

- **Separation of Duties (SoD) in Auditing**: The principle that the individuals being audited should not control the audit system or have the ability to modify audit records. Administrators should not have write access to their own audit logs; audit functions should be managed by a distinct team or role.

- **Continuous Auditing**: An approach where automated tools monitor systems and controls in real time rather than performing periodic point-in-time reviews. Contrasts with traditional annual or quarterly audits. Enabled by SIEM, SOAR, and compliance automation platforms like [[Qualys]] or [[Tenable]].

- **Evidence Integrity**: The concept that audit data used in legal proceedings, disciplinary actions, or incident investigations must be demonstrably unaltered. Achieved through cryptographic hashing, write-once media, chain of custody documentation, and [[Digital Forensics]] best practices.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Audit appears primarily in Domain 4 (Security Operations) and Domain 5 (Security Program Management and Oversight). Understanding audit in the context of accountability controls, compliance frameworks, and log management is essential.

**Key exam themes and tips:**

- **Know the difference between auditing and monitoring**: Monitoring is real-time detection of events; auditing is the retrospective review and accountability function. The exam may try to blur these — remember that auditing implies a formal review process with documented findings.

- **Audit vs. Assessment vs. Penetration Test**: These three are frequently tested together. An **audit** measures conformance to a standard or policy. An **assessment** identifies risks and vulnerabilities. A **penetration test** actively exploits vulnerabilities to demonstrate impact. They are distinct activities with different scopes and methodologies.

- **Who performs the audit matters**: An **internal audit** is performed by the organization's own staff. An **external audit** is performed by an independent third party and carries more weight for compliance purposes. An **independent audit** implies the auditor has no financial or organizational interest in the outcome.

- **The concept of due diligence vs. due care**: Due diligence is the investigative process (auditing systems, reviewing policies). Due care is taking action on findings. Both appear in GRC questions and both require auditing as a mechanism.

- **Common gotcha**: Students confuse "audit log" with "system log." Not all system logs are audit logs — audit logs specifically record security-relevant events tied to accountability. System logs may include performance data, errors, and diagnostic information that is not necessarily audit-relevant.

- **Regulatory framework linkages**: Be able to connect specific regulations to audit requirements. PCI-DSS → Requirement 10 (log monitoring), HIPAA → 45 CFR §164.312(b) (audit controls), SOX → Section 404 (internal control over financial reporting), NIST 800-53 → AU control family.

---

## Security Implications

### Threats Against Audit Systems

Audit infrastructure is a prime target for sophisticated attackers because destroying or manipulating logs is a key step in covering tracks (MITRE ATT&CK T1070 – Indicator Removal on Host). Common attack patterns include:

- **Log deletion**: Direct deletion of log files after gaining elevated privileges. Detectable by gaps in log timestamps or absence of expected log rotation entries.
- **Log tampering**: Modifying specific log entries to remove evidence of malicious actions. Requires either direct file system access or exploitation of the log management system itself.
- **Log flooding**: Generating massive volumes of noise events to overwhelm analysts and obscure malicious activity within legitimate log data. Also risks triggering log rotation that overwrites older evidence.
- **Disabling the audit service**: Stopping `auditd`, the Windows Event Log service, or the SIEM forwarder to create a blind spot. Windows Event ID 1100 (Event Logging Service Shutdown) and 1102 (Audit Log Cleared) are critical alerts.

### Real-World Incidents

**SolarWinds (2020)**: The SUNBURST attackers specifically evaded audit trails by using legitimate SolarWinds processes, waiting for quiet periods, and blending malicious activity with normal administrative traffic. The attack demonstrated that audit logs alone are insufficient without behavioral analytics and anomaly detection layered on top.

**Target Breach (2013)**: Post-incident analysis revealed that the SIEM at Target had generated alerts about the malware activity, but the alerts were not acted upon. This is an audit *review failure* rather than an audit *collection failure* — a critical distinction. Having logs means nothing without a process to review them.

**Equifax (2017)**: The breach went undetected for 76 days partly because SSL inspection had been disabled for 19 months due to an expired certificate, meaning encrypted traffic from the attacker was not being logged or inspected. A routine audit of SSL inspection coverage would have caught this gap.

### CVE Example

**CVE-2021-4034 (PwnKit)**: After exploiting this privilege escalation vulnerability in `pkexec`, attackers gained root. One immediate action taken by threat actors was clearing `/var/log/auth.log` and `/var/log/syslog`. Environments with centralized log forwarding (where logs had already been shipped to a remote SIEM before deletion) retained the evidence; environments relying on local logs alone lost it. This illustrates the criticality of real-time log forwarding for audit integrity.

---

## Defensive Measures

### 1. Define a Comprehensive Audit Policy

Document which events must be logged, at what granularity, and on which systems. Base the policy on risk assessment and regulatory requirements. At minimum, audit:
- All authentication events (success and failure)
- Privileged command execution
- Account creation, modification, and deletion
- Access to sensitive data and critical system files
- Configuration changes to security controls
- Network firewall allow/deny decisions
- Application-level access to sensitive records

### 2. Centralize and Protect Log Storage

Deploy a centralized SIEM or log aggregation platform. Configure log sources to forward in real time:

```bash
# Wazuh agent installation on Linux endpoint
curl -so wazuh-agent-4.7.0.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.0-1_amd64.deb
WAZUH_MANAGER='192.168.1.50' dpkg -i ./wazuh-agent-4.7.0.deb
systemctl enable --now wazuh-agent
```

Protect the log repository with:
- Role-based access (read-only for most; append-only for forwarders)
- Cryptographic integrity verification (hash logs on ingestion)
- Geographic/logical separation from production systems
- Write-once or WORM (Write Once Read Many) storage for archival

### 3. Enable Windows Advanced Audit Policy via Group Policy

```
Computer Configuration > Windows Settings > Security Settings > 
Advanced Audit Policy Configuration > Audit Policies

Recommended minimums:
- Account Logon: Success, Failure
- Account Management: Success, Failure
- Logon/Logoff: Success, Failure
- Object Access: Failure (Success only on sensitive systems)
- Policy Change: Success, Failure
- Privilege Use: Failure (Success on high-security systems)
- Process Tracking: Success (on servers and workstations for threat hunting)
- System: Success,