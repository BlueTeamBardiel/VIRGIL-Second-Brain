---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 054
source: rewritten
---

# Indicators of Compromise
**Digital breadcrumbs that reveal unauthorized access to your systems.**

---

## Overview
An [[Indicator of Compromise]] (IoC) is concrete forensic evidence suggesting that an attacker has successfully penetrated or accessed your network infrastructure. For Security+ professionals, mastering IoC detection separates reactive incident responders from proactive threat hunters—you need to spot the "crime scene" before attackers establish permanent footholds.

---

## Key Concepts

### Indicator of Compromise (IoC)
**Analogy**: Think of an IoC like discovering muddy footprints leading through your house after a break-in. You didn't see the burglar enter, but the footprints prove someone was there and show you where they walked.

**Definition**: Observable artifacts, patterns, or anomalies in system logs, network traffic, file integrity, or user behavior that provide high-confidence evidence of a security breach or unauthorized access attempt.

[[IoC]] comes in multiple forms—each tells a different part of the intrusion story.

---

## Key Concepts

### Network Traffic Anomalies
**Analogy**: Imagine your business normally ships packages domestically, but suddenly you see shipping containers going to countries you don't do business with. That's not normal.

**Definition**: Unusual patterns in data flow, bandwidth consumption, or connection destinations that deviate from your organization's baseline traffic profile, often indicating [[data exfiltration]] or command-and-control communication.

**Common Red Flags**:
- Massive outbound data transfers at odd hours
- Traffic to geographically unusual destinations
- Connections to known malicious IP addresses via [[threat intelligence feeds]]

---

### File Integrity Violations
**Analogy**: You seal your diary with a unique wax stamp. If the seal is broken or the stamp looks different, someone opened it while you were gone.

**Definition**: Changes in [[cryptographic hash values]] (MD5, SHA-256) of files, executable modifications, unexpected timestamps, or permission changes indicate unauthorized file alteration or [[malware]] injection.

**Examples**:
- System .exe files hash values no longer match baseline
- Critical configuration files show newer modification times
- Binary executables gain unexpected execute permissions

---

### DNS Record Modifications
**Analogy**: Imagine someone changing your business address in the phone book so customers get directed to a fake storefront instead.

**Definition**: Unauthorized alterations to [[Domain Name System]] (DNS) records that redirect traffic intended for legitimate services to attacker-controlled servers, enabling [[man-in-the-middle attacks]] or phishing.

**Impact**: Users unknowingly connect to malicious sites believing they reached legitimate destinations.

---

### Authentication Anomalies
**Analogy**: Your friend always calls you on Tuesday mornings from their home number. Getting five failed calls from a casino in Las Vegas at 3 AM is definitely not your friend.

**Definition**: Unusual patterns in login attempts including failed authentication attempts from unusual locations, times, IP addresses, or rapid-succession login failures triggering [[account lockout]] mechanisms.

**Critical IoC**: Account lockout from excessive incorrect password attempts when the legitimate user made zero login attempts = compromise indicator.

---

### Excessive File Access Patterns
**Analogy**: Your coworker normally reads three reports per week. If they suddenly access 200 files in one hour, something's wrong—maybe they're not really your coworker.

**Definition**: Abnormal spikes in file read/write operations, particularly for sensitive or previously untouched data repositories, suggesting [[privilege escalation]], data staging, or [[lateral movement]].

---

### Comparison Table: Common IoC Categories

| IoC Type | Detection Method | Typical Tool | Severity |
|----------|-----------------|--------------|----------|
| Network Traffic | [[SIEM]] flow analysis | [[Wireshark]], [[NetFlow]] | High |
| File Hashes | Baseline comparison | [[Tripwire]], [[AIDE]] | Critical |
| DNS Changes | Query logging | [[DNS server logs]] | High |
| Login Failures | [[Authentication logs]] | [[Windows Event Viewer]] | Medium-High |
| File Access | Audit logs | [[File integrity monitoring]] | Medium |
| Process Behavior | Endpoint detection | [[EDR]] solutions | High |

---

## Exam Tips

### Question Type 1: Identification Scenarios
- *"A system administrator notices that file hashes for critical binaries no longer match stored baseline values. What does this indicate?"* → [[File Integrity Violation]], likely [[malware]] infection or unauthorized modification.
  - **Trick**: Don't confuse hash mismatches with legitimate software updates—the question implies baseline comparison failure.

### Question Type 2: Incident Response Priority
- *"Which IoC typically requires immediate isolation of the affected system?"* → Account lockouts combined with network exfiltration + unexpected file modifications.
  - **Trick**: Some IoCs are suspicious but low-impact; focus on those indicating active compromise and data movement.

### Question Type 3: Detection Technology Matching
- *"Which tool best detects DNS record modifications as an indicator of compromise?"* → [[DNS logging and monitoring]] / DNSSEC validation / threat intelligence feeds tracking known malicious domains.
  - **Trick**: Don't confuse DNS firewalls (prevention) with DNS monitoring (detection of changes).

---

## Common Mistakes

### Mistake 1: Confusing IoC with "Suspicious Activity"
**Wrong**: "Someone accessed the file server at 2 AM—that's definitely a compromise indicator."
**Right**: "Someone accessed the file server at 2 AM + their hash values changed + they logged in from a new country—these combined factors indicate compromise."
**Impact on Exam**: You'll misidentify low-confidence alerts, wasting incident response resources. Security+ requires you to distinguish correlation from causation.

---

### Mistake 2: Ignoring Baseline Establishment
**Wrong**: "This traffic volume looks high to me, so it's a compromise."
**Right**: "This traffic volume is 300% above our documented 90-day baseline during off-peak hours—IoC confirmed."
**Impact on Exam**: You must understand that IoCs are meaningful only in context. The exam tests whether you know to compare against established normal behavior via [[baselining]].

---

### Mistake 3: Single IoC = Definite Compromise
**Wrong**: "One failed login attempt = confirmed breach."
**Right**: "One failed login = suspicious; five failed logins + account lockout + unusual IP + file modifications = high-confidence compromise."
**Impact on Exam**: Security+ emphasizes [[correlation analysis]]. Real breaches show multiple IoCs. Single indicators are "indicators of possible compromise"—never assume without corroboration.

---

### Mistake 4: Overlooking [[Log Aggregation]]
**Wrong**: "I'll check the firewall logs for IoCs."
**Right**: "I'll correlate firewall logs + DNS logs + [[authentication logs]] + file integrity logs in my [[SIEM]] to identify patterns."
**Impact on Exam**: The exam rewards understanding that IoCs rarely exist in isolation. You need [[Security Information and Event Management]] concepts and multi-source correlation.

---

## Related Topics
- [[SIEM and Log Analysis]]
- [[Incident Response Procedures]]
- [[Threat Intelligence and Feeds]]
- [[Forensics and Evidence Collection]]
- [[Baselining and Anomaly Detection]]
- [[File Integrity Monitoring]]
- [[Network Monitoring Tools]]
- [[Authentication and Access Controls]]
- [[Data Exfiltration Detection]]
- [[Malware Analysis Indicators]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | [[Incident Response]] Domain*