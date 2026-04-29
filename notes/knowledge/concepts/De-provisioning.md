# De-provisioning

## What it is
Like cutting a hotel keycard the moment a guest checks out — de-provisioning is the formal process of revoking a user's access rights, credentials, and permissions when they no longer need them. It is the offboarding counterpart to provisioning, ensuring that accounts, certificates, and access tokens are disabled or deleted when a role ends, changes, or expires.

## Why it matters
In 2020, a former SolarWinds contractor retained active credentials months after their contract ended — a textbook de-provisioning failure that expanded the attack surface during an already catastrophic breach. Attackers frequently target "ghost accounts" — orphaned credentials from departed employees — because these accounts are rarely monitored and often retain elevated privileges. Timely de-provisioning directly reduces the window of opportunity for both insider threats and external attackers using stolen credentials.

## Key facts
- **Orphaned accounts** are the primary risk of failed de-provisioning — active credentials with no legitimate owner actively reviewing them.
- De-provisioning should be **triggered automatically** via HR system integration (joiner-mover-leaver workflows), not left to manual IT tickets.
- Scope includes: Active Directory accounts, email, VPN certificates, API keys, cloud IAM roles, MFA tokens, and physical badges.
- **Immediate vs. scheduled** deactivation matters — terminated employees (especially hostile ones) require same-day or same-hour revocation.
- Security+ exam frames de-provisioning within the **Identity and Access Management (IAM)** lifecycle alongside provisioning, privilege review, and account auditing.

## Related concepts
[[Identity and Access Management]] [[Principle of Least Privilege]] [[Account Lifecycle Management]] [[Orphaned Accounts]] [[Access Reviews]]