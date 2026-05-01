---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# CySA+ Cheat Sheet
**Master the five domains of security operations, from foundational risk concepts to threat hunting tactics.**

---

## Overview

The CySA+ certification validates your ability to think like a security operations center (SOC) analyst—someone who detects threats, responds to incidents, and makes risk-based decisions under pressure. You need to understand how security controls work together, how to spot abnormal behavior, and how to turn raw security data into actionable intelligence. This is the framework that ties it all together.

---

## Overview: Domain 1 – Security Operations & Risk Foundations

**The bedrock of security analysis—understanding what we protect and why.**

### The CIA Triad

**Analogy**: Think of a bank vault. Confidentiality is the locked door (only authorized people inside). Integrity is the security camera verifying no one tampered with the contents. Availability is making sure the vault opens during business hours when customers need access.

**Definition**: The CIA Triad represents three pillars of information security:

- **[[Confidentiality]]**: Preventing unauthorized people from viewing sensitive data. Implemented through [[encryption]], [[access controls]], and [[multi-factor authentication]].
- **[[Integrity]]**: Ensuring data hasn't been altered by unauthorized parties. Verified using [[hashing]], [[digital signatures]], and [[file integrity monitoring]].
- **[[Availability]]**: Guaranteeing systems and data are accessible when needed. Maintained through [[redundancy]], [[load balancing]], and [[DDoS protection]].

| Pillar | Threat | Control | Example |
|--------|--------|---------|---------|
| Confidentiality | Data breach | Encryption | TLS for data in transit |
| Integrity | Data modification | Hashing | SHA-256 checksums |
| Availability | Outage/DoS | Redundancy | Failover servers |

### Privacy vs. Security

**Analogy**: Security is like a bouncer at a club—checking ID and preventing trouble. Privacy is the club's promise about what they do with your personal info after you leave (sell it? keep it? delete it?).

**Definition**: 
- **[[Privacy]]** governs how organizations collect, use, retain, and share personal data. It's a legal/compliance framework.
- **[[Security]]** protects data from unauthorized access. It's a technical framework.
- **[[PII (Personally Identifiable Information)]]** includes both direct identifiers (name, SSN) and indirect identifiers (zip code + DOB).
- **[[GAPP (Generally Accepted Privacy Principles)]]** provides the framework: management, notice, consent, minimization, retention, access, disclosure, security, quality, and enforcement.

### Risk Fundamentals

**Analogy**: Imagine a bridge with a rust problem. The rust is a vulnerability. A truck is a threat. The risk is: "Will a truck cross while the rust weakens the bridge?" It depends on both factors existing together.

**Definition**:
- **[[Vulnerability]]**: A weakness in a system (misconfiguration, unpatched software, weak password policy).
- **[[Threat]]**: An actor or event that could exploit that weakness (hacker, malware, natural disaster).
- **[[Risk]]** = [[Threat]] × [[Vulnerability]]. Risk only exists when both are present.

**Threat Types**:
- **[[Adversarial threats]]**: Hackers, APTs (Advanced Persistent Threats), competitors.
- **[[Accidental threats]]**: Misconfigurations, user errors, forgotten credentials.
- **[[Structural threats]]**: Hardware failures, software bugs, end-of-life systems.
- **[[Environmental threats]]**: Fires, floods, power outages, natural disasters.

### Risk Assessment

**Analogy**: Like insurance underwriting—you estimate likelihood (does a hurricane hit here often?) and impact (would it destroy the building?). High likelihood + high impact = buy insurance now.

**Definition**:
- Map threats and vulnerabilities onto a **[[risk matrix]]** (likelihood vs. impact).
- **Risk is contextual**—a password policy matters more in finance than in a startup.
- Quantitative assessment assigns numbers; qualitative uses descriptors (high/med/low).

---

## Overview: Domain 2 – Architecture & Engineering

**Understanding the infrastructure that stops attackers and enables detection.**

### Network Security Fundamentals

**Analogy**: A firewall is like border security. A packet filter checks passports (destination/port). A stateful firewall remembers who entered (established connections). An NGFW checks what they're actually doing (application-level).

**Definition**:
- **[[Firewall types]]**: Packet-filtering, stateful inspection, next-generation (NGFW), web application firewalls (WAF).
- **[[DMZ (Demilitarized Zone)]]**: A network segment isolating public-facing services from internal systems.
- **[[Access Control Lists (ACLs)]]**: Rules defining which traffic is allowed/denied.

### Network Segmentation

**Analogy**: A hospital with separate wings for contagious diseases, surgery, and maternity. If measles spreads in one wing, the others stay safe. That's segmentation.

**Definition**:
- **[[Network segmentation]]** divides a network into zones based on trust levels and function.
- Limits [[lateral movement]]—even if an attacker breaches one zone, they can't freely roam.
- Implemented via [[VLANs]], firewalls, and jump boxes.
- **[[Triple-homed firewall]]**: Three network interfaces separating untrusted (Internet), semi-trusted (DMZ), and trusted (internal) zones.

### Network Access Control (NAC)

**Analogy**: A gym entrance that scans your membership card, checks if your payment is current, and verifies you aren't banned before letting you in. Same concept for network devices.

**Definition**:
- **[[NAC]]** ensures devices and users meet security requirements before network access.
- **[[Agent-based NAC]]**: Software on the device reports compliance.
- **[[Agentless NAC]]**: Network monitors device behavior without software.
- **[[In-band NAC]]**: Inline—blocks non-compliant traffic immediately.
- **[[Out-of-band NAC]]**: Monitors and reports but doesn't block (remediation-focused).
- Criteria include: role, device health, time of access, geographic location.

