# Password Reuse

## What it is
Using the same house key for your front door, office, and safety deposit box means one stolen key opens everything — password reuse works identically. It is the practice of using the same password (or minor variations of it) across multiple accounts or systems, meaning a single credential compromise propagates access across all reused sites.

## Why it matters
In a **credential stuffing attack**, adversaries take billions of username/password pairs leaked from breaches (like the 2012 LinkedIn dump of 117 million accounts) and automate login attempts against unrelated services like banking or email. If a user reused their LinkedIn password on their bank account, the attacker gains access without ever cracking anything — the credential is already valid. This is why even "old" breaches remain operationally dangerous years later.

## Key facts
- **Credential stuffing** is distinct from brute force — it uses known valid credentials, not guesses, making it harder to detect via lockout policies alone
- Tools like **Sentry MBA**, **OpenBullet**, and **Snipr** are commonly used to automate credential stuffing at scale
- **HaveIBeenPwned** (HIBP) aggregates breach data so users and enterprises can check if credentials are exposed
- NIST SP 800-63B explicitly recommends checking new passwords against **known breached password lists** to prevent reuse of compromised credentials
- **Password managers** (Bitwarden, 1Password) are the primary mitigation — they eliminate the cognitive burden of remembering unique passwords, removing the incentive to reuse

## Related concepts
[[Credential Stuffing]] [[Brute Force Attack]] [[Multi-Factor Authentication]] [[Password Spraying]] [[Data Breach]]