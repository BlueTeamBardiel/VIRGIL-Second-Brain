# VPN concentrator

## What it is
Think of it as a highway toll plaza: instead of dozens of side roads each needing their own tollbooth, all traffic funnels through one structure that handles authentication, encryption, and routing at scale. A VPN concentrator is a dedicated hardware or software device that manages a large number of simultaneous VPN tunnels, terminating encrypted connections from remote users or branch sites and routing their traffic into the internal network.

## Why it matters
During the 2020 remote-work surge, attackers actively exploited unpatched Pulse Secure and Citrix VPN concentrators (CVE-2019-11510, CVE-2019-19781) to dump credentials and pivot into corporate networks — no phishing required. A properly hardened concentrator with multi-factor authentication and current patches would have blocked lateral movement before it started.

## Key facts
- Operates at **Layer 3** (Network layer), terminating IPsec, SSL/TLS, or L2TP tunnels from thousands of simultaneous clients
- Supports **split tunneling** (only corporate-bound traffic goes through the VPN) vs. **full tunneling** (all traffic routed through corporate — better visibility, higher load)
- Uses **IKE (Internet Key Exchange)** phases to negotiate and establish IPsec security associations (SAs) for each tunnel
- Common deployment in **DMZ** or network perimeter so that compromised concentrators don't give direct internal access
- Distinct from a standard VPN router — purpose-built for **scalability and session management**, often supporting thousands of concurrent connections with dedicated crypto acceleration hardware

## Related concepts
[[IPsec]] [[SSL VPN]] [[Split Tunneling]] [[DMZ]] [[Multi-Factor Authentication]]