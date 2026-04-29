# log suppression

## What it is
Like a burglar disabling the security camera before breaking in, log suppression is when an attacker (or malware) intentionally disables, clears, or tampers with logging mechanisms to erase evidence of their activity. Precisely, it is any technique used to prevent security-relevant events from being recorded or to delete/alter existing log entries post-compromise.

## Why it matters
During the 2020 SolarWinds attack, the SUNBURST malware actively checked for the presence of security monitoring tools and suppressed its own logging footprint to avoid detection during its dwell time. This is why modern defenses emphasize **forwarding logs to a remote, write-protected SIEM in real time** — once logs leave the host, a local attacker can no longer suppress them retroactively.

## Key facts
- **Windows Event Log tampering** is a common technique; attackers use `wevtutil cl Security` to clear the Security event log, which itself generates Event ID 1102 — a detectable artifact.
- Log suppression maps to **MITRE ATT&CK T1070.001** (Indicator Removal: Clear Windows Event Logs) under the Defense Evasion tactic.
- A **centralized SIEM** with real-time log forwarding is the primary defense, because an attacker who owns the endpoint cannot erase logs already shipped offsite.
- **Log integrity monitoring** (e.g., using cryptographic hashing or WORM storage) can detect after-the-fact tampering even if logs weren't forwarded.
- On Linux systems, attackers commonly target `/var/log/auth.log` and use `shred` or direct file truncation — **auditd** can be configured to detect these actions.

## Related concepts
[[SIEM]] [[log tampering]] [[Defense Evasion]] [[MITRE ATT&CK]] [[audit logging]]