---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Log Management
**Your digital crime scene evidence locker — where every system's story gets recorded and searchable.**

---

## Overview

[[Log Management]] is the practice of gathering event records from every device and application across your network into a single searchable location. Security analysts need this skill because investigating threats without centralized logs means bouncing between ten different systems, missing connections, and wasting hours—like trying to solve a murder mystery by reading one witness statement at a time instead of assembling all the testimony in one room.

---

## Key Concepts

### Centralized Log Collection

**Analogy**: Imagine every witness to a crime writes their statement in a different notebook using different handwriting, different languages, and different timestamps. Now imagine dumping all those notebooks into one filing cabinet and having one detective who can instantly search all of them together. That's centralized logging.

**Definition**: The aggregation of [[Event Logs]] from [[Operating Systems]], [[Firewalls]], [[Proxy Servers]], [[EDR]] tools, [[Email Gateways]], and cloud services into a unified repository accessible through a single search interface.

---

### Log Normalization

**Analogy**: Think of a translator at the United Nations converting English, Mandarin, and Spanish into a standardized format so debates can actually make sense to everyone reading the transcript.

**Definition**: The process of converting logs from different sources (which use different formats, field names, and timestamps) into a consistent, standardized structure for comparison and correlation.

Related: [[Data Standardization]], [[ETL Processes]]

---

### Log Retention

**Analogy**: Security investigations sometimes need to look back months after an attack was first detected. Keeping logs is like keeping security camera footage—throw it away after 30 days and you can't prove what happened on day 60 when you finally noticed the crime.

**Definition**: The duration that [[Log Management]] systems store historical log data, typically ranging from 30 days to 7+ years depending on compliance requirements and organizational risk appetite.

| Retention Period | Use Case | Typical Duration |
|---|---|---|
| Short-term | Active threat hunting & rapid IR | 30–90 days |
| Medium-term | Forensic investigations & compliance | 90–365 days |
| Long-term | Historical analysis & legal holds | 1–7 years |

Related: [[Data Retention Policies]], [[Compliance Requirements]], [[GDPR]], [[SOX]]

---

### Log Correlation

**Analogy**: One traffic camera catches a suspicious car driving past. Three more cameras catch the same car at different intersections. Correlation is when you connect those dots and realize the car is systematically circling the neighborhood, not just passing through randomly.

**Definition**: The process of linking related [[Events]] across multiple logs to identify patterns, sequences, and relationships that reveal the full scope of suspicious activity.

Related: [[Event Correlation]], [[SIEM]], [[Alert Tuning]]

---

### Network Time Protocol (NTP) Synchronization

**Analogy**: If one witness says a crime happened at 2:15 PM but their clock is 20 minutes fast, and another says 2:35 PM with their clock running 5 minutes slow, you'll incorrectly think the events happened 40 minutes apart when they actually happened seconds apart.

**Definition**: The requirement that all devices generating logs maintain synchronized system clocks (usually via [[NTP]]), ensuring timestamps are accurate and comparable across the infrastructure.

Related: [[Time Synchronization]], [[Clock Skew]]

---

### Log Integrity and Immutability

**Analogy**: A criminal who steals evidence from a crime scene can fabricate or destroy testimony. Protected logs are like evidence in a tamper-proof safe—you can see who accessed it and when, and if anyone changes it, you know immediately.

**Definition**: The implementation of controls (encryption, digital signatures, write-once-read-many storage, and access logging) to ensure [[Logs]] cannot be modified or deleted by threat actors covering their tracks.

Related: [[Log Protection]], [[Syslog-ng]], [[Splunk Forwarders]], [[Chain of Custody]]

---

## Analyst Relevance

### Real SOC Scenario: Malware Callback Investigation

Your [[SIEM]] fires an alert: "Suspicious outbound connection to 185.220.101.45 from workstation CORP-LAP-042."

Without [[Log Management]], you're stuck:
- Is this the only device? Don't know without checking each system manually.
- When exactly did it happen? Check the firewall logs, then proxy logs, then EDR logs.
- What data moved? Firewall doesn't show payloads; you'd need packet captures.

**With [[Log Management]]:**
1. **One search**: `destination_ip=185.220.101.45` returns connections from all systems in the last 90 days.
2. **Correlation**: You instantly see three other devices also contacted that IP in the past week—devices the [[SIEM]] didn't alert on.
3. **Timeline**: Logs show the pattern: compromised device A reached out, then device B connected 3 minutes later, then C and D in the following hour—classic [[Lateral Movement]].
4. **Payload inspection**: Proxy logs show the traffic was HTTPS, but DNS logs show a suspicious subdomain resolver was queried first.
5. **User context**: You match IP connections to user logins and see one account was active on all four devices during the callback window.

**Result**: You've escalated from one alert to a 4-device [[Compromise]] with timeline, users, and justification for containment—all from one search interface.

---

## Exam Tips

### Question Type 1: Identifying the Purpose of Log Management
- *"A [[SOC]] analyst receives a [[SIEM]] alert about suspicious outbound traffic. The analyst needs to determine which other hosts communicated with the same destination. Which tool is BEST suited for this investigation?"* → [[Log Management]] or centralized [[SIEM]] (allows cross-system correlation).
- **Trick**: The question might list "[[EDR]] Agent" or "individual firewall logs"—those are data sources, not investigation tools. The exam wants the centralized aggregation platform.

