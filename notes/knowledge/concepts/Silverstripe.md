# Silverstripe

## What it is
Like WordPress but built with a stricter architectural blueprint, Silverstripe is an open-source PHP content management system (CMS) and framework used to build and manage websites. It separates the CMS layer from the application framework, giving developers fine-grained control over both content and code.

## Why it matters
In 2019, CVE-2019-12203 and CVE-2019-12204 exposed Silverstripe installations to session fixation and open redirect vulnerabilities, allowing attackers to hijack authenticated user sessions without ever cracking a password. A defender monitoring HTTP response headers for missing `Set-Cookie` attributes with `HttpOnly` and `Secure` flags would have caught the exposure before exploitation — a classic case where secure cookie configuration stops session hijacking cold.

## Key facts
- **CVE-2019-19326** was a critical XSS vulnerability in Silverstripe CMS allowing unauthenticated attackers to inject malicious scripts through URL parameters into the admin panel.
- Silverstripe uses an ORM (Object-Relational Mapping) layer, so SQL injection risk is reduced when developers use the framework correctly — but raw SQL queries introduced by developers bypass these protections entirely.
- Default Silverstripe installations expose `/dev/build` and `/admin` endpoints; leaving `/dev/build` publicly accessible can leak database schema information.
- Session fixation vulnerabilities in CMS platforms like Silverstripe are mitigated by regenerating session IDs after authentication (`session_regenerate_id()`).
- Silverstripe's security model relies on permission codes assigned to user groups — misconfigured group permissions are a common privilege escalation vector in enterprise deployments.

## Related concepts
[[Session Fixation]] [[Cross-Site Scripting (XSS)]] [[Content Management System Security]] [[SQL Injection]] [[Privilege Escalation]]