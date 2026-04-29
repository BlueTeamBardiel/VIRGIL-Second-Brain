# MITRE ATT&CK Technique T1218 - Signed Binary Proxy Execution

## What it is
Like a criminal borrowing a police uniform to walk through a checkpoint unchallenged, attackers use legitimate, Microsoft-signed binaries to execute malicious code — borrowing the binary's trusted reputation to bypass security controls. T1218 describes the abuse of trusted system utilities (like `mshta.exe`, `regsvr32.exe`, or `rundll32.exe`) to proxy the execution of attacker-controlled payloads, evading application whitelisting and signature-based detection.

## Why it matters
During the Squiblydoo attack technique, adversaries use `regsvr32.exe` to fetch and execute a remote scriptlet (`.sct` file) — a payload that never touches disk as a standalone executable, bypassing AppLocker rules entirely. Defenders who only monitor for unsigned binaries or block unknown executables miss this attack completely because `regsvr32.exe` is a legitimate Windows component.

## Key facts
- **Sub-techniques include:** `mshta.exe` (T1218.005), `regsvr32.exe` (T1218.010), `rundll32.exe` (T1218.011), `certutil.exe` (T1218.013), and `msiexec.exe` (T1218.007), among others
- **Defense evasion focus:** Primary tactic is Defense Evasion — specifically bypassing application whitelisting (AppLocker, WDAC) and signature-based AV
- **LOLBins:** These are "Living off the Land Binaries" — legitimate OS tools weaponized to avoid introducing foreign executables
- **Detection approach:** Monitor process creation events for unusual parent-child relationships (e.g., `Word.exe` spawning `mshta.exe`) and anomalous command-line arguments on trusted binaries
- **Certutil abuse:** `certutil.exe` can decode Base64 and download files, making it a popular downloader proxy despite being a certificate management tool

## Related concepts
[[Living off the Land (LOLBins)]] [[Application Whitelisting Bypass]] [[Defense Evasion Tactics]] [[Process Injection]] [[AppLocker]]