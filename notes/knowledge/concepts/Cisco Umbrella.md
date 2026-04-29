# Cisco Umbrella

## What it is
Think of it as a bouncer who checks the guest list *before* anyone even walks through the door — Cisco Umbrella is a cloud-delivered Secure Internet Gateway (SIG) that enforces DNS-layer security to block malicious domains, IPs, and URLs before a connection is ever established. It sits in the DNS resolution path, acting as a recursive DNS resolver that evaluates every query against threat intelligence in real time.

## Why it matters
During a ransomware campaign, attackers often rely on command-and-control (C2) domains to receive check-ins from infected hosts and deliver encryption keys. Umbrella intercepts the DNS lookup for that C2 domain and returns a block page instead of the real IP address, severing the kill chain at the reconnaissance/callback stage — even before a TCP connection is made, rendering traditional firewall rules irrelevant for that threat vector.

## Key facts
- Operates at **DNS and IP layers**, meaning it can block threats before a full HTTP/S connection is established — effective even on non-standard ports
- Uses **Cisco Talos threat intelligence** to power its real-time domain categorization and reputation scoring
- Provides **Secure Web Gateway (SWG)**, **CASB**, and **firewall-as-a-service** capabilities, making it a full SASE (Secure Access Service Edge) component
- Enforces policy for **roaming users off-VPN** by routing DNS queries through Umbrella regardless of network location via the Roaming Client agent
- Relevant to **CySA+ and Security+** under topics of DNS security, threat intelligence platforms, and cloud-delivered security controls

## Related concepts
[[DNS Security (DNSSEC)]] [[Secure Web Gateway]] [[SASE (Secure Access Service Edge)]] [[Command and Control (C2)]] [[Threat Intelligence Platforms]]