---

### Question Type 2: Log Retention and Forensics
- *"Your organization's compliance requirement mandates investigation capability for incidents occurring up to 180 days ago. What is the minimum [[Log Retention]] period?"* → 180 days minimum; best practice is 365+ days.
- **Trick**: Some answers say "30 days is standard." Not for forensics. 30 days is short-term operational logging; compliance and IR demand longer retention.

---

### Question Type 3: Normalization and Correlation
- *"Logs from five different sources are being ingested into a [[SIEM]]. Timestamps differ by up to 2 hours between systems. What should be implemented first?"* → [[NTP]] synchronization and [[Log Normalization]].
- **Trick**: Don't pick "correlation rules"—if timestamps aren't synchronized, correlation is meaningless. Synchronization and format standardization come before intelligence.

---

### Question Type 4: Incident Investigation Workflow
- *"During a ransomware investigation, the analyst discovers the initial infection vector but needs to identify all systems that may have been encrypted. Where should the analyst search?"* → [[Log Management]] to correlate file access patterns, encryption-related processes, and lateral movement across all endpoints.
- **Trick**: Avoid answers like "check the infected system only" or "review SIEM alerts"—the investigation requires breadth (all systems) and depth (detailed logs), which only [[Log Management]] provides.

---

## Common Mistakes

### Mistake 1: Confusing [[SIEM]] with [[Log Management]]
**Wrong**: "The [[SIEM]] shows the alert, so the [[SIEM]] is the investigation tool."

**Right**: [[SIEM]] rules detect and alert on patterns. [[Log Management]] stores and searches the raw event data behind those alerts. [[SIEM]] says "something bad happened here"; [[Log Management]] shows you the full story.

**Impact on Exam**: You might choose a [[SIEM]]-specific feature when the question asks how to perform deep forensic investigation. [[Log Management]] is the foundation; [[SIEM]] is the early warning system.

---

### Mistake 2: Assuming 30-Day Retention Is Standard
**Wrong**: "We only need to keep logs for 30 days to catch active attacks."

**Right**: [[Compliance requirements]] (PCI-DSS, HIPAA, SOX) mandate 90–365+ days. Advanced persistent threats hide for months before detection. Forensic investigations require historical data beyond the initial alert.

**Impact on Exam**: Questions about "how long should logs be retained for a [[Compromise]] discovered 60 days after infection?" require longer retention. Answer is always "at least as long as your forensic investigation window," which is typically 1 year minimum.

---

### Mistake 3: Overlooking NTP Synchronization
**Wrong**: "Timestamps don't matter much; we can estimate the sequence of events."

**Right**: If Device A's clock is 30 minutes behind Device B's clock, a connection from A to B appears to happen 30 minutes before the initial compromise event, breaking the timeline. [[NTP]] synchronization is mandatory for log correlation.

**Impact on Exam**: Any question mentioning timeline analysis or "events appear out of sequence" is asking if you know [[NTP]] must be configured first.

---

### Mistake 4: Treating Logs as Immutable Without Controls
**Wrong**: "Logs are written to disk, so they're protected."

**Right**: A threat actor with system access can delete or modify logs. You must implement write-once storage, encryption, integrity checking (hashing), and central [[Syslog]] forwarding to protect against tampering.

**Impact on Exam**: Questions about "how to ensure logs cannot be altered by an attacker with admin rights" require answers about [[Log Forwarding]], encryption, and immutable storage—not just "store them securely."

---

### Mistake 5: Forgetting Log Normalization Breaks Correlation
**Wrong**: "We can correlate logs from our firewall, EDR, and email gateway without converting them to a standard format."

**Right**: A firewall logs an IP as "source_ip," EDR logs it as "src_ip," and email logs it as "connecting_host." Without [[Log Normalization]], your search for "185.220.101.45" misses half the events.

**Impact on Exam**: Questions asking "why is correlation failing?" often hinge on missing normalization. Answers involving "map fields" or "standardize formats" are the red flag that normalization is the issue.

---

## Related Topics

- [[SIEM]] — The detection and alerting layer that sits on top of [[Log Management]]
- [[EDR]] — Endpoint-level logging source that feeds into [[Log Management]]
- [[Syslog]] — The protocol commonly used to forward logs to centralized repositories
- [[Event Logs]] — Individual records that comprise the data in a [[Log Management]] system
- [[Splunk]] — Common commercial [[Log Management]] platform (CySA+ may reference this)
- [[ELK Stack]] — Open-source alternative (Elasticsearch, Logstash, Kibana)
- [[Chain of Custody]] — Legal/forensic practice for protecting and documenting log integrity
- [[Incident Response]] — [[Log Management]] is essential for IR investigations
- [[Forensics]] — Long-term [[Log Retention]] enables post-incident forensic analysis
- [[Compliance Requirements]] — Regulations drive [[Log Retention]] policies
- [[Threat Hunting]] — Analysts use [[Log Management]] to proactively search for adversary behavior

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | [[Log Management]]*