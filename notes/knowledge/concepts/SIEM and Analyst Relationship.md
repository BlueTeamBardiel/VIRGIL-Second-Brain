# SIEM and Analyst Relationship

## What it is
Think of a SIEM as a 911 dispatch center: it aggregates every incoming call (log), correlates patterns, and hands prioritized incidents to the analyst — but it's the human detective who decides if the "noise complaint" is actually a hostage situation. A Security Information and Event Management (SIEM) system collects, normalizes, and correlates log data from across an environment to surface alerts, while analysts provide the contextual judgment, threat intuition, and investigative action the machine cannot.

## Why it matters
During the SolarWinds supply chain attack, defenders with mature SIEM deployments were able to correlate unusual authentication patterns and lateral movement telemetry that individually looked benign. Analysts who understood their SIEM's baseline tuning could distinguish the attackers' "low and slow" behavior from normal admin activity — organizations without that human-SIEM partnership missed the breach for months.

## Key facts
- **SIEM functions**: log aggregation, normalization, correlation rules, alerting, and long-term retention for forensic investigation
- **Analyst's role**: triage alerts (true positive vs. false positive), investigate root cause, escalate or close incidents — the SIEM generates noise, the analyst generates signal
- **Alert fatigue** is the critical failure mode: over-tuned SIEMs produce thousands of low-fidelity alerts, causing analysts to miss real threats buried in the queue
- **Correlation rules vs. behavioral analytics**: traditional SIEMs use static rules (if X then alert); modern SIEMs add UEBA to detect anomalies without predefined signatures
- **Retention matters**: compliance frameworks (PCI-DSS, HIPAA) typically require 90-day online and 1-year archived log storage — SIEMs enforce this automatically

## Related concepts
[[Log Management]] [[Alert Triage]] [[Security Operations Center (SOC)]] [[UEBA]] [[Incident Response]]