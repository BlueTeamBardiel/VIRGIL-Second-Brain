# Living off the Land

## What it is
Like a burglar who breaks into your house and uses *your own kitchen knives* instead of bringing weapons from outside, Living off the Land (LotL) is an attack technique where adversaries exclusively use legitimate, pre-installed system tools — PowerShell, WMI, certutil, mshta — to conduct malicious operations without dropping custom malware on disk.

## Why it matters
In the 2020 SolarWinds supply chain attack, attackers used native Windows tools and signed binaries to move laterally and exfiltrate data, bypassing traditional AV solutions that were looking for known malicious files. Because the tools used (PowerShell, WMI) are the same ones administrators use daily, distinguishing attack from legitimate admin activity becomes the core defensive challenge.

## Key facts
- **LOLBins (Living off the Land Binaries)** are the specific signed, trusted executables abused — examples include `certutil.exe`, `regsvr32.exe`, `mshta.exe`, and `rundll32.exe`
- LotL attacks are highly effective against **signature-based detection** because no novel malware binary exists to fingerprint
- **Fileless malware** is a closely related technique — payloads live in memory or the registry, never touching disk, making forensic recovery harder
- Defense relies on **behavioral analytics and anomaly detection** (e.g., UEBA, EDR tools) — watching *what* trusted tools do, not just *what* they are
- MITRE ATT&CK catalogs LotL under tactics like **Execution (T1059)** and **Defense Evasion**, making it a recurring theme on CySA+ exam scenarios

## Related concepts
[[Fileless Malware]] [[PowerShell Attack Techniques]] [[MITRE ATT&CK Framework]] [[Defense Evasion]] [[Behavioral Analytics]]