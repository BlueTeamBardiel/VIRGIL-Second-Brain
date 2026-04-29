# Tutor LMS

## What it is
Like a classroom building with many unlocked side doors, Tutor LMS is a WordPress-based Learning Management System plugin that manages course content, student enrollment, and instructor roles — but its architecture introduces multiple trust boundaries that attackers love to probe. Precisely, it is a feature-rich LMS plugin (over 20,000 active installs) that integrates deeply with WordPress user roles and REST API endpoints to deliver e-learning functionality.

## Why it matters
In 2022, Tutor LMS was found vulnerable to a privilege escalation flaw (CVE-2022-0634) that allowed low-privileged users — including enrolled students — to modify course data and access restricted content by manipulating POST parameters without proper capability checks. This is a textbook example of broken access control (OWASP A01), where a plugin trusts user-supplied role data rather than enforcing server-side authorization. Defenders must audit WordPress plugin REST endpoints and ensure nonce verification and `current_user_can()` checks are applied to every privileged action.

## Key facts
- Tutor LMS vulnerabilities frequently involve **broken access control** and **insecure direct object references (IDOR)** due to insufficient capability checks on AJAX and REST endpoints
- WordPress plugin vulnerabilities are tracked in the **WPScan Vulnerability Database**; Tutor LMS has appeared multiple times since 2020
- Attackers target LMS platforms specifically for **PII harvesting** (student names, emails, payment data) and **certificate fraud**
- Privilege escalation in WordPress plugins often exploits the gap between `subscriber` and `administrator` roles via unprotected `wp_ajax_nopriv_` hooks
- Mitigation requires **input validation**, **nonce tokens**, and explicit **capability checks** (`current_user_can('manage_options')`) on all sensitive endpoints

## Related concepts
[[Broken Access Control]] [[WordPress Security]] [[Privilege Escalation]] [[IDOR]] [[CVE Vulnerability Management]]