---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.5"
tags: [security-plus, sy0-701, domain-2, hardening, endpoint-protection, defense-in-depth]
---

# 2.5 - Hardening Techniques (continued)

Hardening techniques represent the practical, layered approach to reducing attack surface and detecting threats at the endpoint level. This section covers endpoint detection and response ([[EDR]]), host-based firewalls, intrusion prevention, port management, credential hygiene, and software inventory control—all foundational to the [[Defense in Depth]] strategy that the Security+ exam emphasizes. Mastering these concepts is critical because they directly translate to real-world sysadmin responsibilities and are tested heavily in scenario-based questions.

---

## Key Concepts

- **[[Endpoint Detection and Response (EDR)]]**: A modern threat protection approach that goes beyond signatures to include behavioral analysis, machine learning, and process monitoring; enables investigation and automated response without manual intervention

- **Host-Based Intrusion Prevention System ([[HIPS]])**:
  - Recognizes and blocks known attacks at the OS/application level
  - Detects anomalies: buffer overflows, registry modifications, unauthorized file writes to system folders, access to unencrypted data
  - Often integrated into endpoint protection suites
  - Uses signatures, heuristics, and behavioral analysis

- **Host-Based Firewall**: Software-based, runs on individual endpoints; controls inbound/outbound traffic by application process; provides granular visibility and centralized management

- **Open Ports and Services**:
  - Every open port = potential entry point
  - Must close all unnecessary ports and services
  - Default installations often include bloatware and unused services
  - Applications may request broad port ranges (0–65,535)
  - Verification tool: [[Nmap]] or similar port scanner

- **Default Credentials**: Network devices, management interfaces, and applications ship with default passwords; these are among the first targets for attackers

- **Unnecessary Software**: Each application introduces vulnerabilities; unused software should be removed to reduce attack surface

- **[[Defense in Depth]]**: Multi-faceted protection across many platforms (mobile, desktop, servers); no single solution is sufficient

---

## How It Works (Feynman Analogy)

Think of your network as a castle:

- **The outer walls** = [[Firewall]] and port closures (block entry points)
- **Guards at the gates** = [[HIPS]] and host-based firewalls (monitor who/what enters)
- **Sentries inside the castle** = [[EDR]] agents (detect behavior that looks suspicious, not just known threats)
- **Locked storage rooms** = Removing unused software (fewer places attackers can hide)

**Technical translation**: A hardened endpoint runs minimal software, listens only on required ports, has credentials changed from defaults, and runs both preventive (HIPS) and detective (EDR) agents. When an attack attempt occurs—whether it matches a known signature or exhibits suspicious behavior—multiple layers detect and can automatically respond (isolate, quarantine, rollback) without waiting for human intervention.

---

## Exam Tips

- **EDR vs. Signature-based antivirus**: The exam tests whether you understand that EDR uses *behavioral analysis and machine learning* to catch zero-days that signatures cannot. Antivirus looks for known malware; EDR watches for suspicious behavior.

- **HIPS is prevention; EDR is detection + response**: Know the difference. HIPS blocks bad traffic before it lands; EDR detects it after the fact and investigates/responds. You may see questions pairing them together in a defense-in-depth scenario.

- **Port management is foundational**: Expect scenario questions about discovering open ports with [[Nmap]] and determining which should be closed. The exam rewards detailed knowledge of why every open port matters.

- **Default credentials are low-hanging fruit**: The exam often tests whether you recognize that changing defaults is a basic hardening step—don't overlook it in scenario answers. It's often the "easiest fix."

- **Software bloat = vulnerability bloat**: Recognize that removing unnecessary applications is a simple, high-impact hardening technique. The exam may ask which of several hardening steps is most efficient; removing unused software is always a strong answer.

---

## Common Mistakes

- **Confusing prevention with detection**: Candidates often say "EDR prevents attacks" when it actually *detects* them. HIPS *prevents*; EDR *detects and responds*. This distinction is tested in scenario questions.

- **Overlooking the "lightweight agent" aspect of EDR**: The exam emphasizes that EDR agents are lightweight and scalable precisely because threats are increasing. Candidates sometimes think EDR requires heavy infrastructure; it doesn't—that's its advantage over older approaches.

