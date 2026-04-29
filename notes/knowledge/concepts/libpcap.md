# libpcap

## What it is
Think of libpcap as a universal telephone wiretap adapter — instead of needing a different tool for every phone model, it gives any application a single, standardized socket into the raw stream of network traffic regardless of the underlying hardware. Precisely, libpcap (Packet Capture library) is a portable C library that provides a high-level API for capturing raw network packets directly from a network interface, bypassing the normal OS network stack. It is the foundational engine beneath tools like Wireshark, tcpdump, Snort, and Zeek.

## Why it matters
Defenders use libpcap-based tools to capture traffic and detect lateral movement — for example, running Snort in packet capture mode to identify a Mimikatz-style pass-the-hash attack crossing the wire between Windows hosts. Attackers equally leverage custom libpcap programs to build covert packet sniffers, capturing cleartext credentials on networks still using Telnet, FTP, or HTTP. This dual-use nature means understanding libpcap is essential for both building defenses and understanding how passive interception attacks work.

## Key facts
- libpcap uses **BPF (Berkeley Packet Filter)** syntax for filtering captured packets at the kernel level, minimizing CPU overhead by dropping unwanted packets before they reach userspace.
- Requires **root/administrator privileges** (or the `CAP_NET_RAW` capability on Linux) to open a network interface in promiscuous mode.
- **Promiscuous mode** allows the NIC to capture all packets on the wire, not just those addressed to the host — critical for network-wide monitoring.
- The Windows equivalent is **WinPcap** (now superseded by **Npcap**), which Wireshark and Nmap depend on for raw packet access.
- Captured traffic is stored in **PCAP file format** (.pcap), a standard forensic artifact format analyzed in incident response and CySA+ exam scenarios.

## Related concepts
[[Wireshark]] [[Promiscuous Mode]] [[Network Traffic Analysis]] [[Packet Filtering]] [[Intrusion Detection System]]