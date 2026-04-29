# WordPress AJAX

## What it is
Think of it like a drive-through window at a restaurant — customers place orders without leaving their car, and food comes back without anyone going inside. WordPress AJAX is a mechanism that lets browser-side JavaScript send requests to the server and receive data without reloading the entire page, routed through the central endpoint `wp-admin/admin-ajax.php`.

## Why it matters
Attackers frequently target AJAX handlers that fail to verify user permissions or validate nonces (anti-CSRF tokens). A classic example: a vulnerable plugin registers an AJAX action accessible to unauthenticated users (`wp_ajax_nopriv_`), allowing attackers to trigger admin-level functions — like creating rogue admin accounts — without logging in. This attack class has appeared in critical CVEs affecting plugins with millions of active installs.

## Key facts
- All AJAX requests funnel through one file: `wp-admin/admin-ajax.php`, making it a high-value monitoring target for WAF rules and log analysis.
- Two action hooks control access: `wp_ajax_{action}` (authenticated users only) and `wp_ajax_nopriv_{action}` (unauthenticated users) — misconfiguring which hook is used is the root cause of many privilege escalation vulnerabilities.
- Nonce verification (`check_ajax_referer()`) is the primary CSRF defense; skipping it leaves handlers open to cross-site request forgery attacks.
- Lack of capability checks (`current_user_can()`) inside AJAX handlers is a separate, compounding vulnerability — authentication ≠ authorization.
- AJAX abuse is detectable via anomalous POST request volume to `admin-ajax.php` in SIEM log analysis, a common CySA+ scenario.

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Privilege Escalation]] [[Broken Access Control]]