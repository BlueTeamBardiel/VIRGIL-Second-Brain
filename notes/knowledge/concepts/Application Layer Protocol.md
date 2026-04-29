# Application Layer Protocol

## What it is
Think of application layer protocols as the specific *language dialects* two programs agree to speak — like how a sommelier and a chef use precise culinary vocabulary that a random passerby wouldn't understand. Formally, application layer protocols (OSI Layer 7) define the rules, syntax, and semantics governing how applications exchange data over a network. Examples include HTTP, DNS, SMTP, FTP, and SSH.

## Why it matters
Attackers routinely abuse legitimate application layer protocols to blend malicious traffic into normal network activity — a technique called **Command and Control (C2) over trusted protocols**. For example, malware families like DNScat tunnel C2 traffic inside DNS queries, exploiting the fact that DNS (port 53) is rarely blocked by firewalls. Defenders use deep packet inspection (DPI) and protocol anomaly detection to catch traffic that uses the right port but violates expected protocol behavior.

## Key facts
- **MITRE ATT&CK T1071** specifically catalogs "Application Layer Protocol" as an adversary technique used to evade network defenses by hiding C2 in HTTP/S, DNS, or SMTP traffic
- DNS operates on **port 53 (UDP/TCP)**; its recursive query structure makes it a favorite exfiltration channel due to widespread firewall allowances
- **Port/protocol mismatches** (e.g., HTTP traffic on port 8443) are red flags detectable via flow analysis tools like Zeek or Wireshark
- HTTPS (port 443) presents a **defensive blind spot** — TLS encryption hides payload content, making certificate inspection and JA3 fingerprinting critical detection tools
- Application layer protocols can be analyzed without decrypting traffic using **metadata analysis**: query frequency, response size, timing patterns

## Related concepts
[[Command and Control]] [[DNS Tunneling]] [[Deep Packet Inspection]] [[Protocol Anomaly Detection]] [[MITRE ATT&CK Framework]]