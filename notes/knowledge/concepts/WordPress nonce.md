# WordPress nonce

## What it is
Think of it like a single-use ticket stub at a concert — it's valid once, tied to a specific show, and expires fast. A WordPress nonce is a time-limited cryptographic token embedded in URLs and forms to verify that a request was intentionally initiated by a legitimate authenticated user within a recent session window.

## Why it matters
Without nonces, a logged-in WordPress admin can be tricked by a Cross-Site Request Forgery (CSRF) attack — for example, visiting a malicious page that silently submits a hidden form to `wp-admin/user-new.php`, creating a new admin account the attacker controls. The nonce breaks this attack because the forged request cannot know the valid token tied to the victim's session.

## Key facts
- WordPress nonces are **not truly one-time** — they remain valid for **12 hours by default**, then a second 12-hour grace window activates the previous nonce, giving a total 24-hour lifespan
- They are generated with `wp_create_nonce('action-name')` and verified with `wp_verify_nonce()` or `check_admin_referer()`
- A nonce is tied to three factors: the **action name**, the **user ID**, and the **current session token** — changing any one invalidates it
- Nonces are **not secret tokens** for authentication; they are anti-CSRF tokens. Using them as capability checks without also verifying user roles is a common developer security mistake
- Missing nonce verification on AJAX handlers (`wp_ajax_*`) is one of the most frequently reported WordPress plugin vulnerabilities in CVE databases

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Session Tokens]] [[Same-Origin Policy]]