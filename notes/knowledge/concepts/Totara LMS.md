# Totara LMS

## What it is
Think of it like a corporate version of Moodle with a locked front door — it's a Learning Management System (LMS) built for enterprise workforce training and compliance. Totara is an open-source LMS platform forked from Moodle, designed specifically for organizational learning, compliance tracking, and performance management in business environments.

## Why it matters
LMS platforms like Totara are attractive attack surfaces because they aggregate employee credentials, personal data, and compliance records in one place. CVE-2019-17179 demonstrated a stored Cross-Site Scripting (XSS) vulnerability in Totara that allowed authenticated users to inject malicious scripts into course content — a scenario where a low-privileged employee account could escalate influence by targeting administrators who review course submissions. Organizations running unpatched Totara instances risk credential harvesting and session hijacking against their entire workforce training infrastructure.

## Key facts
- Totara is forked from **Moodle** (open-source LMS) and inherits many of its underlying PHP-based vulnerabilities and attack patterns
- Common vulnerability classes include **Stored XSS**, **CSRF**, **SQL injection**, and **insecure file upload** due to its PHP/web application architecture
- Totara stores **PII** (employee names, roles, training records) making it a GDPR/compliance-relevant target during data breach investigations
- Default misconfigurations (guest access enabled, weak session tokens) are common findings during web application penetration tests of enterprise LMS deployments
- Patching cadence matters: Totara follows a **rolling release model**, meaning organizations running older branches frequently fall behind on critical security patches

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Moodle Security]] [[Web Application Vulnerabilities]]