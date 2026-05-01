---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# X. Incident Detection and Analysis
**Security analysts hunt for breadcrumbs of compromise by weaving together clues from logs, traffic, and system behavior.**

---

## Overview

Detecting incidents means spotting the telltale signs that something malicious has happened or is happening right now. Security analysts don't just acknowledge that alerts fire—they ask the critical question: *Do these pieces of evidence actually point to a real compromise?* This section trains you to recognize the patterns attackers leave behind, understand what those patterns mean, and chain multiple weak signals into strong confidence that a breach has occurred.

---

## Key Concepts

### Indicators of Compromise (IoCs)

**Analogy**: Think of IoCs like fingerprints at a crime scene. A single smudged print isn't conclusive—it could belong to anyone who visited. But when you find five fingerprints from the same person in places they shouldn't have been, suddenly you have a case.

**Definition**: [[Indicators of Compromise (IoCs)]] are discrete pieces of observable information—events, actions, behaviors—that correlate with malicious activity. They're forensic artifacts that reveal unauthorized access, data exfiltration, lateral movement, or persistence mechanisms. A single IoC is rarely conclusive; their power lies in correlation.

**Detection Purpose**: IoCs help analysts identify active compromises, catch suspicious behavior early, and build evidence chains for incident response investigations.

---

### Indicators of Attack (IoAs) vs. Indicators of Compromise (IoCs)

**Analogy**: An IoA is watching the burglar actively breaking in through your window (real-time). An IoC is finding a muddy footprint inside your house the next morning (forensic evidence).

**Definition**: 

| Aspect | [[Indicator of Attack (IoA)]] | [[Indicator of Compromise (IoC)]] |
|--------|------|------|
| **Timing** | Detected *during* active attack | Detected *after* or *during* analysis |
| **Focus** | Attacker behavior, techniques (MITRE ATT&CK) | Forensic artifacts, system changes |
| **Analyst Action** | Real-time response, block/contain | Retrospective investigation, evidence collection |
| **Confidence** | Medium (behavior-based) | Higher (concrete artifacts) |

*In practice, security teams blur these terms and use "IoC" as the umbrella concept.*

---

### Unusual Network Traffic

**Analogy**: Your company's network is like a highway system with normal routes. When you suddenly see cars taking backroads, driving at midnight, or heading to towns they've never visited, that's suspicious.

**Definition**: [[Unusual Network Traffic]] includes communications that deviate from baseline behavior—unexpected port usage, peer-to-peer flows, lateral movement, or command-and-control (C2) callbacks. Attackers often try to hide these channels, but they leave ripples in traffic patterns.

**Common Red Flags**:
- Connections to non-standard ports (e.g., SSH on port 8022, RDP on 3390)
- Systems talking to each other for the first time (broken trust relationships)
- Internal-to-internal lateral movement not explained by business function
- Outbound traffic to external IPs at odd hours
- Volume spikes inconsistent with baseline

**Outbound Traffic Focus**:
- Unexpected C2 callbacks to attacker infrastructure
- Unusual protocols (reverse shell via SSH, data exfil via FTP)
- [[DNS]] queries to suspicious or typosquatted domains
- Timing anomalies (traffic at 2 AM when the company is asleep)

---

### Resource Consumption Anomalies

**Analogy**: Your computer normally hums along using 30% CPU. Suddenly it's screaming at 95% and the fan is loud. Something is either working hard or working *against* you.

**Definition**: [[Resource Consumption Anomalies]] occur when CPU, memory, disk, network bandwidth, or database I/O spike beyond baseline. Attackers running malware, cryptominers, or exfiltration tools consume resources noticeably.

**Examples**:
- CPU spikes tied to [[ransomware]] encryption or cryptomining
- Memory exhaustion from [[backdoor]] processes or memory-resident malware
- Disk space shrinking from data staging before exfiltration
- Database query floods from SQL injection or privilege abuse
- Network bandwidth consumed by C2 or data tunneling

**Critical Caveat**: Not every spike is malicious. Legitimate admin scripts, scheduled backups, and deployment pipelines also spike resources. Correlation with other IoCs is mandatory.

---

### Unusual User and Account Behavior

**Analogy**: You know your accountant Sally—she works 9–5, logs in from her desk, and reads expense reports. Suddenly Sally is accessing the payroll database at 3 AM from an IP in Belarus and copying files to a flash drive. That's not Sally acting like Sally.

**Definition**: [[Behavioral IoCs]] flag actions inconsistent with user roles, historical patterns, or time-of-day norms. Attackers, even if they steal credentials, often behave differently than legitimate users.

**High-Signal Behaviors**:
- [[Privilege Escalation]] attempts or unauthorized group additions
- [[Impossible Travel]]: Same user logging in from distant geographies within physically impossible timeframes
- Bot-like behavior: Commands executed microseconds apart, repeated identical actions, inhuman typing speed
- Off-hours access for non-on-call roles
- Access to resources unrelated to job function (accountant accessing source code repos)
- Mass file access or copying not matching job duties

**Detection Complexity**: Legitimate admin automation scripts, backup jobs, and DevOps pipelines can mimic attacker behavior. Context is everything—a 3 AM database query from the backup service account is normal; from a marketing user, it's red.

---

### File and Configuration Modifications

**Analogy**: Someone broke into your house and rearranged furniture, added a hidden safe, and left muddy footprints on the carpet. Changes to your physical space scream "intruder."

**Definition**: [[File Integrity Monitoring (FIM)]] and [[Host-Based Intrusion Detection Systems (HIDS)]] track unauthorized changes to critical files, configurations, and system settings. Attackers modify files to establish persistence, disable defenses, or prepare for lateral movement.

