# sensitive data exposure

## What it is
Imagine a bank vault with a glass door — the lock works perfectly, but anyone walking by can read the account numbers written on sticky notes inside. Sensitive data exposure occurs when an application fails to adequately protect confidential information (PII, credentials, financial data, health records) at rest or in transit, making it accessible to unauthorized parties even without breaking encryption directly. It differs from a breach caused by exploiting a vulnerability — the data was simply never properly protected in the first place.

## Why it matters
In 2019, Facebook stored hundreds of millions of user passwords in plaintext in internal logs, accessible to thousands of employees for years. Had a malicious insider or attacker pivoted to that logging system, they could have harvested credentials without cracking a single hash. The defense is straightforward but often skipped: never log sensitive fields, enforce hashing with bcrypt/Argon2, and audit data stores regularly.

## Key facts
- Sensitive data exposure was formerly OWASP Top 10 #3 (now folded into **A02: Cryptographic Failures** in the 2021 list)
- Common root causes: HTTP instead of HTTPS, weak ciphers (MD5/SHA-1 for passwords), unencrypted database fields, verbose error messages leaking stack traces
- **Data at rest** should use AES-256; **data in transit** should use TLS 1.2 minimum (TLS 1.3 preferred)
- Storing passwords with MD5 — even salted — is considered exposure because the algorithm is too fast to resist GPU-based brute force
- Regulations like **HIPAA**, **PCI-DSS**, and **GDPR** impose specific penalties for exposed health, payment, and personal data respectively

## Related concepts
[[cryptographic failures]] [[transport layer security]] [[data classification]] [[personally identifiable information]] [[insecure direct object reference]]