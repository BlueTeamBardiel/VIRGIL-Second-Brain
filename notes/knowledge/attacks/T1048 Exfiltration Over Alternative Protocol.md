# T1048 Exfiltration Over Alternative Protocol

## What it is
Like a smuggler shipping contraband inside a legal cargo container labeled "produce," attackers use legitimate-looking network protocols — DNS, ICMP, or FTP — to secretly move stolen data out of a network, bypassing controls watching the obvious exits. Precisely: T1048 describes exfiltration that deliberately avoids the primary command-and-control channel by encoding or tunneling data through protocols that security tools routinely trust or overlook.

## Why it matters
During the 2020 SolarWinds campaign, threat actors used DNS-based exfiltration to siphon data because most organizations log HTTP/HTTPS far more carefully than DNS query traffic — making DNS an ideal blind spot. A defender monitoring only TCP 443 egress while ignoring abnormally large or frequent DNS queries to external resolvers will miss this entirely.

## Key facts
- **Sub-techniques include**: DNS (T1048.001), asymmetric encrypted/unencrypted protocols (T1048.002/003), and ICMP tunneling — each exploiting a different trusted protocol
- **DNS exfiltration signature**: unusually long subdomain labels (e.g., `c3RvbGVuZGF0YQ==.evil.com`) or high query volume to a single external domain
- **ICMP tunneling** embeds payload data inside ping packet data fields, which most firewalls pass without inspection
- **Detection method**: behavioral baselines matter — alert on DNS queries exceeding normal byte thresholds or ICMP packets with non-zero data payloads larger than 64 bytes
- **Mitigation**: DNS filtering (e.g., Cisco Umbrella), egress filtering on non-standard ports, and deep packet inspection on "allowed" protocols

## Related concepts
[[DNS Tunneling]] [[T1071 Application Layer Protocol]] [[Data Loss Prevention]] [[Network Traffic Analysis]] [[T1041 Exfiltration Over C2 Channel]]