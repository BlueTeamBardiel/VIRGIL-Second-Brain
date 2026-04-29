# Honeynets

## What it is
Like a fake neighborhood built next to a real city — complete with decoy houses, fake residents, and wired streetlights recording every visitor — a honeynet is a network of multiple honeypots designed to simulate an entire realistic environment. Unlike a single honeypot, a honeynet creates a full ecosystem of decoy servers, workstations, and services that makes attackers believe they've infiltrated a legitimate network.

## Why it matters
In 2010, researchers used a honeynet to study the Conficker worm's behavior in the wild — observing exactly how it propagated, which ports it probed, and how it communicated with C2 servers, all without risking production systems. This intelligence directly informed defensive signatures and patch prioritization across global networks.

## Key facts
- A honeynet uses a **honeywall** (a gateway device) to control, capture, and log all traffic entering and leaving the decoy network without alerting attackers.
- Honeynets are classified as **high-interaction** deception systems — attackers engage with real (or near-real) OS instances, generating rich behavioral data.
- All traffic into a honeynet is **inherently suspicious** — no legitimate users should ever touch it, so any connection is worth investigating.
- Data captured includes attacker **tools, techniques, and procedures (TTPs)** — valuable for threat intelligence and improving SIEM detection rules.
- Honeynets carry **legal and operational risk**: if an attacker pivots from the honeynet to attack third parties, the organization may face liability (the "entrapment vs. enticement" distinction matters here).

## Related concepts
[[Honeypot]] [[Deception Technology]] [[Threat Intelligence]] [[Intrusion Detection System]] [[Network Traffic Analysis]]