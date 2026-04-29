# Intrusion Prevention System

## What it is
Like a bouncer who doesn't just identify troublemakers but physically blocks them at the door before they enter, an IPS sits **inline** on the network and actively drops malicious traffic in real time — not merely logging it. It is an active security control that inspects packets, matches them against threat signatures or behavioral baselines, and blocks, resets, or quarantines offending sessions automatically.

## Why it matters
In 2017-style EternalBlue exploit campaigns, attackers sent crafted SMB packets to propagate ransomware laterally across networks. A properly tuned IPS with up-to-date signatures would have detected the anomalous SMB exploit pattern and dropped those packets before they reached vulnerable hosts — breaking the kill chain at the lateral movement phase without requiring human intervention.

## Key facts
- **IPS vs. IDS**: IDS is passive (detect and alert only); IPS is inline and active (detect and block) — a classic Security+ distinction
- **Four detection methods**: Signature-based, anomaly-based (statistical baseline), policy-based, and reputation-based
- **False positive risk**: An aggressive IPS can block legitimate traffic; tuning sensitivity is critical to avoid business disruption
- **Deployment modes**: Network-based (NIPS) sits at the perimeter or core; Host-based (HIPS) runs on individual endpoints
- **Common evasion techniques attackers use**: Fragmentation, protocol obfuscation, and traffic encryption (encrypted payloads can blind signature-based IPS)

## Related concepts
[[Intrusion Detection System]] [[Signature-Based Detection]] [[Anomaly-Based Detection]] [[Next-Generation Firewall]] [[Defense in Depth]]