# intrusion detection systems

## What it is
Like a security guard who watches the cameras and radios for backup but never physically stops anyone, an IDS monitors network traffic or host activity for suspicious patterns and generates alerts — but takes no blocking action itself. It is a passive monitoring tool that compares observed behavior against known attack signatures (signature-based) or deviations from a baseline (anomaly-based) to identify potential threats.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network for weeks before detection. A properly tuned network-based IDS (NIDS) monitoring east-west traffic between POS systems and internal servers could have flagged the anomalous data exfiltration patterns long before 40 million card numbers left the building — if someone had acted on the alerts.

## Key facts
- **NIDS vs. HIDS**: Network-based IDS monitors traffic at a network tap or span port; Host-based IDS monitors logs, file integrity, and processes on a single endpoint
- **Signature-based detection** has low false positives but cannot detect zero-day attacks; **anomaly-based detection** can catch novel threats but generates more false positives
- An IDS *detects and alerts* only — an IPS (Intrusion Prevention System) sits inline and can actively *block* traffic; this is the most tested distinction on Security+
- **False positive**: legitimate traffic flagged as malicious; **false negative**: malicious traffic that goes undetected — tuning an IDS is the art of balancing these two
- Common deployment locations: behind the firewall (to catch what got through), at the DMZ boundary, and on critical internal segments

## Related concepts
[[intrusion prevention systems]] [[SIEM]] [[network traffic analysis]] [[anomaly-based detection]] [[indicators of compromise]]