# Content inspection

## What it is
Like a customs agent opening every suitcase to check what's actually inside rather than trusting the label on the luggage tag, content inspection examines the actual payload of network traffic — not just headers or port numbers. It is the deep analysis of data within packets or files to identify malicious content, policy violations, or sensitive data exfiltration, regardless of the protocol or port being used.

## Why it matters
An attacker tunneling malware commands over port 443 (HTTPS) would bypass a firewall that only checks ports and protocols. A next-generation firewall or proxy performing SSL/TLS inspection can decrypt, inspect the payload for command-and-control signatures, then re-encrypt — catching the malware that a traditional packet filter would wave through without question.

## Key facts
- **Deep Packet Inspection (DPI)** operates at Layer 7, analyzing application-layer content rather than stopping at Layer 4 (transport) header examination
- **SSL/TLS inspection** (also called SSL decryption or "man-in-the-middle by design") is required to perform content inspection on encrypted traffic — the device presents its own certificate to the client
- **Data Loss Prevention (DLP)** engines rely on content inspection to detect patterns like credit card numbers (regex: 16-digit sequences) or PII leaving the network
- Content inspection is a core function of **Next-Generation Firewalls (NGFW)** and **Secure Web Gateways (SWG)**, distinguishing them from stateful firewalls
- **File carving** is a forensic form of content inspection that reconstructs files from raw packet streams regardless of file extension or header manipulation

## Related concepts
[[Deep Packet Inspection]] [[Data Loss Prevention]] [[SSL TLS Inspection]] [[Next-Generation Firewall]] [[Intrusion Detection System]]