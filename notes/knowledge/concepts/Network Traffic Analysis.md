# Network Traffic Analysis

## What it is
Like a customs inspector examining every shipping container entering a port — checking manifests, flagging anomalies, and pulling suspicious cargo for deeper inspection — Network Traffic Analysis (NTA) is the systematic capture and examination of packets moving across a network to identify threats, anomalies, and policy violations. It operates on both raw packet data (full packet capture) and summarized flow data (NetFlow/IPFIX) to reconstruct what happened on the wire.

## Why it matters
During the 2020 SolarWinds supply chain attack, defenders who had NTA in place were able to identify anomalous outbound DNS queries and beaconing patterns from compromised hosts — characteristic C2 behavior that endpoint tools missed entirely. Without traffic visibility, the malware's lateral movement went undetected for months in organizations that relied solely on host-based detection.

## Key facts
- **NetFlow vs. Full Packet Capture**: NetFlow records metadata (IPs, ports, bytes, duration) with low storage overhead; full PCAP captures actual payload content but requires significant storage — both are tested on CySA+
- **Baseline deviation** is the core detection method: you must know "normal" to recognize malicious — unusual port usage, unexpected protocols, or data exfiltration volumes trigger alerts
- **Protocol analyzers** (Wireshark, tcpdump) capture and decode PCAP files; **flow analyzers** (ntopng, SolarWinds NTA) work with summarized flow data
- **Encrypted traffic** doesn't make NTA useless — metadata analysis (JA3 fingerprints, certificate anomalies, timing patterns) still exposes malicious behavior like TLS-wrapped C2 channels
- **East-west traffic** (internal host-to-host) is as critical to monitor as north-south (perimeter) — ransomware and APTs rely heavily on lateral movement that only internal taps or span ports reveal

## Related concepts
[[Intrusion Detection System]] [[NetFlow Analysis]] [[Packet Capture]] [[Command and Control]] [[Security Information and Event Management]]