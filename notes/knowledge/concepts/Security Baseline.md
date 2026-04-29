# Security Baseline

## What it is
Like a doctor's chart recording your "normal" vital signs before surgery, a security baseline documents the known-good, minimum-acceptable configuration state of a system. It defines the standard settings, patch levels, and controls that every device of a given type must meet before deployment and maintain throughout its lifecycle.

## Why it matters
In the 2020 SolarWinds breach, attackers modified Orion software builds to blend in with normal network traffic — exactly the kind of deviation a properly monitored baseline would flag. Organizations with documented network and endpoint baselines could compare current behavior against known-good states and detect anomalous outbound connections faster than those flying blind.

## Key facts
- Baselines are distinct from hardening guides (like CIS Benchmarks): hardening *creates* the target state; a baseline *documents and measures* adherence to it over time.
- NIST SP 800-53 and NIST SP 800-70 both reference security configuration baselines as foundational to continuous monitoring programs.
- Configuration drift — when systems gradually deviate from their baseline — is one of the most common audit findings and a primary attack surface for privilege escalation.
- Security Content Automation Protocol (SCAP) tools (e.g., OpenSCAP) automate baseline compliance scanning by comparing live system configs against defined XCCDF/OVAL profiles.
- On the CySA+ exam, baseline anomaly detection specifically refers to using the baseline as a reference for behavioral analytics — not just configuration; this includes network traffic volume, login times, and process execution patterns.

## Related concepts
[[Configuration Management]] [[Hardening]] [[Continuous Monitoring]] [[SCAP]] [[Configuration Drift]]