# User Account Management

## What it is
Think of it like a hotel keycard system — every guest gets a card that opens only their room, cards expire at checkout, and the front desk can deactivate any card instantly. User Account Management is the formal process of creating, modifying, monitoring, and terminating user accounts and their associated privileges throughout an identity's lifecycle within an organization's systems.

## Why it matters
In 2020, the SolarWinds breach was amplified because attackers leveraged orphaned service accounts with excessive privileges that no one had reviewed or deactivated. If organizations had enforced regular account audits and least-privilege principles, lateral movement would have been dramatically harder. Proper account lifecycle management is one of the highest-ROI defensive controls available.

## Key facts
- **Principle of Least Privilege (PoLP):** Accounts should have only the minimum permissions required to perform their function — nothing more.
- **Orphaned/Zombie Accounts:** Accounts belonging to terminated employees that remain active are a top attack vector; automated offboarding workflows close this gap.
- **Privileged Account Management (PAM):** Admin and service accounts require stricter controls — time-limited sessions, just-in-time (JIT) access, and dedicated monitoring.
- **Account Recertification:** Periodic access reviews (often quarterly) verify that each user's privileges still match their current role — a key compliance requirement under SOX, HIPAA, and PCI-DSS.
- **Default Accounts:** Factory-default accounts (e.g., `admin/admin`) must be renamed or disabled immediately upon deployment; they are trivially targeted by credential-stuffing tools.

## Related concepts
[[Identity and Access Management]] [[Principle of Least Privilege]] [[Privileged Access Management]] [[Role-Based Access Control]] [[Separation of Duties]]