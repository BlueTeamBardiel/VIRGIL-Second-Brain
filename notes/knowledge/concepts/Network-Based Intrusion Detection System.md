# Network-Based Intrusion Detection System

## What it is
Like a security camera watching every car pass through a toll booth — recording license plates, flagging stolen vehicles, but never physically stopping anyone — a Network-Based Intrusion Detection System (NIDS) monitors network traffic passively, analyzing packets at strategic chokepoints and alerting administrators when suspicious patterns emerge. It detects threats in transit without actively blocking them, distinguishing it from its prevention-focused sibling (NIPS).

## Why it matters
During the 2013 Target breach, attackers moved laterally across the internal network for weeks before exfiltration. A properly tuned NIDS placed at internal segment boundaries — not just the perimeter — could have flagged anomalous east-west traffic volumes and command-and-control beacon patterns, giving defenders a detection window to respond before 40 million card numbers were stolen.

## Key facts
- NIDS operates in **promiscuous mode**, capturing all traffic on a network segment, not just traffic addressed to itself
- Uses two primary detection methods: **signature-based** (matches known attack patterns — low false positives, misses zero-days) and **anomaly-based** (establishes baselines, flags deviations — catches novel attacks but higher false positive rate)
- Typically deployed at **network taps or SPAN ports** on switches, ensuring it sees a copy of traffic without being inline
- **Cannot inspect encrypted traffic** (TLS/HTTPS) without additional decryption capabilities — a growing blind spot as encryption adoption increases
- Generates **alerts only** — it has no blocking capability; response requires integration with firewalls, SOC analysts, or SOAR platforms

## Related concepts
[[Intrusion Prevention System]] [[Signature-Based Detection]] [[Anomaly-Based Detection]] [[Security Information and Event Management]] [[Packet Capture]]