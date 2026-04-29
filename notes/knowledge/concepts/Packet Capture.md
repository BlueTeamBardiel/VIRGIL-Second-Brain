# packet capture

## What it is
Like a flight recorder on an airplane that logs every moment of a journey, a packet capture records every byte of data crossing a network interface. Technically, it's the process of intercepting and logging network traffic at the data-link layer using tools like Wireshark or tcpdump, storing raw frames for later analysis. The captured data includes headers, payloads, and timing metadata for every packet observed.

## Why it matters
During incident response, a SOC analyst suspecting credential theft can replay a packet capture to identify cleartext passwords transmitted over Telnet or FTP — literally reading the username and password in the packet payload. Conversely, attackers who gain access to a network switch can run a promiscuous-mode capture to harvest credentials and session tokens from other users on the same segment.

## Key facts
- **Promiscuous mode** allows a NIC to capture all packets on a segment, not just those addressed to it — required for passive sniffing
- **pcap** (libpcap/WinPcap) is the standard file format; Wireshark reads `.pcap` and `.pcapng` files natively
- Packet captures are **admissible forensic evidence** but require proper chain of custody and are subject to wiretap laws (e.g., ECPA in the US)
- **Full packet capture** stores entire payloads; **flow data (NetFlow/IPFIX)** stores only metadata — both serve different analytical purposes
- Encrypted traffic (TLS 1.3) limits payload inspection; analysts must rely on metadata (IP, port, timing, certificate info) unless a decryption key is available
- Switches limit capture scope by default; analysts use **port mirroring (SPAN ports)** or **network TAPs** to gain visibility across segments

## Related concepts
[[network protocol analysis]] [[promiscuous mode]] [[Wireshark]] [[NetFlow]] [[man-in-the-middle attack]] [[chain of custody]]