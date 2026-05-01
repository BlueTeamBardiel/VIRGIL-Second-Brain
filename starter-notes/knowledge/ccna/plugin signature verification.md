# plugin signature verification

## What it is
Like a wax seal on a medieval letter — if the seal is broken or forged, you know the contents were tampered with before they reached you. Plugin signature verification is the process of cryptographically validating that a software plugin or extension was created by a trusted publisher and has not been modified since signing, typically using asymmetric key pairs and certificate chains.

## Why it matters
In 2020, attackers compromised the SolarWinds Orion build pipeline and injected malicious code into legitimate, signed software updates — demonstrating that signature verification only protects against *post-build* tampering, not a compromised signing process itself. Defenders use signature verification as a mandatory gate in software supply chain security to reject unsigned or invalidly signed plugins before execution.

## Key facts
- Plugins are signed using the publisher's **private key**; verification uses the corresponding **public key** embedded in a trusted certificate
- Browsers like Chrome enforce **Web Store signing** — extensions must be signed by Google's infrastructure, preventing sideloading of unsigned plugins by default
- A **revoked or expired certificate** should cause verification to fail, even if the cryptographic signature itself is mathematically valid
- **Code signing certificates** can be stolen or fraudulently issued, meaning signature validity does not guarantee the publisher's system was uncompromised
- Plugin signature verification is a core control against **supply chain attacks** and is referenced in frameworks like NIST SP 800-161 and SLSA (Supply chain Levels for Software Artifacts)

## Related concepts
[[code signing]] [[public key infrastructure]] [[supply chain attacks]] [[certificate revocation]] [[software bill of materials]]
