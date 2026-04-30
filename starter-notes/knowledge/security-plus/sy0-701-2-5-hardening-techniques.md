```yaml
---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.5"
tags: [security-plus, sy0-701, domain-2, hardening, system-hardening, encryption]
---
```

# 2.5 - Hardening Techniques

System hardening is the process of reducing the attack surface of an information system by eliminating unnecessary services, applying security patches, and enforcing strict access controls across all layers—OS, applications, and network. This section covers foundational defensive strategies that are critical to the exam, as hardening is the proactive first line of defense against exploitation and unauthorized access. The Security+ exam expects you to understand both the *categories* of hardening techniques and the *specific implementations* for different operating systems and scenarios.

---

## Key Concepts

### System Hardening (General)
- **Definition**: The practice of securing a system by reducing its vulnerability surface through configuration, patching, and access control
- **Scope**: Applies across all platforms—[[Windows]], [[Linux]], [[iOS]], [[Android]], and proprietary systems
- **Purpose**: Minimize the number of attack vectors available to an adversary

### Operating System Updates
- **OS Updates/Service Packs**: Major feature and stability releases; may require reboots
- **Security Patches**: Critical fixes for known vulnerabilities; should be applied immediately upon release
- **Patch Management**: A formal process ensuring timely deployment across the enterprise without breaking systems
- **Exam focus**: Know the difference between optional updates and critical security patches; understand the risk of *not* patching

### User Account Hardening
- **Minimum Password Length**: Industry standard is 12–16 characters; Security+ expects you to know longer = stronger
- **Password Complexity**: Require uppercase, lowercase, numbers, and symbols to increase entropy
- **Account Limitations**: 
  - Account lockout after failed login attempts (defend against [[brute force]])
  - Disable unused accounts
  - Enforce principle of least privilege (remove unnecessary user rights)
  - Restrict administrative accounts and use [[MFA]] on privileged accounts

### Network Access and Security Hardening
- **Network Segmentation**: Isolate critical systems using [[VLAN]]s or [[Zero Trust]] architecture
- **Firewall Rules**: Implement allow-lists (whitelist) rather than deny-lists; close all ports by default
- **Disable Unnecessary Services**: Every running service is a potential attack vector
- **Network Monitoring**: Continuous visibility into traffic patterns

### Encryption Techniques

#### File System Encryption
- **Windows EFS (Encrypting File System)**: Encrypts individual files/folders on NTFS volumes; transparent to authorized users
- **Purpose**: Protects data at rest against physical theft or unauthorized file system access
- **Limitation**: Does not protect data in use or in transit

#### Full Disk Encryption (FDE)
- **Definition**: Encrypts all data on a storage device, including OS, applications, and user files
- **[[Windows]] BitLocker**: Built into Windows Pro/Enterprise; uses TPM (Trusted Platform Module) for key management
- **Apple FileVault**: macOS equivalent; uses platform-specific key escrow mechanisms
- **Linux LUKS**: Linux Unified Key Setup; industry-standard for Linux FDE
- **Exam focus**: FDE is the more robust choice and should be deployed on all devices, especially portable ones

#### Network Communication Encryption
- **[[VPN]] (Virtual Private Network)**: Encrypts all traffic between client and gateway; masks IP and location
- **Application-level Encryption**: [[TLS]]/[[SSL]] for web traffic, [[SSH]] for remote access, [[HTTPS]] for HTTP
- **End-to-end Encryption**: Ensures data is encrypted from sender to receiver, not readable by intermediate nodes

### Anti-Malware and Monitoring
- **Anti-virus (AV)**: Signature-based detection of known malware families
- **Anti-malware**: Broader detection including spyware, PUPs (potentially unwanted programs), and rootkits
- **Real-time Scanning**: Monitor file system and memory for suspicious activity
- **Heuristic Detection**: Detect suspicious behavior patterns even if signatures don't match
- **[[SIEM]] Integration**: Centralize logs and alerts (e.g., [[Wazuh]]) for detection and response

---

## How It Works (Feynman Analogy)

**Imagine a castle:**

A freshly built castle (new OS) has every gate open, guards are untrained, and messengers can shout secrets from the ramparts. System hardening is like:

1. **Closing unnecessary gates** → Disable unused services and ports
2. **Training guards with strict rules** → Apply access controls and set password policies
3. **Sealing the walls** → Encrypt all sensitive areas (files, disks, communications)
4. **Installing watchtowers** → Deploy AV, anti-malware, and [[SIEM]] monitoring
5. **Regular inspections and repairs** → Patch vulnerabilities and update defenses

