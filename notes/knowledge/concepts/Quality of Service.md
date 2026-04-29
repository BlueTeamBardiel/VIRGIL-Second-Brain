# Quality of Service

## What it is
Like a highway with HOV lanes that let ambulances through even during rush hour, QoS is a network mechanism that prioritizes certain traffic types to guarantee bandwidth, low latency, or reliability. Precisely: QoS is a set of technologies and policies that manage network resources by assigning priority levels to different traffic classes (voice, video, data) to meet performance requirements.

## Why it matters
Attackers exploit QoS misconfigurations in VoIP environments by flooding a network with low-priority traffic to consume bandwidth, degrading call quality in a targeted DoS — a tactic called a "voice flood" attack. Defenders configure QoS policies that cap the bandwidth available to any single traffic class, preventing bulk data transfers from starving latency-sensitive applications like emergency communications or video surveillance feeds.

## Key facts
- **DSCP (Differentiated Services Code Point)** is the modern QoS marking standard; it uses 6 bits in the IP header to classify traffic into 64 possible priority levels
- **Traffic shaping** delays packets to smooth bursts; **traffic policing** drops packets that exceed a defined rate — policing is harsher but protects against flooding
- QoS misconfigurations can be exploited to **bypass security controls**: an attacker marking malicious traffic as high-priority may cause it to skip deep packet inspection queues
- **802.1p** (Layer 2) and **DSCP** (Layer 3) are the two primary QoS marking mechanisms — security policies must account for both layers
- In **unified communications**, QoS is a baseline requirement; without it, legitimate voice/video traffic becomes a vector for resource exhaustion attacks against critical services

## Related concepts
[[Denial of Service]] [[Traffic Analysis]] [[Network Segmentation]] [[VoIP Security]] [[Bandwidth Management]]