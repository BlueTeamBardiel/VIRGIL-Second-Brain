# tcpdump

## What it is
Think of tcpdump as a court stenographer sitting on your network cable, transcribing every conversation that passes by in real time. It is a command-line packet analyzer that captures and displays network traffic by reading directly from a network interface, using the libpcap library to filter and inspect raw packets.

## Why it matters
During incident response, an analyst suspecting a compromised host can run `tcpdump -i eth0 -w capture.pcap` to silently record all outbound traffic, then later discover the host beaconing to a C2 server every 60 seconds over port 443. Without packet capture, that covert channel would have remained invisible — firewall logs would only show "allowed HTTPS traffic."

## Key facts
- **Basic capture syntax:** `tcpdump -i eth0 host 192.168.1.1 and port 80` captures only traffic matching both the IP and port filter (BPF syntax)
- **Write/read flags:** `-w file.pcap` saves raw packets to disk; `-r file.pcap` reads them back — both are essential for offline forensic analysis
- **Privilege requirement:** tcpdump requires root or CAP_NET_RAW capability to open network interfaces in promiscuous mode
- **Promiscuous mode** (`-p` disables it) causes the NIC to capture all packets on the segment, not just those addressed to the host — critical for hub-based or port-mirrored environments
- **Output verbosity:** `-v`, `-vv`, `-vvv` increase detail; `-X` displays both hex and ASCII payload, useful for spotting plaintext credentials or malware signatures

## Related concepts
[[Wireshark]] [[Network Protocol Analysis]] [[Packet Capture (PCAP)]] [[Berkeley Packet Filter]] [[Promiscuous Mode]]