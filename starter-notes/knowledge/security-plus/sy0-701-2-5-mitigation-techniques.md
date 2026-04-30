```yaml
---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.5"
tags: [security-plus, sy0-701, domain-2, mitigation-techniques, defensive-controls]
---
```

# 2.5 - Mitigation Techniques

Mitigation techniques are the defensive controls and practices organizations deploy to reduce risk, prevent exploitation, and limit the blast radius of security incidents. This section covers the core defensive strategies tested on the Security+ exam: [[Patching]], [[Encryption]], [[Monitoring]], [[Least Privilege]], [[Configuration Enforcement]], and [[Decommissioning]]. Understanding when and how to apply each mitigation is critical for both the exam and real-world sysadmin work—you won't pass domain 2 without solid knowledge of these foundational controls.

---

## Key Concepts

- **[[Patching]]**: The process of applying updates to systems, applications, and firmware to fix vulnerabilities and improve stability. Monthly patches are standard; emergency out-of-band patches address zero-days and critical flaws discovered between regular cycles.

- **[[Least Privilege]]** (Principle of Least Privilege): Users and applications receive only the minimum permissions and rights required to perform their specific job function. No user should run with administrative privileges by default; limiting privilege scope restricts the damage a compromised account can cause.

- **[[Full Disk Encryption]] (FDE)**: Encrypts the entire contents of a storage device, including the OS, applications, and data. Common implementations: [[BitLocker]] (Windows), [[FileVault]] (macOS), [[LUKS]] (Linux).

- **File-Level Encryption**: Protects individual files or folders at the file system level. Example: [[Windows EFS]] (Encrypting File System). Allows granular control over which data is encrypted.

- **Application-Level Encryption**: Encryption managed and enforced by the application itself; data is encrypted before being stored, protecting it even if the storage medium is compromised.

- **[[Monitoring]]**: Continuous collection and aggregation of security events from multiple sources (sensors) into centralized systems (collectors) for analysis and response. Includes intrusion detection/prevention, authentication logs, web access logs, database transactions, and email logs.

- **[[SIEM]]** (Security Information and Event Management): A central platform that collects, correlates, and analyzes log data from diverse sources across the enterprise. Often includes a correlation engine to identify patterns and anomalies.

- **[[Posture Assessment]]**: A formal check performed each time a device connects to the network, verifying OS patch levels, [[EDR]] status, firewall configuration, and certificate validity.

- **Network Quarantine**: Non-compliant devices are isolated in a private [[VLAN]] with restricted access, preventing them from reaching critical systems until remediated.

- **[[Decommissioning]]**: The formal, secure process of removing and disposing of hardware (hard drives, SSDs, USB drives, etc.). Must include data destruction or device recycling to prevent unauthorized data recovery.

- **Out-of-Band Updates**: Emergency security patches released outside the normal monthly update cycle in response to zero-day exploits or critical vulnerabilities.

- **Third-Party Updates**: Patches for applications, device drivers, and firmware from software vendors and manufacturers—not the operating system itself.

---

## How It Works (Feynman Analogy)

**The Castle Defense Model:**

Imagine you're protecting a castle from invasion. You don't just build one wall and hope for the best. Instead, you use *layers* of defense:

1. **Patching** = Repairing holes and weak spots in the walls as soon as you discover them. Some repairs are routine maintenance (monthly patches), but if an enemy discovers a critical flaw (zero-day), you send a team out immediately to fix it before they can exploit it.

2. **Least Privilege** = Not every guard in the castle gets the keys to the throne room. A gate sentry only needs to open the gate, not access the treasury. If one guard is compromised by an enemy spy, they can only damage the one area they have access to, not the entire castle.

3. **Encryption** = Your treasure chest is locked with a cipher so complex that even if a thief steals it, they can't open it without the key. Full disk encryption locks the entire castle's secrets; file-level encryption locks only specific chests; application encryption is like a safe-within-a-safe.

4. **Monitoring** = Lookouts on the walls constantly watch for suspicious activity. They report everything they see to a central command center (the [[SIEM]]), where strategists analyze patterns and spot coordinated attacks that no single lookout would notice alone.

5. **Configuration Enforcement** = Before any new soldier or merchant enters the castle, you inspect them: Do they have the right armor? Is their weapon sharp? Is their paperwork valid? If they fail inspection, they wait outside in a holding area until they comply.

6. **Decommissioning** = When an old shield or weapon breaks, you don't leave it in the trash where enemies can find it and learn its weaknesses. You either recycle it into new equipment or destroy it completely.

**The Technical Reality:** These aren't independent controls—they work together. A patched system with least privilege and encryption is harder to breach. If breached, monitoring detects it. Configuration enforcement prevents non-compliant devices from becoming bridgeheads. Decommissioning prevents data leaks from discarded hardware.

---

## Exam Tips

- **Patching vs. Auto-Updates**: The exam tests whether you understand that auto-update is *not always* the best option. Know the difference between regular monthly patches, out-of-band emergency patches, and third-party patches. A question might ask: "What should you do if a zero-day is discovered?" Answer: deploy an emergency out-of-band patch, not wait for the monthly cycle.

- **Least Privilege ≠ Just File Permissions**: Least privilege applies to *users* AND *applications*. The exam loves questions like: "Which principle prevents a compromised user account from accessing unrelated systems?" Answer: [[Least Privilege]]. Bonus: Know that users should never run daily tasks with admin privileges—only when absolutely necessary, and then drop back to normal.

- **Encryption Scope Matters**: Distinguish between [[FDE]] (entire disk), file-level (individual files/folders), and application-level (app-managed). The exam asks: "You want to protect sensitive data even if the hard drive is stolen—what's the minimum requirement?" Answer: [[FDE]] or application-level encryption. "You want different users to access different files on the same disk?" Answer: file-level encryption.

