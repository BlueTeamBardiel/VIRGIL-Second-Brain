# WCFM Marketplace

## What it is
Think of it like Amazon's third-party seller infrastructure bolted onto a WordPress site — WCFM Marketplace is a multi-vendor plugin for WooCommerce that lets multiple independent sellers manage storefronts, products, and orders within a single WordPress installation. It extends WooCommerce with vendor dashboards, commission management, and role-based access controls.

## Why it matters
WCFM Marketplace has been repeatedly targeted through privilege escalation and broken access control vulnerabilities — attackers exploiting flawed REST API endpoints to modify vendor data or escalate a low-privileged vendor account into a shop manager or administrator role. In 2021, a critical vulnerability (CVE-2021-24315) allowed unauthenticated users to update arbitrary user metadata, effectively enabling account takeover without credentials — a textbook Broken Access Control scenario from the OWASP Top 10.

## Key facts
- WCFM Marketplace relies on WordPress user roles (vendor, shop manager, admin); misconfigured role capabilities are a primary attack surface
- REST API endpoints in WCFM have historically lacked proper `current_user_can()` authorization checks, enabling IDOR and privilege escalation
- CVE-2021-24315 carried a CVSS score of 9.8 (Critical), allowing unauthenticated user metadata manipulation
- Plugin vulnerabilities in WordPress ecosystems are tracked through the WPScan Vulnerability Database and NVD; patching cadence is a critical defense metric
- Defense-in-depth for WCFM deployments includes WAF rules targeting REST API abuse, least-privilege role assignment, and disabling unused plugin REST routes

## Related concepts
[[Broken Access Control]] [[Privilege Escalation]] [[Insecure Direct Object Reference]] [[WordPress Security]] [[REST API Security]]