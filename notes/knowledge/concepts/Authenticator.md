# Authenticator

## What it is
Like a bouncer checking your ID at the door — an authenticator is the mechanism that verifies *you are who you claim to be* before granting access. Precisely, it is any factor or device used to confirm identity during the authentication process, ranging from passwords and hardware tokens to biometrics and authenticator apps (like Google Authenticator or Microsoft Authenticator).

## Why it matters
In the 2020 Twitter hack, attackers used phone-based social engineering to bypass SMS authenticators — a stark reminder that not all authenticators are equally strong. Organizations that had moved from SMS OTP to TOTP apps or hardware tokens (like YubiKeys) were significantly more resistant to this SIM-swapping attack vector, illustrating why authenticator *type* selection is a critical security decision.

## Key facts
- **Three authenticator categories** map to the classic factors: something you know (password/PIN), something you have (hardware token, phone app), and something you are (biometric)
- **TOTP (Time-based One-Time Password)** authenticator apps generate 6-digit codes every 30 seconds using a shared secret and the current timestamp (RFC 6238)
- **SMS-based authenticators** are considered the weakest second factor due to SIM-swapping and SS7 protocol vulnerabilities — NIST SP 800-63B deprecated them as a sole authenticator
- **FIDO2/WebAuthn** represents the strongest modern authenticator standard, using public-key cryptography and binding authentication to a specific origin (preventing phishing)
- Authenticators are evaluated by **AAL (Authenticator Assurance Level)** in NIST 800-63B: AAL1 (single factor), AAL2 (MFA required), AAL3 (hardware-bound cryptographic authenticator required)

## Related concepts
[[Multi-Factor Authentication]] [[TOTP]] [[FIDO2]] [[Identity and Access Management]] [[SIM Swapping]]