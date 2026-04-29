# SameSite Cookie

## What it is
Think of it like a bouncer at a private club who only lets your drink order through if *you* placed it while standing inside — not if someone outside slid a note under the door. SameSite is a cookie attribute that instructs browsers to restrict when cookies are sent with cross-site requests. It controls whether a cookie travels along with requests that originate from a different domain than the one that set the cookie.

## Why it matters
Without SameSite restrictions, an attacker can craft a malicious webpage that silently triggers a state-changing request to your bank's site — and the browser helpfully attaches your session cookie, authenticating the attack. This is classic Cross-Site Request Forgery (CSRF). Setting `SameSite=Strict` on the session cookie means the browser refuses to send it with any cross-origin request, effectively neutering the attack without requiring token-based CSRF defenses.

## Key facts
- **Three values**: `Strict` (cookie never sent cross-site), `Lax` (sent only on top-level navigation GETs, like clicking a link), `None` (always sent, but *requires* `Secure` attribute or browser blocks it)
- **Default behavior**: Modern browsers default to `SameSite=Lax` if the attribute is omitted, closing the worst CSRF gaps automatically
- **`SameSite=None; Secure`** is required for legitimate third-party cookie use cases like embedded payment widgets or OAuth flows
- **Defense layer, not a silver bullet**: SameSite doesn't protect against XSS — if an attacker runs script on your origin, same-site requests are fair game
- **Chrome 80+ enforcement**: Google's 2020 update made `Lax` the default, breaking many legacy apps that relied on unguarded cross-site cookie sending

## Related concepts
[[CSRF]] [[Session Hijacking]] [[Cookie Security Attributes]] [[Same-Origin Policy]] [[OAuth 2.0]]