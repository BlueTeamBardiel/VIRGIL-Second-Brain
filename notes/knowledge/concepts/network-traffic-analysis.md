# network-traffic-analysis

## What it is
Like a customs inspector who reads the labels, weights, and timing of every shipping container without opening them, network traffic analysis examines packet metadata, flow data, and payloads to understand what's happening on a network. It is the systematic inspection of network communications to detect anomalies, identify threats, and reconstruct attack timelines. Tools like Wireshark, Zeek, and tcpdump capture and decode this data at varying levels of depth.

## Why it matters
During the 2020 SolarWinds supply chain attack, defenders used network traffic analysis to spot beaconing behavior — compromised hosts calling out to attacker-controlled domains at suspiciously regular intervals. By baselining normal DNS and HTTP patterns, analysts identified the SUNBURST malware's command-and-control traffic even when the malware itself evaded endpoint detection. Without traffic analysis, the dwell time (already averaging 12+ days) would have been catastrophically longer.

## Key facts
- **Flow analysis** (NetFlow/IPFIX) captures metadata — source/destination IP, ports, byte counts, duration — without storing full packet payloads, making it scalable for high-volume environments
- **Protocol anomalies** are a primary detection signal: DNS tunneling, for example, shows unusually long hostnames or high query volumes that deviate from baseline
- **Wireshark display filter** `tcp.flags.syn == 1 && tcp.flags.ack == 0` isolates SYN packets to detect port scans or SYN flood DoS attempts
- **Encrypted traffic analysis (ETA)** uses TLS handshake metadata, certificate details, and byte-length patterns to classify threats without decryption — critical as ~90% of modern traffic is encrypted
- On Security+/CySA+, NTA is directly tied to **anomaly-based detection**, **lateral movement identification**, and **data exfiltration** scenarios

## Related concepts
[[packet-capture]] [[intrusion-detection-systems]] [[dns-tunneling]] [[netflow-analysis]] [[baseline-and-anomaly-detection]]