# QoS

## What it is
Think of QoS like a hospital triage system: trauma patients get immediate attention while sprained ankles wait — network traffic is prioritized the same way. Quality of Service (QoS) is a set of technologies and policies that manage network traffic to ensure critical applications receive guaranteed bandwidth, low latency, and reduced jitter. It classifies, marks, and queues packets based on predefined priority rules.

## Why it matters
Attackers exploit QoS mechanisms through **QoS marking manipulation** — if an attacker gains access to a network segment, they can re-mark their malicious traffic (e.g., setting DSCP bits to Expedited Forwarding) to ensure it receives priority processing, potentially pushing legitimate traffic into starvation conditions. This technique can also be used to degrade VoIP or video conferencing during a targeted denial-of-service operation without flooding the pipe entirely — a subtle, harder-to-detect attack vector.

## Key facts
- **DSCP (Differentiated Services Code Point)** is the modern standard for QoS marking, replacing the older IP Precedence model; it lives in the 6-bit ToS field of the IP header
- QoS can be weaponized for **traffic shaping attacks** where an adversary deprioritizes security tool telemetry (e.g., SIEM log forwarding) to create detection blind spots
- **DSCP trust boundaries** should be established at network edges — untrusted endpoints should never be allowed to self-mark their own traffic priority
- QoS misconfigurations can inadvertently create a **side channel**: traffic timing differences between priority queues can leak information about application behavior
- On Security+/CySA+, QoS appears in the context of **network hardening**, **VoIP security**, and **bandwidth management controls**

## Related concepts
[[DSCP Marking]] [[VoIP Security]] [[Traffic Shaping]] [[Denial of Service]] [[Network Segmentation]]