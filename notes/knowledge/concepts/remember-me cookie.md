# remember-me cookie

## What it is
Like leaving a spare key under the doormat so you don't need your full keychain every visit — a remember-me cookie is a long-lived browser token that lets a web application authenticate a returning user without requiring them to log in again. Technically, it is a persistent HTTP cookie containing a token (often a random value mapped server-side to a user account) with an expiration date measured in days or weeks rather than the browser session.

## Why it matters
In the 2012 breach analysis of poorly implemented sites, attackers who stole remember-me cookies via XSS could authenticate as victims indefinitely — bypassing passwords and MFA entirely — because the tokens were never invalidated after a password change. A proper defense requires server-side token rotation (issuing a new token on each use) and immediate invalidation of all persistent tokens when the user resets credentials.

## Key facts
- Remember-me cookies should be **cryptographically random** (≥128 bits of entropy) and treated with the same sensitivity as session tokens
- They must be stored **server-side in a lookup table** — encoding user ID or role data directly in the cookie is a broken authentication vulnerability
- The cookie should carry **Secure, HttpOnly, and SameSite=Strict** flags to limit exposure to network sniffing, XSS, and CSRF
- **Token rotation** — issuing a fresh token on every use and invalidating the old one — defeats replay attacks from stolen cookies
- Password or email changes should **revoke all active remember-me tokens** for that account; failure to do so is flagged under OWASP A07 (Identification and Authentication Failures)

## Related concepts
[[session token]] [[persistent cookie]] [[broken authentication]] [[HttpOnly flag]] [[CSRF]]