# Device Posture

## What it is
Like a bouncer checking your ID *and* your sobriety before letting you into a club, device posture evaluation assesses whether an endpoint meets a defined security baseline *before* granting it network or resource access. It is the continuous or point-in-time verification that a device satisfies specific health requirements — such as having an up-to-date OS, active endpoint protection, disk encryption enabled, and no jailbreak indicators — prior to or during authenticated sessions.

## Why it matters
In 2020, attackers exploited VPN vulnerabilities partly because organizations granted access to any authenticated device regardless of its patch level or security configuration. A Zero Trust architecture with device posture checking would have blocked an unpatched, compromised laptop from reaching internal resources even with valid credentials — containing lateral movement before it started.

## Key facts
- Device posture is a core enforcement mechanism in **Zero Trust Network Access (ZTNA)** and **NAC (Network Access Control)** frameworks
- Common posture checks include: OS patch level, antivirus signature currency, firewall status, disk encryption state (BitLocker/FileVault), and certificate presence
- **Conditional Access** policies in platforms like Microsoft Entra ID (Azure AD) use posture signals to grant, limit, or block access dynamically
- A device failing posture checks is typically placed in a **remediation VLAN** or quarantine zone rather than the production network
- Posture can be **agent-based** (software installed on endpoint) or **agentless** (assessed via network fingerprinting, browser attributes, or certificates) — each with different visibility trade-offs

## Related concepts
[[Zero Trust Architecture]] [[Network Access Control]] [[Endpoint Detection and Response]] [[Conditional Access]] [[802.1X Authentication]]