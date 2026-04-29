# Network Monitoring

## What it is
Think of it like a cardiologist reading an EKG — not watching the heart itself, but watching the *signals* it produces to detect arrhythmias before a heart attack occurs. Network monitoring is the continuous collection and analysis of network traffic, device states, and performance metrics to detect anomalies, unauthorized activity, or failures in real time.

## Why it matters
In the 2020 SolarWinds attack, the malicious actors deliberately kept their traffic volumes low and mimicked legitimate Orion software behavior — staying beneath the threshold of most monitoring tools for months. Organizations with robust behavioral baselining and anomaly-based monitoring (rather than pure signature detection) had a measurably better chance of catching the lateral movement before data exfiltration completed.

## Key facts
- **SNMP (Simple Network Management Protocol)** is the foundational protocol for polling device health; SNMPv3 adds authentication and encryption — earlier versions send community strings in plaintext.
- **NetFlow/IPFIX** captures metadata about traffic flows (source, destination, bytes, duration) without storing full packet content — critical for bandwidth and anomaly analysis at scale.
- **Baseline establishment** is required before anomaly detection works; you cannot flag "unusual" without first defining "normal."
- **Promiscuous mode** must be enabled on a NIC for passive packet capture (used by tools like Wireshark/tcpdump) — otherwise the NIC discards frames not addressed to it.
- On Security+/CySA+, network monitoring is tied to **continuous security monitoring (CSM)** under NIST SP 800-137 — expect questions linking it to vulnerability management and incident response workflows.

## Related concepts
[[Intrusion Detection System]] [[NetFlow Analysis]] [[Security Information and Event Management]] [[Packet Capture]] [[Anomaly-Based Detection]]