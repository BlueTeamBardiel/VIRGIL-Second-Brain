# NDR - Network Detection and Response

## What it is
Think of NDR as a seasoned air traffic controller who doesn't just watch scheduled flights — it notices when a small plane starts flying erratic patterns that no legitimate pilot would. NDR is a security technology that continuously monitors network traffic using behavioral analytics, machine learning, and signature detection to identify threats that bypass perimeter controls. Unlike firewalls that enforce rules, NDR *observes patterns* across east-west and north-south traffic to detect anomalies in real time.

## Why it matters
During the SolarWinds supply chain attack, compromised software beaconed outward to attacker-controlled infrastructure using legitimate-looking HTTPS traffic — exactly the kind of subtle, low-and-slow behavior that signature-based tools miss. An NDR solution analyzing baseline communication patterns could flag that Orion servers were suddenly communicating with unusual external domains at odd intervals, triggering investigation before lateral movement escalated.

## Key facts
- NDR operates primarily on **full packet capture, flow data (NetFlow/IPFIX), and metadata** — not just logs — giving it visibility that SIEM alone cannot provide
- It detects threats using three methods: **signature-based detection, behavioral analytics (UEBA integration), and threat intelligence feeds**
- NDR covers **east-west (lateral) traffic** inside the network — critical for catching attackers who already bypassed the perimeter
- Part of the **SOC Visibility Triad** alongside EDR (endpoint) and SIEM (log management) — each covers blind spots the others miss
- NDR solutions typically baseline **normal traffic behavior over 1-4 weeks** before anomaly detection becomes reliable, making deployment patience critical

## Related concepts
[[EDR - Endpoint Detection and Response]] [[SIEM]] [[Network Flow Analysis]] [[Zero Trust Architecture]] [[Lateral Movement]]