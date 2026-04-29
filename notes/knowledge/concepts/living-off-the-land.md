# living-off-the-land

## What it is
Like a survivalist who never visits a store — using only what's already in the forest — attackers use tools and binaries already installed on the target system to carry out their attack. Precisely, Living-off-the-Land (LotL) is an attack technique where threat actors leverage legitimate, pre-installed system utilities (called LOLBins — Living-off-the-Land Binaries) to execute malicious actions, avoiding the need to drop custom malware.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries used native Windows tools like `certutil.exe` and PowerShell to move laterally and exfiltrate data — no novel malware was dropped, causing traditional signature-based AV to remain completely silent. Defenders had to pivot to behavioral analytics and anomaly detection to even notice something was wrong, because every individual tool being used was "legitimate."

## Key facts
- Common LOLBins include `certutil.exe`, `mshta.exe`, `regsvr32.exe`, `wmic.exe`, and `PowerShell` — all legitimate Windows binaries frequently abused.
- LotL attacks are especially effective at evading antivirus and EDR tools that rely on signature-based detection, since no new malicious files are written to disk.
- The MITRE ATT&CK framework catalogs LotL techniques under multiple tactics including Execution (T1059), Defense Evasion, and Lateral Movement.
- Detection relies heavily on behavioral analysis: looking for unusual parent-child process relationships (e.g., Word spawning PowerShell) rather than file hashes.
- Application whitelisting (via AppLocker or WDAC) is one of the strongest preventive controls — if `mshta.exe` isn't needed, block it.

## Related concepts
[[LOLBins]] [[fileless-malware]] [[PowerShell-abuse]] [[application-whitelisting]] [[MITRE-ATT&CK]]