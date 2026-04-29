# Beacon

## What it is
Like a prisoner blinking in Morse code from a window at scheduled intervals, a beacon is malware-infected host that periodically "checks in" with an attacker's command-and-control (C2) server. It sends small, regular signals over the network — often disguised as normal traffic — to receive instructions, exfiltrate data, or confirm continued access.

## Why it matters
During the SolarWinds attack, compromised SUNBURST malware beaconed to attacker-controlled domains using randomized intervals and legitimate-looking HTTP traffic to evade detection. Defenders who monitored for consistent, low-volume outbound connections to unusual domains were able to identify the pattern — demonstrating that hunting for beaconing behavior is a critical SOC skill.

## Key facts
- **Jitter** is the deliberate randomization of beacon timing intervals (e.g., ±30% of a base interval) to defeat simple pattern-matching detection rules
- Beacons commonly use **HTTP/HTTPS, DNS, or ICMP** as carrier protocols to blend into normal traffic
- Security analysts hunt beacons by looking for **long connection duration + low data volume + regular periodicity** in netflow data
- A beacon interval as short as **every few seconds** is considered aggressive; intervals of **hours or days** are used for stealth ("slow and low")
- Tools like **Cobalt Strike** generate beacons by default and are frequently used by both red teams and real threat actors — making C2 beacon signatures a common SIEM detection target

## Related concepts
[[Command and Control (C2)]] [[Cobalt Strike]] [[DNS Tunneling]] [[Netflow Analysis]] [[Indicators of Compromise]]