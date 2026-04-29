# NIST SP 800-63B

## What it is
Think of it as the FDA's nutrition label for passwords — a federal standard that tells organizations exactly what "healthy" authentication looks like. NIST SP 800-63B (Digital Identity Guidelines, Authentication and Lifecycle Management) defines requirements for authenticator strength, password policies, and multi-factor authentication across three Assurance Levels (AAL1, AAL2, AAL3).

## Why it matters
In 2019, a major healthcare provider was breached because their password policy forced 90-day rotations and complexity requirements — causing users to follow predictable patterns like "Summer2019!". NIST 800-63B directly contradicts this outdated approach: it mandates checking passwords against breach databases instead of forcing rotation, preventing exactly the credential stuffing attack that followed.

## Key facts
- **Banned passwords list**: Organizations MUST check new passwords against known-compromised credential lists (e.g., Have I Been Pwned) — not just enforce complexity rules
- **No mandatory periodic rotation**: NIST explicitly prohibits forced password expiration *unless* there is evidence of compromise
- **Minimum 8 characters, support up to 64**: Passphrases are encouraged; truncating long passwords violates the standard
- **AAL2 requires MFA**: Must use two distinct authentication factors; SMS OTP is permitted but discouraged due to SIM-swapping risk
- **AAL3 requires hardware-based authentication**: Phishing-resistant cryptographic authenticators (e.g., FIDO2/WebAuthn keys) are mandatory at the highest assurance level

## Related concepts
[[Multi-Factor Authentication]] [[Password Spraying]] [[FIDO2/WebAuthn]] [[Credential Stuffing]] [[NIST Cybersecurity Framework]]