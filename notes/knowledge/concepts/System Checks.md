# System Checks

## What it is
Like a pilot running through a pre-flight checklist before takeoff, system checks are structured verification routines that confirm a system's security posture is sound before operations begin — or continuously throughout runtime. Precisely: system checks are automated or manual processes that validate configuration integrity, patch status, running services, and baseline compliance against a known-good state.

## Why it matters
During the SolarWinds supply chain attack, threat actors modified build processes so that the legitimate software *itself* became malicious — proper system integrity checks comparing cryptographic hashes of binaries against trusted baselines could have flagged the tampered Orion updates before deployment. Organizations with mature File Integrity Monitoring (FIM) had a fighting chance; those relying on blind trust did not.

## Key facts
- **FIM tools** (e.g., Tripwire, AIDE) perform system checks by hashing critical files and alerting on unauthorized changes — a direct exam topic for CySA+
- System checks are a core component of **configuration management** and map to NIST SP 800-53 controls under the CM family
- **OVAL (Open Vulnerability and Assessment Language)** is a standardized schema used to express system check definitions for automated compliance scanning
- Security+ distinguishes between *agent-based* checks (software installed on the endpoint) and *agentless* checks (performed remotely via SSH, WMI, or SNMP) — each has different blind spots
- A failed system check during a **credentialed vulnerability scan** (e.g., Nessus with admin rights) returns far more accurate results than an uncredentialed scan, catching misconfigurations FIM alone might miss

## Related concepts
[[File Integrity Monitoring]] [[Vulnerability Scanning]] [[Configuration Management]] [[Baseline Configuration]] [[SCAP]]