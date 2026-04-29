# Configuration Enforcement

## What it is
Like a restaurant health inspector who doesn't just check kitchens once but returns unannounced to ensure standards haven't slipped, configuration enforcement continuously monitors and corrects system settings to ensure they match an approved baseline. It is the automated or procedural process of detecting configuration drift and remediating deviations — ensuring systems remain in a known, secure state rather than gradually degrading over time.

## Why it matters
In 2020, the SolarWinds attackers exploited misconfigured network monitoring rules that had drifted from their intended baselines, allowing lateral movement to go undetected for months. Had automated configuration enforcement been in place to detect and alert on or revert those deviations, the attacker's window of opportunity would have been dramatically narrowed.

## Key facts
- **Configuration drift** occurs when systems gradually deviate from their secure baseline due to patches, manual changes, or software updates — enforcement tools detect and correct this drift
- Tools like **SCAP** (Security Content Automation Protocol), **Chef**, **Puppet**, and **Ansible** are commonly used to enforce configurations at scale
- **CIS Benchmarks** and **STIG** (Security Technical Implementation Guides) provide the standardized baselines that enforcement tools compare against
- Enforcement can operate in two modes: **audit mode** (detect and alert only) or **enforcement mode** (automatically remediate deviations)
- Configuration enforcement is a key control for compliance frameworks including **PCI-DSS**, **NIST 800-53**, and **ISO 27001**, which require documented and maintained secure baselines

## Related concepts
[[Hardening]] [[Baseline Configuration]] [[Security Content Automation Protocol (SCAP)]] [[Change Management]] [[Continuous Monitoring]]