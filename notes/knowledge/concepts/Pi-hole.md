# Pi-hole

## What it is
Think of it as a bouncer at a nightclub with a blocklist — if your domain name isn't on the approved list, you never even get through the door. Pi-hole is a network-wide DNS sinkhole that intercepts DNS queries and blocks requests to known ad-serving, tracking, and malicious domains before a connection is ever established.

## Why it matters
In a defense scenario, Pi-hole can block DNS-based C2 (command-and-control) traffic — if malware on an infected host tries to phone home to a known malicious domain, Pi-hole returns a null response instead of the real IP, severing the communication channel silently. This is the same principle enterprise security teams use with DNS RPZ (Response Policy Zones) to neutralize malware callbacks across thousands of endpoints.

## Key facts
- Pi-hole operates at **Layer 7 (Application Layer)** by intercepting DNS queries (UDP/TCP port 53) and returning NXDOMAIN or a sinkhole IP for blocked entries
- It functions as a **recursive DNS resolver** or forwards to upstream resolvers (e.g., 1.1.1.1, 8.8.8.8) for allowed domains
- Blocking occurs **before TCP connections are made**, meaning no bandwidth is consumed downloading blocked content — this is why it differs from browser-level ad blockers
- Uses community-maintained **blocklists** (e.g., StevenBlack's hosts file) that can be updated on a schedule, similar to IDS signature updates
- Pi-hole provides **query logging and dashboards**, making it a lightweight DNS monitoring tool — useful for spotting anomalous lookup patterns indicative of DNS tunneling or exfiltration

## Related concepts
[[DNS Sinkholes]] [[DNS Tunneling]] [[Network Traffic Analysis]] [[Command and Control (C2)]] [[Recursive DNS Resolution]]