# CSRF tokens

## What it is
Like a secret handshake your bank whispers to your browser that a rogue website can't overhear — a CSRF token is a unique, unpredictable value embedded in a web form that the server generates per-session (or per-request) and validates on submission. Without this token, the server has no way to distinguish a legitimate user-initiated request from a forged one riding on stolen session cookies.

## Why it matters
In 2008, a CSRF vulnerability in a major router's admin panel allowed attackers to serve malicious HTML that silently sent authenticated requests to change DNS settings — redirecting victims to phishing sites without them ever clicking a suspicious link. A CSRF token tied to the user's session would have invalidated the forged request immediately, since the attacker's page has no way to read the token value due to the Same-Origin Policy.

## Key facts
- CSRF tokens must be **unpredictable and unique per session** (or per request for higher security); sequential or static tokens provide no protection
- The token is typically delivered via a **hidden form field** or **custom HTTP header** (e.g., `X-CSRF-Token`) and validated server-side on every state-changing request (POST, PUT, DELETE)
- **SameSite cookie attribute** (`Strict` or `Lax`) is a modern complementary defense that prevents cookies from being sent on cross-origin requests at all
- CSRF tokens do **not** protect against XSS — if an attacker can execute JavaScript on your domain, they can read the token directly
- The **Synchronizer Token Pattern** and **Double Submit Cookie Pattern** are the two primary CSRF token implementation strategies covered in OWASP guidelines

## Related concepts
[[Cross-Site Request Forgery]] [[Same-Origin Policy]] [[Session Hijacking]] [[SameSite Cookies]] [[Cross-Site Scripting]]