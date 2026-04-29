# SameSite Cookies

## What it is
Think of SameSite as a bouncer at a club who checks whether a request originated *inside* the venue before letting a cookie through — cross-site requests get stopped at the door. It is a cookie attribute (`SameSite=Strict|Lax|None`) that instructs browsers to control whether cookies are sent along with cross-site requests, directly limiting the attack surface for cross-site request forgery (CSRF).

## Why it matters
Without SameSite restrictions, a malicious site can embed a hidden form that silently submits a POST request to your bank — and your browser dutifully attaches your session cookie, authenticating the forged action. Setting `SameSite=Strict` on the session cookie means the browser will not attach it to any cross-origin request, neutralizing the attack entirely even if no CSRF token is present.

## Key facts
- **Three values**: `Strict` (never sent cross-site), `Lax` (sent on top-level GET navigation only), `None` (always sent — requires `Secure` flag to prevent plaintext leakage)
- **Default behavior**: Modern browsers default to `Lax` when no SameSite attribute is specified, providing partial CSRF protection out of the box
- **`SameSite=None` requires HTTPS**: Combining `None` without `Secure` causes most browsers to reject or ignore the cookie entirely
- **Not a complete CSRF solution**: Lax still allows cookies on cross-site GET requests initiated by top-level navigation (e.g., clicking a link), so idempotency of GET methods remains important
- **"Same-site" ≠ "same-origin"**: Two subdomains under the same registrable domain (e.g., `api.example.com` and `app.example.com`) are considered same-site but not same-origin — a subtle but testable distinction

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Cookie Security Attributes]] [[Same-Origin Policy]]