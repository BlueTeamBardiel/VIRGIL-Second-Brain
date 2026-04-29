# Real-Time Monitoring

## What it is
Like a hospital's cardiac ICU where every heartbeat is displayed on a screen the moment it happens — not reviewed in a chart the next morning — real-time monitoring is the continuous, immediate collection and analysis of system, network, or user activity as it occurs. It enables defenders to detect and respond to threats within seconds or minutes rather than days, dramatically shrinking the attacker's dwell time.

## Why it matters
During the 2020 SolarWinds breach, attackers maintained access for nearly 9 months before discovery — a catastrophic failure of real-time visibility. A properly configured SIEM with real-time alerting on anomalous outbound DNS traffic or unusual service account behavior could have surfaced the intrusion far earlier, limiting the blast radius across thousands of organizations.

## Key facts
- **SIEM platforms** (e.g., Splunk, Microsoft Sentinel) are the primary tool for real-time monitoring, aggregating logs from endpoints, firewalls, and applications into a single correlated view
- **Mean Time to Detect (MTTD)** is the key metric real-time monitoring improves; the industry average dwell time without it exceeds 200 days
- Real-time monitoring supports **continuous security monitoring (CSM)**, a requirement under NIST SP 800-137 and a core CySA+ domain
- **Alerting thresholds and tuning** are critical — poorly tuned systems generate alert fatigue, causing analysts to miss genuine threats buried in noise
- Combines with **User and Entity Behavior Analytics (UEBA)** to detect insider threats and compromised credentials through behavioral baselines rather than static signatures

## Related concepts
[[SIEM]] [[Security Operations Center (SOC)]] [[Continuous Security Monitoring]] [[User and Entity Behavior Analytics (UEBA)]] [[Log Management]]