# Pre-authentication

## What it is
Like a bouncer checking your ID *before* you even tell them your name — pre-authentication is a security requirement that forces a user to prove identity *before* the system processes any meaningful request. In Kerberos, pre-authentication requires the client to encrypt a timestamp with their password hash before the Key Distribution Center (KDC) issues a Ticket Granting Ticket (TGT).

## Why it matters
When Kerberos pre-authentication is **disabled** on an account, an attacker can request a TGT for that user without any credential — the KDC happily returns an encrypted blob that can be cracked offline. This is the AS-REP Roasting attack: tools like `Rubeus` or `GetNPUsers.py` harvest these encrypted responses and feed them to `hashcat`, potentially recovering plaintext passwords without ever touching the domain controller's logs in a meaningful way.

## Key facts
- **AS-REP Roasting** targets accounts with "Do not require Kerberos preauthentication" enabled in Active Directory (`DONT_REQ_PREAUTH` flag)
- Without pre-authentication, the KDC returns an AS-REP encrypted with the user's password-derived key — crackable offline at full GPU speed
- Pre-authentication is **enabled by default** in modern Active Directory; it must be explicitly disabled, often for legacy application compatibility
- The encrypted timestamp uses the user's NTLM hash as a key, so weak passwords are the real vulnerability even when pre-auth is enforced
- Defenders detect AS-REP Roasting by monitoring for **Event ID 4768** with encryption type `0x17` (RC4) and no pre-authentication flag set

## Related concepts
[[Kerberos Authentication]] [[AS-REP Roasting]] [[Kerberoasting]] [[Active Directory Attack Techniques]] [[Offline Password Cracking]]