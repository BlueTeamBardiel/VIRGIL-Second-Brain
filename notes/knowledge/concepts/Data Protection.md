# Data Protection

## What it is
Think of data protection like a bank vault with multiple layers: a thick steel door (encryption), a sign-in log (access controls), and a security camera (auditing) — no single mechanism is enough alone. Data protection is the collection of technical and administrative controls that ensure data remains confidential, maintains integrity, and stays available only to authorized parties throughout its entire lifecycle — creation, storage, transmission, and destruction.

## Why it matters
In 2017, Equifax exposed 147 million records because sensitive PII was stored unencrypted in a database that sat behind a single unpatched Apache Struts vulnerability. Proper data protection — encrypting data at rest, enforcing least privilege on database access, and classifying data by sensitivity — would have dramatically reduced the blast radius of that breach even after the attacker got in.

## Key facts
- **Data states require different controls**: data at rest (AES-256 encryption), data in transit (TLS 1.3), and data in use (memory encryption, trusted execution environments)
- **Data classification drives protection level**: Public → Internal → Confidential → Restricted; controls scale with sensitivity
- **DLP (Data Loss Prevention)** tools monitor, detect, and block unauthorized data exfiltration across endpoints, network, and cloud
- **Data minimization** is a legal requirement under GDPR Article 5 — collect only what is necessary, retain only as long as needed
- **Secure data destruction** matters: deleted files are recoverable without proper wiping (DoD 5220.22-M standard) or physical destruction for media

## Related concepts
[[Encryption]] [[Data Loss Prevention]] [[Access Control]] [[Data Classification]] [[GDPR Compliance]]