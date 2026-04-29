# SameSite Cookie Attribute

## What it is
Like a bouncer who only lets regulars in — someone already inside the club — SameSite tells the browser to send a cookie *only* when the request originates from the same site that set it, blocking uninvited cross-site requests from carrying it along. It is an HTTP cookie attribute (`SameSite=Strict`, `Lax`, or `None`) that controls whether cookies are transmitted with cross-origin requests, serving as a browser-enforced defense against cross-site request forgery.

## Why it matters
A banking site sets a session cookie without `SameSite`. An attacker tricks a logged-in user into visiting a malicious page containing a hidden form that POSTs a fund transfer to the bank. The browser helpfully attaches the session cookie — and the bank processes the fraudulent request. With `SameSite=Strict`, the browser refuses to attach that cookie to any cross-site request, silently killing the attack before it starts.

## Key facts
- **Strict**: Cookie is never sent with cross-site requests — including when clicking a link from another site, which can break OAuth flows and external navigation.
- **Lax**: Cookie is sent with top-level navigations (GET requests via links) but *not* with cross-site POST, iframe loads, or image requests. This is the modern browser default.
- **None**: Cookie is always sent cross-site, but *requires* `Secure` attribute (HTTPS only) or browsers will reject the cookie outright.
- As of 2020, Chrome defaults unattributed cookies to `Lax`, meaning legacy apps may break silently when relying on cross-site cookie delivery.
- `SameSite` does **not** replace CSRF tokens — it is a defense-in-depth layer, not a complete CSRF mitigation on its own.

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Cookie Security Attributes]] [[Content Security Policy]] [[Session Hijacking]]