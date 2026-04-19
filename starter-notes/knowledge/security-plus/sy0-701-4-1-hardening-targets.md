---
domain: "4.0 - Security Operations"
section: "4.1"
tags: [security-plus, sy0-701, domain-4, hardening, baseline-configuration, asset-security]
---

# 4.1 - Hardening Targets

Hardening targets refers to the systematic process of securing systems by removing default configurations and unnecessary services across multiple device categories—from network infrastructure to cloud platforms. This topic is critical for Security+ because hardening is a foundational control that reduces attack surface and vulnerabilities before threats ever reach your environment. The exam expects you to understand hardening requirements for five major target categories: mobile devices, workstations, network infrastructure devices, servers, and cloud infrastructure—and to recognize that no system is secure out-of-the-box.

---

## Key Concepts

- **Hardening**: The process of securing a system by eliminating default configurations, removing unnecessary software/services, and applying security best practices specific to the device type or OS.

- **Default Configuration Risk**: Manufacturers ship systems with generic, well-known credentials and settings; attackers actively exploit defaults, making immediate hardening non-negotiable.

- **Hardening Guides**: Manufacturer-specific and general-purpose security guidelines (NIST, MITRE, vendor docs) that provide step-by-step hardening procedures; always prefer manufacturer guidance for accuracy.

- **Mobile Devices** (phones, tablets): Always-connected, often hold sensitive company/personal data; hardening includes updates, segmentation, and [[MDM|Mobile Device Management (MDM)]] control.

- **Workstations** (desktops, laptops): User-facing systems requiring constant monitoring, automated patching, [[Active Directory]] integration, and removal of unnecessary software.

- **Network Infrastructure Devices** (switches, routers): Purpose-built systems with embedded/limited OS; require authentication hardening, manufacturer security updates, and ongoing monitoring.

- **Cloud Infrastructure**: Requires securing the management workstation (the "keys to the kingdom"), implementing [[Least Privilege]], [[EDR|Endpoint Detection and Response (EDR)]], and maintaining C2C (Cloud-to-Cloud) backups.

- **Segmentation**: Logical or physical separation of data (e.g., company vs. personal data on mobile devices) to limit breach scope.

- **Patch Management**: Regular updates for OS, firmware, and applications to fix vulnerabilities; should be automated and prioritized.

- **Policy Management**: Centralized control of system configurations via tools like [[Active Directory]] Group Policy to enforce hardening baselines across devices.

- **Least Privilege**: Granting only the minimum permissions necessary for each service, user, and application to function.

- **EDR (Endpoint Detection and Response)**: Security tools deployed on endpoints to detect, investigate, and respond to threats; critical for cloud-connected devices.

---

## How It Works (Feynman Analogy)

Think of a new house fresh from the builder: it comes with the front door unlocked, all locks are the same default key, windows don't have locks, and every light is on 24/7. Before you move in, you'd change every lock, install window locks, turn off lights you don't need, and maybe hire a security guard to monitor entry. You wouldn't live in it as-is.

Systems work the same way. Manufacturers can't know your specific security needs, so they ship defaults that prioritize **ease of use over security**. Hardening is your job as a sysadmin—you change those locks (credentials), remove unnecessary services (like unused software), apply patches (fix holes in the house), and set up monitoring (the security guard). Each device type (mobile, workstation, router, cloud server) needs different security measures because they face different threats and have different purposes. A router handles network traffic and needs strong authentication; a mobile device is always on the internet and needs an [[MDM]] to centrally enforce policies; a workstation needs constant patching because users click things; cloud infrastructure needs least-privilege access because one compromised credential could expose everything.

The exam tests whether you know **what to harden for each device type** and **why defaults are dangerous**.

---

## Exam Tips

- **Recognize the Five Target Categories**: Mobile devices, workstations, network infrastructure, servers, and cloud infrastructure—the exam will likely ask which hardening measure applies to which category. Don't confuse a router's hardening needs (authentication, firmware updates) with a workstation's (patching, software removal, MDM).

- **Defaults Are Always Wrong**: Any question mentioning "default credentials," "factory settings," or "out-of-the-box configuration" is testing whether you know they must be changed. The correct answer is almost always "remove defaults" or "change to secure configuration."

- **Manufacturer Guidance Beats Generic Guides**: The exam may ask where to find hardening procedures. Prefer manufacturer-specific hardening guides over generic online resources—they have the most accurate, detailed security requirements.

- **Cloud Infrastructure ≠ Cloud Security**: A trick question might confuse cloud management workstations (which need hardening like any workstation) with cloud services themselves. Remember: **securing the management workstation is critical** because it has "keys to the kingdom" (root/admin credentials).

