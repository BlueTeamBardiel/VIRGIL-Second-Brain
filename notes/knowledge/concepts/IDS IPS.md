# IDS IPS

## What it is
Think of an IDS as a security camera that records a break-in and alerts the guard *after* it happens, while an IPS is a guard standing at the door who physically stops the intruder mid-step. An Intrusion Detection System (IDS) passively monitors network traffic and logs/alerts on suspicious activity without blocking it; an Intrusion Prevention System (IPS) sits inline in the traffic flow and can actively drop malicious packets in real time.

## Why it matters
During the 2013 Target breach, attackers moved laterally across the network for weeks before detection. A properly tuned inline IPS with behavioral rules could have flagged and blocked the unusual point-of-sale traffic exfiltrating card data to an internal staging server — stopping the breach rather than merely logging it.

## Key facts
- **IDS is out-of-band (passive)**; traffic flows past a tap/SPAN port — it sees a copy. **IPS is inline (active)**; all traffic passes *through* it, enabling blocking but creating a potential choke point or single point of failure.
- **Detection methods**: Signature-based (known attack patterns), Anomaly-based (deviations from a baseline), and Heuristic/Behavioral analysis. Signature-based misses zero-days; anomaly-based generates more false positives.
- A **false positive** = legitimate traffic flagged as malicious (disrupts business); a **false negative** = malicious traffic missed (security failure). Tuning balances these two risks.
- **HIDS** (Host-based) monitors a single endpoint's logs and file integrity; **NIDS** (Network-based) monitors traffic across a network segment.
- An IPS that fails **open** passes all traffic when it crashes (availability priority); one that fails **closed** blocks all traffic (security priority). Know which your organization requires.

## Related concepts
[[Firewall]] [[SIEM]] [[Network Traffic Analysis]] [[Defense in Depth]] [[Signature-Based Detection]]