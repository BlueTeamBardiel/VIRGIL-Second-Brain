# Orphaned Accounts

## What it is
Like a hotel keycard that still opens room 412 after the guest has checked out and gone home — an orphaned account is a user account that remains active in a system after the person who owned it no longer needs access (due to termination, role change, or departure). These accounts retain permissions but have no legitimate active owner monitoring or using them.

## Why it matters
In the 2020 SolarWinds breach, attackers leveraged dormant and orphaned service accounts to move laterally through networks without triggering alerts — because nobody was watching credentials that "nobody" was using. Orphaned accounts are prime targets for attackers because they generate no baseline activity patterns, making malicious use harder to detect through behavioral analytics.

## Key facts
- Orphaned accounts violate the **principle of least privilege** by maintaining access rights beyond their legitimate need period
- Formal remediation requires **account reconciliation** — periodically comparing active directory accounts against current HR records
- They are a key finding in **access reviews (user access reviews / recertification campaigns)**, required under frameworks like SOX, HIPAA, and ISO 27001
- Service and system accounts are especially dangerous when orphaned because they often carry **elevated privileges** and lack human owners to notice suspicious activity
- The **Security+ exam** categorizes orphaned accounts under Identity and Access Management (IAM) weaknesses, alongside over-provisioned and shared accounts

## Related concepts
[[Principle of Least Privilege]] [[Identity and Access Management]] [[Account Lifecycle Management]] [[Privilege Escalation]] [[Access Control Reviews]]