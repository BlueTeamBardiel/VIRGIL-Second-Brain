# Traffic Monitoring

## What it is
Like a tollbooth camera that logs every vehicle's license plate, speed, and lane — traffic monitoring is the continuous capture and analysis of network packets and flow data to detect anomalies, policy violations, and intrusions. It operates at multiple layers, from raw packet capture (full content) to NetFlow metadata (who talked to whom, when, and how much).

## Why it matters
During the 2020 SolarWinds breach, attackers used low-and-slow data exfiltration specifically designed to blend into normal traffic patterns. Organizations with robust traffic monitoring using behavioral baselines — rather than just signature detection — had a fighting chance of flagging the anomalous outbound connections to attacker-controlled domains before massive data loss occurred.

## Key facts
- **Full packet capture (PCAP)** vs. **NetFlow/IPFIX**: PCAP records everything (high storage cost), while NetFlow records only metadata — source/dest IP, port, protocol, byte counts, duration.
- **Promiscuous mode** must be enabled on a NIC (or a port mirror/SPAN port configured on a switch) for a sensor to capture traffic not destined for itself.
- **Baseline deviation** is the core detection strategy — flagging when a host suddenly sends 10× its normal outbound data is more powerful than matching known malware signatures.
- **East-west traffic** (lateral movement between internal hosts) is the blind spot most organizations miss; most legacy monitoring only watches north-south (perimeter) traffic.
- Tools like **Zeek (formerly Bro)** and **Wireshark** are standard exam references; Zeek generates high-level connection logs while Wireshark performs deep packet inspection interactively.

## Related concepts
[[Intrusion Detection System]] [[NetFlow Analysis]] [[Security Information and Event Management]] [[Packet Analysis]] [[Network Baseline]]