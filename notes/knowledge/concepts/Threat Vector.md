# Threat Vector

## What it is
Think of a medieval castle: the walls are strong, but the drawbridge, the supply carts, and the messenger pigeons are all different *paths* an attacker might exploit. A threat vector is the specific pathway or method an attacker uses to gain unauthorized access to a system or deliver a payload. It describes *how* an attack reaches its target, not what the attack does once it arrives.

## Why it matters
In the 2021 Colonial Pipeline attack, the threat vector was a compromised VPN password — attackers didn't breach the firewall directly, they walked in through a legitimate remote access channel. Defenders who understood that VPN endpoints were a viable threat vector would have prioritized MFA enforcement there, which was notably absent. Identifying threat vectors lets defenders allocate controls to the actual entry points, not just the obvious ones.

## Key facts
- Threat vector ≠ threat surface: the **attack surface** is the total collection of possible entry points; a threat vector is one specific route through that surface
- Common threat vectors include phishing email, removable media (USB drops), unpatched software, misconfigured APIs, and compromised credentials
- MITRE ATT&CK maps adversary behaviors to initial access techniques — essentially cataloguing threat vectors by real-world use
- Security+ exam distinguishes between **vectors** (the path) and **attack types** (e.g., SQL injection, XSS) — know which is which
- Reducing threat vectors is a core principle of **attack surface reduction**, achieved through disabling unused services, enforcing least privilege, and patching

## Related concepts
[[Attack Surface]] [[Initial Access (MITRE ATT&CK)]] [[Vulnerability]] [[Threat Actor]] [[Defense in Depth]]