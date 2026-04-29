# ConformityCheck

## What it is
Like a building inspector who walks through a new house comparing every outlet and beam against the approved blueprints, a ConformityCheck verifies that a system's current configuration matches a defined, approved baseline. It is a compliance validation process that compares the actual state of a system (OS settings, installed software, security controls) against a documented standard such as CIS Benchmarks, STIG, or an internal policy. Deviations flag potential security drift or unauthorized changes.

## Why it matters
In 2020, the SolarWinds breach persisted partly because compromised build systems deviated from expected configurations without triggering alerts — conformity checks against known-good baselines could have detected anomalous changes in the build pipeline earlier. Defenders use automated conformity checking tools (like SCAP-compliant scanners) to continuously validate that hardened configurations haven't eroded due to patch updates, misconfiguration, or insider tampering. Catching a single disabled firewall rule or re-enabled guest account can stop lateral movement before it starts.

## Key facts
- Conformity checks are a core component of **configuration management** and **continuous monitoring** frameworks (NIST SP 800-137).
- Tools like **OpenSCAP**, **Microsoft Desired State Configuration (DSC)**, and **Chef InSpec** automate conformity checking against defined baselines.
- **STIG (Security Technical Implementation Guides)** and **CIS Benchmarks** are the most common reference baselines used in conformity checks for government and enterprise environments.
- A failed conformity check should trigger a **remediation workflow** — not just a log entry — to close the gap before it becomes an exploitable vulnerability.
- Conformity checking supports **PCI-DSS Requirement 10** and **NIST CSF Identify/Protect** functions by providing evidence of continuous compliance.

## Related concepts
[[Configuration Baseline]] [[SCAP]] [[Continuous Monitoring]] [[Hardening]] [[Vulnerability Management]]