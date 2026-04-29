# Intrusion Detection System

## What it is
Like a motion-sensor alarm in a museum that screams when someone walks past a painting but doesn't physically stop the thief — an IDS watches network traffic or host activity and *alerts* on suspicious behavior without actively blocking it. Precisely, an IDS is a security tool that monitors systems or networks for policy violations and known attack signatures, generating alerts for human or automated review.

## Why it matters
During the 2013 Target breach, attackers moved laterally from HVAC vendor credentials into the payment card environment over several days. A properly tuned network IDS monitoring east-west traffic for unusual SMB connections or large data staging could have flagged this movement before 40 million card numbers were exfiltrated — illustrating that detection speed directly limits breach scope.

## Key facts
- **NIDS vs. HIDS**: Network IDS monitors traffic at a tap or span port; Host IDS monitors logs, file integrity, and processes on a single endpoint.
- **Signature-based detection** matches traffic against known attack patterns (low false positives, blind to zero-days); **anomaly-based detection** flags deviations from a baseline (catches novel attacks, higher false positive rate).
- An IDS is *passive* — it detects and alerts. An IPS (Intrusion **Prevention** System) sits inline and can drop malicious packets in real time.
- **True positive**: real attack correctly flagged. **False positive**: benign traffic wrongly flagged. Tuning reduces false positives but risks increasing **false negatives** (missed attacks).
- Common IDS tools include **Snort** (open-source, rule-based), **Suricata** (multi-threaded, NIDS/IPS), and **OSSEC** (HIDS focused on log analysis and file integrity).

## Related concepts
[[Intrusion Prevention System]] [[Security Information and Event Management]] [[Network Traffic Analysis]] [[Anomaly-Based Detection]] [[Signature-Based Detection]]