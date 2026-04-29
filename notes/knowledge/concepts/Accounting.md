# Accounting

## What it is
Like a bank statement that records every transaction so you can spot a fraudulent charge, accounting in cybersecurity is the third leg of the AAA framework — it records *what* authenticated users actually did and *when*. Precisely defined: accounting (also called auditing) is the process of tracking and logging user activities, resource access, and session data after authentication and authorization have occurred.

## Why it matters
In 2020, the SolarWinds breach went undetected for months partly because organizations lacked sufficient logging to correlate attacker lateral movement across systems. Robust accounting — capturing authentication events, privilege use, and network flows — would have surfaced the anomalous SAML token forging and unusual service account behavior far earlier, dramatically shrinking the attacker's dwell time.

## Key facts
- Accounting is the **"A"** in AAA alongside Authentication and Authorization — all three must work together; accounting alone is meaningless without the others
- Common accounting protocols include **RADIUS** (logs network access sessions) and **TACACS+** (logs every command executed on network devices, not just login events)
- Key data captured: session start/stop times, bytes transferred, commands issued, source IP, and resource accessed
- **Non-repudiation** depends on accounting — cryptographically signed logs prevent a user from denying they performed an action
- SIEM systems ingest accounting logs to enable correlation and alerting; without accounting data, a SIEM is essentially blind
- Log integrity matters: accounting records stored without tamper protection (e.g., write-once storage, hashing) can be deleted or altered by an attacker covering their tracks

## Related concepts
[[AAA Framework]] [[RADIUS]] [[TACACS+]] [[SIEM]] [[Non-Repudiation]] [[Audit Logs]]