**Key Modifications**:
- Config file edits (sudoers, SSH keys, firewall rules)
- Log file tampering or deletion (covering tracks)
- Unauthorized binaries or scripts in system directories
- Changes to startup/boot configurations for persistence
- Missing security patches or unexpected patching

**Tools**:
- [[OSSEC]]: Open-source HIDS with FIM capabilities
- [[Tripwire]]: Commercial file integrity monitor
- [[auditd]] (Linux): Kernel-level audit logging

---

### Login and Access Timing Anomalies

**Analogy**: Your employee Bob always drives to the office, swipes his badge at 8:47 AM, and leaves at 5:15 PM. One day, his badge swipes in Toronto at 8 AM and London at 8:15 AM. Physically impossible—someone cloned his badge or stole his credentials.

**Definition**: [[Temporal and Geographic Anomalies]] flag logins that violate physical laws or normal work schedules. These are powerful IoCs when correlated correctly.

**Examples**:
- [[Impossible Travel]]: Same user from New York then London within 30 minutes
- Off-hours access for roles that shouldn't work nights
- Access patterns misaligned with job title (clerk accessing executive payroll)
- Repeated failed login attempts followed by success (credential stuffing or brute force)

**Noise and False Positives**: VPN users, remote workers, and shift-based staff complicate analysis. Organizations must baseline each user and tune detection to their population.

---

### Denial-of-Service (DoS) Activity

**Analogy**: A DoS is like flooding the front desk with so many visitors that legitimate customers can't get service. The attacker doesn't need access—they just break the system for everyone.

**Definition**: [[Denial-of-Service (DoS)]] attacks consume resources (bandwidth, CPU, memory) to prevent legitimate users from accessing systems. They can originate externally (DDoS botnets) or internally (compromised machines amplifying traffic).

**Variants**:
- Single-source DoS: One attacker/machine floods a target
- [[Distributed Denial-of-Service (DDoS)]]: Botnet coordinates thousands of machines
- [[Amplification Attacks]]: Attacker spoofs traffic through third-party services (DNS, NTP) to magnify volume
- Application-layer DoS: Low-volume, high-impact attacks (Slowloris, ReDoS)

**As an IoC**: DoS activity itself signals compromise, especially if:
- Internal systems initiating external DoS attacks (compromised machine)
- Unusual traffic volumes from specific hosts
- Patterns match known botnet signatures

**Distinction**: Repeated rapid-fire requests to an application *might* be DoS, but could also indicate exploitation attempts or fuzzing.

---

### Unusual DNS Traffic

**Analogy**: DNS is the internet's address book. Normally people look up legitimate domain names. But if someone is querying random gibberish thousands of times, or trying to hide secrets in DNS packets, something is wrong.

**Definition**: [[DNS]] is a high-value detection surface because attackers abuse it for command-and-control, data exfiltration, and reconnaissance. Unusual DNS patterns reveal compromise.

**Red Flags**:
- [[Domain Generation Algorithm (DGA)]]: Bot generates random domain names to find C2 servers; shows abnormally high query volume and failures
- [[DNS Tunneling]]: Attacker encodes data (stolen files, commands) in DNS queries to bypass firewalls
- [[Fast-Flux DNS]]: Attacker rapidly changes IP addresses for a domain to maintain C2 resilience
- Queries to newly registered or typosquatted domains
- DNS failures at scale (NXDOMAIN responses)
- Large DNS responses (data exfil compressed into DNS replies)

**Detection Risk**: Security teams sometimes over-whitelist or over-allow DNS to avoid false positives, accidentally blinding themselves to real attacks.

---

### Probes, Scans, and Reconnaissance

**Analogy**: A burglar casing a house checks doors, peers in windows, and tests the alarm. Port scans and network probes are reconnaissance—attackers mapping targets before exploitation.

**Definition**: [[Network Scanning and Probing]] involves sequential connection attempts, port scanning, or service enumeration. Internal scans often signal compromised systems conducting lateral reconnaissance.

**Indicators**:
- Sequential TCP connection attempts to multiple ports on same host
- ICMP echo requests (ping sweeps) mapping network ranges
- Service enumeration (banner grabbing, SMB enumeration)
- Vulnerability scanning tools (Nessus, OpenVAS signatures in logs)

**Context**: External scans are expected (from security assessments, threat actors). *Internal* scans are more suspicious—why would a file server scan 200 machines for open ports unless compromised?

---

## Analyst Relevance

A SOC analyst's job is sitting in a control center watching thousands of alerts fire daily. Most are noise. But imagine this real scenario:

**3:15 AM**: A finance user's account has three failed login attempts, then success from an IP in Romania.
**3:18 AM**: Network flow shows that user's machine talking to an internal database server that it's never contacted before.
**3:22 AM**: File integrity monitoring alerts: critical system files in `/etc/ssh` modified.
**3:25 AM**: DNS query for a newly registered domain (`totally-legit-updates.ru`) from that same machine.

Each alert alone is suspicious-ish. Together, they form a narrative: *credentials compromised, initial access gained, lateral movement begun, persistence established, C2 callback attempted.* The analyst doesn't just acknowledge alerts—they synthesize IoCs into a **confirmed compromise** and escalates to incident response.

Without understanding IoC correlation, that analyst dismisses each alert as potential false positive and the breach continues for weeks.

---

## Exam Tips

### Question Type 1: Identifying IoCs from Logs
- *"Your network monitoring tool alerts on a user downloading a 500 MB file from a cloud storage site at 2 AM. This user normally works 9–5 and has never accessed this site. What IoC is most relevant?"* → **Behavioral anomaly (off-hours, anomalous access) + unusual data transfer volume**
- **Trick**: Don't pick "file downloaded"—that's too vague. Focus on *why* it's suspicious: timing