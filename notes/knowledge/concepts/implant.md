# implant

## What it is
Like a spy who gets a job at the embassy and quietly radios intelligence back to headquarters, an implant is malicious code installed on a compromised system that establishes persistent communication with an attacker. Technically, it is a stealthy piece of software embedded in a target environment that provides remote access, executes commands, and exfiltrates data while evading detection.

## Why it matters
In the 2020 SolarWinds attack, threat actors inserted a backdoor implant (SUNBURST) into legitimate software update packages, giving them persistent access to thousands of networks including U.S. government agencies for months before discovery. Defenders hunting for implants must look beyond signature detection — SUNBURST mimicked legitimate SolarWinds traffic patterns to blend into normal network noise.

## Key facts
- Implants differ from standard malware in their emphasis on **persistence and stealth** over immediate damage — they are designed to remain undetected long-term
- Common persistence mechanisms include registry run keys, scheduled tasks, DLL hijacking, and WMI subscriptions
- Implants typically use **command-and-control (C2) beaconing** — periodically phoning home at randomized intervals to receive instructions and evade timing-based detection
- Many advanced implants use **living-off-the-land (LotL)** techniques, executing through legitimate system tools like PowerShell or WMI to avoid triggering AV alerts
- Detection relies heavily on behavioral analytics: unusual outbound connections, process injection anomalies, and unexpected privileged account activity are key indicators of compromise (IoCs)

## Related concepts
[[command and control (C2)]] [[persistence mechanisms]] [[living off the land]] [[lateral movement]] [[indicators of compromise]]