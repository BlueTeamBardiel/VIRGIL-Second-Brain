# Network-Based Intrusion Detection

## What it is
Like a security camera watching every hallway in a building rather than guarding a single door, a Network-based Intrusion Detection System (NIDS) monitors traffic flowing across network segments rather than protecting individual hosts. It captures and analyzes packets in real time, flagging suspicious patterns against known attack signatures or behavioral baselines — but it only alerts, never blocks.

## Why it matters
During the 2013 Target breach, attackers moved laterally from an HVAC vendor connection toward payment card systems. A properly tuned NIDS watching internal east-west traffic could have flagged the anomalous SMB scanning and unusual data flows long before 40 million card numbers were exfiltrated, giving defenders a critical intervention window.

## Key facts
- **Placement matters**: NIDS sensors are typically positioned behind the firewall on a SPAN port or network tap to see decrypted internal traffic — placing one only at the perimeter misses lateral movement entirely.
- **Detection methods**: Signature-based detection matches known attack patterns (fast, low false negatives) while anomaly-based detection flags deviations from baselines (catches zero-days, higher false positives).
- **Passive architecture**: NIDS operates in promiscuous mode and generates alerts only — it cannot drop packets or terminate sessions (that's the job of a NIPS, its active cousin).
- **Encrypted traffic blind spot**: With TLS 1.3 widespread, NIDS cannot inspect payload content without SSL/TLS inspection infrastructure, forcing reliance on metadata analysis (JA3 fingerprints, flow timing, certificate fields).
- **Common tools**: Snort and Suricata are the dominant open-source NIDS platforms; both use rule-based signature engines and appear frequently on Security+/CySA+ exam objectives.

## Related concepts
[[Host-Based Intrusion Detection]] [[Security Information and Event Management]] [[Signature vs Anomaly Detection]] [[Network Tap and SPAN Port]] [[Intrusion Prevention Systems]]