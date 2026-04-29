# Identity & Access Management

## What it is
Think of IAM like a hotel key card system: the front desk verifies who you are (authentication), stamps your card with your room number and pool access (authorization), and logs every door you open (accounting). In security terms, IAM is the framework of policies, technologies, and processes that ensures the right people access the right resources at the right times — and no more. It encompasses user provisioning, authentication mechanisms, role assignments, and access reviews across an organization's systems.

## Why it matters
In the 2020 SolarWinds breach, attackers leveraged compromised service accounts with excessive privileges to move laterally across networks for months undetected. Had least-privilege IAM controls been enforced — limiting those accounts to only their required functions — the blast radius would have been significantly contained. This is why access reviews and privilege minimization aren't just compliance checkboxes; they're active breach limiters.

## Key facts
- **Authentication vs. Authorization**: Authentication verifies identity (who you are); authorization determines permissions (what you can do) — these are distinct steps in IAM
- **Principle of Least Privilege**: Users and systems should have only the minimum access required to perform their function — a core IAM design rule
- **Provisioning and Deprovisioning**: Failing to remove access when employees leave is a leading cause of insider threat exposure; automated offboarding is a best practice
- **Role-Based Access Control (RBAC)**: Assigns permissions to roles rather than individuals, reducing administrative overhead and permission sprawl
- **MFA is an IAM control**: Multi-factor authentication is one of the most effective IAM mechanisms, reducing account compromise risk by over 99% according to Microsoft telemetry
- **Privileged Access Management (PAM)**: A subset of IAM focused specifically on controlling and auditing high-privilege accounts like admins and service accounts

## Related concepts
[[Least Privilege]] [[Multi-Factor Authentication]] [[Privileged Access Management]] [[Role-Based Access Control]] [[Zero Trust Architecture]]