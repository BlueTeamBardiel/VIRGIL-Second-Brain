# NIDS

## What it is
Like a security guard watching camera feeds for the entire building rather than standing at one door, a Network Intrusion Detection System monitors traffic flowing across network segments rather than a single host. It passively analyzes packets in real-time, comparing them against known attack signatures or behavioral baselines to flag suspicious activity — without blocking traffic itself.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network after compromising an HVAC vendor's credentials. A properly tuned NIDS placed at internal network chokepoints could have detected the unusual internal scanning and bulk data movement toward the exfiltration staging server, triggering alerts before 40 million card numbers were stolen.

## Key facts
- **Passive by design**: NIDS detects and alerts but does *not* block traffic — that's NIPS (prevention). Confusing the two is a classic exam trap.
- **Placement matters**: Deployed on a network tap or SPAN port to see mirrored traffic; positioned outside the firewall sees all attacks, inside sees only what gets through.
- **Two detection methods**: Signature-based (fast, known threats, low false positives) vs. anomaly-based (catches zero-days, higher false positive rate).
- **Encrypted traffic blind spot**: Traditional NIDS cannot inspect TLS-encrypted payloads without SSL inspection/decryption infrastructure — a growing limitation.
- **Snort and Suricata** are the canonical open-source NIDS tools; Security+/CySA+ exam questions frequently reference these by name.

## Related concepts
[[HIDS]] [[NIPS]] [[Signature-Based Detection]] [[Anomaly-Based Detection]] [[SIEM]]