# Common Mistakes made by SOC Analysts

## What it is
Like a smoke detector that only alarms when the house is already ash, a SOC analyst who reacts without context misses the fire that matters. Common SOC analyst mistakes are recurring operational and cognitive errors that degrade threat detection quality — including alert fatigue-driven dismissals, poor triage prioritization, missing lateral movement indicators, and inadequate documentation of investigation steps.

## Why it matters
During the 2020 SolarWinds breach, threat actors dwelled inside networks for **up to 14 months** before detection — partially because analysts dismissed unusual outbound DNS queries as noise rather than investigating them as beaconing behavior. A single miscategorized alert, combined with poor escalation habits, can turn a containable intrusion into a catastrophic data breach.

## Key facts
- **Alert fatigue** is the #1 cognitive failure: analysts who process 500+ daily alerts begin auto-closing without investigation, increasing false negative rates dramatically
- **Scope creep in triage** — failing to correlate a single alert with related log sources (firewall, EDR, DNS) causes analysts to miss multi-stage attack chains
- **Inadequate baselines**: without a known-good behavioral baseline, analysts cannot distinguish anomalous from normal — making statistical deviation meaningless
- **Poor chain of custody documentation** during incident response makes forensic evidence inadmissible and timelines unrecoverable
- **Neglecting low-severity alerts**: attackers deliberately craft activity to score below escalation thresholds (living-off-the-land techniques abuse trusted binaries like `certutil.exe` or `wmic.exe`)

## Related concepts
[[Alert Fatigue]] [[Incident Response Lifecycle]] [[SIEM Tuning]] [[Threat Intelligence]] [[Log Analysis]]