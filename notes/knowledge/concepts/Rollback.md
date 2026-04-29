# Rollback

## What it is
Like rewinding a DVR to before a power surge scrambled your recording, a rollback restores a system, application, or database to a previously known-good state. Precisely: it is the process of reverting software, firmware, or configuration to an earlier version, typically after a failed update, corruption, or security incident. It undoes recent changes, discarding anything applied after the chosen restore point.

## Why it matters
Attackers exploit rollback as an offensive technique — called a **downgrade attack** — by forcing a system to revert to an older, vulnerable version of a protocol or software (e.g., forcing TLS 1.3 down to TLS 1.0 to exploit known weaknesses like POODLE). Defensively, rollback is critical in incident response: when ransomware corrupts production systems, restoring from a clean snapshot is often faster than rebuilding from scratch, making verified, immutable backups essential.

## Key facts
- **Downgrade attacks** are the offensive abuse of rollback — SSL stripping and POODLE are canonical examples of protocol downgrade exploitation
- **Secure Boot** uses cryptographic signing to prevent unauthorized firmware rollbacks to vulnerable versions
- NIST SP 800-34 (Contingency Planning) recommends tested rollback procedures as part of BCP/DR planning
- **Database rollback** relies on transaction logs; attackers who corrupt logs can prevent recovery — protecting log integrity is critical
- Rollback capabilities should be tested *before* incidents; an untested backup is just hope, not a control
- Immutable backups (WORM — Write Once Read Many) prevent ransomware from corrupting the rollback target itself

## Related concepts
[[Downgrade Attack]] [[Backup and Recovery]] [[Patch Management]] [[Secure Boot]] [[Incident Response]]