# SSLVPN

## What it is
Think of it like a secure pneumatic tube built inside a glass pipe — anyone can see the tube exists, but everything traveling through it is sealed airtight. SSL/TLS VPN is a remote access technology that creates an encrypted tunnel between a client and a network gateway using the same TLS protocol that secures HTTPS websites, typically over port 443, requiring only a web browser or lightweight client rather than dedicated VPN software.

## Why it matters
In 2021, threat actors exploited CVE-2021-20038, a critical buffer overflow in SonicWall SSL-VPN, to gain unauthenticated remote code execution on gateway appliances — effectively hijacking the front door of thousands of corporate networks. Because SSL VPN gateways sit at the network perimeter and authenticate remote users, a single unpatched vulnerability can expose every internal resource that remote workers access. Organizations that delayed patching had their SSL VPN endpoints weaponized as initial access footholds for ransomware deployment.

## Key facts
- Operates over **TCP port 443**, making it firewall-friendly since outbound HTTPS is rarely blocked
- Two delivery modes: **clientless** (browser-only, limited app access via web portal) and **thin-client/full-tunnel** (installed agent, full network access)
- Authentication is layered — supports **MFA, certificates, and LDAP/RADIUS integration**, unlike older IPsec VPNs which often relied on pre-shared keys
- SSL VPN gateways are **high-value attack targets** (Pulse Secure, Fortinet, Citrix, SonicWall all had critical CVEs 2019–2022)
- Distinguished from **IPsec VPN** by operating at the **application/transport layer** (Layer 7/4) rather than the network layer (Layer 3), simplifying NAT traversal

## Related concepts
[[TLS]] [[IPsec VPN]] [[Zero Trust Network Access]] [[Multi-Factor Authentication]] [[Remote Code Execution]]