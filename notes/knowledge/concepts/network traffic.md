# network traffic

## What it is
Think of network traffic like the flow of cars on a highway — each packet is a vehicle carrying cargo (data), traveling between on-ramps (source IPs) and exits (destination IPs) along defined lanes (ports and protocols). Precisely, network traffic is the total volume of data packets transmitted across a network at any given time, characterized by source/destination addresses, protocols, ports, and payload content. It is the raw material that every detection, monitoring, and forensic tool ultimately analyzes.

## Why it matters
In the 2020 SolarWinds attack, malicious traffic blended seamlessly with legitimate HTTPS communications to exfiltrate data — a technique called "living off the land" that evaded signature-based tools entirely. Defenders who had established baseline traffic profiles (normal beaconing intervals, typical data volumes) were better positioned to detect the subtle anomalies the attackers left behind. This is why traffic analysis is a core skill in threat hunting and incident response.

## Key facts
- **Flow data vs. full packet capture:** NetFlow/IPFIX records metadata (who talked to whom, when, how much) without storing payloads; full PCAP captures everything but is storage-intensive
- **Protocols have expected port numbers:** deviations (e.g., HTTP running on port 4444 instead of 80) are a classic red flag for C2 channels
- **East-west traffic** (server-to-server inside a network) is as critical to monitor as north-south (internal-to-internet) — lateral movement hides in east-west flows
- **Baseline + anomaly detection:** Security+ and CySA+ both emphasize that knowing "normal" traffic patterns is prerequisite to identifying malicious deviations
- **Encrypted traffic analysis (ETA)** allows pattern-based detection without decryption using TLS metadata like certificate fields and packet timing

## Related concepts
[[packet analysis]] [[intrusion detection system]] [[NetFlow]] [[protocol analysis]] [[baseline]]