The more gates you close and the better-guarded the remaining ones are, the harder the castle is to breach. An attacker with only one entry point is far less dangerous than one with a dozen.

**Technical reality:** Hardening reduces the *attack surface*—the sum of all ways an attacker could exploit the system. Every unpatched vulnerability, disabled encryption, or open service increases risk exponentially.

---

## Exam Tips

- **Expect scenario questions**: "A user's laptop was stolen. Which hardening technique would have protected the data?" Answer: [[Full Disk Encryption]] (FDE), not just EFS or AV.
  
- **Distinguish encryption types**: The exam loves to mix up EFS (file-level, Windows only), FDE (block-level, all data), and network encryption ([[VPN]], [[TLS]]). Know which layer each protects.

- **Patching priorities**: Critical security patches > optional updates. Know that zero-day exploits (unpatched vulns) are the highest risk; old, unpatched systems are low-hanging fruit for attackers.

- **Account hardening vs. system hardening**: Don't confuse strict password policy (user-side) with firewall rules (network-side). Both are hardening, but different layers.

- **Watch for "defense in depth"**: The exam expects multiple hardening controls, not just one. A system with FDE + AV + firewall + patches is hardened; a system with only patches is not.

---

## Common Mistakes

- **Assuming EFS protects against theft**: EFS protects individual files from unauthorized access *while the OS is running*. If an attacker boots to another OS or removes the drive, EFS is bypassed. Full Disk Encryption is the right answer for stolen devices.

- **Thinking patches are optional**: Candidates sometimes treat patches as "nice to have." On the exam and in the real world, unpatched systems are compromised systems. Patch management is non-negotiable.

- **Confusing "hardening" with "backup"**: Hardening reduces attack surface; [[backups]] recover from attacks. Both are essential, but they're different. Hardening prevents compromise; backups mitigate damage.

---

## Real-World Application

In your [YOUR-LAB] fleet, hardening would mean: ensuring all VMs run current patches, enforcing BitLocker on Windows endpoints, deploying FDE on Linux nodes, configuring [[Tailscale]] [[VPN]] for encrypted remote access, and centralizing all logs in [[Wazuh]] for anomaly detection. [[Active Directory]] password policies enforce complexity/length, and network segmentation via [[VLAN]]s (or Zero Trust) isolates critical infrastructure. Regular vulnerability scans (e.g., [[Nmap]], OpenVAS) identify unpatched systems before attackers do.

---

## Wiki Links

**Core Hardening Concepts:**
- [[System Hardening]]
- [[Patch Management]]
- [[Least Privilege]]
- [[Defense in Depth]]
- [[Attack Surface]]

**Operating Systems:**
- [[Windows]]
- [[Linux]]
- [[macOS]]
- [[Active Directory]]

**Encryption & Cryptography:**
- [[Encryption]]
- [[Full Disk Encryption (FDE)]]
- [[BitLocker]]
- [[FileVault]]
- [[LUKS]]
- [[EFS]] (Encrypting File System)
- [[TLS]]
- [[SSH]]
- [[HTTPS]]
- [[Hashing]]
- [[PKI]]

**Network Security:**
- [[VPN]]
- [[Zero Trust]]
- [[VLAN]]
- [[Firewall]]
- [[Network Segmentation]]
- [[DNS]]

**Monitoring & Detection:**
- [[SIEM]]
- [[Wazuh]]
- [[Anti-virus]]
- [[Anti-malware]]
- [[IDS]]
- [[IPS]]
- [[Real-time Scanning]]

**Authentication & Access:**
- [[MFA]]
- [[LDAP]]
- [[OAuth]]
- [[SAML]]

**Tools & Frameworks:**
- [[Tailscale]]
- [[Nmap]]
- [[Metasploit]]
- [[Wireshark]]
- [[Kali Linux]]
- [[NIST]]
- [[MITRE ATT&CK]]

**Related Security Domains:**
- [[CIA Triad]]
- [[Incident Response]]
- [[Forensics]]
- [[SOC]]
- [[DFIR]]
- [[Malware]]
- [[Ransomware]]
- [[Phishing]]
- [[SQL Injection]]
- [[XSS]]
- [[Buffer Overflow]]

---

## Tags

`domain-2` `security-plus` `sy0-701` `hardening` `encryption` `patch-management` `access-control` `defense-in-depth`

---
_Ingested: 2026-04-15 23:50 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
