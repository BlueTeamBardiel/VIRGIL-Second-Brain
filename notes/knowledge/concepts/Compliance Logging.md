# Compliance Logging

## What it is
Like a bank's vault entry ledger that records every person who touched a safe-deposit box — timestamp, identity, duration — compliance logging is the systematic collection and retention of security-relevant event records to satisfy regulatory and legal requirements. It ensures organizations can prove *what happened, when, and who did it* to auditors, investigators, or courts. Unlike operational logging (focused on uptime), compliance logging is driven by frameworks like HIPAA, PCI DSS, or SOX, each dictating exactly what must be captured and for how long.

## Why it matters
During the 2013 Target breach investigation, forensic analysts needed card transaction logs and network access records to reconstruct how attackers moved from an HVAC vendor's credentials to the payment card environment. Without compliant, tamper-evident logs retained long enough, the attack timeline and scope would have been unrecoverable. Compliance logging gave investigators the audit trail needed to identify the breach vector and duration.

## Key facts
- **PCI DSS Requirement 10** mandates logging all access to cardholder data, failed login attempts, and privilege escalations — logs must be retained for **at least 12 months**, with 3 months immediately available.
- **HIPAA** requires audit controls (§164.312(b)) documenting access to ePHI; no specific retention period is set federally, but 6 years is the standard interpretation.
- Logs must be **tamper-evident** — write-once storage (WORM drives) or cryptographic hashing protects integrity for legal admissibility.
- **Syslog** (UDP 514 / TCP 6514 with TLS) is the standard protocol for forwarding logs to centralized SIEM systems like Splunk or IBM QRadar.
- NTP synchronization across all logging sources is critical — **time skew** in logs can invalidate forensic timelines in court.

## Related concepts
[[SIEM]] [[Audit Trails]] [[Log Management]] [[Chain of Custody]] [[PCI DSS]]