---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# TryHackMe SimpleCTF
**A foundational penetration testing scenario teaching service enumeration and vulnerability identification on network hosts.**

---

## Overview

SimpleCTF is an introductory capture-the-flag challenge that walks security professionals through the systematic process of discovering what services are listening on a target machine and identifying exploitable weaknesses. For a SOC analyst or junior penetration tester, this exercise demonstrates why network reconnaissance is your first critical step—you can't attack what you don't know exists.

---

## Key Concepts

### Network Service Enumeration

**Analogy**: Think of a building security audit. Before you test door locks, you need to walk around and document which doors exist, where they are, and which are in use. Network enumeration is the same—you're cataloging the "doors" (open ports) your target is leaving accessible.

**Definition**: The process of systematically probing a network host to discover which [[TCP/UDP Ports]] are listening for connections and what [[services]] are bound to those ports.

**Tool**: [[nmap]] (Network Mapper) is the industry standard—`nmap -A <target>` performs aggressive scanning including [[service version detection]] and [[OS fingerprinting]].

---

### Port Categorization by Range

| Port Range | Designation | Significance |
|---|---|---|
| 0-1023 | Well-known ports | Privileged services ([[FTP]], [[HTTP]], [[SSH]]) |
| 1024-49151 | Registered ports | Application-specific services |
| 49152-65535 | Dynamic/private ports | Ephemeral client ports |

**Analogy**: Like ZIP codes—the first range is where government buildings live (standard, expected places). Higher ranges are where anyone can set up shop.

---

### Common Lower-Port Services in CTF Scenarios

**[[FTP]] (Port 21)**
- **Context**: File Transfer Protocol, unencrypted file sharing
- **Why it matters**: Often misconfigured with weak credentials or anonymous access enabled
- **Attacker interest**: Direct file access without authentication

**[[HTTP]] (Port 80)**
- **Context**: Web server traffic, unencrypted
- **Why it matters**: Web applications frequently contain [[SQL injection]], [[directory traversal]], or [[authentication bypass]] vulnerabilities
- **Attacker interest**: Primary vector for application-level exploits and CVE hunting

**[[SSH]] (Port 22, Higher Ports)**
- **Context**: Secure Shell, encrypted remote access
- **Why it matters**: Often runs on non-standard ports in CTF/hardening scenarios; [[brute force]] and [[credential stuffing]] attacks target SSH
- **Attacker interest**: Post-exploitation access or lateral movement

---

### Vulnerability Identification

**Analogy**: Once you know which stores are in the building, you check if the locks are broken. A [[CVE]] (Common Vulnerabilities and Exposures) is the recorded "broken lock"—a specific, reproducible weakness in a service version.

**Definition**: Using [[service version detection]] output from [[nmap]] to cross-reference public vulnerability databases ([[CVE]] registry, [[Exploit-DB]]) and identify known exploits matching the target's software versions.

---

## Analyst Relevance

**Real SOC Scenario**: 

You're assigned to assess a newly discovered internal machine (10.201.77.93) that appeared on the network unexpectedly. You run:
```bash
nmap -A 10.201.77.93
```

Results show [[FTP]] on port 21, [[HTTP]] on port 80, and [[SSH]] on a high port (2222). 

Your job:
1. **Flag the risk**: Port 21 (FTP) transmits credentials in cleartext—this alone is a compliance violation
2. **Hunt the CVE**: If HTTP is running Apache 2.4.10, you check Exploit-DB and find a [[path traversal]] vulnerability
3. **Recommend remediation**: Disable [[FTP]], upgrade [[HTTP]], relocate [[SSH]] or restrict access

This workflow—enumerate → identify → report—is your daily bread as a security analyst.

---

## Exam Tips

### Question Type 1: Service Discovery
- *"Using Nmap aggressive scanning, you identify FTP on port 21 and HTTP on port 80 on a target. Which port range category do these fall under?"* → **Well-known ports (0-1023)**
- **Trick**: Don't confuse port number with service type. SSH on port 2222 is still SSH, just on a non-standard port.

### Question Type 2: CVE Correlation
- *"A web server on the target is identified as Apache 2.4.15. What is your next step?"* → **Cross-reference the version against known vulnerabilities in CVE databases**
- **Trick**: Version numbers matter. Apache 2.4.15 vs. 2.4.16 can be the difference between vulnerable and patched.

### Question Type 3: Protocol Risk Assessment
- *"An internal server is running unencrypted FTP alongside SSH. Which protocol poses the greater credential exposure risk?"* → **FTP—credentials traverse the network in plaintext**
- **Trick**: Encryption status is more important than the port number.

---

## Common Mistakes

### Mistake 1: Assuming All High Ports Are Non-Standard
**Wrong**: "I found something on port 3000, so it must be a development server and low-risk."
**Right**: Enumerate the actual service—port 3000 could be a production application. Risk depends on the application, not the port number.
**Impact on Exam**: CySA+ questions test whether you understand that enumeration reveals *what*, not assumptions about *risk level*.

### Mistake 2: Skipping Version Detection
**Wrong**: "I found HTTP running. That's all I need to know."
**Right**: Run `nmap -sV` or `-A` to get software versions, then correlate with CVE databases.
**Impact on Exam**: You'll face questions where two targets both run "HTTP"—the difference is one has a patchable CVE and one doesn't.

### Mistake 3: Conflating Port Privilege with Service Criticality
**Wrong**: "It's on a high port, so it's not important."
**Right**: A database service on port 3306 (MySQL) or custom app on port 9000 can be equally critical.
**Impact on Exam**: CySA+ demands you prioritize by threat, not by port number conventions.

---

## Related Topics
- [[nmap]]
- [[CVE]] and [[Common Vulnerabilities and Exposures]]
- [[Service Version Detection]]
- [[Port Scanning Techniques]]
- [[Exploit-DB]]
- [[Network Reconnaissance]]
- [[CySA+]]

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | Penetration Testing Foundation*