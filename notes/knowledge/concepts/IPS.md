# IPS

## What it is
Think of an IPS as a bouncer who doesn't just check IDs at the door (like a firewall) but also watches the dance floor and physically removes anyone throwing punches. An Intrusion Prevention System is an inline network security device that monitors traffic in real-time, detects malicious activity using signature, anomaly, or policy-based detection, and actively blocks or drops that traffic before it reaches its destination.

## Why it matters
In 2017, the WannaCry ransomware spread globally by exploiting the EternalBlue SMB vulnerability (MS17-010). Organizations with a properly configured IPS that had updated signatures for this exploit were able to automatically drop the malicious SMB packets at the network level, preventing lateral movement — even on unpatched systems — buying critical response time.

## Key facts
- **Inline deployment** is the defining characteristic: traffic physically flows *through* the IPS, enabling active blocking (contrasted with IDS, which monitors a traffic copy via SPAN port and can only alert)
- **Detection methods**: Signature-based (known threats, low false positives), Anomaly-based (statistical baselines, catches zero-days but higher false positives), and Policy-based (enforces rules regardless of signatures)
- **False positive risk**: Aggressive IPS rules can block legitimate traffic — a misconfigured IPS dropping valid HTTP POST requests can take down a web application
- **HIPS vs. NIPS**: Host-based IPS runs on individual endpoints and can inspect encrypted traffic after decryption; Network-based IPS operates at the perimeter or network segments
- **Common placement**: Behind the firewall, in front of critical servers, or at network segment boundaries — not at the outermost edge where raw internet noise would overwhelm it

## Related concepts
[[IDS]] [[Firewall]] [[SIEM]] [[Network Segmentation]] [[Signature-Based Detection]]