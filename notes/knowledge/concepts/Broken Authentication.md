# Broken Authentication

## What it is
Imagine a nightclub bouncer who never checks IDs, accepts expired licenses, or lets anyone in who *claims* to be on the VIP list — that's broken authentication. It refers to flaws in how applications verify user identity, including weak password policies, improper session management, credential exposure, and missing multi-factor authentication. Attackers exploit these weaknesses to impersonate legitimate users without ever needing to crack encryption.

## Why it matters
In the 2012 LinkedIn breach, attackers stole 6.5 million (later revealed to be 117 million) password hashes stored using unsalted SHA-1 — a broken authentication implementation that allowed mass credential cracking within hours. Defenders responded by migrating to bcrypt with salting, demonstrating that the storage mechanism itself is part of the authentication chain and must be hardened end-to-end.

## Key facts
- Broken Authentication is listed in the **OWASP Top 10** (historically #2, now merged under broader identity failures in 2021 edition)
- **Credential stuffing** attacks exploit broken authentication by replaying breached username/password pairs across multiple sites — possible because users reuse passwords
- Session tokens with **insufficient entropy** (predictable values) allow attackers to hijack sessions without stealing credentials directly
- **Default credentials** (admin/admin) left unchanged on devices or applications are a textbook broken authentication vulnerability tested on Security+
- Mitigations include: enforcing **MFA**, implementing account lockout policies, using secure session management (HttpOnly/Secure cookie flags), and hashing passwords with **bcrypt, scrypt, or Argon2**

## Related concepts
[[Session Hijacking]] [[Credential Stuffing]] [[Multi-Factor Authentication]] [[Password Spraying]] [[OWASP Top 10]]