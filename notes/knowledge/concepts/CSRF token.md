# CSRF token

## What it is
Like a secret handshake that only your browser tab and the server know — if you can't reproduce it, you're not who you claim to be. A CSRF (Cross-Site Request Forgery) token is a unique, unpredictable value embedded in web forms or request headers that the server generates per-session (or per-request) and validates on submission, ensuring the request originated from its own page rather than a malicious third-party site.

## Why it matters
In 2008, a vulnerability in a major router's admin panel lacked CSRF protection — attackers embedded a hidden `<img>` tag pointing to `http://192.168.1.1/admin?dns=attacker.com`, and any authenticated user who visited a malicious page silently changed their DNS settings. A CSRF token would have stopped this cold: the attacker's site couldn't read the token from the legitimate page due to the Same-Origin Policy, so the forged request would fail server-side validation.

## Key facts
- Tokens must be **unpredictable and unique** — sequential or static values are exploitable; cryptographically random tokens (e.g., 128-bit) are required
- The **Synchronizer Token Pattern** stores the token server-side and compares it against the value submitted in the form or `X-CSRF-Token` header
- **Double Submit Cookie** pattern sends the token as both a cookie and a request parameter — the server checks they match, exploiting the fact that cross-origin requests can't read cookies
- CSRF tokens protect **state-changing requests** (POST, PUT, DELETE) — GET requests should never perform state changes
- The `SameSite` cookie attribute (`Strict` or `Lax`) is a modern **complementary defense**, but does not fully replace CSRF tokens in all browser contexts

## Related concepts
[[Cross-Site Request Forgery]] [[Same-Origin Policy]] [[Session Management]] [[SameSite Cookie Attribute]] [[Input Validation]]