# Audit and Accountability

## What it is
Like a casino's eye-in-the-sky camera system that records every hand dealt and every chip moved, audit and accountability is the security practice of logging user and system actions so that any event can be traced back to a specific identity. It encompasses the creation, protection, and review of audit logs to ensure non-repudiation — meaning no one can deny their actions after the fact.

## Why it matters
In the 2013 Target breach, attackers moved laterally through the network for weeks before detection. Robust audit logging with real-time alerting would have flagged the unusual HVAC vendor account accessing point-of-sale systems — a textbook case where accountability controls could have compressed the attacker's dwell time from weeks to hours.

## Key facts
- **NIST SP 800-53 AU control family** defines Audit and Accountability as a formal control category, covering log generation, review, protection, and retention
- Logs must capture **who, what, when, and where**: user ID, action taken, timestamp, and source system
- **Non-repudiation** is the core security goal — achieved through cryptographic signing of logs or write-once storage (WORM)
- **Log integrity** is as important as log existence; attackers routinely clear or modify logs (e.g., `wevtutil cl System`) to cover tracks
- SIEM platforms aggregate logs for correlation; Security+ exam often pairs audit controls with **detective controls** in the control category taxonomy

## Related concepts
[[Non-Repudiation]] [[SIEM]] [[Log Management]] [[Access Control]] [[Incident Response]]