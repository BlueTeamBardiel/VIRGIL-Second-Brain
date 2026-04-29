# EyouCMS

## What it is
Like a prefabricated house kit that's cheap and fast to assemble but ships with the front door unlocked by default — EyouCMS is an open-source Chinese-language content management system (CMS) built on the ThinkPHP framework, widely deployed for small business and government websites in China. It has accumulated a significant CVE history due to persistent vulnerabilities in its file upload and authentication mechanisms.

## Why it matters
In 2021–2022, threat actors exploited multiple EyouCMS vulnerabilities — including unauthenticated arbitrary file upload (CVE-2022-23544 and related bugs) — to plant web shells on compromised servers, achieving remote code execution without any credentials. This pattern mirrors classic supply-chain and web application risk: organizations adopt a popular, "good enough" CMS without tracking its patch cadence, and attackers harvest the unpatched installations at scale.

## Key facts
- **File upload bypass**: EyouCMS has repeatedly failed to properly validate file extensions and MIME types, allowing attackers to upload `.php` web shells disguised as image files.
- **ThinkPHP dependency risk**: Because it is built on ThinkPHP, critical ThinkPHP RCE vulnerabilities (e.g., CVE-2018-20062) directly affect EyouCMS installations running outdated framework versions.
- **Default credential exposure**: Administrative panels at `/admin` paths are often left with default or weak credentials, making credential-stuffing trivially effective.
- **OWASP Top 10 overlap**: EyouCMS vulnerabilities commonly map to A03 (Injection), A04 (Insecure Design), and A05 (Security Misconfiguration) in the OWASP Top 10.
- **Patch lag reality**: The open-source community maintaining EyouCMS releases patches inconsistently, meaning responsible disclosure windows are frequently exploited before fixes reach production deployments.

## Related concepts
[[Web Shell]] [[File Upload Vulnerability]] [[Content Management System Security]] [[Remote Code Execution]] [[ThinkPHP]]