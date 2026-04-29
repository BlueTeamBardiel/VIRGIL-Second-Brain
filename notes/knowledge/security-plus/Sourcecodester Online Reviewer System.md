# Sourcecodester Online Reviewer System

## What it is
Like a pop quiz app built on a paper foundation — functional on the surface but structurally unsound underneath — the Sourcecodester Online Reviewer System is a PHP-based web application distributed as open-source educational software for creating and managing online quizzes and assessments. It has been repeatedly identified as containing critical vulnerabilities including SQL injection and unrestricted file upload flaws in its publicly distributed codebase.

## Why it matters
Developers and students frequently download Sourcecodester applications as starter templates or learning projects and deploy them in production environments without auditing the code. Attackers targeting these installations can exploit documented SQL injection vulnerabilities (tracked in CVE databases) to dump credentials or bypass authentication, then pivot to full server compromise — a classic case of vulnerable-by-design software proliferating because of its "free and easy" appeal.

## Key facts
- Multiple CVEs have been assigned to this application, including SQL injection vulnerabilities in parameters like `id` passed to MySQL queries without sanitization
- Suffers from **unrestricted file upload** vulnerabilities, allowing attackers to upload PHP webshells disguised as profile images or quiz assets
- Authentication bypass is achievable through manipulated SQL queries (e.g., `' OR 1=1--`) in login forms
- Represents the **vulnerable open-source application** category frequently tested in CySA+ scenarios involving SAST/DAST tool findings
- Exemplifies why OWASP Top 10 categories A03 (Injection) and A04 (Insecure Design) remain persistent real-world threats even in small-scale deployments

## Related concepts
[[SQL Injection]] [[Unrestricted File Upload]] [[Web Application Vulnerability Assessment]] [[OWASP Top 10]] [[CVE Database]]