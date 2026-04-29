# token store

## What it is
Think of a token store like a coat-check room at a club — you surrender your coat (credentials) once at the door, receive a numbered ticket (token), and flash that ticket all night instead of carrying your coat everywhere. Precisely, a token store is a secured repository — in memory, on disk, or within a dedicated service — where authentication tokens (JWTs, OAuth access tokens, session tokens) are held for reuse during an authenticated session. It abstracts credential handling so applications request tokens from one central location rather than repeatedly authenticating from scratch.

## Why it matters
In the 2020 SolarWinds attack, adversaries harvested SAML tokens cached in token stores to move laterally across cloud environments — never touching passwords at all. Once an attacker reads tokens from an in-memory store (e.g., via a process dump of an SSO agent), they can replay those tokens against any relying service until expiration, making token lifetime and storage isolation critical defense controls.

## Key facts
- Tokens stored in **browser localStorage** are accessible to JavaScript, making them vulnerable to XSS attacks; **httpOnly cookies** are preferred for web token storage.
- **Pass-the-token** attacks mirror Pass-the-Hash — stolen tokens are replayed without ever cracking a password.
- Token stores should enforce **short TTLs (time-to-live)** and support **token revocation lists** to invalidate compromised tokens before expiration.
- On Windows, the **LSA (Local Security Authority)** process acts as a privileged token store; tools like Mimikatz target it directly to extract Kerberos tickets.
- **Secret managers** (HashiCorp Vault, AWS Secrets Manager) function as hardened token stores with auditing, rotation, and access-control policies baked in.

## Related concepts
[[OAuth 2.0]] [[JSON Web Token (JWT)]] [[Pass-the-Hash]] [[Single Sign-On (SSO)]] [[Credential Dumping]]