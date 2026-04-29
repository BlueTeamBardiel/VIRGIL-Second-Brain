# MTU

## What it is
Think of MTU like a postal service rule: no single package can exceed 70 lbs — anything heavier must be split into multiple boxes. Maximum Transmission Unit (MTU) is the largest size (in bytes) of a single packet that can be transmitted over a network link without being fragmented. Ethernet's standard MTU is 1500 bytes; anything larger must be broken into smaller fragments before transit.

## Why it matters
Attackers exploit MTU and packet fragmentation in **fragmentation attacks** — deliberately crafting oversized or malformed fragments that reassemble into malicious payloads on the target, bypassing IDS/IPS systems that inspect only individual fragments rather than the reconstructed stream. This technique was central to historical evasion tools like Fragrouter and remains relevant when testing whether security appliances perform full fragment reassembly before inspection.

## Key facts
- **Standard Ethernet MTU = 1500 bytes**; jumbo frames extend this to 9000 bytes on supported hardware
- **IP fragmentation** occurs when a packet exceeds the MTU of a link — the IP header's Fragment Offset and More Fragments flag fields track reassembly
- **Path MTU Discovery (PMTUD)** uses ICMP "Fragmentation Needed" messages (Type 3, Code 4) to negotiate the smallest MTU along an entire route — blocking ICMP can silently break PMTUD and cause connectivity issues
- **Tiny fragment attacks** split TCP header data across fragments so the first fragment is too small to contain the full port information, historically bypassing ACL rules
- MTU mismatches are a common cause of VPN tunnel failures, especially with IPsec adding overhead that pushes packets over the 1500-byte limit

## Related concepts
[[IP Fragmentation]] [[ICMP]] [[Packet Filtering]] [[IDS Evasion]] [[IPsec]]