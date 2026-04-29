# Serge

## What it is
Think of Serge like a security camera with a logbook built into the lens — it doesn't just watch, it records everything it sees in a structured, searchable way. Serge is an open-source network packet capture and logging tool designed to passively monitor network traffic and store session metadata in a SQLite database for later analysis. It operates at the network level, capturing flow data without requiring active probing or agents on endpoints.

## Why it matters
In a blue team investigation, a SOC analyst suspects lateral movement occurred three days ago but the SIEM only retained alerts, not raw traffic. If Serge was deployed on that network segment, analysts can query its SQLite database to reconstruct TCP/UDP sessions, identify beaconing patterns, and map which internal hosts communicated with a suspected C2 IP — turning a cold case into a reconstructable timeline without needing full PCAP storage.

## Key facts
- Serge performs **passive traffic capture**, meaning it generates no network noise and is invisible to active scanning tools
- Stores session metadata (IP pairs, ports, timestamps, byte counts) in **SQLite**, making it queryable without specialized tools
- Designed for **long-term retention** of flow data at lower storage cost than full PCAP solutions like Wireshark captures
- Particularly useful for **small/resource-constrained environments** that cannot afford enterprise NDR solutions like Zeek or Arkime
- Operates similarly to **NetFlow** analysis but is self-contained without requiring dedicated flow-exporting infrastructure

## Related concepts
[[Network Traffic Analysis]] [[Packet Capture (PCAP)]] [[NetFlow]] [[Zeek]] [[Security Onion]]