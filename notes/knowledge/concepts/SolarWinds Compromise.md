# SolarWinds Compromise

## What it is
Imagine a trusted locksmith secretly copies a master key into every lock they install across thousands of buildings — that's the SolarWinds attack. Threat actors (APT29/Cozy Bear) injected malicious code called **SUNBURST** into the legitimate SolarWinds Orion software build pipeline, distributing a trojanized update to ~18,000 organizations worldwide between March–June 2020.

## Why it matters
Because the malicious DLL (`SolarWinds.Orion.Core.BusinessLayer.dll`) was cryptographically signed by SolarWinds itself, traditional signature-based defenses couldn't distinguish it from legitimate software. Attackers used it to establish persistent backdoors inside U.S. government agencies — including Treasury and CISA — and exfiltrated data for months before FireEye detected it in December 2020.

## Key facts
- **Supply chain attack vector**: Malware was inserted during the CI/CD build process, not through a direct network intrusion on victims
- **SUNBURST dormancy**: The backdoor waited 12–14 days before activating, specifically to evade sandbox analysis that typically runs shorter timeframes
- **C2 via DNS**: Command-and-control communication was disguised as legitimate Orion telemetry traffic using DNS beaconing to `avsvmcloud[.]com`
- **Affected ~18,000 organizations** received the trojanized update; roughly 100 were actively exploited for deeper access
- **Detection method**: FireEye discovered it while investigating the theft of their own red team tools — an anomalous device registration triggered an MFA alert

## Related concepts
[[Supply Chain Attack]] [[Advanced Persistent Threat]] [[Code Signing]] [[CI/CD Pipeline Security]] [[DNS Beaconing]]