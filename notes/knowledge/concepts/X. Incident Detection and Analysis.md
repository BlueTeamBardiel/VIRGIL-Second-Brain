# X. Incident Detection and Analysis

## What it is
Like a hospital triage nurse who must distinguish a sprained ankle from a heart attack before calling a code blue, incident detection and analysis is the process of identifying potential security events and determining whether they represent actual threats requiring escalation. It involves collecting data from logs, alerts, and sensors, then applying context to separate genuine incidents from false positives.

## Why it matters
During the 2020 SolarWinds attack, malicious activity hid inside legitimate software update traffic for months — defenders who relied solely on perimeter alerts missed it entirely. Organizations with mature detection capabilities using behavioral baselines and SIEM correlation rules were able to spot anomalous lateral movement patterns that signature-based tools ignored.

## Key facts
- **NIST SP 800-61** defines the incident response lifecycle: Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-Incident Activity
- **IoCs (Indicators of Compromise)** such as unusual outbound traffic, unexpected privileged account logins, and file hash matches are primary detection signals
- **Mean Time to Detect (MTTD)** is the key metric here — industry average is ~200 days for a breach, making early detection high-value
- **SIEM systems** correlate logs from multiple sources (firewall, endpoint, DNS) to surface incidents that individual tools miss; rules and baselines drive alert fidelity
- Incidents are classified by **severity levels** (P1–P4 or Critical/High/Medium/Low) during analysis to prioritize response resources and escalation paths

## Related concepts
[[Security Information and Event Management (SIEM)]] [[Indicators of Compromise (IoC)]] [[NIST Incident Response Framework]] [[Log Analysis]] [[Threat Intelligence]]