# T1071 Exfiltration Over Command and Control Channel

## What it is
Like a spy who smuggles stolen documents out of a building inside the same diplomatic pouch he used to receive his orders, attackers reuse their existing C2 communication channel to ship stolen data back out. Precisely: T1071 describes adversaries exfiltrating data through the same protocol or tunnel already established for command and control — such as HTTP, DNS, or HTTPS — rather than opening a separate exfiltration pathway.

## Why it matters
During the SolarWinds SUNBURST campaign, compromised systems sent stolen reconnaissance data outbound over HTTPS to attacker-controlled domains, blending perfectly with normal enterprise web traffic. Defenders who only monitored for unusual ports or new outbound connections missed the exfiltration entirely because it rode inside traffic that security tools were configured to trust.

## Key facts
- Attackers favor this technique because it reduces their footprint — one channel for both C2 and exfil means fewer anomalies to trigger DLP or firewall rules
- Common carrier protocols include DNS (data encoded in TXT or subdomain queries), HTTP/S (data in POST bodies or headers), and ICMP (data in echo request payloads)
- Detection relies on behavioral analytics: unusual data volume, high query frequency, or abnormally large DNS responses are stronger signals than port-based blocking
- MITRE maps this under both TA0011 (Command and Control) and TA0010 (Exfiltration), reflecting its dual role
- SSL/TLS inspection is a critical defensive control — encrypted C2 channels make payload-level detection impossible without decryption at a proxy

## Related concepts
[[DNS Tunneling]] [[C2 Beaconing]] [[Data Loss Prevention]] [[SSL Inspection]] [[T1048 Exfiltration Over Alternative Protocol]]