### Identity & Access Management (IAM)

**Analogy**: Authentication is showing your driver's license. Authorization is what you're allowed to do with it (rent a car vs. buy alcohol). Accounting is the rental company's log of when you drove.

**Definition**:
- **[[AAA (Authentication, Authorization, Accounting)]]**: The three pillars of identity management.
- **[[MFA (Multi-Factor Authentication)]]**: Requires something you know (password), have (phone), or are (fingerprint). Dramatically reduces breach impact.
- **[[SSO (Single Sign-On)]]**: One login credential across multiple systems. Reduces credential sprawl but creates a single point of failure if compromised.
- **[[Federation]]** (SAML, OAuth, OIDC): Allows users to authenticate once and access resources across organizations.
- **[[PAM (Privileged Access Management)]]**: Protects and monitors accounts with elevated permissions (admins, service accounts).

| Control | Threat | Example |
|---------|--------|---------|
| MFA | Credential theft | Hacker gets password but can't bypass SMS code |
| SSO | Credential sprawl | One password for Slack, Salesforce, GitHub |
| PAM | Insider threat | Admin account access logged and time-limited |

### Cloud & Modern Architecture

**Analogy**: Renting an apartment vs. buying a house. Rent (SaaS) = landlord controls everything. Own (on-premises) = you control everything. Condo (PaaS/IaaS) = shared responsibility.

**Definition**:
- **[[Shared Responsibility Model]]**: Cloud provider and customer each own security for different layers.
  - **[[SaaS]]**: Provider owns infrastructure, OS, apps. You own data, access controls.
  - **[[PaaS]]**: Provider owns platform. You own applications and data.
  - **[[IaaS]]**: Provider owns hardware. You own OS, middleware, applications, data.
- **[[Zero Trust]]**: Never trust, always verify—explicit authentication for every access request, least privilege for every user/device.
- **[[SASE (Secure Access Service Edge)]]**: Combines SD-WAN + cloud-native security. Reduces latency and improves security for remote workers.
- **[[CASB (Cloud Access Security Broker)]]**: Monitors and enforces security policies on cloud app usage.

### Data Protection

**Analogy**: Encryption is scrambling a postcard so only the recipient can read it. Hashing is like a fingerprint—unique to the data, but you can't recreate the data from the fingerprint.

**Definition**:
- **[[Encryption]]**: Transforms plaintext into ciphertext. Only authorized parties with the key can decrypt.
- **[[Hashing]]**: Creates a fixed-length fingerprint of data. Any change produces a different hash.
- **[[DLP (Data Loss Prevention)]]**: Detects and prevents unauthorized exfiltration of sensitive data (PII, PHI, payment card data).

---

## Overview: Domain 3 – Malicious Activity & Detection

**Identifying what attackers are doing through logs, behavior, and analytics.**

### Logs & Monitoring

**Analogy**: Logs are security camera footage. A single camera (server log) captures one room. A monitoring system correlates footage from all cameras to spot patterns (someone moving through every room at night).

**Definition**:
- **[[Logs]]** are generated by operating systems, applications, and network devices. They record events (logins, file changes, network connections).
- **[[Log centralization]]** is mandatory in modern SOCs—collect all logs to one place.
- **[[SIEM (Security Information & Event Management)]]**: Aggregates, parses, and correlates logs from thousands of sources to detect incidents.
- **[[Baseline analysis]]**: Understanding normal behavior helps spot deviations (sudden spike in failed logins = possible brute force attack).

### Behavior Analysis

**Analogy**: A customer who always buys coffee on Tuesday at 9 AM suddenly buys $5,000 in electronics on Saturday. That's anomalous and warrants investigation.

**Definition**:
- **[[Host indicators]]**: Unusual CPU/memory usage, unexpected processes, new persistence mechanisms (scheduled tasks, startup folders).
- **[[Network indicators]]**: Beaconing (periodic outbound connections to command-and-control), traffic on unusual ports, large data exfiltration, unexpected outbound connections.
- **[[Application indicators]]**: New user accounts created, unexpected output files, error logs with suspicious patterns.

### Email Security

**Analogy**: Email authentication is like a notary public verifying signatures. SPF says "this person is allowed to sign for my company." DKIM says "this signature hasn't been forged." DMARC says "enforce these rules or reject the mail."

**Definition**:
- **[[SPF (Sender Policy Framework)]]**: DNS record listing which mail servers can send from your domain.
- **[[DKIM (DomainKeys Identified Mail)]]**: Digital signature proving the message came from your domain and wasn't altered in transit.
- **[[DMARC (Domain-based Message Authentication, Reporting, and Conformance)]]**: Policy that says what to do with mail failing SPF/DKIM (monitor, quarantine, reject).
- **Implementation strategy**: Start in monitor mode, then enforce after validating legitimate traffic.

### File Analysis

**Analogy**: Examining a suspicious package. Hashing is like getting its weight and dimensions. Strings analysis is like reading visible labels. Sandboxing is opening it in a sealed room to see what it does.

**Definition**:
- **[[Hashing]]** (SHA-256): Creates a unique fingerprint of a file. Compare against malware databases ([[VirusTotal]]).
- **[[Strings]]**: Extracts readable text from binary files. Quick way to spot suspicious commands, URLs, registry keys.
- **[[Obfuscation]]**: Attackers compress, encrypt, or encode malware. Doesn't make it invisible—just slows analysis.

### Sandboxing

**Analogy**: A sealed room where you can safely detonate a bomb and observe the blast pattern without endangering the building.

**Definition**:
- **[[Sandbox]]**: Isolated environment executing suspicious code without access to real systems