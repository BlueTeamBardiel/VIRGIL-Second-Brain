# Credential Management

## What it is
Think of it like a hotel key card system: each guest gets a unique card, cards expire automatically, lost cards get deactivated instantly, and the front desk keeps a log of every door opened. Credential management is the systematic process of creating, storing, distributing, rotating, and revoking authentication secrets (passwords, certificates, API keys, tokens) across an organization's lifecycle. It ensures that only authorized identities hold valid credentials at any given moment.

## Why it matters
In 2021, attackers compromised the Colonial Pipeline network partly because a legacy VPN account with a reused, unrotated password had no MFA protection — credentials that should have been long deactivated. Proper credential management, including rotation schedules and deprovisioning workflows, would have eliminated that attack surface before the breach occurred.

## Key facts
- **Privileged Account Management (PAM)** tools like CyberArk or HashiCorp Vault vault and auto-rotate credentials for service accounts and admins, checking them out on demand
- **Password vaulting** separates knowledge of credentials from the humans using them — even admins may never see the actual plaintext password
- **Credential rotation** is the practice of automatically replacing secrets on a schedule (or after suspected exposure) to limit the window of exploitation
- **Secrets sprawl** occurs when API keys, tokens, and passwords are hardcoded into source code or config files, a top finding in cloud breach investigations
- **Deprovisioning** — revoking access immediately upon employee termination — is a critical control; orphaned accounts are a persistent attacker target

## Related concepts
[[Identity and Access Management]] [[Privileged Access Management]] [[Multi-Factor Authentication]] [[Password Policies]] [[Secrets Management]]