# WPForms

## What it is
Think of WPForms like a drag-and-drop vending machine builder bolted onto the front of a website — users design the slots, WordPress handles the mechanics. Precisely, WPForms is a popular WordPress plugin that enables non-developers to create web forms (contact, payment, registration) through a visual interface, processing and storing user-submitted data server-side.

## Why it matters
In 2021, a critical SQL injection vulnerability (CVE-2021-20101 and related findings) in WPForms allowed authenticated attackers to manipulate database queries through unsanitized form field inputs, potentially exfiltrating sensitive user data. Because WPForms is installed on over 6 million WordPress sites, a single unpatched vulnerability becomes a massive attack surface — attackers routinely scan for outdated plugin versions using tools like WPScan to identify targets at scale.

## Key facts
- WPForms has historically been vulnerable to **SQL injection**, **Cross-Site Scripting (XSS)**, and **CSRF** attacks due to inadequate input validation and nonce handling
- Plugin-based vulnerabilities are tracked in the **WPScan Vulnerability Database** and **CVE/NVD**, making patch management critical for WordPress hardening
- Attackers commonly use **authenticated vs. unauthenticated** vulnerability classifications — unauthenticated flaws in form plugins are rated higher severity (CVSS 8+) because no account is needed to exploit them
- **Input validation and output encoding** are the primary defenses — WPForms vulnerabilities typically arise when submitted data is rendered back to users or passed directly to database queries without sanitization
- WordPress plugin attack surface falls under **CWE-20 (Improper Input Validation)** and is a common vector in web application penetration testing and CySA+ scenario questions

## Related concepts
[[SQL Injection]] [[Cross-Site Scripting (XSS)]] [[WordPress Security]] [[Input Validation]] [[CVE]]