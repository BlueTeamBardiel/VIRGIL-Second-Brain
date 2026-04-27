```yaml
---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.4"
tags: [security-plus, sy0-701, domain-2, physical-security, physical-attacks]
---
```

# 2.4 - Physical Attacks

Physical attacks represent a fundamental and often overlooked threat vector that bypasses all digital security controls through direct in-person access to infrastructure, devices, and facilities. This section covers attacks that exploit the physical environment and access points rather than software vulnerabilities, reminding security professionals that no amount of encryption or authentication can stop an attacker with a screwdriver and physical access to your hardware. For the SY0-701 exam, understanding physical attacks is critical because they represent a foundational layer of the [[CIA Triad]] and complement technical security controls—you cannot have true security if your physical perimeter is compromised.

---

## Key Concepts

- **Physical Access = Full Control**: If an attacker has unrestricted physical access to a server or network device, they can extract hard drives, bypass operating system protections, install malware, or perform direct memory attacks. No firewall, [[Encryption]], or [[Authentication]] method can prevent this.

- **Brute Force (Physical)**: A literal, non-technical attack where an attacker uses force (tools, methods, or persistence) to bypass physical barriers like locks, doors, windows, or server cages. This is fundamentally different from password brute force attacks.

- **RFID Cloning**: Radio-Frequency Identification (RFID) badges and key fobs used for access control can be duplicated using readily available commercial hardware (often under $50). The process takes seconds and creates a duplicate credential without authentication.

- **Multi-Factor Authentication (MFA) for Physical Access**: [[MFA]] becomes critical in physical security contexts—a cloned card is useless if you also require biometric verification (fingerprint, iris scan) or a PIN code alongside the RFID credential.

- **Environmental Attacks**: Threats targeting the infrastructure that supports technology systems rather than the systems themselves. Includes power supply interruption, HVAC failure, humidity extremes, temperature swings, and fire/smoke damage.

- **HVAC (Heating, Ventilation, and Air Conditioning) Compromise**: Data centers and server rooms require strict environmental controls (typically 64–80°F, 20–80% relative humidity). Failure to maintain these conditions can cause hardware failure, data corruption, and system downtime.

- **Fire Suppression Systems**: Physical data centers require fire suppression (sprinklers, halon, CO₂). An attacker could trigger false alarms or interfere with suppression systems, causing facility evacuation or equipment damage.

- **Power Monitoring & Supply**: Uninterruptible Power Supplies ([[UPS]]), backup generators, and redundant power feeds protect against outages. Loss of power is a physical attack that can crash systems and corrupt data.

- **Social Engineering + Physical Access**: Physical attacks often combine with social engineering (tailgating, pretexting) to gain facility access without forced entry.

- **"Door Locks Keep Out Honest People"**: A colloquial but important principle—basic locks and barriers deter casual intrusion but determined attackers will find ways around them. Physical security must be layered and monitored.

---

## How It Works (Feynman Analogy)

**Imagine your house has a state-of-the-art smart lock with biometric fingerprint recognition.** No one can guess the password, it's encrypted, and the system logs every access attempt. But if someone breaks a window, climbs inside, and walks to your safe, the smart lock becomes irrelevant—they simply need a screwdriver and time.

**In IT infrastructure**, the same principle applies. You can deploy [[Firewalls]], [[IDS]]/[[IPS]] systems, [[Encryption]], and [[Zero Trust]] architecture, but if an attacker walks into your server room, unplugs a hard drive, and walks out, none of those digital defenses mattered. They now have direct access to your data without touching a single network cable.

**Physical attacks work at a layer *below* digital security.** They exploit the fact that computing hardware is physical—it requires power, cooling, physical space, and human access to maintain. By attacking these foundational elements (the environment, the access controls, the devices themselves), attackers bypass the entire digital security stack and operate in a realm where technology cannot defend itself.

---

## Exam Tips

- **Understand the "No Keyboard" Principle**: The exam will test whether you understand that physical access to a server negates [[Authentication]], [[Authorization]], and encryption protections. If they have the hardware, they control it. This is a core Security+ concept.

