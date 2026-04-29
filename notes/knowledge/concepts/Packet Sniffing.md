# packet sniffing

## What it is
Like a postal worker secretly opening every letter passing through a sorting facility and reading the contents before resealing them, packet sniffing is the capture and inspection of network traffic as it traverses a medium. More precisely, it is the process of placing a network interface into **promiscuous mode** to capture all frames on a segment — not just those addressed to the host — then decoding and analyzing the raw byte streams.

## Why it matters
On an unencrypted Wi-Fi network at a coffee shop, an attacker running Wireshark can capture HTTP login forms and extract plaintext usernames and passwords in real time — a passive attack that leaves zero footprint on the victim's system. Defensively, network analysts use the same technique with tools like tcpdump to capture traffic for incident response, detecting lateral movement or data exfiltration by inspecting packet payloads and metadata.

## Key facts
- **Promiscuous mode** allows a NIC to capture all frames on the network segment, not just unicast traffic destined for its MAC address
- Sniffing is **passive by default** — no packets are injected, making it nearly invisible to intrusion detection systems
- Switched networks limit sniffing scope to a single collision domain; attackers counter this with **ARP poisoning** to redirect traffic through their machine (a man-in-the-middle setup)
- **Protocol targets**: Telnet, FTP, HTTP, and SNMPv1/v2 transmit credentials in cleartext — all trivially captured
- Defense: **TLS/SSL encryption** renders sniffed payloads unreadable; **network segmentation** and **802.1X port authentication** reduce exposure surface

## Related concepts
[[ARP poisoning]] [[man-in-the-middle attack]] [[promiscuous mode]] [[protocol analysis]] [[Wireshark]]