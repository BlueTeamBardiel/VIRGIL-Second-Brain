# IDS

## What it is
Like a security camera that records everything and triggers an alarm when it spots suspicious behavior — but doesn't physically stop anyone from entering. An Intrusion Detection System (IDS) monitors network traffic or host activity, analyzes it against known attack signatures or behavioral baselines, and generates alerts when anomalies are detected without actively blocking traffic.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network for weeks. A properly tuned network-based IDS monitoring east-west traffic could have flagged the unusual data staging behavior and exfiltration patterns, giving defenders a window to respond before 40 million card records were stolen.

## Key facts
- **NIDS vs. HIDS**: Network-based IDS monitors traffic at a network tap or span port; Host-based IDS monitors system calls, log files, and file integrity on individual endpoints
- **Detection methods**: Signature-based detection matches known attack patterns (low false positives, misses zero-days); Anomaly-based detection establishes a baseline and flags deviations (catches novel attacks, higher false positive rate)
- **Passive only**: IDS detects and alerts — it does *not* block; an IPS (Intrusion Prevention System) adds active blocking capability
- **Placement matters**: A NIDS placed outside the firewall sees all attacks; placed inside, it sees only what gets through — each position serves a different monitoring purpose
- **False positive vs. false negative tradeoff**: Tuning sensitivity too high floods analysts with noise; too low means missed detections — finding the right threshold is a core operational challenge

## Related concepts
[[IPS]] [[SIEM]] [[Network Monitoring]] [[Anomaly Detection]] [[Firewall]]