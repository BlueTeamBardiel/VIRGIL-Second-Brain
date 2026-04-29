# protocol dissector

## What it is
Like a translator who doesn't just say "someone spoke French" but writes out every word, grammar rule, and accent mark — a protocol dissector parses raw network bytes into labeled, human-readable fields according to a specific protocol's specification. It's a software component (built into tools like Wireshark) that decodes protocol headers, payloads, and flags layer by layer, turning hex into meaning.

## Why it matters
During incident response, a SOC analyst captures traffic from a suspected C2 channel. The packets *look* like normal DNS, but the dissector reveals abnormally large TXT record payloads and irregular query timing — classic signs of DNS tunneling. Without the dissector, the analyst sees only raw bytes; with it, the exfiltration channel becomes immediately visible.

## Key facts
- Wireshark ships with **over 3,000 built-in dissectors**, each responsible for one protocol (HTTP, TLS, DNS, SMB, etc.)
- Dissectors can be **chained** — an Ethernet dissector hands off to IP, which hands off to TCP, which hands off to HTTP, reflecting the OSI model
- **Malformed packet attacks** deliberately violate protocol specs to crash or exploit vulnerable dissectors (CVE-2023-0667 in Wireshark is a real example of a dissector heap overflow)
- Custom/proprietary protocols can be decoded by writing **Lua scripts** in Wireshark, enabling dissection of industrial or legacy protocols
- Protocol dissectors are critical for **deep packet inspection (DPI)** in NGFWs — without them, firewalls can't enforce application-layer rules

## Related concepts
[[deep packet inspection]] [[packet analysis]] [[network traffic analysis]] [[Wireshark]] [[DNS tunneling]]