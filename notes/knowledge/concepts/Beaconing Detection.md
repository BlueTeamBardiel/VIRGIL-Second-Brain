# Beaconing Detection

## What it is
Like a lost hiker firing a signal flare at regular intervals hoping rescue will find them, malware beaconing is a compromised host sending periodic, rhythmic check-in signals to a command-and-control (C2) server. Beaconing detection is the security practice of identifying these regular outbound communication patterns — consistent timing intervals, packet sizes, or destinations — that distinguish automated malware callbacks from normal human-generated traffic.

## Why it matters
During the SolarWinds SUNBURST attack, compromised hosts beaconed to attacker-controlled domains at randomized but statistically detectable intervals (every 12–14 days initially, then more frequently). Defenders who analyzed DNS query patterns and outbound traffic timing were able to identify infected hosts even when the malware mimicked legitimate traffic — demonstrating that statistical regularity, not just signatures, can expose advanced threats.

## Key facts
- **Jitter** is a deliberate randomization technique attackers add to beacon intervals (e.g., ±20% of the base interval) to evade time-based detection; defenders must account for this in detection logic
- Beacons often use common protocols (HTTP/S, DNS) over allowed ports to blend in — protocol analysis matters as much as port analysis
- Detection relies on **long-tail analysis**: aggregating connection logs over hours or days to find statistical regularity invisible in short windows
- A classic indicator: small, consistent packet sizes with no human-correlated timing (no beacons during business hours = automated, not user-driven)
- SIEM tools and NDR (Network Detection and Response) platforms use **frequency analysis** and machine learning to flag low-and-slow beaconing that signature-based IDS would miss

## Related concepts
[[Command and Control (C2)]] [[DNS Tunneling]] [[Network Traffic Analysis]] [[SIEM]] [[Indicators of Compromise (IoC)]]