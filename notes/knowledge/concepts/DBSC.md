# DBSC

## What it is
Like a bouncer who checks not just your ID but also verifies you're *physically present* at the door each time you re-enter — Device Bound Session Credentials (DBSC) is a proposed browser API that cryptographically binds web authentication sessions to a specific device using a private key stored in hardware (e.g., TPM), making stolen session cookies useless on any other machine.

## Why it matters
Cookie theft via info-stealer malware (like Redline or Raccoon) is a dominant initial access vector — attackers exfiltrate session cookies and replay them from entirely different machines, bypassing MFA entirely. DBSC defeats this by requiring the server to periodically challenge the browser with a proof-of-possession cryptographic signature that only the original device's hardware key can produce; a stolen cookie without the bound private key is worthless.

## Key facts
- DBSC is a **Google-proposed open standard** currently in origin trial in Chrome; it is not yet a ratified W3C standard
- Session binding uses **asymmetric key pairs** where the private key never leaves the secure hardware enclave (TPM/Secure Enclave)
- The server issues short-lived session tokens and **periodically re-challenges** the client — the session dies if the device cannot sign the challenge
- Designed to defeat **pass-the-cookie attacks** without requiring users to re-authenticate (transparent to end-users)
- DBSC only protects against **post-issuance cookie theft**; it does not protect against credential phishing or account takeover at login time

## Related concepts
[[Session Hijacking]] [[Pass-the-Cookie Attack]] [[TPM (Trusted Platform Module)]] [[Multi-Factor Authentication]] [[Hardware-Backed Attestation]]