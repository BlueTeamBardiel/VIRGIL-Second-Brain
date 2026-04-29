# DjangoBlog

## What it is
Like a pre-furnished apartment where someone already decorated and left the doors unlocked, DjangoBlog is an open-source blogging platform built on the Django web framework — it ships with features ready-to-use but carries inherited vulnerabilities if left unpatched or misconfigured. It is a Python/Django-based CMS available on GitHub, commonly used as a learning project or lightweight production blog engine.

## Why it matters
DjangoBlog has been repeatedly targeted in CVE disclosures involving Server-Side Request Forgery (SSRF) and Cross-Site Scripting (XSS) vulnerabilities in its admin interface and comment handling logic. An attacker exploiting an unpatched SSRF flaw could use the blog server as a proxy to probe internal network services — pivoting from a public-facing blog into a private cloud metadata endpoint (e.g., AWS IMDSv1 at 169.254.169.254) to steal IAM credentials.

## Key facts
- DjangoBlog has documented CVEs including SSRF vulnerabilities (e.g., CVE-2023-2800-range disclosures) that allow unauthenticated or low-privilege users to trigger outbound requests from the server
- Django's ORM normally prevents SQL injection, but misconfigured raw query usage in projects like DjangoBlog can reintroduce this risk
- Stored XSS vulnerabilities in comment or markdown-rendering features can lead to admin session hijacking
- Running DjangoBlog with `DEBUG=True` in production exposes full stack traces, environment variables, and secret keys — a critical misconfiguration
- Patch management for third-party Django apps is distinct from patching Django core itself; many deployments miss application-level CVEs

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Cross-Site Scripting (XSS)]] [[Django Security Hardening]] [[CVE Management]] [[Debug Mode Misconfiguration]]