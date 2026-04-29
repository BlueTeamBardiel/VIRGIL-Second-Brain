# wp_nonce

## What it is
Like a time-stamped wax seal on a medieval letter that expires in 24 hours — if someone hands you the letter a week later, you know it's been tampered with. A WordPress nonce is a unique, time-limited token embedded in forms and URLs that verifies a request is intentional, legitimate, and recent, protecting against forged requests from malicious third-party sites.

## Why it matters
Without nonce validation, an attacker can craft a malicious link that — when clicked by a logged-in WordPress admin — silently executes privileged actions like creating a new admin account or deleting content. This is a classic CSRF attack: the admin's authenticated session does the attacker's bidding without realizing it. Proper `wp_nonce` generation and verification (`wp_verify_nonce()`) breaks this attack chain entirely.

## Key facts
- WordPress nonces are not truly single-use ("nonce" is a misnomer); they are valid for **12 hours**, then accepted for another 12 hours in a grace period, for a total window of up to **24 hours**
- Generated with `wp_create_nonce('action-name')` and verified with `wp_verify_nonce($token, 'action-name')` — the **action name** must match or verification fails
- Nonces are **user-specific and session-specific**, computed using the user's ID, session token, and a secret key — a nonce valid for one user will not validate for another
- Failure to validate nonces in custom plugins/themes is one of the **most common WordPress vulnerability classes** catalogued by WPScan and Wordfence
- Nonces protect against **CSRF** but do NOT protect against XSS or brute force — they are not a substitute for authentication or authorization checks

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Session Tokens]] [[Same-Origin Policy]]