- **RFID Cloning ≠ Hacking**: The exam may present RFID cloning as a social engineering or physical security issue, not a cybersecurity attack in the traditional sense. Know that it's fast (<5 seconds), cheap (<$50), and why [[MFA]] is the mitigation.

- **Environmental vs. Digital**: Don't confuse physical environmental attacks (HVAC failure, power loss) with cyber attacks. The exam tests whether you understand that your data center's infrastructure is part of your attack surface. A cooling system failure is a physical security incident, not a software vulnerability.

- **Layered Physical Security**: The exam may ask about mitigation strategies for physical attacks. The answer is always layered controls: locks (perimeter), access badges (credential), guards (surveillance), CCTV (monitoring), and environmental controls (infrastructure resilience).

- **MFA Applies to Physical Access**: Modern Security+ exams increasingly blur the line between digital and physical access control. Know that [[MFA]] (multi-factor authentication) for physical access typically means: credential (RFID card) + biometric (fingerprint) + PIN (knowledge factor). This mirrors digital [[MFA]] principles.

---

## Common Mistakes

- **Assuming Digital Security Prevents Physical Attacks**: Candidates sometimes answer "use encryption" or "enable a firewall" to a physical security question. Remember: encryption protects data in transit and at rest, but physical access allows an attacker to bypass encryption entirely by extracting the device and accessing it offline.

- **Underestimating RFID Cloning Impact**: Exam questions may present RFID cloning as a low-priority threat because "it's just access control." But cloning an RFID card gives you facility access to servers, backup systems, and sensitive hardware—this is a critical vulnerability. The answer is always [[MFA]].

- **Forgetting About Environmental Controls as Security**: Some candidates treat HVAC and power systems as "operations issues," not "security issues." On the exam, environmental attacks are explicitly part of physical security. A failed cooling system is a denial-of-service (DoS) attack on your infrastructure.

---

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] homelab, physical security is often overlooked in favor of digital controls like [[Active Directory]], [[Tailscale]], and [[Wazuh]]. However, physical attacks are just as relevant: if an attacker gains access to the server rack and pulls a hard drive, all the [[encryption]] and access controls become moot. Morpheus should implement: (1) locked server cage access, (2) RFID badge access logging, (3) environmental monitoring (temperature/humidity alerts via [[Wazuh]]), and (4) surveillance cameras. In production environments, this is why [[SOC]] teams monitor not just network traffic via [[IDS]]/[[IPS]] but also physical security events—a sudden power loss or HVAC alarm may be as critical as a malware alert.

---

## Related Concepts & Wiki Links

- [[CIA Triad]] — Confidentiality, Integrity, Availability; physical attacks threaten all three
- [[Authentication]] — Moot if attacker has physical access; [[MFA]] mitigates some physical attacks
- [[Encryption]] — Protects data in transit/at rest but not against direct device access
- [[Zero Trust]] — Assume breach; physical security is part of the perimeter
- [[Access Control]] — RFID badges, biometrics, locks; foundational to physical security
- [[Multi-Factor Authentication (MFA)]] — Critical mitigation for RFID cloning and credential-based physical access
- [[Firewall]] — Digital control; does not prevent physical attacks
- [[IDS/IPS]] — Monitors network traffic; cannot detect someone physically walking into a data center
- [[SIEM]] — [[Wazuh]], [[Splunk]] — Can monitor environmental sensors, access logs, and physical security events
- [[Active Directory]] — Manages digital access; doesn't control physical facility access
- [[Tailscale]] — VPN for remote access; doesn't protect against physical server compromise
- [[NIST]] — Physical security guidelines (e.g., NIST SP 800-53)
- [[Incident Response]] — Physical security incidents (break-ins, equipment theft, environmental failures) must be investigated
- [[Forensics]] — If a device is physically compromised, forensic analysis may be needed
- [[MITRE ATT&CK]] — Includes "Facility Access" as a tactic (TA0001)

---

## Tags

`domain-2` `security-plus` `sy0-701` `physical-security` `physical-attacks` `access-control` `rfid` `environmental-controls` `infrastructure-security`

---
_Ingested: 2026-04-15 23:43 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
