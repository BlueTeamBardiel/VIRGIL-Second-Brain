# audit trail tampering

## What it is
Like a burglar erasing their footprints in the snow after breaking into a house, audit trail tampering is the deliberate modification, deletion, or corruption of log files and records to conceal unauthorized activity. Precisely defined, it is any action taken to alter the integrity of audit logs — including event logs, access records, or transaction histories — to prevent forensic reconstruction of an attacker's actions.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the network for weeks; investigators relied heavily on preserved log data to reconstruct the attack timeline. Had the attackers successfully cleared Windows Event Logs and network flow records, attribution and scope determination would have been nearly impossible, significantly delaying containment. This is why log forwarding to a write-protected, centralized SIEM is considered a foundational control — it removes the attacker's ability to erase evidence from the system they've compromised.

## Key facts
- **Privilege escalation enables tampering**: Attackers typically need admin/root privileges to clear logs; the Windows command `wevtutil cl System` wipes the System event log entirely.
- **Log forwarding is the primary defense**: Sending logs in real-time to a remote, hardened syslog server or SIEM means local log deletion no longer destroys evidence.
- **Indicators of tampering include gaps**: A sudden absence of log entries, sequence number breaks, or timestamp discontinuities are red flags during forensic analysis.
- **WORM storage enforces integrity**: Write Once, Read Many storage solutions prevent any modification of log data after initial writing — a hardware-enforced chain of custody.
- **Regulatory frameworks require log integrity**: PCI-DSS Requirement 10.5 and HIPAA explicitly mandate tamper-evident logging mechanisms and audit trail retention periods.

## Related concepts
[[log management]] [[SIEM]] [[chain of custody]] [[least privilege]] [[forensic investigation]]