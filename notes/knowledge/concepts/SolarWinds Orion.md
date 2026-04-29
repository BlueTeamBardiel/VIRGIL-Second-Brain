# SolarWinds Orion

## What it is
Imagine a master key that opens every door in a building — and a thief secretly made a copy during manufacturing, before the key was ever handed to tenants. SolarWinds Orion is an IT infrastructure monitoring platform used by thousands of enterprises and government agencies to manage networks, servers, and applications. Because it requires deep system access to monitor everything, it became a perfect vehicle for a supply chain attack when adversaries compromised its build process.

## Why it matters
In 2020, threat actors (attributed to Russian SVR, tracked as APT29/Cozy Bear) inserted malicious code — dubbed **SUNBURST** — into a legitimate Orion software update (versions 2019.4 through 2020.2.1). Approximately 18,000 organizations downloaded the trojanized update, giving attackers a months-long, stealthy backdoor into targets including the US Treasury, DHS, and Fortune 500 companies before detection.

## Key facts
- **Supply chain attack**: The malware was embedded in the *official* signed build (SolarWinds.Orion.Core.BusinessLayer.dll), bypassing typical code-signing trust
- **SUNBURST dormancy**: The backdoor waited ~14 days after installation before activating, evading sandbox analysis that uses short observation windows
- **C2 via DNS**: SUNBURST used DNS-based command-and-control, blending into legitimate Orion traffic to avoid detection
- **Privilege level**: Orion runs with high-privilege service accounts, giving attackers near-unrestricted lateral movement capability once inside
- **Detection gap**: The intrusion went undetected for approximately **9 months** (March–December 2020), highlighting failures in behavioral monitoring and network segmentation

## Related concepts
[[Supply Chain Attack]] [[SUNBURST Malware]] [[Trusted Execution]] [[Lateral Movement]] [[Command and Control]]