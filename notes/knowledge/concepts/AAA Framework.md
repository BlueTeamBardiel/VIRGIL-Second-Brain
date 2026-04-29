# AAA framework

## What it is
Think of AAA like a nightclub bouncer with three jobs: checking your ID (are you who you claim?), verifying your name on the list (what can you do?), and writing down that you entered (who did what when?). **Authentication, Authorization, and Accounting** form the three pillars of access control: proving identity, granting permissions based on that identity, and logging actions for accountability.

## Why it matters
A bank's network breach exposed customer data because attackers bypassed authentication. But here's where AAA saved them: authorization limits meant the compromised account couldn't access the core database anyway, and accounting logs revealed exactly which records were touched. Without all three layers, the breach would have been catastrophic instead of contained.

## Key facts
- **Authentication** verifies *who* you are (passwords, biometrics, certificates—proof of identity)
- **Authorization** determines *what* you can access (role-based access control, permissions, policies)
- **Accounting** records *what you did* (logs, audit trails, non-repudiation evidence)
- AAA assumes authentication succeeds; authorization then enforces principle of least privilege
- Accounting is often neglected but critical for forensics, compliance (SOX, HIPAA), and detecting insider threats
- RADIUS and TACACS+ are protocols that implement AAA for network devices

## Related concepts
[[Zero Trust Architecture]] [[RBAC]] [[Principle of Least Privilege]] [[Non-repudiation]] [[Access Control Lists]]