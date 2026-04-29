# Production Environment

## What it is
Like a live Broadway stage during opening night — every action is real, every mistake has consequences, and the audience (users) are watching. A production environment is the live, operational infrastructure where applications and services run for real end-users, handling actual data and business transactions. It sits at the end of the deployment pipeline after development and staging environments.

## Why it matters
In 2020, a misconfigured AWS S3 bucket in a production environment exposed over 100 million Capital One customer records — a direct result of improper IAM permissions applied to live infrastructure. Attackers specifically target production environments because that's where real credentials, real PII, and real financial data live. Hardening production systems through strict change control and least-privilege access is a frontline defense requirement.

## Key facts
- **Separation of environments** (dev → staging → production) is a core security control; skipping this pipeline is a common source of vulnerabilities being pushed live
- Production environments should enforce **change management processes** (e.g., CAB approval) — unauthorized changes are a key indicator of compromise
- **Debug modes, verbose logging, and test credentials** must never exist in production; these are frequent targets during reconnaissance
- Production access should follow **least privilege and just-in-time (JIT) access** principles — standing admin access dramatically widens the attack surface
- Security monitoring priorities (SIEM, IDS/IPS, DLP) are almost always focused on production environments because that's where data exfiltration occurs

## Related concepts
[[Change Management]] [[Least Privilege]] [[Defense in Depth]] [[Data Classification]] [[Vulnerability Management]]