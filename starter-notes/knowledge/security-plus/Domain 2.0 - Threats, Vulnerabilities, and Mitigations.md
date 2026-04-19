---
domain: "Security+"
tags: [threats, vulnerabilities, mitigations, sy0-701, exam-domain, cybersecurity]
---
# Domain 2.0 - Threats, Vulnerabilities, and Mitigations

**Domain 2.0** of the CompTIA Security+ SY0-701 exam covers the identification, analysis, and response to **threats**, **vulnerabilities**, and **mitigations** — forming the analytical core of defensive security work. This domain accounts for **22% of the exam** and requires candidates to recognize attack types, understand how vulnerabilities arise, and apply appropriate countermeasures in realistic scenarios. Mastery of this domain connects directly to [[Threat Intelligence]], [[Vulnerability Management]], and [[Incident Response]] workflows used in real security operations.

---

## Overview

Domain 2.0 is the largest weighted domain in the SY0-701 exam blueprint, reflecting the industry reality that the majority of a security analyst's daily work involves identifying and responding to threats and weaknesses. The domain is not merely theoretical — it demands practical recognition of attack patterns, malware behaviors, social engineering tactics, and the ability to match specific mitigations to specific threat scenarios. Unlike earlier CompTIA objectives, SY0-701 explicitly ties threats to the **MITRE ATT&CK framework** concepts, requiring candidates to think in terms of tactics, techniques, and procedures (TTPs).

Vulnerabilities in this domain are examined from multiple angles: application flaws, misconfigurations, hardware weaknesses, cryptographic failures, and supply chain risks. The domain distinguishes between a **vulnerability** (a weakness), a **threat** (a potential exploiter of that weakness), and a **risk** (the likelihood and impact of exploitation). This three-part model underpins virtually every security program and directly informs how organizations prioritize remediation resources. A SQL injection flaw sitting on an internet-facing application presents a different risk calculation than the same flaw on an air-gapped internal system.

Mitigations range from technical controls (patching, segmentation, encryption) to administrative controls (policies, training, change management) and physical controls (access restrictions, surveillance). The SY0-701 blueprint emphasizes that no single mitigation is sufficient and that **defense in depth** — layering multiple controls — is the standard professional approach. Candidates must understand not only what a control does but also its limitations and failure modes.

The real-world context for this domain is sobering: according to Verizon's Data Breach Investigations Report, the overwhelming majority of breaches involve phishing, credential theft, exploitation of known vulnerabilities, and ransomware — all topics squarely within Domain 2.0. Understanding these threats at a mechanistic level, rather than as buzzwords, separates effective security practitioners from those who merely pass exams.

---

## How It Works

Domain 2.0 is organized around three interconnected pillars. Understanding how each pillar functions technically is essential for both the exam and real-world application.

### Pillar 1: Threat Actors and Attack Vectors

Threat actors are categorized by **motivation**, **capability**, and **resources**:

| Actor Type | Motivation | Sophistication | Example |
|---|---|---|---|
| Nation-State | Espionage, sabotage | Very High | APT28 (Fancy Bear) |
| Organized Crime | Financial gain | High | Conti ransomware group |
| Hacktivist | Ideology, protest | Medium | Anonymous |
| Insider Threat | Sabotage, theft, negligence | Varies | Malicious employee |
| Script Kiddie | Notoriety, curiosity | Low | Uses pre-built exploit kits |
| Competitor | Corporate espionage | Medium-High | Industrial espionage |

Attack vectors describe *how* threats reach a target. The SY0-701 blueprint focuses on:

- **Direct access**: Physical USB drop, keyboard logger installation
- **Wireless**: Evil twin APs, Bluetooth attacks
- **Email/Phishing**: Malicious attachments, credential harvesting links
- **Supply chain**: Compromised software updates (SolarWinds, 3CX)
- **Social media**: OSINT gathering, pretexting
- **Cloud**: Misconfigured S3 buckets, exposed APIs

### Pillar 2: Vulnerability Types

**Application Vulnerabilities** operate at the code and logic level:

```
# SQL Injection example — attacker input in a login form:
Username: admin'--
Password: anything

# Resulting query becomes:
SELECT * FROM users WHERE username='admin'--' AND password='anything'
# Everything after -- is commented out; authentication bypassed
```

**Memory Vulnerabilities** exploit how programs handle data in memory:

```c
// Buffer overflow in C — no bounds checking:
char buffer[64];
gets(buffer);  // Gets writes whatever input provides — can overwrite return address
               // Attacker places shellcode after buffer; redirects execution
```

**Race Conditions (TOCTOU — Time of Check to Time of Use)**:
A program checks a condition (e.g., file permissions) and then uses the resource, but an attacker modifies the resource in the gap between check and use.

**Cryptographic Weaknesses**:
- Use of MD5 or SHA-1 for password hashing (collision-vulnerable)
- Use of ECB mode in block ciphers (patterns preserved in ciphertext)
- Hardcoded credentials in firmware (common in IoT devices)