- **Monitoring ≠ Prevention**: Monitoring *detects* breaches; it doesn't stop them. A [[SIEM]] is a *detective control*, not a preventive control. The exam tests this distinction. "Which control will prevent SQL injection attacks?" NOT monitoring—that's input validation, [[WAF]], or secure coding. "Which will detect them?" Monitoring and [[SIEM]] correlation.

- **Posture Assessment + Quarantine**: Know the workflow: Device connects → Posture assessment checks OS patches, [[EDR]] status, firewall, certificates → If non-compliant, device is quarantined in a private [[VLAN]] with limited access → After remediation, it's checked again and released. This is a *preventive* control that stops sick devices from infecting the network.

---

## Common Mistakes

- **Thinking auto-update is always safe**: Candidates often assume auto-updates are the best practice. The exam tests nuance: auto-updates can break compatibility, cause system instability, or deploy patches without proper testing. Organizations should *plan* patches, not auto-deploy them (with exceptions for critical security patches). Know when auto-update is appropriate (e.g., home users, non-critical systems) vs. when manual control is needed (e.g., enterprise servers, medical devices).

- **Confusing monitoring with prevention**: Many candidates think "we're monitoring with a [[SIEM]]" means "we're preventing attacks." Wrong. Monitoring is detection and response, not prevention. If the exam asks "How do you *prevent* unauthorized access?" the answer might be [[MFA]], [[Firewall]], [[Access Control]], or [[Encryption]]—not [[SIEM]] or [[IDS]]. (An [[IPS]] is prevention; an [[IDS]] is detection.)

- **Misunderstanding decommissioning scope**: Candidates often think decommissioning only applies to storage devices. While HDDs, SSDs, and USB drives are the primary focus, decommissioning also includes destroying certificates, revoking credentials, and removing devices from inventories. The exam tests: "You're retiring a server—what must you do?" Answer: securely wipe the disk, revoke its certificates, remove it from [[Active Directory]], and document the process.

---

## Real-World Application

In your [[[YOUR-LAB]]] homelab, these mitigations are in constant play: [[Wazuh]] serves as the monitoring and detection layer, alerting on suspicious activity across the fleet; [[Active Directory]] enforces [[Least Privilege]] through group policy and role-based access control; full disk encryption protects VMs if storage is compromised; regular patching (especially out-of-band patches) keeps the lab's systems ahead of known exploits; [[Tailscale]] VPN enforces network segmentation and posture checking before devices connect to the internal mesh. Decommissioning policies ensure that when lab VMs or physical devices are retired, their data is securely wiped or destroyed, not left in snapshots or backups accessible to unauthorized parties.

---

## Wiki Links

**Core Mitigation Concepts:**
- [[Patching]]
- [[Least Privilege]]
- [[Encryption]]
- [[Full Disk Encryption]]
- [[BitLocker]]
- [[FileVault]]
- [[Windows EFS]]
- [[Monitoring]]
- [[SIEM]]
- [[Configuration Enforcement]]
- [[Posture Assessment]]
- [[EDR]]
- [[Decommissioning]]

**Detection & Response Tools:**
- [[SIEM]]
- [[IDS]]
- [[IPS]]
- [[Firewall]]
- [[Wazuh]]
- [[MITRE ATT&CK]]
- [[SOC]]

**Security Principles & Frameworks:**
- [[CIA Triad]]
- [[Zero Trust]]
- [[NIST]]
- [[Principle of Least Privilege]]

**Infrastructure & Homelab:**
- [[[YOUR-LAB]]]
- [[Active Directory]]
- [[LDAP]]
- [[Tailscale]]
- [[VLAN]]
- [[VPN]]

**Threats & Vulnerabilities:**
- [[Ransomware]]
- [[Malware]]
- [[Phishing]]
- [[SQL Injection]]
- [[XSS]]
- [[Zero-Day]]

**Related Domains:**
- [[2.0 - Threats, Vulnerabilities, and Mitigations]]
- [[Incident Response]]
- [[DFIR]]

---

## Tags

`domain-2` `security-plus` `sy0-701` `mitigation-techniques` `defensive-controls` `patching` `encryption` `least-privilege` `monitoring` `siem` `posture-assessment` `decommissioning`

---

## Study Notes

**Why this matters for SY0-701:**
Domain 2 is 22% of the exam, and mitigation techniques are *core* to the domain. You cannot pass without understanding how these controls work, when to apply them, and what problem each one solves. The exam tests both *breadth* (knowing all six mitigation types) and *depth* (understanding the nuances of encryption types, patching strategies, and monitoring architectures).

**Interlock with other domain 2 topics:**
- Mitigations directly address the [[Threats]] and [[Vulnerabilities]] covered in sections 2.1–2.4.
- [[Incident Response]] (domain 4) relies on the monitoring and logging enabled by these mitigations.
- [[Access Control]] and [[Identity & Access Management]] (domain 4) are closely related to [[Least Privilege]].

**Exam question patterns:**
- "Which mitigation addresses X threat?" (matching control to threat)
- "What's the *first* step when you discover a zero-day?" (emergency patching)
- "How do you prevent a compromised user account from accessing sensitive data?" ([[Least Privilege]])
- "How do you detect a breach?" ([[Monitoring]]/[[SIEM]])
- "What should happen to a non-compliant device?" (quarantine via [[Posture Assessment]])

---

**Last updated:** 2025 | **Next review:** Before practice exam 2

```

---
_Ingested: 2026-04-15 23:50 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
