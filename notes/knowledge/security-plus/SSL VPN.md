# SSL VPN

## What it is
Think of it like a secure pneumatic tube system inside a public building — anyone can walk into the lobby (the internet), but your documents travel through an encrypted tube only you can open. An SSL VPN is a remote access solution that uses TLS (formerly SSL) to create an encrypted tunnel between a remote user's browser or client and a corporate network, without requiring traditional IPsec client software or firewall reconfiguration.

## Why it matters
During the 2021 Pulse Secure SSL VPN breaches, attackers exploited CVE-2021-22893 — an unauthenticated remote code execution vulnerability — to bypass multi-factor authentication and harvest credentials from dozens of government agencies. This illustrates that SSL VPNs, despite being designed as a secure gateway, become a high-value attack surface precisely *because* they are internet-facing and always on.

## Key facts
- SSL VPNs operate at **Layer 7 (Application layer)**, unlike IPsec VPNs which operate at Layer 3, making them more firewall-friendly (uses port 443)
- Two main modes: **clientless** (browser-only, limited app access) and **tunnel mode** (full network access via lightweight client)
- Authentication often integrates **MFA, certificates, or SAML-based SSO** — compromise of any factor can defeat the entire gateway
- SSL VPN appliances (Pulse, Fortinet, Citrix) have been repeatedly targeted via **pre-auth RCE and credential disclosure CVEs** — patching cadence is critical
- Split tunneling in SSL VPNs can **leak traffic outside the encrypted channel**, potentially bypassing corporate security controls if misconfigured

## Related concepts
[[TLS]] [[IPsec VPN]] [[Zero Trust Network Access]] [[Split Tunneling]] [[Remote Access Trojan]]