# GET2 Penetrator

## What it is
Like a locksmith's master key that quietly tests every door lock in a building before anyone notices it was there, GET2 Penetrator is a covert network scanning and exploitation framework. It is a malicious toolkit — associated with state-sponsored threat actors, particularly those aligned with Russian intelligence operations — designed to perform stealthy reconnaissance and initial access against hardened network targets.

## Why it matters
GET2 Penetrator appeared in campaigns targeting industrial control systems and critical infrastructure networks, where defenders noted its ability to map internal network topology without triggering standard IDS signatures. A SOC analyst encountering anomalous low-and-slow ICMP and TCP probe patterns from an internal host may be observing GET2-style lateral reconnaissance, making behavioral detection far more valuable than signature-based alerts in this scenario.

## Key facts
- Associated with the **Sandworm** threat actor group (APT28-adjacent), linked to Russian GRU Unit 74455
- Operates using **low-frequency, randomized scanning** to evade threshold-based detection rules
- Capable of enumerating network services, identifying vulnerable hosts, and staging follow-on payload delivery
- Frequently deployed **post-initial compromise** to facilitate lateral movement, not as the initial intrusion vector
- Detection relies heavily on **anomaly-based behavioral analytics** (e.g., unusual internal scanning from a workstation) rather than static signatures

## Related concepts
[[Sandworm APT]] [[Lateral Movement]] [[Network Reconnaissance]] [[Behavioral Detection]] [[ICS Security]]