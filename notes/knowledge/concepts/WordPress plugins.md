# WordPress plugins

## What it is
Think of WordPress plugins like apps on a smartphone — they extend what the core platform can do, but every third-party app you install is a new door into your house. Precisely, WordPress plugins are PHP-based software modules that integrate with the WordPress core via hooks and filters, extending site functionality without modifying the core installation.

## Why it matters
In 2021, the Fancy Product Designer plugin (installed on 17,000+ sites) contained an unauthenticated file upload vulnerability (CVE-2021-24370), allowing attackers to upload web shells and achieve remote code execution with zero authentication required. This is the classic plugin attack pattern: a popular, trusted plugin silently becomes the easiest path to full server compromise.

## Key facts
- The majority of WordPress CVEs originate from plugins, not the WordPress core itself — third-party code is consistently the weakest link
- Common plugin vulnerability classes: SQL injection, Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF), arbitrary file upload, and broken access control
- Abandoned plugins (no updates for 2+ years) are high-value targets because disclosed vulnerabilities remain unpatched indefinitely
- Attackers actively scan for specific plugin version headers using tools like WPScan to fingerprint and exploit vulnerable installations at scale
- Defense-in-depth for plugins includes: minimal plugin count, verified publisher reputation, WAF rules (e.g., ModSecurity), file integrity monitoring, and principle of least privilege for the WordPress database user

## Related concepts
[[Remote Code Execution]] [[Cross-Site Scripting (XSS)]] [[Attack Surface Management]]