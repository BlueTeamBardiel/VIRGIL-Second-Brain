# LOLBAS

## What it is
Like a burglar using your own house keys, ladder, and toolbox to rob you — LOLBAS (Living Off the Land Binaries, Scripts, and Libraries) refers to the attacker technique of weaponizing legitimate, pre-installed Windows system tools to execute malicious actions. These are trusted executables already present on the target system, signed by Microsoft, that can be abused to download files, execute code, or bypass security controls.

## Why it matters
In the SolarWinds attack, adversaries used `rundll32.exe` and `certutil.exe` — both native Windows binaries — to execute payloads and decode malicious content, helping them evade antivirus detection for months. Defenders must implement application whitelisting policies and behavioral monitoring rather than relying solely on signature-based detection, since these binaries are inherently "trusted."

## Key facts
- **certutil.exe** can download files from the internet and decode Base64 content — frequently abused for payload delivery
- **mshta.exe** executes HTML Applications (HTAs) and is commonly used to run remote malicious scripts
- **regsvr32.exe** (Squiblydoo attack) can bypass AppLocker by loading remote COM scriptlets via `/u /n /s /i:` switches
- LOLBAS techniques map to **MITRE ATT&CK T1218** (System Binary Proxy Execution) and sub-techniques
- The LOLBAS Project (lolbas-project.github.io) catalogs every known abusable Windows binary with documented attack functions
- Detection strategy: monitor for **abnormal parent-child process relationships** (e.g., Word spawning `mshta.exe`) and unusual network connections from system binaries

## Related concepts
[[Living off the Land (LotL)]] [[Application Whitelisting]] [[MITRE ATT&CK]] [[Defense Evasion]] [[LOLBins]]