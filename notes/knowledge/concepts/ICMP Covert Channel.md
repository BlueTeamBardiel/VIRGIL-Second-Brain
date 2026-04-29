# ICMP Covert Channel

## What it is
Imagine smuggling secret messages inside hollow chocolates at a border crossing — the inspector sees ordinary candy, never knowing contraband is hidden inside. An ICMP covert channel works exactly this way: attackers embed data inside the payload field of ICMP Echo (ping) packets, which most firewalls pass freely because ping looks like harmless network diagnostics. The data rides invisibly inside legitimate-looking traffic, bypassing security controls entirely.

## Why it matters
The tool **Loki** (released 1996) demonstrated this technique publicly, and modern variants like **ptunnel** allow full TCP tunneling over ICMP — meaning an attacker can establish a command-and-control connection or exfiltrate data even on networks that block all TCP/UDP outbound traffic. Blue teamers monitoring for this look for ICMP packets with unusually large or non-standard payloads, since legitimate ping typically sends only 32–64 bytes of recognizable pattern data.

## Key facts
- Standard Windows ping payload is 32 bytes of alphabet characters (`abcdefghijklmnop...`); payloads deviating from this pattern are a red flag
- ICMP type 8 (Echo Request) / type 0 (Echo Reply) are the most commonly abused message types for covert channels
- Detection signatures include: high ICMP packet volume, consistent inter-packet timing, and payload entropy anomalies
- Firewalls that allow ICMP passthrough without deep packet inspection are vulnerable; the fix is rate-limiting ICMP and inspecting payload content
- ICMP tunneling can encapsulate DNS, HTTP, or raw shell commands — making it a full C2 mechanism, not just data theft

## Related concepts
[[Covert Channel]] [[DNS Tunneling]] [[Command and Control (C2)]] [[Deep Packet Inspection]] [[Network Traffic Analysis]]