- **Patch Management Is Non-Negotiable**: Questions about mobile devices, workstations, or infrastructure devices will often test whether you prioritize updates. Always select answers emphasizing regular, automated patching. Slow or manual patching is a sign of poor hardening.

- **EDR Is for Endpoints, Not Just Servers**: Don't assume EDR is only for servers. The exam expects you to know EDR should be deployed on all endpoints accessing cloud infrastructure or critical networks.

---

## Common Mistakes

- **Confusing Hardening with Just Patching**: Hardening includes patching, but it's much more—removing unnecessary software, changing defaults, segmenting data, implementing authentication controls, and monitoring. A candidate might answer "just apply updates" when the full answer should include multiple hardening steps.

- **Underestimating Mobile Device Hardening**: Many candidates treat mobile devices as "less important" than workstations or servers. The exam tests that mobile hardening is equally critical—they're always connected, often hold sensitive data, and require [[MDM]] control and segmentation.

- **Forgetting Cloud Management Workstation Security**: Candidates may focus on hardening cloud infrastructure itself (VPCs, IAM policies) and forget that the workstation **administering** the cloud is the highest-priority target. A compromised admin workstation = compromised cloud environment. This is a common exam trap.

---

## Real-World Application

In Morpheus's [YOUR-LAB] homelab, hardening targets directly applies to securing the [[Proxmox]] infrastructure (network hardening for the hypervisor), [[Active Directory]] domain controllers (authentication defaults must be changed), [[Wazuh]] agents deployed on every VM (workstation hardening with monitoring), and [[Tailscale]] nodes (mobile/remote device hardening). For example, when spinning up a new AD domain controller, Morpheus wouldn't leave the default RDP port open or use a weak KRBTGT password—he'd change defaults, apply the latest Windows patches, enforce [[Group Policy]] baselines, and monitor with [[Wazuh]]. Similarly, any mobile device connecting to the homelab via [[Tailscale]] would need device profiling and segmentation policies. In real SOCs, hardening is the first line of defense: a hardened infrastructure resists 80% of automated attacks before [[SIEM|SIEM tools]] like [[Wazuh]] ever see them.

---

## Wiki Links

### Core Concepts
- [[Hardening]]
- [[Least Privilege]]
- [[Defense in Depth]]
- [[CIA Triad]]
- [[Zero Trust]]
- [[Baseline Configuration]]
- [[Asset Management]]

### Device/System Types
- [[Mobile Device Management (MDM)]]
- [[Active Directory]]
- [[Group Policy]]
- [[Workstation Security]]
- [[Network Infrastructure]]
- [[Cloud Infrastructure]]
- [[Endpoint Detection and Response (EDR)]]

### Security Mechanisms
- [[Authentication]]
- [[Authorization]]
- [[Segmentation]]
- [[VLAN]]
- [[Encryption]]
- [[TLS]]
- [[Patch Management]]
- [[Firmware Updates]]
- [[Vulnerability Management]]

### Tools & Platforms
- [[Proxmox]]
- [[Wazuh]]
- [[Tailscale]]
- [[Splunk]]
- [[Pi-hole]]
- [[Kali Linux]]
- [[Nmap]]
- [[Metasploit]]

### Standards & Frameworks
- [[NIST]]
- [[NIST Cybersecurity Framework]]
- [[MITRE ATT&CK]]
- [[CIS Benchmarks]]

### Related Security Operations Topics
- [[Incident Response]]
- [[DFIR]]
- [[Forensics]]
- [[SOC]]
- [[Monitoring and Logging]]
- [[Malware Analysis]]
- [[Threat Detection]]

---

## Tags

#domain-4 #security-plus #sy0-701 #hardening #baseline-configuration #asset-security #mobile-security #workstation-security #network-hardening #cloud-hardening #patch-management #default-configurations #attack-surface-reduction

---

**Study Strategy for This Section:**

1. **Create a hardening checklist matrix**: rows = device types (mobile, workstation, network, server, cloud), columns = hardening categories (authentication, patching, software removal, monitoring, segmentation). Fill in specific requirements for each.

2. **Drill scenario questions**: "Your CEO brings a new iPhone to the office—what hardening steps do you take?" / "A new router arrives—what's the first hardening action?" / "You're securing a cloud admin workstation—what's your priority?"

3. **Memorize the Five Categories**: Test yourself on which hardening measures apply to which device type. The exam loves scenario-based questions that require you to distinguish (e.g., "Which hardening measure is most critical for a network switch?" vs. "...for a mobile device?")

4. **Cross-reference with CompTIA objectives**: Ensure you understand hardening in the context of [[NIST]], [[CIS Benchmarks]], and manufacturer guides—the exam will ask where to source hardening procedures.

---
_Ingested: 2026-04-16 00:03 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
