# Macaroon

## What it is
Like a hotel keycard that has "only works on floor 3, only between 9–5, only for housekeeping" stamped right into the magnetic strip — a Macaroon is a bearer token that carries its own *caveats* (restrictions) cryptographically baked in, using a chain of HMAC signatures. Unlike a JWT where the server validates claims, Macaroons allow the *holder* to add further restrictions before delegating, without contacting the issuing authority.

## Why it matters
In a cloud storage API, an admin can issue a Macaroon granting full access, then a developer attaches a caveat limiting it to read-only operations on a specific bucket, expiring in one hour, before handing it to an automated job. If that token is stolen, the attacker inherits all the baked-in restrictions — a massive improvement over a raw API key that would grant full access forever.

## Key facts
- Macaroons use **chained HMACs**: each caveat appends a new HMAC derived from the previous one, making it cryptographically impossible to *remove* a caveat without invalidating the chain.
- **Third-party caveats** allow delegation to external services — e.g., "this token is only valid if auth-service.example.com confirms the user is logged in."
- The issuing server only stores the **root key**, not every issued token — the token itself carries proof of legitimacy.
- They were introduced by Google researchers in 2014 and are used in systems like **Bakery (Go)** and **libmacaroons**.
- Unlike OAuth tokens, Macaroons require **no database lookup** to verify first-party caveats — verification is purely cryptographic.

## Related concepts
[[JSON Web Token (JWT)]] [[HMAC]] [[Capability-Based Access Control]] [[OAuth 2.0]] [[Least Privilege]]