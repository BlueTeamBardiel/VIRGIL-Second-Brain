# discharge tokens

## What it is
Like a one-time boarding pass that self-destructs after you walk through the gate, a discharge token is a cryptographic credential that becomes invalid immediately after a single successful use. Precisely, it is a nonce-based authentication or authorization token designed with a "burn after reading" property — the server marks it consumed upon first presentation, preventing any replay.

## Why it matters
In password reset flows, a discharge token sent via email ensures that even if an attacker intercepts the reset link hours later, it is already invalidated after the legitimate user clicked it once. Without this control, an attacker with delayed email access (e.g., through a compromised mail archive) could reuse the reset link to take over the account — a classic replay attack scenario that discharge tokens directly neutralize.

## Key facts
- Discharge tokens are single-use by design; the server maintains state (a "used" flag or deletion) in a backing store after first validation
- They are distinct from expiring tokens — a discharge token can expire AND be single-use; expiry alone does not prevent replay within the validity window
- Commonly implemented in password reset links, email verification flows, and OAuth one-time authorization codes (the `code` in the authorization code flow is a discharge token)
- Proper implementation requires atomic check-and-mark operations to prevent TOCTOU (Time-of-Check Time-of-Use) race conditions where two simultaneous requests both pass validation
- Storage of used token hashes (rather than raw tokens) in the database prevents exposure of valid tokens if the "used tokens" table is breached

## Related concepts
[[replay attack]] [[nonce]] [[OAuth authorization code flow]] [[TOCTOU race condition]] [[session token]]