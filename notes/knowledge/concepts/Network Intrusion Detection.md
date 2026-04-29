# Network Intrusion Detection

## What it is
Like a smoke detector that doesn't put out fires but screams when it smells something burning, a Network Intrusion Detection System (NIDS) passively monitors traffic and alerts on suspicious activity without actively blocking it. It sits out-of-band on the network, analyzing packets against known attack signatures or behavioral baselines to identify potential threats in real time.

## Why it matters
In the 2013 Target breach, attackers moved laterally from HVAC vendor credentials to the payment card network. A properly tuned NIDS monitoring east-west traffic could have flagged the anomalous internal scanning and credential reuse before 40 million card numbers were exfiltrated — the breach went undetected for weeks.

## Key facts
- **Signature-based detection** matches traffic against known attack patterns (low false positives, blind to zero-days); **anomaly-based detection** flags deviations from baseline behavior (catches novel attacks, higher false positive rate)
- A NIDS operates in **promiscuous mode**, reading all packets on a segment regardless of destination MAC address
- Placement matters: a NIDS **outside the firewall** sees all inbound attacks; **inside the firewall** sees only what bypassed perimeter defenses — most deployments use both
- **True positive** = correctly identified attack; **false positive** = benign traffic flagged as malicious; tuning reduces false positives but risks increasing **false negatives**
- Common NIDS tools include **Snort** (rule-based, open source) and **Zeek** (formerly Bro; behavioral/protocol analysis) — both appear on CySA+ objectives
- A NIDS differs from a **NIPS** (Inline Prevention System) in that NIPS sits **in-band** and can drop malicious packets; NIDS only observes and alerts

## Related concepts
[[Signature-Based Detection]] [[Security Information and Event Management (SIEM)]] [[Network Intrusion Prevention System]] [[Anomaly-Based Detection]] [[Packet Capture and Analysis]]