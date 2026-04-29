# admin-ajax.php

## What it is
Think of it as a drive-through window at the back of a restaurant — it handles requests without reloading the full menu. Precisely, `admin-ajax.php` is WordPress's built-in AJAX handler, located at `/wp-admin/admin-ajax.php`, that processes asynchronous requests from both authenticated users and unauthenticated visitors via registered action hooks.

## Why it matters
Because the endpoint is publicly accessible by design, attackers routinely probe it for vulnerable plugins that register poorly secured AJAX actions. In the 2021 exploitation of the Fancy Product Designer plugin (CVE-2021-24370), unauthenticated attackers abused an exposed AJAX action to upload arbitrary PHP files, achieving Remote Code Execution on hundreds of thousands of WordPress sites — no login required.

## Key facts
- The file is always reachable at `https://target.com/wp-admin/admin-ajax.php` regardless of WordPress hardening, making it a reliable recon landmark during web application assessments.
- Requests use POST parameters: `action` specifies which registered hook to invoke; improper capability checks (`current_user_can()`) on that hook are the root cause of most related CVEs.
- A response of `0` or `-1` indicates the action exists but failed authorization; a valid JSON response confirms the action handler executed successfully — useful for blind enumeration.
- Unauthenticated AJAX actions are registered with `wp_ajax_nopriv_{action}`; authenticated-only actions use `wp_ajax_{action}` — missing the nopriv distinction is a classic developer security mistake.
- WAF rules commonly rate-limit or monitor this endpoint; defenders should log all requests to `admin-ajax.php` and alert on unusual `action` parameter values.

## Related concepts
[[WordPress Security]] [[Remote Code Execution]] [[Broken Access Control]] [[AJAX Security]] [[Web Application Enumeration]]