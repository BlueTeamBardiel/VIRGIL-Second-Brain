# network PCAP

## What it is
Think of it like a DVR recording every frame of a security camera feed — except instead of video, it captures every packet crossing a network interface, byte-for-byte. A PCAP (Packet CAPture) file is a standardized binary format that stores raw network traffic, including full headers and payloads, timestamped to microsecond precision. Tools like Wireshark, tcpdump, and Zeek can read and analyze this format.

## Why it matters
During incident response to a data exfiltration attack, analysts replay a PCAP from the perimeter firewall to reconstruct exactly what data left the network, to which IP, over which port, and when — even if logs were deleted. A PCAP doesn't lie the way application logs can; it's the ground truth of what actually happened on the wire. This makes it the gold standard for forensic evidence in breach investigations.

## Key facts
- **libpcap** (Linux/macOS) and **WinPcap/Npcap** (Windows) are the underlying libraries that most capture tools use to pull packets from the NIC at the kernel level
- PCAP files have a **global header** followed by per-packet records; the magic number `0xA1B2C3D4` identifies the format
- **Promiscuous mode** must be enabled on the NIC to capture traffic not addressed to that specific host — critical for hub-based or port-mirrored captures
- **PCAP-NG** (Next Generation) is the modern successor format, supporting multiple interfaces and richer metadata in a single file
- On Security+/CySA+ exams, PCAP analysis is associated with **protocol analysis**, **full packet capture**, and distinguishing it from **NetFlow** (which captures metadata only, not payloads)

## Related concepts
[[Wireshark]] [[NetFlow analysis]] [[network forensics]] [[promiscuous mode]] [[intrusion detection systems]]