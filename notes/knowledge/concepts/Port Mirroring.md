# Port Mirroring

## What it is
Like a postal worker secretly making a photocopy of every letter passing through a sorting facility without the sender or recipient knowing, port mirroring duplicates all traffic flowing through a switch port and forwards that copy to a designated monitoring port. It is a switch-level feature (also called SPAN — Switched Port Analyzer) that enables passive, non-intrusive traffic inspection without disrupting the original data flow.

## Why it matters
A SOC analyst deploying a network IDS (like Snort or Zeek) connects the sensor to a SPAN port configured to mirror traffic from the core switch uplink. This allows the IDS to inspect every packet traversing the network in real time — catching lateral movement, beaconing malware, or data exfiltration — without sitting inline and risking performance degradation or becoming a single point of failure.

## Key facts
- **SPAN (local)** mirrors traffic on the same switch; **RSPAN (Remote SPAN)** extends mirroring across multiple switches using a dedicated VLAN; **ERSPAN** encapsulates mirrored traffic in GRE for transport across Layer 3 networks.
- Port mirroring is **passive** — the monitoring device receives copies but cannot inject traffic back into the mirrored segment.
- A misconfigured SPAN port that mirrors to an untrusted port represents a **data leakage vulnerability**, potentially exposing all switch traffic to an attacker with physical access.
- Network TAPs (Test Access Points) are the hardware alternative to port mirroring — they provide full-duplex capture and are considered more reliable for forensic-grade collection.
- Attackers who gain switch management access can configure rogue SPAN sessions for **covert network eavesdropping**, making switch hardening critical.

## Related concepts
[[Network TAP]] [[Intrusion Detection System (IDS)]] [[VLAN]] [[Packet Capture (PCAP)]] [[Network Traffic Analysis]]