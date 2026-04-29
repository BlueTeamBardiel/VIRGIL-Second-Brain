# SIEM Anomaly Detection

## What it is
Like a casino pit boss who memorizes every regular gambler's betting patterns and immediately spots when someone deviates — a SIEM anomaly detection system learns your network's "normal" baseline and fires alerts when behavior statistically diverges from it. Specifically, it uses correlation rules, machine learning, and behavioral baselines within a Security Information and Event Management platform to identify suspicious deviations in log data, user activity, or network traffic in near-real-time.

## Why it matters
During the 2020 SolarWinds supply chain attack, compromised systems communicated with attacker-controlled C2 servers at unusual hours using legitimate-looking traffic — exactly the kind of low-and-slow deviation that signature-based tools miss but behavioral anomaly detection is designed to catch. Organizations with properly tuned SIEM baselines had a measurably shorter dwell time because lateral movement and abnormal authentication patterns triggered alerts before exfiltration completed.

## Key facts
- **Baseline period** is typically 30–90 days of collected log data before anomaly detection becomes reliable; alerts fired before this window generate excessive false positives
- **True positive vs. false positive tradeoff** is the central tuning challenge — overly sensitive rules cause alert fatigue, causing analysts to ignore real threats
- SIEM anomaly detection relies on **log sources including**: Windows Event Logs, firewall logs, DNS queries, authentication logs (Active Directory), and endpoint telemetry
- **User and Entity Behavior Analytics (UEBA)** is the dedicated module for anomaly detection within modern SIEMs, scoring risk per user or device over time
- Common anomaly triggers for exams: **impossible travel** (logins from two geographically distant locations within minutes), **off-hours privileged access**, and **spike in failed authentication attempts**

## Related concepts
[[UEBA]] [[Log Aggregation]] [[Threat Hunting]] [[Correlation Rules]] [[Indicators of Compromise]]