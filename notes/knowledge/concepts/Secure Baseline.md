# Secure Baseline

## What it is
Like a doctor knowing your resting heart rate before diagnosing illness, a secure baseline is the documented "healthy normal" state of a system — its configuration, installed software, active ports, and running services — against which all future states are compared. It defines the minimum-security configuration a system must meet before deployment and throughout its lifecycle.

## Why it matters
In the 2020 SolarWinds attack, malicious DLL updates went undetected partly because organizations lacked baselines to recognize that new, unexpected processes were running on their network management servers. Had defenders maintained and continuously monitored against a known-good baseline, anomalous behavior would have triggered alerts far earlier in the kill chain.

## Key facts
- A secure baseline is established using hardening guides such as **CIS Benchmarks** or **DISA STIGs**, which define specific, measurable configuration requirements per OS or application
- Baselines address both **security posture** (disabled services, patched software, enforced password policies) and **performance state**, enabling dual-purpose anomaly detection
- **Configuration drift** — gradual deviation from the baseline due to patches, user changes, or misconfigurations — is monitored using tools like SCAP-compliant scanners (e.g., OpenSCAP, Nessus)
- On Security+/CySA+, baselines appear in the context of **change management**, **vulnerability management**, and **continuous monitoring** workflows
- Baselining is a core component of the **NIST Risk Management Framework (RMF)** Step 3 (Implement) and Step 4 (Assess), ensuring systems are configured to approved specifications before authorization

## Related concepts
[[Configuration Management]] [[Hardening]] [[Security Control Assessment]] [[Vulnerability Scanning]] [[Change Management]]