# COMPE - WooCommerce Compare Products

## What it is
Like a price tag left in the wrong pocket that reveals what's inside a sealed package, COMPE is a known vulnerability class affecting the WooCommerce Compare Products plugin for WordPress. It refers to security weaknesses — typically Cross-Site Scripting (XSS) or SQL Injection — introduced through improperly sanitized user input in product comparison functionality on e-commerce sites.

## Why it matters
An attacker targeting a WooCommerce storefront could inject malicious JavaScript through the compare products widget, stealing session cookies from authenticated administrators. Once an admin cookie is captured, the attacker gains full backend access, enabling malware installation, customer data exfiltration, or payment skimming code injection — a direct path to a PCI DSS breach incident.

## Key facts
- WooCommerce Compare Products vulnerabilities frequently manifest as **Stored XSS**, where payloads persist in the database and execute for every visitor viewing a comparison page
- These plugin-level vulnerabilities are catalogued in the **CVE database** and tracked via **WordPress vulnerability databases** like WPScan
- Plugin vulnerabilities represent the **#1 attack surface for WordPress sites**, accounting for over 55% of known WordPress compromises
- Exploitation often requires **low or no authentication**, making them high-severity targets in automated scanning campaigns
- Remediation follows the standard patch management cycle: **identify → update plugin → verify → monitor logs** for prior exploitation indicators

## Related concepts
[[Cross-Site Scripting (XSS)]] [[SQL Injection]] [[CVE Database]] [[Plugin Vulnerability Management]] [[Session Hijacking]]