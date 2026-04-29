# security monitoring

## What it is
Like a hospital's vital-signs dashboard that never stops watching heart rate, blood pressure, and oxygen levels so nurses catch deterioration before it becomes cardiac arrest — security monitoring is the continuous collection, analysis, and alerting on log and event data across an environment to detect threats in real time. It transforms raw telemetry from endpoints, networks, and applications into actionable intelligence.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations with mature security monitoring detected anomalous outbound connections from the SUNBURST backdoor to `avsvmcloud[.]com` — those without it remained compromised for months undetected. A tuned SIEM correlating DNS queries with process creation events was often the difference between a 15-minute and a 15-month dwell time.

## Key facts
- **SIEM** (Security Information and Event Management) is the core platform — it aggregates logs, normalizes them, and applies correlation rules to generate alerts
- **Mean Time to Detect (MTTD)** is the primary metric; industry average dwell time is ~21 days, meaning monitoring failures are costly
- **Log sources** should include at minimum: firewalls, DNS, authentication systems (Active Directory), and endpoint EDR telemetry
- **Continuous monitoring** is mandated by NIST SP 800-137 and is a core component of the RMF (Risk Management Framework)
- Alerts are triaged by severity (P1–P4) and investigated in a SOC; untuned rules generate **alert fatigue**, which causes analysts to miss real incidents

## Related concepts
[[SIEM]] [[log management]] [[incident response]] [[threat detection]] [[SOC operations]]