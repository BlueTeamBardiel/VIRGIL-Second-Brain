# TTL manipulation

## What it is
Like a letter that self-destructs after passing through a certain number of post offices, TTL (Time-To-Live) is a counter in IP packet headers that decrements by 1 at each router hop and drops the packet at zero. Attackers manipulate this field to exploit inconsistencies between how network security devices and end hosts interpret packets with unusual TTL values, causing the two to "see" different traffic streams.

## Why it matters
In IDS/IPS evasion, an attacker crafts two overlapping packet streams — one with a TTL just long enough to reach the IDS but expire before the target, and a real payload with sufficient TTL to reach the victim. The IDS reconstructs a harmless decoy stream while the host assembles the actual malicious payload, effectively blinding the detection system to the real attack.

## Key facts
- Default TTL values differ by OS: Linux/Android typically uses **64**, Windows uses **128**, and older Cisco/network gear uses **255** — useful for OS fingerprinting.
- TTL manipulation is a core technique in **IP fragmentation attacks** and **session splicing**, both classified as IDS evasion methods.
- Tools like **Scapy** and **hping3** allow manual TTL field crafting for penetration testing and evasion research.
- **Traceroute** exploits TTL manipulation intentionally — it sends packets with incrementing TTL values (1, 2, 3…) to map network hops via ICMP Time Exceeded responses.
- Defenders counter TTL evasion by configuring IDS/IPS to **normalize packets** (e.g., Snort's `stream5` preprocessor discards packets that wouldn't reach the endpoint).

## Related concepts
[[IDS Evasion Techniques]] [[IP Fragmentation Attacks]] [[OS Fingerprinting]] [[Packet Crafting]] [[Network Intrusion Detection Systems]]