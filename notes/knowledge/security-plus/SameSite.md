# SameSite

## What it is
Like a bouncer who only lets in guests who arrived from *within* the venue — not outsiders who claim to be regulars — SameSite is a cookie attribute that controls whether a browser sends a cookie along with cross-site requests. It tells the browser: "Only attach this cookie if the request originated from the same site that set it."

## Why it matters
Without SameSite, an attacker can craft a malicious webpage that triggers a state-changing request (like a fund transfer) to your bank — and your browser will dutifully attach your authenticated session cookie. This is the classic **Cross-Site Request Forgery (CSRF)** attack. Setting `SameSite=Strict` or `SameSite=Lax` on session cookies breaks this attack by refusing to send the cookie when the request originates from a foreign site.

## Key facts
- **Three values**: `Strict` (never sent cross-site), `Lax` (sent on top-level navigations like clicking a link, but not on embedded images or AJAX), `None` (always sent, but *requires* `Secure` flag)
- `SameSite=Lax` became the **default in modern browsers** (Chrome 80+) when no attribute is explicitly set
- `SameSite=None` without `Secure` is **rejected by browsers** — the cookie simply won't be sent
- SameSite does **not** replace CSRF tokens — it's a complementary defense layer, not a complete solution
- SameSite is a **defense-in-depth control**, not an authentication or encryption mechanism — it only affects *when* cookies are transmitted

## Related concepts
[[Cross-Site Request Forgery]] [[CSRF Tokens]] [[Cookie Security Attributes]] [[Same-Origin Policy]] [[Cross-Site Scripting]]