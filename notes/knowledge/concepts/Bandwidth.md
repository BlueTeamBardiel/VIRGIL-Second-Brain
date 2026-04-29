# Bandwidth

## What it is
Think of bandwidth like a highway: a 2-lane road moves fewer cars per hour than an 8-lane interstate, regardless of how fast each car drives. Bandwidth is the maximum amount of data that can be transmitted over a network link in a given time period, measured in bits per second (bps). It represents capacity, not speed — a critical distinction.

## Why it matters
In a volumetric DDoS attack, adversaries flood a target's network link with more traffic than its bandwidth can carry — say, 400 Gbps against a pipe rated for 10 Gbps — causing legitimate traffic to be dropped entirely. Defenders mitigate this upstream through ISP-level scrubbing centers or services like Cloudflare Magic Transit, which absorb the flood before it ever reaches the victim's network edge.

## Key facts
- Bandwidth is measured in **bits per second** (bps, Mbps, Gbps), not bytes — a 100 Mbps link transfers ~12.5 MB of data per second
- **Bandwidth vs. latency**: high bandwidth ≠ low latency; a satellite link can have 500ms latency with 100 Mbps bandwidth simultaneously
- **Bandwidth consumption** is a key metric in network baseline monitoring — sudden spikes can indicate data exfiltration or C2 beaconing (relevant to CySA+ anomaly detection)
- Volumetric DDoS attacks are classified by the **bandwidth they consume** (bits per second), distinguished from protocol attacks (packets per second) and application attacks (requests per second)
- **Traffic shaping and QoS** policies prioritize critical traffic when bandwidth is constrained, a defensive control to maintain availability during congestion

## Related concepts
[[DDoS Attacks]] [[Network Baseline]] [[Traffic Analysis]] [[Quality of Service]] [[Network Monitoring]]