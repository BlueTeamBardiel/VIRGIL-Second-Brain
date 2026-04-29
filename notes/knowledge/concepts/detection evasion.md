# detection evasion

## What it is
Like a smuggler who dismantles contraband into innocent-looking parts to pass through customs separately, detection evasion is the collection of techniques attackers use to make malicious activity look benign to security tools. Precisely defined: it is any method that prevents intrusion detection systems, antivirus engines, EDR solutions, or human analysts from correctly identifying an attack in progress.

## Why it matters
During the 2020 SolarWinds supply chain attack, Sunburst malware lay dormant for up to two weeks after infection before calling home, deliberately mimicking legitimate Orion software traffic patterns and blending into normal business hours activity. Security teams had the logs the entire time but saw nothing alarming — the evasion was so effective that the breach went undetected for roughly nine months.

## Key facts
- **Living-off-the-land (LOtL):** Attackers abuse legitimate system tools like PowerShell, WMI, and certutil so that malicious commands are indistinguishable from normal admin activity.
- **Obfuscation vs. encryption:** Obfuscation scrambles code structure to fool signature scanners; encryption hides payload content in transit — both defeat different detection layers.
- **Timestomping** modifies file metadata timestamps to make malicious files appear to predate the attack window, defeating timeline-based forensic analysis.
- **Fragmentation and slow-and-low attacks** split traffic or throttle exfiltration speed to stay below volume-based alert thresholds in IDS/IPS signatures.
- **Process injection** (e.g., DLL injection, process hollowing) hides malicious code inside trusted processes like `svchost.exe`, bypassing application whitelisting controls.

## Related concepts
[[obfuscation]] [[living-off-the-land attacks]] [[indicator of compromise]] [[endpoint detection and response]] [[process injection]]