# Multifactor Authentication

## What it is

In Portal, GLaDOS doesn't just check that you have the Portal Gun — she also routes you through chambers gated by pressure plates, cube placements, and timed switches. Possessing the gun isn't enough; you have to *be standing somewhere* and *do something* before the door opens. That's exactly what Multifactor Authentication does — it demands proof from more than one independent category before granting access, so a stolen credential alone can't open the door.

**Multifactor Authentication (MFA)** is an authentication method requiring the user to present two or more credentials drawn from *different* authentication factor categories to verify identity.

## Why it matters

Single-factor password authentication is a slow-motion catastrophe: credential stuffing, phishing, and database breaches turn one leaked password into total account compromise. MFA breaks that chain — the attacker who phished the password still lacks the phone, the fingerprint, or the location. **SY0-701 Objective 4.6** explicitly requires you to know MFA implementations and the factors and attributes involved. CompTIA's favorite trap: presenting two items from the *same* factor (e.g., password + security question — both "something you know") and asking if it qualifies as MFA. It does not.

## Key facts

### The five factors and attributes

CompTIA splits MFA into **factors** (what you authenticate with) and **attributes** (context about the authentication).

| Type | Category | Examples |
|---|---|---|
| Factor | **Something you know** | [[Password]], PIN, [[security question]] |
| Factor | **Something you have** | [[Smart card]], [[hardware token]] ([[YubiKey]]), [[TOTP]] app, [[push notification]] |
| Factor | **Something you are** | [[Fingerprint]], [[retina scan]], [[facial recognition]], voiceprint — i.e., [[biometrics]] |
| Attribute | **Somewhere you are** | [[GPS]] location, [[geofencing]], IP geolocation |
| Attribute | **Something you do** | Typing rhythm, mouse patterns, [[behavioral biometrics]] |

True MFA requires factors from **different categories**. Two passwords ≠ MFA. Password + fingerprint = MFA.

### Common implementations

- **[[TOTP]]** — Time-based One-Time Password (RFC 6238). 6-digit code rotating every 30 seconds. Google Authenticator, Authy.
- **[[HOTP]]** — HMAC-based One-Time Password (RFC 4226). Counter-based, not time-based. Used in some hardware tokens.
- **[[Push notification]]** — Approve/deny prompt on a registered device. Vulnerable to **[[MFA fatigue]]** attacks.
- **[[SMS]]-based codes** — Discouraged. Vulnerable to [[SIM swapping]] and [[SS7]] interception. NIST SP 800-63B deprecates it for high-assurance use.
- **[[FIDO2]] / [[WebAuthn]]** — Phishing-resistant hardware-backed authentication. The gold standard.
- **[[Smart card]] + PIN** — Common in government/military ([[CAC]], [[PIV]] cards). Combines "have" + "know."
- **[[Biometric]] + password** — Phone unlock patterns.

### Attacks against MFA

| Attack | Mechanic | Defense |
|---|---|---|
| **[[MFA fatigue]]** (push bombing) | Spam push prompts until user taps Approve | [[Number matching]], rate limiting |
| **[[SIM swapping]]** | Hijack phone number to intercept SMS codes | Drop SMS; use TOTP/FIDO2 |
| **[[Adversary-in-the-middle]]** ([[AitM]]) | Proxy login page captures session token after MFA | [[FIDO2]] / [[WebAuthn]] (origin-bound) |
| **[[Pass-the-cookie]]** | Steal post-MFA session cookie | Short session lifetimes, device binding |
| **Social engineering helpdesk** | Convince support to reset MFA | Strong identity verification procedures |

### Exam-relevant nuances

- **2FA is a subset of MFA.** Two factors = MFA. CompTIA may use the terms interchangeably; don't get tripped up.
- **[[Single Sign-On]] ([[SSO]])** is *not* MFA — it's session reuse. SSO can be paired with MFA at the initial authentication.
- **Authentication ≠ Authorization.** MFA proves *who you are*, not *what you can do*.
- **[[Adaptive authentication]]** / [[risk-based authentication]] uses attributes (location, device, behavior) to decide *when* to demand additional factors.

## Related concepts

[[Authentication]] · [[Authorization]] · [[Identity and Access Management]] · [[FIDO2]] · [[TOTP]] · [[Biometrics]] · [[Single Sign-On]] · [[Passwordless authentication]] · [[Zero Trust]] · [[MFA fatigue]] · [[Adaptive authentication]]

---
*Source: VIRGIL knowledge base — 2026-05-08*