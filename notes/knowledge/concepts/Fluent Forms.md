# Fluent Forms

## What it is
Like a mailbox slot on a website — it looks simple on the outside, but everything dropped in gets processed by the system behind the wall. Fluent Forms is a popular WordPress drag-and-drop form builder plugin used to collect user input (contact forms, surveys, payment forms) and route that data to backend systems or third-party integrations.

## Why it matters
In 2022, a stored Cross-Site Scripting (XSS) vulnerability (CVE-2022-1004) was discovered in Fluent Forms that allowed unauthenticated attackers to inject malicious scripts into form fields. When an administrator viewed submitted entries in the WordPress dashboard, the payload executed in their browser — potentially stealing session cookies, hijacking admin accounts, and achieving full site compromise without ever logging in.

## Key facts
- Fluent Forms has had multiple CVEs involving **stored XSS**, **SQL injection**, and **privilege escalation** — high-value targets because plugins run with WordPress core trust
- Its broad **third-party integrations** (Stripe, Mailchimp, Zapier) expand the attack surface beyond the plugin itself — a single vulnerable form can expose payment pipelines
- WordPress plugins like Fluent Forms are a primary vector for **supply chain attacks** — malicious updates pushed through compromised developer accounts can backdoor thousands of sites simultaneously
- Proper **input validation and output encoding** on form fields are the primary defenses; WAF rules targeting `<script>` tags and SQL metacharacters serve as compensating controls
- Plugin vulnerabilities are tracked in the **WPScan Vulnerability Database** and **CVE/NVD** — patch cadence monitoring is a key CySA+ defensive task

## Related concepts
[[Cross-Site Scripting (XSS)]] [[SQL Injection]] [[WordPress Security]] [[Input Validation]] [[Supply Chain Attack]]