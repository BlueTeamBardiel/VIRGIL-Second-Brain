# VPN

## What it is
Like a sealed diplomatic pouch travelling through hostile territory — the courier (your ISP) carries it but cannot open or read what's inside. A VPN (Virtual Private Network) creates an encrypted tunnel between a client and a server, routing traffic through that server so the contents are hidden from intermediaries and the destination sees the VPN server's IP, not yours.

## Why it matters
In 2020, threat actors exploited unpatched vulnerabilities in Pulse Secure and Fortinet VPN appliances (CVE-2019-11510, CVE-2018-13379) to steal credentials and pivot into corporate networks — turning the security tool itself into the attack surface. Organizations that failed to patch these internet-facing VPN gateways handed attackers authenticated access without a single phishing email.

## Key facts
- **Split tunneling** routes only some traffic through the VPN; it reduces bandwidth load but can expose corporate data if the "outside" traffic is compromised
- **IPSec** operates at Layer 3 and is commonly used for site-to-site VPNs; **SSL/TLS VPNs** (e.g., OpenVPN, Cisco AnyConnect) operate at Layer 4/7 and are preferred for remote access because they traverse firewalls easily via port 443
- **Always-on VPN** (used in zero-trust architectures) forces all device traffic through the corporate tunnel regardless of user action, reducing shadow IT risk
- A VPN does **not** provide anonymity against the VPN provider itself — if they log, they can be compelled to disclose
- For Security+: VPNs use **tunneling protocols** (L2TP, PPTP, IKEv2) combined with **encryption protocols** (IPSec, SSL/TLS); PPTP is considered broken and should never appear in a correct answer as a secure choice

## Related concepts
[[IPSec]] [[Tunneling Protocols]] [[Zero Trust Architecture]] [[Split Tunneling]] [[TLS]]