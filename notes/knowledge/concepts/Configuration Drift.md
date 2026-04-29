# Configuration Drift

## What it is
Like a ship's hull slowly accumulating barnacles until it can barely move, systems accumulate unauthorized changes over time — patches applied inconsistently, firewall rules added ad hoc, services enabled "temporarily" — until the actual state no longer matches the approved baseline. Configuration drift is the gradual, often unintentional divergence of a system's running configuration from its documented, security-hardened baseline.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors relied partly on the fact that many organizations had drifted from their baseline monitoring configurations — SIEM rules had been disabled, log forwarding had lapsed — making the backdoor traffic invisible for months. Regular configuration assessments using tools like SCAP scanners or CIS-CAT can detect drift before attackers exploit it.

## Key facts
- **Baseline comparison** is the core detection technique: tools diff the current state against a known-good configuration snapshot (e.g., using STIG or CIS Benchmarks as the reference).
- Configuration drift is a primary reason why **continuous monitoring** is mandated in frameworks like NIST SP 800-137 and RMF.
- **Immutable infrastructure** (replacing servers rather than patching them) is a modern architectural defense against drift in cloud environments.
- Drift is tracked using **SCCM, Ansible, Puppet, or Chef** in enterprise environments; unauthorized changes trigger alerts in a mature SecOps workflow.
- On the **CySA+ exam**, configuration drift appears under the "system and network architecture" and "vulnerability management" domains — know that it increases attack surface over time and undermines defense-in-depth.

## Related concepts
[[Security Baseline]] [[Vulnerability Management]] [[Continuous Monitoring]] [[Change Management]] [[SCAP]]