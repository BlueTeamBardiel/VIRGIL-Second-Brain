# MITRE ATT&CK T1132 - Data Encoding

## What it is
Like a spy writing messages in pig latin to slip past a guard who only looks for English words, adversaries encode data during C2 communications so that security tools scanning for plaintext indicators miss the traffic entirely. Precisely, T1132 describes techniques where attackers transform data using standard encoding schemes (Base64, hex, URL encoding) to obfuscate command-and-control communications and evade signature-based detection.

## Why it matters
During the APT41 campaign, malware encoded C2 beacon traffic in Base64 before sending it over HTTP, making the payload appear as routine web traffic to perimeter firewalls and IDS signatures tuned for plaintext malicious strings. Defenders who implemented anomaly-based detection — flagging HTTP POST bodies with unusually high Base64 density — were able to catch what signature rules missed entirely.

## Key facts
- **Sub-techniques**: T1132.001 (Standard Encoding — Base64, hex) and T1132.002 (Non-Standard Encoding — custom schemes that require reverse engineering to decode)
- Encoding is **not encryption** — Base64 can be decoded by anyone without a key; its purpose is obfuscation, not confidentiality
- Common detection strategy: hunt for **high-entropy strings** or Base64 patterns in HTTP headers, DNS TXT records, and POST bodies using tools like CyberChef or YARA rules
- Frequently paired with **T1071 (Application Layer Protocol)** to blend encoded C2 traffic inside legitimate protocols like HTTP/HTTPS or DNS
- On the CySA+ exam, expect questions distinguishing encoding (reversible, no key) from encryption (requires key) and hashing (one-way, non-reversible)

## Related concepts
[[T1071 Application Layer Protocol]] [[T1001 Data Obfuscation]] [[T1573 Encrypted Channel]]