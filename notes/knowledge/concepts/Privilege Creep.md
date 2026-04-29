# Privilege Creep

## What it is
Like a hotel guest who keeps getting handed extra room keys every time they move floors — and never returns the old ones — privilege creep occurs when a user accumulates access rights over time beyond what their current role requires. Formally, it is the gradual accumulation of excessive permissions as users change roles, take on new responsibilities, or receive access for one-time tasks that is never revoked.

## Why it matters
In the 2013 Target breach, attackers pivoted through a third-party HVAC vendor account that had far more network access than it needed — a textbook privilege creep scenario where historical over-provisioning created a lateral movement pathway. A proper access review cycle would have constrained that vendor account to HVAC systems only, containing the blast radius.

## Key facts
- **Violates least privilege**: Users should hold only the minimum permissions needed for their current job function — creep is direct evidence this principle has failed
- **Detected through access reviews/recertification**: Periodic user access reviews (UAR) are the primary control; managers formally re-approve or revoke each entitlement
- **Common in role transitions**: Employees who transfer departments often retain legacy permissions — combining both old and new access creates toxic combinations
- **Measured via entitlement sprawl**: Security teams track privilege creep using Identity Governance and Administration (IGA) tools that flag accounts with outlier permission sets
- **Feeds SoD violations**: Accumulated privileges can break Separation of Duties controls, allowing one person to initiate *and* approve transactions — a major fraud risk in financial systems

## Related concepts
[[Least Privilege]] [[Separation of Duties]] [[Identity and Access Management]] [[User Access Review]] [[Toxic Combinations]]