**Configuration Vulnerabilities**:
```bash
# Finding default credentials still active on network devices:
nmap -sV --script=http-default-accounts 192.168.1.0/24

# Checking for open, unauthenticated services:
nmap -p 22,23,80,443,8080,3389 --open 192.168.1.0/24
```

**Supply Chain Vulnerabilities** occur when third-party components (libraries, firmware, hardware) introduce weaknesses. The Log4Shell vulnerability (CVE-2021-44228) affected millions of systems because log4j was embedded invisibly in countless applications.

### Pillar 3: Mitigation Techniques

Mitigations operate across the **NIST Cybersecurity Framework** functions of Identify, Protect, Detect, Respond, and Recover.

**Segmentation** limits blast radius:
```
# Example firewall rule — isolating IoT VLAN from corporate LAN:
iptables -A FORWARD -i vlan30 -o vlan10 -j DROP
iptables -A FORWARD -i vlan10 -o vlan30 -j DROP
```

**Patching cadence** follows risk tiers:
- Critical (CVSS 9.0–10.0): Patch within 24–72 hours
- High (CVSS 7.0–8.9): Patch within 7–14 days
- Medium (CVSS 4.0–6.9): Patch within 30 days
- Low (CVSS 0.1–3.9): Patch within 90 days

**Input validation** prevents injection attacks:
```python
# Parameterized query — safe from SQL injection:
import sqlite3
conn = sqlite3.connect('users.db')
cursor = conn.cursor()
username = input("Enter username: ")
cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
# The ? placeholder is never interpreted as SQL syntax
```

**Monitoring and alerting** using SIEM correlation rules detect threats in near real-time by aggregating logs from endpoints, network devices, and cloud services.

---

## Key Concepts

- **Threat Actor**: An individual or group that poses a potential danger to an organization's assets; classified by motivation (financial, political, ideological), sophistication, and resource level. Nation-state actors represent the highest capability tier.

- **Attack Vector vs. Attack Surface**: An **attack vector** is the specific pathway an attacker uses to reach a target (e.g., phishing email); the **attack surface** is the total set of all possible vectors and exposure points across a system or organization. Reducing attack surface is a foundational security principle.

- **Vulnerability vs. Exploit**: A **vulnerability** is a flaw or weakness in a system; an **exploit** is the specific code, technique, or sequence of actions that takes advantage of that vulnerability. Not every vulnerability has a public exploit — this distinction matters in risk prioritization.

- **Zero-Day**: A vulnerability that is **unknown to the vendor** and for which no patch exists. Zero-days are extremely valuable on criminal and intelligence markets. Organizations rely on behavior-based detection and compensating controls when patches are unavailable.

- **Indicators of Compromise (IoCs)**: Observable artifacts that suggest a system has been compromised, including suspicious IP addresses, unusual file hashes, anomalous outbound connections, unauthorized account creation, and unexpected registry modifications.

- **Indicators of Attack (IoAs)**: Evidence that an attack is **in progress** — behavioral signals such as lateral movement, privilege escalation attempts, or enumeration of domain controllers, even before payload delivery is confirmed.

- **CVSS (Common Vulnerability Scoring System)**: A standardized framework for rating the severity of vulnerabilities on a 0–10 scale, considering factors like attack complexity, privileges required, user interaction, and impact on confidentiality, integrity, and availability.

- **Defense in Depth**: A layered security strategy where multiple independent controls (technical, administrative, physical) are stacked so that the failure of any single control does not result in total compromise.

- **Compensating Control**: A security measure implemented when the primary control cannot be applied — for example, enhanced monitoring and network segmentation for a legacy system that cannot be patched.

- **Supply Chain Attack**: An attack that targets a **less-secure element in the supply chain** (vendor, software library, hardware component) to compromise downstream targets, bypassing the primary organization's security controls entirely.

---

## Exam Relevance

### High-Frequency Topics

The SY0-701 exam consistently tests the following within Domain 2.0:

**Social Engineering Recognition**: Expect scenario questions where you must identify the *specific* type — phishing vs. spear phishing vs. whaling vs. vishing vs. smishing vs. pretexting. The key differentiators are **targeting specificity** and **communication channel**.

**Malware Classification**: Know the behavioral distinction between virus (attaches to files, requires host execution), worm (self-replicates across networks, no user interaction required), Trojan (disguised as legitimate software), ransomware (encrypts data, demands payment), spyware (silent data exfiltration), rootkit (hides its presence, operates at kernel/firmware level), and keylogger.

**Vulnerability Type Matching**: Questions present a scenario (e.g., "an attacker submits `<script>alert('xss')</script>` in a web form") and ask you to identify the vulnerability type. Know XSS, SQLi, CSRF, SSRF, directory traversal, and buffer overflow cold.

### Common Gotchas

