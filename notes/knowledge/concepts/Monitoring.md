# monitoring

## What it is
Like a hospital's ICU with nurses watching every vital sign and alarm threshold, security monitoring is the continuous collection and analysis of system, network, and application data to detect anomalies and threats in real time. It transforms raw logs and traffic into actionable intelligence by correlating events against known baselines and threat signatures.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations *with* robust network monitoring detected anomalous outbound DNS requests to attacker-controlled domains — organizations *without* it went months without realizing compromised software was beaconing to command-and-control infrastructure. Effective monitoring turned a potential catastrophic breach into a containable incident for those who had it deployed.

## Key facts
- **SIEM (Security Information and Event Management)** is the core monitoring platform — it aggregates, normalizes, and correlates log data from across the environment to generate alerts
- **Baseline behavior** must be established before anomaly detection works; you can't spot abnormal without knowing normal (e.g., a server that suddenly transfers 10GB at 3AM)
- **Alert tuning** is critical — an untuned SIEM generating thousands of false positives causes alert fatigue, leading analysts to miss real threats
- **Log retention** policies matter for compliance (PCI-DSS requires 12 months; 3 months must be immediately available) and forensic investigations
- **Continuous monitoring** is a NIST requirement under the RMF (Risk Management Framework), meaning monitoring isn't a one-time activity but an ongoing control

## Related concepts
[[SIEM]] [[log management]] [[intrusion detection system]] [[threat hunting]] [[baseline]]