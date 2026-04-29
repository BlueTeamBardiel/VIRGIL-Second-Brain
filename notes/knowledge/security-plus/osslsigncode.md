# osslsigncode

## What it is
Think of it as a notary stamp machine that works on any desk — not just the official government office. `osslsigncode` is an open-source command-line tool that applies Authenticode digital signatures to Windows PE executables (`.exe`, `.dll`, `.cab`, `.msi`) on non-Windows systems like Linux and macOS, using OpenSSL under the hood.

## Why it matters
Attackers use `osslsigncode` to sign malware with stolen or self-signed code-signing certificates, making payloads appear legitimate to Windows SmartScreen and endpoint defenses that check for the presence of a signature without fully validating the certificate chain. In red team operations, signing a payload with even an expired or untrusted certificate can bypass certain AV heuristics that treat unsigned binaries more aggressively than signed ones.

## Key facts
- Signs PE binaries using PKCS#12 (`.pfx`) certificate bundles — the same format used by legitimate Windows developers
- Can **add, remove, verify, or timestamp** Authenticode signatures, making it useful for both offense and forensic analysis
- Timestamp counter-signing (via RFC 3161 TSA servers) allows a signature to remain valid even after the signing certificate expires — a critical evasion detail
- A valid-looking signature does **not** mean the binary is safe; trust depends on the CA chain, not the presence of a signature
- Forensic analysts use `osslsigncode -verify` to extract signer details, certificate thumbprints, and signing timestamps from suspicious binaries during incident response

## Related concepts
[[Authenticode]] [[Code Signing Certificates]] [[PE File Format]] [[SmartScreen Filter]] [[Certificate Pinning]]