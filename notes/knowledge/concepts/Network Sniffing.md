# network sniffing

## What it is
Like a postal worker secretly photocopying every letter passing through the sorting facility, network sniffing captures packets traversing a network segment without disrupting their delivery. Precisely, it is the passive interception and logging of network traffic using tools like Wireshark or tcpdump, operating the network interface in **promiscuous mode** to capture frames not addressed to that host.

## Why it matters
In 2011, Firesheep demonstrated sniffing's real danger by capturing unencrypted session cookies over open Wi-Fi at coffee shops, allowing anyone to hijack Facebook and Twitter accounts with one click. This attack accelerated the web's mass adoption of HTTPS — a direct example of a passive threat driving active defensive change. Defenders also use sniffing legitimately for intrusion detection, baseline traffic analysis, and incident response forensics.

## Key facts
- **Promiscuous mode** allows a NIC to capture all packets on a segment, not just those addressed to its MAC; **monitor mode** is the wireless equivalent for raw 802.11 frame capture
- Sniffing is **passive** — it generates no traffic, making it nearly invisible to traditional detection methods (no SYN scans, no anomalous connections)
- Switches reduce sniffing exposure versus hubs by unicasting frames, but attackers bypass this via **ARP poisoning** (a.k.a. ARP spoofing) to redirect traffic through their machine
- **Encrypted protocols** (HTTPS, SSH, TLS) render captured packets unreadable — this is the primary countermeasure
- Tools tested on Security+/CySA+: **Wireshark** (GUI analysis), **tcpdump** (CLI capture), **NetworkMiner** (passive OS fingerprinting from captures)

## Related concepts
[[ARP poisoning]] [[promiscuous mode]] [[packet analysis]] [[man-in-the-middle attack]] [[protocol analysis]]