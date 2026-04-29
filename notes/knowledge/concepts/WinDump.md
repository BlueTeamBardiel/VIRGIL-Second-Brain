# WinDump

## What it is
Think of it as a stethoscope pressed against the chest of your Windows network — every heartbeat of traffic captured and displayed in raw detail. WinDump is the Windows port of the Unix `tcpdump` command-line packet analyzer, relying on the WinPcap driver library to capture live network packets directly from a network interface.

## Why it matters
During incident response, an analyst suspecting data exfiltration can run WinDump on a Windows host to capture outbound traffic and inspect packet payloads for signs of sensitive data leaving the network in cleartext. For example, `windump -i 1 -w capture.pcap port 443` captures all TLS traffic to a PCAP file for later analysis in Wireshark, preserving a forensic record without altering the live environment.

## Key facts
- WinDump depends on **WinPcap** (or its successor **Npcap**) to access raw network interfaces on Windows; without it, the tool will not function.
- Uses the same **Berkeley Packet Filter (BPF)** syntax as tcpdump, so filters like `host 192.168.1.1 and tcp port 80` transfer directly between platforms.
- Output is written in **PCAP format**, making it fully compatible with Wireshark and other forensic tools for offline analysis.
- Requires **administrator privileges** to capture packets, which limits casual misuse but also means attackers with elevated access can weaponize it for credential harvesting on unencrypted protocols.
- WinDump is considered a **legacy tool** — WinPcap development stalled, and most modern deployments prefer Npcap-backed tools; however, it remains a recognized network forensics utility on Security+ objectives.

## Related concepts
[[tcpdump]] [[Wireshark]] [[WinPcap]] [[Packet Capture (PCAP)]] [[Network Forensics]]