- **Ignoring the "API-driven, no intervention required" detail**: EDR's ability to respond *automatically* without a technician is a key differentiator. A scenario question might ask what allows a company to respond faster—the answer is automated EDR response via APIs.

- **Assuming all hardening is about the network edge**: Candidates focus on firewalls and miss that host-based tools (HIPS, host firewall, EDR agents) are equally important. The exam tests "defense in depth"—multiple layers.

---

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] homelab, hardening techniques manifest as:

- **[[Wazuh]]** agent (EDR-like) deployed on all systems to detect intrusions via behavioral analysis and rule-based detection
- **Host-based firewall** enabled on Windows systems (Windows Defender Firewall) and Linux hosts, configured to allow only required services
- **Port auditing** via [[Nmap]] to verify only SSH (22), Tailscale (custom port), and necessary services are open
- **Active Directory** credential policies ensuring service account passwords are strong and rotated
- **Regular patching** and removal of unnecessary software (e.g., not installing build tools on production VMs)
- **Tailscale VPN** as a zero-trust layer, reducing reliance on open ports

These layers together reduce the attack surface and enable rapid detection and response when threats occur.

---

## Wiki Links

### Core Concepts
- [[CIA Triad]]
- [[Defense in Depth]]
- [[Zero Trust]]
- [[Attack Surface Reduction]]

### Detection & Prevention Tools
- [[Endpoint Detection and Response (EDR)]]
- [[Host-Based Intrusion Prevention System (HIPS)]]
- [[Host-Based Firewall]]
- [[Antivirus]]
- [[SIEM]] (for centralized log analysis)
- [[IDS]] / [[IPS]]

### Network & Port Management
- [[Firewall]]
- [[NGFW]] (Next-Generation Firewall)
- [[Nmap]]
- [[Port Scanning]]
- [[Network Segmentation]]
- [[VLAN]]

### Authentication & Credentials
- [[Active Directory]]
- [[LDAP]]
- [[MFA]] (Multi-Factor Authentication)
- [[OAuth]]
- [[SAML]]
- [[PKI]] (Public Key Infrastructure)

### Protocols & Encryption
- [[TLS]] / [[SSL]]
- [[Encryption]]
- [[Hashing]]
- [[DNS]]
- [[VPN]]

### Offensive & Monitoring Tools
- [[Metasploit]]
- [[Wireshark]]
- [[Kali Linux]]
- [[Wazuh]]
- [[Splunk]]
- [[Pi-hole]]

### Network Infrastructure
- [[Tailscale]]
- [[Firewalls]]
- [[Proxies]]

### Standards & Frameworks
- [[NIST]]
- [[MITRE ATT&CK]]
- [[CIS Benchmarks]]

### Incident Response & Forensics
- [[Incident Response]]
- [[Forensics]]
- [[DFIR]] (Digital Forensics and Incident Response)
- [[SOC]] (Security Operations Center)

### Threat Categories
- [[Malware]]
- [[Ransomware]]
- [[Phishing]]
- [[SQL Injection]]
- [[XSS]] (Cross-Site Scripting)
- [[Buffer Overflow]]
- [[Privilege Escalation]]

### Homelab References
- [[[YOUR-LAB]]]
- [[Wazuh]]
- [[Tailscale]]

---

## Tags

`domain-2` `security-plus` `sy0-701` `hardening-techniques` `endpoint-protection` `edr` `defense-in-depth` `hips` `firewall` `port-management` `vulnerability-management`

---

## Summary Table: Hardening Techniques at a Glance

| Technique | Type | Purpose | Example |
|-----------|------|---------|---------|
| EDR | Detective | Detect & respond to threats via behavior & ML | [[Wazuh]], CrowdStrike |
| HIPS | Preventive | Block known attack patterns | Built into Windows Defender |
| Host Firewall | Preventive | Control app-level traffic | Windows Defender Firewall, UFW |
| Port Closure | Preventive | Reduce entry points | Close all but SSH (22), required services |
| Default Credential Change | Preventive | Prevent easy compromise | Change router, switch, app passwords |
| Software Removal | Preventive | Reduce vulnerability footprint | Uninstall unused applications |

---

**Last Updated**: 2025 | **Status**: Ready for SY0-701 exam review

---
_Ingested: 2026-04-15 23:50 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
