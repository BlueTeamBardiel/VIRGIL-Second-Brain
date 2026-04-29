# SourceCodester Patient Appointment Scheduler System

## What it is
Like a hospital reception desk staffed by someone who accepts any note slipped under the door without checking who wrote it, this is a PHP-based open-source web application for managing patient appointments that has been repeatedly found to contain critical unpatched vulnerabilities. It is a freely distributed healthcare scheduling system frequently cited in CVE databases for SQL injection and cross-site scripting (XSS) flaws in its input handling routines.

## Why it matters
In 2023, multiple CVEs (including CVE-2023-28990 series) documented unauthenticated SQL injection vulnerabilities in this system's appointment booking parameters, meaning an attacker could dump an entire patient database — names, contact details, medical appointment records — without logging in. This represents a HIPAA-reportable breach scenario triggered by a single malformed HTTP request, illustrating how open-source healthcare software with no security review cycle becomes a direct liability.

## Key facts
- Classified under CWE-89 (SQL Injection) and CWE-79 (XSS) — two of the OWASP Top 10 most critical web vulnerabilities
- Vulnerabilities are frequently **unauthenticated**, meaning no credentials are required to exploit them — raising severity scores to CVSS 9.8 (Critical)
- SourceCodester systems appear regularly on exploit-db.com and in CVE feeds as targets for proof-of-concept (PoC) exploit publication
- The system's PHP code lacks prepared statements, relying on direct string concatenation in database queries — the textbook cause of SQL injection
- Serves as a common example in penetration testing training because its source code is publicly available for hands-on analysis

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[CVE and CVSS Scoring]] [[OWASP Top 10]] [[HIPAA Security Rule]]