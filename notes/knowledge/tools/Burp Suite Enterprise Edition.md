# Burp Suite Enterprise Edition

## What it is
Think of it as a tireless security auditor that never sleeps — automatically crawling your web applications 24/7 looking for cracks in the walls. Burp Suite Enterprise Edition is a scalable, automated web vulnerability scanning platform built on PortSwigger's Burp Scanner engine, designed for continuous, scheduled scanning across large application portfolios rather than manual point-in-time testing.

## Why it matters
A financial services company running dozens of customer-facing web apps needs to know the moment a developer accidentally introduces a SQL injection flaw in a new deployment. Burp Suite Enterprise Edition integrates directly into CI/CD pipelines, scanning new builds automatically and failing the pipeline if critical vulnerabilities are detected — catching flaws before they ever reach production and reducing mean time to remediation dramatically.

## Key facts
- Runs on a centralized server architecture with a web UI, allowing teams to schedule and manage scans without individual Burp Pro licenses on every tester's machine
- Uses the same Burp Scanner engine as Burp Suite Professional, detecting OWASP Top 10 vulnerabilities including SQLi, XSS, XXE, and SSRF
- Supports CI/CD integration via REST API, enabling automated scanning triggers from Jenkins, GitLab CI, and similar pipelines
- Issues findings are exported in multiple formats (HTML, XML, JSON) and can feed directly into vulnerability management platforms like Jira or Splunk
- Licensed by concurrent scans rather than per-user seats, making it cost-efficient at enterprise scale but cost-prohibitive for individual practitioners (that's what Burp Pro is for)

## Related concepts
[[Burp Suite Professional]] [[DAST (Dynamic Application Security Testing)]] [[OWASP Top 10]] [[CI/CD Pipeline Security]] [[Web Application Firewall]]