# Local Data Staging

## What it is
Like a thief stacking jewelry in a pillowcase before slipping out the window, local data staging is the attacker's prep work between stealing data and actually exfiltrating it. Precisely: it is the technique (MITRE ATT&CK T1074.001) where an adversary aggregates, compresses, and/or encrypts collected data into a single location on the compromised host before transmitting it outside the network.

## Why it matters
During the 2020 SolarWinds breach, threat actors staged collected credentials and reconnaissance data locally in temp directories before exfiltration, buying time to compress and encrypt the payload to evade DLP tools that might flag large outbound transfers. Defenders who monitor for unusual write activity to staging directories — `%TEMP%`, `C:\Windows\Temp`, `/tmp` — can catch attackers in this preparatory phase before data ever leaves the network.

## Key facts
- **MITRE ATT&CK T1074.001** classifies this under "Data Staged: Local Data Staging" within the Collection tactic phase
- Attackers commonly use **RAR, 7-Zip, or zip** utilities to compress/encrypt staged data, generating suspicious child processes from unexpected parent processes
- Common staging locations include `%TEMP%`, `AppData\Roaming`, `/dev/shm`, and hidden directories to avoid casual inspection
- Detection focus: **anomalous file creation volume**, compression tool execution by non-standard users, and large files appearing in temp paths are key IOCs
- Staging often precedes **scheduled exfiltration** — attackers may wait for low-traffic windows (nights/weekends) to avoid bandwidth anomaly detection

## Related concepts
[[Data Exfiltration]] [[Collection (ATT&CK Tactic)]] [[Data Loss Prevention]] [[Archive Collected Data]] [[Indicator of Compromise]]