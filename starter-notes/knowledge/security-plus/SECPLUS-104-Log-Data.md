---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 104
source: rewritten
---

# Log Data
**Every device on your network is constantly writing a diary of what happens — security professionals read those diaries to hunt threats.**

---

## Overview
Organizations generate enormous volumes of [[Log|logging]] data across their entire IT infrastructure, capturing security-relevant events at every layer. These records serve as your forensic evidence trail, allowing you to reconstruct incidents, validate compliance posture, and detect threats in real-time. For Security+, understanding what logs exist, where they live, and what they reveal is fundamental to threat detection and incident response.

---

## Key Concepts

### Firewall Logs
**Analogy**: Think of a firewall log as a security guard's clipboard at a building entrance — every visitor (traffic) is recorded with their arrival time, destination, what they carried, and whether they were allowed inside or turned away.

**Definition**: [[Firewall]] logs record all [[Network Traffic|network traffic]] crossing the perimeter, documenting [[Source IP|source]] and [[Destination IP|destination]] addresses, [[Port|ports]], [[Protocol|protocols]], and the firewall's action ([[Allow]] or [[Block]]).

| Log Element | Purpose |
|---|---|
| Source/Destination IPs | Identifies communicating parties |
| Port Numbers | Reveals which services are in use |
| Firewall Action | Shows permit vs. deny decisions |
| Timestamps | Establishes timeline of events |

### Next-Generation Firewall (NGFW) Logs
**Analogy**: If standard firewall logs are "who came through the door," NGFW logs are "what they were actually doing and which store they visited" — they understand the content and intent behind traffic.

**Definition**: [[NGFW|Next-Generation Firewalls]] extend basic traffic logging to include [[Application Layer|application-layer]] awareness, [[URL Category|URL categories]], [[Anomaly Detection|anomaly flagging]], and identification of suspicious patterns within encrypted traffic flows.

### Intrusion Prevention System (IPS) Logs
**Analogy**: An IPS log is like a security system that not only records a break-in attempt but also logs exactly which lock was attacked and what tool was used.

**Definition**: [[IPS]] logs capture [[Exploit|exploit]] attempts, [[Attack Signature|attack signatures]], and blocked malicious payloads in granular detail, providing forensic evidence of attack activity.

### DNS Query Logs
**Analogy**: DNS logs are like a record of every address someone looked up in a phone book — revealing their intent before they actually dial the number.

**Definition**: [[DNS]] logs capture domain name resolutions and can reveal [[Malware|malicious]] activity through suspicious [[Domain|domain]] resolution patterns or [[Command and Control|C2]] communications.

### URL/Web Content Logs
**Analogy**: These logs track which websites employees visited, similar to an internet service provider recording browsing history.

**Definition**: Logs documenting [[HTTP]]/[[HTTPS]] requests, including the [[URL|URLs]] accessed, categories blocked by [[Web Filter|web filtering]] policies, and [[Data Exfiltration|data exfiltration]] indicators.

### Log Correlation
**Analogy**: Correlation is like connecting dots — one log shows someone tried to access a file at 2:00 PM, another log shows that file was encrypted at 2:15 PM, and a third shows data left the network at 2:30 PM. Together, they tell a complete attack story.

**Definition**: [[Log Correlation|Correlating]] events across multiple [[Log Source|log sources]] (firewall, IPS, [[Endpoint Detection and Response|EDR]], [[System Log|system logs]]) to reconstruct incidents and identify patterns invisible in individual logs.

---

## Exam Tips

### Question Type 1: Log Source Identification
- *"Which log source would best show you that an employee accessed a website categorized as 'streaming video'?"* → [[NGFW]] or [[Proxy]] logs (they perform content categorization)
- *"You need to see which internal IP attempted to connect to an external server on port 443. Where do you look?"* → [[Firewall]] logs (they track all traffic crossing the boundary)
- **Trick**: Don't confuse firewall logs with IPS logs — firewalls track allowed/blocked traffic, while IPS logs focus on detected [[Threat|threats]] and exploits specifically.

### Question Type 2: Log Analysis Scenarios
- *"Security team finds DNS queries to 'paymentupdate.fake.com' followed by network traffic to 192.168.1.50. What does this suggest?"* → [[Malware]] using DNS for [[Reconnaissance|reconnaissance]] or C2
- **Trick**: The exam may present realistic attack chains — you must identify which logs contributed to detection at each stage.

### Question Type 3: NGFW vs. Standard Firewall
- *"Why would you deploy an NGFW instead of a standard firewall?"* → To see application and [[URL]] data, not just IP/port data
- **Trick**: Standard firewalls = what traffic flows; NGFWs = what traffic actually does

---

## Common Mistakes

### Mistake 1: Assuming Firewall Logs Show All Network Activity
**Wrong**: "The firewall log will show me everything that happened on my network because all traffic goes through it."
**Right**: Firewall logs show traffic crossing the perimeter boundary — internal network-to-network traffic (east-west) bypasses the firewall entirely.
**Impact on Exam**: You may be asked where to find lateral movement evidence — look to [[EDR]] or [[SIEM]] logs, not just firewall logs.

### Mistake 2: Confusing IPS Logs with Firewall Logs
**Wrong**: "The firewall and IPS both block traffic, so their logs serve the same purpose."
**Right**: [[Firewall]] logs show [[Policy|policy]]-based decisions (allow port 443?); [[IPS]] logs show threat-based decisions (is this a known [[Exploit|exploit]]?).
**Impact on Exam**: A question asking for "proof of a prevented attack" points to IPS logs, while "proof of policy enforcement" points to firewall logs.

### Mistake 3: Overlooking Log Correlation
**Wrong**: "I'll examine the firewall log, see a blocked connection, and that's the end of my investigation."
**Right**: A blocked connection in the firewall might correlate with a successful exploit in the IPS log from the same source seconds earlier — one blocked, one succeeded.
**Impact on Exam**: Expect multi-log scenario questions where you must tie events across different log sources to understand the full incident.

### Mistake 4: Forgetting URL Categorization is an NGFW Feature
**Wrong**: "Our standard firewall will tell me if employees are accessing gambling sites."
**Right**: Standard firewalls see only IPs and ports; [[NGFW]] and [[Proxy]] logs show URL categories.
**Impact on Exam**: When the question mentions "blocking by category" or "URL filtering," immediately think NGFW, not basic firewall.

---

## Related Topics
- [[Firewall]]
- [[NGFW]]
- [[IPS]]
- [[SIEM]]
- [[Log Analysis]]
- [[Incident Response]]
- [[Threat Hunting]]
- [[DNS]]
- [[Network Traffic Analysis]]
- [[EDR]]
- [[Proxy Logs]]
- [[Forensics]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*