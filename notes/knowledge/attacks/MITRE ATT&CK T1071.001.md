# MITRE ATT&CK T1071.001

## What it is
Like a spy hiding secret messages inside ordinary postcards sent through the normal postal system, attackers use standard HTTP/S web traffic as a carrier for command-and-control (C2) communications. T1071.001 describes adversaries who embed C2 instructions inside legitimate-looking web requests, exploiting the fact that HTTP/S traffic is almost universally permitted through firewalls.

## Why it matters
During the APT41 campaigns, threat actors tunneled C2 traffic over HTTPS to blend with normal corporate web browsing, making their malware beaconing nearly invisible to perimeter defenses. A defender using network traffic analysis noticed periodic, metronomically regular HTTPS requests to an unusual domain — a classic beacon pattern — which exposed the compromise despite the encrypted channel.

## Key facts
- Subcategory of T1071 (Application Layer Protocol); specifically abuses HTTP (port 80) and HTTPS (port 443) to blend C2 into legitimate traffic
- Attackers exploit the fact that blocking HTTP/S would cripple normal business operations, giving them near-guaranteed firewall traversal
- Beaconing behavior (regular interval callbacks) is the primary detection indicator; look for consistent byte sizes and timing patterns in web proxy logs
- User-Agent strings and HTTP headers are often hardcoded or anomalous in malware, providing a detection artifact even in encrypted traffic via JA3 fingerprinting
- Defense-in-depth countermeasures include TLS inspection (SSL decryption), DNS filtering, web proxies with content inspection, and behavioral analytics on outbound traffic

## Related concepts
[[Command and Control]] [[Web Proxy]] [[TLS Inspection]] [[Beaconing Detection]] [[JA3 Fingerprinting]]