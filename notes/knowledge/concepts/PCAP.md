# pcap

## What it is
Like a flight data recorder that captures every packet crossing a wire instead of cockpit instruments, pcap (packet capture) is a file format and API standard that records raw network traffic at the packet level for later analysis. Tools like Wireshark, tcpdump, and Zeek use the `.pcap` (or newer `.pcapng`) format to store full packet payloads, headers, and precise timestamps.

## Why it matters
During incident response after a suspected data exfiltration event, analysts replay a captured `.pcap` file to reconstruct exactly what data left the network — including plaintext credentials, file contents, or C2 beaconing patterns. Without pcap evidence, defenders are left reading logs that only show connection metadata, missing the actual payload content.

## Key facts
- **libpcap** (Linux/macOS) and **WinPcap/Npcap** (Windows) are the underlying capture libraries that most tools rely on; understanding the library matters for scripting custom capture tools
- pcap captures happen at Layer 2 (Data Link), meaning you see raw Ethernet frames including MAC addresses — not just IP/TCP headers
- **Promiscuous mode** must be enabled on a NIC to capture traffic not addressed to that host; on a switched network you additionally need port mirroring (SPAN port) or a network tap
- `.pcapng` (Next Generation) supports multiple interfaces, comments, and timestamps with nanosecond resolution — `.pcap` is legacy but still ubiquitous
- For Security+/CySA+: pcap analysis is a **protocol analyzer** technique used in both threat hunting and network forensics; Wireshark's display filters (e.g., `http.request.method == "POST"`) are distinct from capture filters written in BPF syntax

## Related concepts
[[Wireshark]] [[Network Forensics]] [[Promiscuous Mode]] [[Protocol Analysis]] [[Traffic Analysis]]