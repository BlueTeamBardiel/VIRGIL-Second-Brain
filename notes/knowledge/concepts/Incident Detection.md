# Incident Detection

## What it is
Like a smoke detector that distinguishes between burnt toast and a house fire, incident detection is the process of identifying when anomalous activity crosses the threshold from noise into a genuine security event. It is the systematic monitoring of systems, logs, and network traffic to recognize indicators of compromise (IoCs) or attack (IoAs) in time to trigger a response.

## Why it matters
In the 2020 SolarWinds supply chain attack, malicious code beaconed out to attacker-controlled domains for *months* before detection — largely because the traffic mimicked legitimate Orion software behavior and flew under alert thresholds. Organizations with behavioral analytics and proper baselining caught the anomaly faster; those relying solely on signature-based detection missed it entirely.

## Key facts
- **Detection methods**: Signature-based (known patterns), anomaly-based (deviations from baseline), and behavior-based (heuristic/AI) are the three primary approaches tested on CySA+
- **Mean Time to Detect (MTTD)** is the key metric — industry average historically sits around 200+ days for data breaches (IBM Cost of a Data Breach Report)
- **SIEM systems** aggregate and correlate logs from multiple sources; they are the primary tool for centralized incident detection in enterprise environments
- **IoCs vs. IoAs**: IoCs are forensic artifacts (malicious IPs, file hashes); IoAs focus on attacker *behavior* in progress — detecting IoAs enables earlier intervention
- Detection feeds directly into the **NIST SP 800-61** incident response lifecycle: Preparation → **Detection & Analysis** → Containment → Eradication → Recovery

## Related concepts
[[Security Information and Event Management (SIEM)]] [[Indicators of Compromise]] [[Incident Response Lifecycle]] [[Anomaly-Based Detection]] [[Threat Intelligence]]