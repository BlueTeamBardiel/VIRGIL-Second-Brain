# libnss3

## What it is
Think of it as the universal translator that lets your browser speak fluent TLS, certificate, and cryptography — without every app reinventing the wheel. `libnss3` (Network Security Services 3) is a shared library developed by Mozilla that provides cross-platform cryptographic functions, including TLS/SSL protocol handling, certificate management, and PKCS standards support, used by Firefox, Thunderbird, and many Linux applications.

## Why it matters
In 2021, a critical heap buffer overflow vulnerability (CVE-2021-43527) was discovered in libnss3's DER signature parsing code, affecting any application that used NSS for certificate verification — not just browsers. An attacker could craft a malicious certificate that triggered the overflow when verified, potentially enabling remote code execution on email clients and other NSS-dependent tools, demonstrating how a single shared library flaw cascades across an entire ecosystem.

## Key facts
- **Shared library risk multiplier**: Because libnss3 is a dynamically linked dependency, a single unpatched version compromises every application on the system that links against it.
- **Certificate validation chain**: libnss3 handles the full X.509 certificate path validation process, making it a high-value target for attacks that want to bypass TLS trust checks.
- **FIPS 140-2 compliance**: NSS includes a FIPS 140-2 validated cryptographic module, making it common in government and compliance-heavy Linux deployments.
- **Separate certificate store**: Unlike Windows (CertStore) or macOS (Keychain), libnss3 maintains its own certificate database (`cert9.db`), meaning Firefox may trust different CAs than the OS does.
- **Common Linux attack surface**: Privilege escalation exploits on Linux systems often scan for outdated libnss3 versions as part of local exploit chaining.

## Related concepts
[[TLS/SSL]] [[X.509 Certificates]] [[Shared Library Hijacking]] [[CVE Vulnerability Scoring]] [[Certificate Authority Trust]]