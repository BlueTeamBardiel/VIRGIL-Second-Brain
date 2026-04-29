# Continuous Monitoring

## What it is
Like a hospital's ICU where every patient is wired to sensors that alert nurses the *moment* vitals drift outside safe ranges — rather than checking in once per shift — continuous monitoring is the ongoing, automated collection and analysis of security data across an organization's systems, networks, and applications to detect threats and configuration changes in near real-time.

## Why it matters
In the 2020 SolarWinds attack, compromised software updates sat undetected in victim environments for months precisely because organizations lacked the visibility to notice unusual outbound traffic patterns to attacker-controlled domains. A mature continuous monitoring program with proper network traffic analysis and SIEM alerting would have flagged those anomalous DNS beacons far earlier, dramatically shrinking the attacker's dwell time.

## Key facts
- Continuous monitoring is a core requirement of the **NIST Risk Management Framework (RMF)** — Step 6 specifically mandates ongoing authorization and monitoring after system authorization
- **ISCM (Information Security Continuous Monitoring)** is defined by NIST SP 800-137 as maintaining ongoing awareness of vulnerabilities, threats, and security posture
- Key data sources include: SIEM logs, vulnerability scanner feeds, configuration management databases (CMDB), IDS/IPS alerts, and endpoint telemetry
- Monitoring effectiveness is measured by **Mean Time to Detect (MTTD)** and **Mean Time to Respond (MTTR)** — both are CySA+ exam targets
- Continuous monitoring differs from periodic audits: audits are point-in-time snapshots; monitoring provides persistent, dynamic visibility between formal reviews

## Related concepts
[[SIEM]] [[Risk Management Framework]] [[Vulnerability Management]] [[Threat Intelligence]] [[Security Baselines]]