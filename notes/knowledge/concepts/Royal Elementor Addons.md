# Royal Elementor Addons

## What it is
Like a Swiss Army knife duct-taped to a Swiss Army knife, Royal Elementor Addons is a third-party plugin that extends WordPress's Elementor page builder with additional widgets and templates. It is a widely-installed WordPress plugin (1M+ active installations) that adds UI components, and like many plugin ecosystems, its broad attack surface has made it a recurring target for critical vulnerabilities.

## Why it matters
In late 2023, Royal Elementor Addons was found to contain a **critical unauthenticated arbitrary file upload vulnerability (CVE-2023-5360, CVSS 9.8)** that allowed attackers to upload malicious PHP files without any login credentials, achieving Remote Code Execution (RCE) on vulnerable WordPress sites. Threat actors actively exploited this flaw in the wild within days of disclosure, mass-scanning for unpatched installations to deploy webshells and establish persistent backdoors.

## Key facts
- **CVE-2023-5360** affected Royal Elementor Addons versions ≤ 1.3.78; patched in 1.3.79 — a textbook case of insufficient file type validation.
- The vulnerability resided in the **form widget's file upload handler**, which failed to properly restrict MIME types, allowing `.php` file uploads disguised as images.
- Exploitation required **zero authentication**, placing it in the highest-risk category for WordPress plugin flaws.
- This class of vulnerability maps to **CWE-434** (Unrestricted Upload of File with Dangerous Type) — a commonly tested concept in security certifications.
- Defense requires **defense-in-depth**: WAF rules blocking PHP uploads, file execution restrictions in upload directories, and prompt patch management via vulnerability scanners like WPScan or Tenable.

## Related concepts
[[File Upload Vulnerabilities]] [[Remote Code Execution]] [[WordPress Security]] [[CWE-434]] [[Web Application Firewall]]