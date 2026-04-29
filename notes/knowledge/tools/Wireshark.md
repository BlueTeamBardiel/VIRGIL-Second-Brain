# Wireshark

## What it is
Like a court stenographer who records every word spoken in a courtroom, Wireshark captures and transcribes every packet traveling across a network interface. It is an open-source protocol analyzer that allows security professionals to capture, inspect, and dissect network traffic in real time or from saved capture files (.pcap).

## Why it matters
During a incident response investigation, an analyst suspects credential theft via a man-in-the-middle attack on an unencrypted HTTP session. By loading a .pcap file in Wireshark and filtering for `http.request.method == "POST"`, the analyst can reconstruct the exact username and password transmitted in plaintext — providing forensic proof of the compromise and identifying the attacker's IP address.

## Key facts
- Wireshark operates in **promiscuous mode**, allowing a NIC to capture all packets on a network segment, not just those addressed to the local machine
- The **display filter** syntax (`ip.addr == 192.168.1.1`) differs from **capture filters** (BPF syntax: `host 192.168.1.1`) — a common exam distinction
- **Follow TCP Stream** reconstructs the full conversation between two hosts, making it easy to read application-layer data like HTTP, FTP, or Telnet sessions
- Wireshark can **decrypt TLS traffic** if provided the server's private key or a pre-master secret log file, critical for inspecting otherwise opaque HTTPS sessions
- Useful for detecting **ARP poisoning** by identifying duplicate ARP replies mapping different MACs to the same IP address

## Related concepts
[[Packet Capture (PCAP)]] [[Man-in-the-Middle Attack]] [[Protocol Analysis]] [[ARP Poisoning]] [[Network Forensics]]