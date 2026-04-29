# AAA

## What it is
Think of AAA like a nightclub's three-stage process: the bouncer checks your ID (Authentication), confirms you're on the guest list (Authorization), and logs which VIP room you entered (Accounting). AAA is the framework that answers: *Who are you?* → *What can you do?* → *What did you do?*

Authentication verifies identity (passwords, MFA, certificates). Authorization grants access rights based on that identity. Accounting logs actions for compliance and forensics.

## Why it matters
A breach of AAA is catastrophic. In 2019, Capital One's AWS misconfiguration failed authorization checks, exposing 100M records—the attacker authenticated as an assumed role but shouldn't have been authorized. Without accounting logs, detection takes weeks. Banks depend on AAA: weak authentication = credential theft; weak authorization = privilege escalation; missing accounting = undetectable fraud.

## Key facts
- **Authentication** alone is insufficient—a valid user with wrong permissions is still a threat
- **Authorization** uses access control models: RBAC (role-based), ABAC (attribute-based), ACLs
- **Accounting** requires immutable, timestamped logs (syslog, audit trails, SIEM ingestion)
- AAA is stateless by design—each request proves identity and checks permissions independently
- Radius and Tacacs+ are legacy AAA protocols; modern systems use OAuth 2.0, SAML, and Kerberos

## Related concepts
[[Authentication]] [[Authorization]] [[Access Control]] [[Privilege Escalation]] [[Audit Logging]]