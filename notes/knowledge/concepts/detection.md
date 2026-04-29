# detection

## What it is
Like a smoke detector that doesn't stop a fire but tells you one is burning, detection is the security function focused on identifying that an attack or compromise has occurred or is in progress. Precisely, it is the process of monitoring systems, networks, and behaviors to recognize indicators of compromise (IOCs), anomalies, or known attack signatures in real time or near-real time.

## Why it matters
During the 2020 SolarWinds supply chain attack, the malicious SUNBURST backdoor went undetected for roughly 9 months because defenders lacked visibility into anomalous DNS beacon traffic and lateral movement patterns. Organizations with mature SIEM deployments and behavioral analytics — specifically those hunting for unusual outbound connections to `avsvmcloud[.]com` — were able to detect and contain the threat faster once indicators were published.

## Key facts
- Detection relies on two core approaches: **signature-based** (matching known bad patterns) and **anomaly-based** (flagging deviations from baseline behavior); neither alone is sufficient.
- **Mean Time to Detect (MTTD)** is the primary KPI for detection effectiveness; industry average historically exceeds 200 days for breaches.
- SIEM tools aggregate logs from multiple sources and correlate events; **correlation rules** define what patterns constitute an alert.
- The **Pyramid of Pain** (David Bianco) ranks IOCs by attacker cost to change — TTPs (tactics, techniques, procedures) are hardest to change and most valuable to detect.
- Detection is distinct from **prevention** (blocking threats) and **response** (acting after detection); together they form the core of the NIST CSF five functions.

## Related concepts
[[SIEM]] [[indicators-of-compromise]] [[intrusion-detection-system]] [[anomaly-based-detection]] [[mean-time-to-detect]]