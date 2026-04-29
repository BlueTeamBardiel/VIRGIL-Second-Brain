# AAA - Authentication, Authorization, and Accounting

## What it is
Think of AAA like airport security: the guard checks your identity (Authentication), verifies you're allowed in the terminal you're heading to (Authorization), and records which flights you boarded (Accounting). AAA is a framework that controls access to network resources by verifying *who* you are, *what* you can do, and *what* you did—creating a complete audit trail.

## Why it matters
Without AAA, a breach is silent and undetectable. An attacker could compromise a user's credentials, access sensitive data, and vanish without a trace. With AAA implemented, you'd catch the intrusion because accounting logs show abnormal access patterns, authorization rules would limit lateral movement even if one account is stolen, and strong authentication (like MFA) would prevent the initial credential compromise.

## Key facts
- **Authentication** verifies identity (passwords, biometrics, certificates, MFA)—answers "Are you really Alice?"
- **Authorization** grants permissions based on identity and role (ACLs, RBAC, policies)—answers "Can Alice access this file?"
- **Accounting** logs actions for auditing and compliance—answers "What did Alice do and when?"
- RADIUS and TACACS+ are protocols that implement AAA for network device access
- Accounting creates non-repudiation: users can't deny their actions when logs exist

## Related concepts
[[RBAC]] [[RADIUS]] [[MFA]] [[Access Control Lists]] [[Non-Repudiation]]