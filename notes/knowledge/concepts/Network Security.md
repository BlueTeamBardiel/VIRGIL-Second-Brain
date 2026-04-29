# network security

## What it is
Think of network security like the combination of a city's walls, checkpoints, traffic cameras, and emergency response teams — each layer doing a distinct job to keep threats out and catch what slips through. Network security is the practice of implementing policies, technologies, and controls to protect the confidentiality, integrity, and availability of data as it moves across or resides within a network. It encompasses both perimeter defenses and internal monitoring.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and pushed malicious updates to ~18,000 organizations — once inside trusted networks, the malware moved laterally for months undetected. This breach demonstrated that perimeter-only thinking fails; internal segmentation and anomaly detection (zero trust principles) are essential to limit blast radius when an attacker inevitably gets in.

## Key facts
- **Defense in depth** requires multiple overlapping security layers — firewall, IDS/IPS, endpoint protection, and network segmentation — so no single failure grants full access
- **Network segmentation** using VLANs or subnets limits lateral movement; a compromised endpoint in the guest VLAN cannot reach the finance VLAN directly
- **IDS vs. IPS**: an Intrusion Detection System *alerts* on suspicious traffic; an Intrusion Prevention System *blocks* it inline — IPS adds latency but stops attacks automatically
- **The OSI model matters for attacks**: ARP poisoning targets Layer 2, IP spoofing targets Layer 3, TCP session hijacking targets Layer 4 — knowing the layer helps select the right control
- **Port security** on managed switches can restrict which MAC addresses communicate on a port, preventing rogue device connections and limiting DHCP starvation attacks

## Related concepts
[[firewall]] [[zero trust architecture]] [[intrusion detection system]] [[network segmentation]] [[defense in depth]]