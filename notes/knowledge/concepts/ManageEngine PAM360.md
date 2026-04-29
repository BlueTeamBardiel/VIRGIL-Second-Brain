# ManageEngine PAM360

## What it is
Think of it as a bank vault with a detailed visitor log — every key, every access, every moment recorded. ManageEngine PAM360 is an enterprise Privileged Access Management (PAM) solution that centralizes control over privileged accounts, credentials, and sessions across an organization's IT infrastructure. It enforces least-privilege principles by vaulting passwords, brokering connections, and recording privileged sessions in real time.

## Why it matters
In 2023, threat actors exploited CVE-2022-47966, a critical RCE vulnerability in ManageEngine products including PAM360, to gain unauthenticated remote code execution on unpatched systems — effectively turning the vault's front door into an open window. This attack illustrated the irony that PAM tools, if unpatched, become high-value targets precisely because they hold the keys to everything else. Defenders must treat PAM infrastructure itself as crown-jewel assets requiring rigorous patch management and network segmentation.

## Key facts
- PAM360 provides **just-in-time (JIT) access**, granting temporary elevated privileges only when needed, reducing standing privilege exposure
- It integrates **session recording and keystroke logging** for privileged sessions, supporting forensic investigations and compliance audits (SOX, HIPAA, PCI-DSS)
- CVE-2022-47966 carried a **CVSS score of 9.8** (Critical), stemming from improper use of an outdated Apache Santuario XML signature verification library
- PAM360 supports **SSH key and SSL certificate lifecycle management**, addressing non-password credentials often overlooked in identity governance
- It connects with SIEM platforms (like Splunk) to forward **privileged activity logs**, enabling correlation of anomalous access patterns

## Related concepts
[[Privileged Access Management]] [[Least Privilege Principle]] [[Credential Vaulting]] [[CVE Vulnerability Scoring]] [[Just-In-Time Access]]