- **Pharming vs. Phishing**: Pharming redirects DNS at the infrastructure level (poisoned cache or hosts file) — no user clicks a malicious link. Phishing requires user interaction with a deceptive message.
- **Rootkits vs. RATs**: A rootkit hides malware and itself from the OS; a Remote Access Trojan (RAT) provides covert remote control but doesn't necessarily hide from the OS.
- **Vulnerability vs. Risk**: The exam often tests whether candidates confuse *having a vulnerability* with *being at risk*. Risk requires both a threat actor AND a vulnerability. A vulnerability with no viable threat actor is low risk.
- **Threat Intelligence Sharing**: Know that **ISACs (Information Sharing and Analysis Centers)** are sector-specific threat intelligence sharing bodies (FS-ISAC for finance, H-ISAC for healthcare). The exam may present these alongside [[STIX/TAXII]] formats.
- **Zero-Day Mitigations**: When a patch doesn't exist, correct mitigations are compensating controls: WAF rules, network segmentation, disabling affected features, enhanced monitoring — NOT "wait for the vendor."

### Question Pattern: "Which mitigation BEST addresses..."

These questions have one correct answer and several plausible distractors. Map each threat type to its primary mitigation:
- Phishing → Security awareness training + email filtering + MFA
- Unpatched systems → Vulnerability scanning + patch management program
- SQL injection → Input validation + parameterized queries + WAF
- Insider threat → Least privilege + user behavior analytics + separation of duties
- DDoS → Rate limiting + anycast diffusion + upstream scrubbing services

---

## Security Implications

### Active Threat Landscape

**Ransomware** remains the dominant financially motivated threat. Modern ransomware operations (LockBit, ALPHV/BlackCat, Cl0p) use a **double extortion** model: data is exfiltrated *before* encryption, and victims face both operational disruption and data leak threats. Initial access is most commonly achieved through:
1. Phishing with malicious Office macros or LNK files
2. Exploitation of internet-facing vulnerabilities (VPN appliances, RDP)
3. Purchasing access from Initial Access Brokers (IABs)

**Notable CVEs Relevant to This Domain**:

| CVE | Description | CVSS | Impact |
|---|---|---|---|
| CVE-2021-44228 | Log4Shell — JNDI injection in log4j | 10.0 | RCE on any log4j-using system |
| CVE-2021-34527 | PrintNightmare — Windows Print Spooler | 8.8 | Local privilege escalation + RCE |
| CVE-2023-23397 | Outlook zero-click NTLM hash theft | 9.8 | Credential theft without user interaction |
| CVE-2023-44487 | HTTP/2 Rapid Reset DDoS | N/A | Record-breaking DDoS amplification |
| CVE-2020-14882 | Oracle WebLogic RCE | 9.8 | Unauthenticated remote code execution |

**Social Engineering Incidents**:
- **Twitter 2020 breach**: Attackers used vishing (voice phishing) to convince Twitter employees to provide VPN credentials, enabling access to internal admin tools and the takeover of high-profile accounts including Obama, Biden, and Musk.
- **MGM Resorts 2023**: A 10-minute vishing call impersonating an employee to the IT help desk resulted in a breach estimated at $100M+ in impact, demonstrating that technical controls alone cannot compensate for social engineering.

**Attack Chain Example — Spear Phishing to Ransomware**:
```
1. Reconnaissance: Attacker scrapes LinkedIn for IT staff names and org structure
2. Weaponization: Crafts Excel file with malicious macro, themed as "Q3 Budget Review"
3. Delivery: Sends from spoofed domain (company-corp.com vs. company.com)
4. Exploitation: User enables macros; macro downloads Cobalt Strike beacon
5. C2: Beacon phones home over HTTPS to attacker-controlled server
6. Lateral Movement: Attacker uses Pass-the-Hash to spread across domain
7. Exfiltration: Data staged to cloud storage (Mega, Dropbox)
8. Impact: Ransomware deployed via GPO or PSExec; backups deleted via vssadmin
```

---

## Defensive Measures

### Technical Controls

**1. Endpoint Detection and Response (EDR)**
Deploy EDR solutions (CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) on all endpoints. EDR provides behavioral analysis, memory scanning, and rollback capabilities that signature-based AV cannot match.

**2. Email Security Gateway**
Configure SPF, DKIM, and DMARC to prevent email spoofing:
```
# DNS SPF record example:
v=spf1 include:_spf.google.com ip4:203.0.113.10 -all

# DMARC policy — reject failing messages and send reports:
v=DMARC1; p=reject; rua=mailto:dmarc@yourdomain.com; ruf=mailto:forensics@yourdomain.com
```

**3. Vulnerability Scanning**
Run authenticated scans weekly with tools like **Nessus**, **OpenVAS**, or **Qualys**:
```bash
# OpenVAS CLI scan against target subnet:
omp -u admin -w password -G  # List scan configs
omp -u admin -w password -T  # List targets
# Create and launch scan via gvm-cli or Greenbone web UI
```

**4. Web Application Firewall (WAF)**
Deploy ModSecurity with OWASP Core Rule Set (CRS) in front of web applications:
```apache
# Apache ModSecurity basic configuration:
SecRuleEngine