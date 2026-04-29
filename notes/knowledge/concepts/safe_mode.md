# safe_mode

## What it is
Like a car's limp mode that disables non-essential systems to get you to a mechanic safely, Safe Mode boots an OS with only the minimum kernel drivers and services required to function. It deliberately strips away third-party software, network connections, and non-critical processes to create a minimal, controlled execution environment.

## Why it matters
During incident response, an analyst boots a compromised Windows host into Safe Mode to perform malware removal because many rootkits and persistent backdoors register as startup services that won't load in this stripped-down environment. Attackers have also weaponized Safe Mode itself — ransomware families like REvil force reboots into Safe Mode with Networking specifically to bypass endpoint detection and response (EDR) agents that don't run in Safe Mode, then encrypt files unimpeded.

## Key facts
- Windows Safe Mode loads only drivers listed in the `HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot` registry key — attackers can add malware entries here to persist even during Safe Mode boots
- Safe Mode with Networking enables network drivers and services, creating a wider attack surface than minimal Safe Mode
- **REvil/Sodinokibi** ransomware abuse: uses `bcdedit /set {current} safeboot network` to force Safe Mode reboot before encryption begins
- Forensic investigators use Safe Mode to examine systems because fewer processes are running, reducing the risk of evidence tampering by active malware
- EDR solutions like CrowdFalcon and SentinelOne have added Safe Mode sensor persistence specifically in response to ransomware abuse of this technique

## Related concepts
[[persistence_mechanisms]] [[incident_response]] [[ransomware]] [[rootkit]] [[endpoint_detection_and_response]]