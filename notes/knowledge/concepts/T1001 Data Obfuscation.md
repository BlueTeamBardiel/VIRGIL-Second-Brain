# T1001 Data Obfuscation

## What it is
Like a spy writing a message in lemon juice — the content is there, but it's deliberately disguised so a casual observer sees nothing suspicious. Data obfuscation is the technique attackers use to hide command-and-control (C2) communications by encoding, encrypting, or disguising malicious traffic so it blends into normal network activity. It falls under the broader MITRE ATT&CK category of Command and Control (TA0011).

## Why it matters
The APT group behind the SolarWinds SUNBURST backdoor used obfuscated DNS queries to blend C2 traffic with legitimate DNS traffic — the malware encoded stolen data into subdomain lookups, making it appear as routine DNS resolution. Defenders who only inspected payload content missed the attack; only behavioral analysis of DNS query frequency and entropy caught it.

## Key facts
- T1001 has three documented sub-techniques: **T1001.001** (Junk Data), **T1001.002** (Steganography), and **T1001.003** (Protocol Impersonation)
- Steganography (T1001.002) hides data *within* innocent-looking files like images or audio — malware may exfiltrate data by embedding it in uploaded JPEGs
- Protocol Impersonation (T1001.003) wraps malicious traffic to mimic legitimate protocols (e.g., disguising C2 as HTTPS without valid certificates)
- Detection relies heavily on **traffic entropy analysis** and **deep packet inspection (DPI)** — high entropy in DNS TXT records or HTTP headers signals possible obfuscation
- Obfuscation ≠ encryption: encrypted traffic is unreadable but identifiable; obfuscated traffic actively disguises *what kind* of communication is occurring

## Related concepts
[[T1071 Application Layer Protocol]] [[T1048 Exfiltration Over Alternative Protocol]] [[T1573 Encrypted Channel]] [[DNS Tunneling]] [[Network Traffic Analysis]]