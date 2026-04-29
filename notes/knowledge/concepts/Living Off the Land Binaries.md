# living off the land binaries

## What it is
Like a burglar who breaks into your house and uses *your own kitchen knives* instead of bringing weapons from outside, LOLBins are legitimate, pre-installed system tools that attackers repurpose to execute malicious actions. Specifically, they are trusted OS binaries (e.g., `certutil.exe`, `mshta.exe`, `regsvr32.exe` on Windows) that bypass security controls because defenders expect them to run legitimately.

## Why it matters
During the SolarWinds supply chain attack, adversaries used `rundll32.exe` and WMI — both native Windows tools — to execute payloads and move laterally, making detection extremely difficult because no foreign malware binaries were dropped to disk. This is precisely why traditional signature-based AV failed: there was nothing "new" to flag. Defenders must pivot to behavioral analytics that detect *anomalous use* of trusted tools, not just the presence of known malware.

## Key facts
- **LOLBAS Project** (lolbas-project.github.io) catalogs Windows LOLBins; the equivalent for Linux is **GTFOBins**
- Common Windows examples: `certutil.exe` (download files), `mshta.exe` (execute HTML applications), `regsvr32.exe` (bypass AppLocker), `wmic.exe` (lateral movement)
- LOLBin attacks are **fileless** in nature — payloads often run in memory, leaving minimal forensic artifacts on disk
- Detected primarily through **behavioral analysis**, EDR telemetry, and SIEM correlation rules rather than signature scanning
- Mitigations include **Application Control policies** (Windows Defender Application Control / AppLocker), disabling unnecessary binaries, and monitoring command-line argument anomalies via Sysmon Event ID 1

## Related concepts
[[fileless malware]] [[application whitelisting]] [[MITRE ATT&CK]] [[endpoint detection and response]] [[privilege escalation]]