# wolfSSL

## What it is
Like a Swiss Army knife trimmed down to just a scalpel — lightweight but precise — wolfSSL is a compact, embedded TLS/SSL library written in C, specifically engineered for resource-constrained environments like IoT devices, microcontrollers, and real-time operating systems where OpenSSL would be too heavy to run.

## Why it matters
In 2022, researchers discovered that wolfSSL had a buffer overflow vulnerability (CVE-2022-38152) affecting session ticket handling, which could allow remote attackers to crash TLS servers running on embedded devices — including industrial control systems and medical equipment. This illustrates how cryptographic library flaws in embedded environments are especially dangerous because patching millions of deployed IoT devices is slow or impossible, leaving attack surfaces open for years.

## Key facts
- wolfSSL implements **TLS 1.0 through TLS 1.3** and supports DTLS, making it relevant for both TCP and UDP-based secure communications
- Written in **ANSI C with no external dependencies**, making it portable to bare-metal environments as small as 20–100 KB of flash/RAM
- Holds **FIPS 140-2 and FIPS 140-3 certifications**, making it legally usable in U.S. government and defense applications
- Supports **post-quantum cryptography algorithms** (e.g., KYBER, DILITHIUM) via its experimental integration — relevant for future-proofing embedded systems
- Commonly found in **automotive (AUTOSAR), aerospace, and medical device firmware**, meaning a single library vulnerability has broad critical infrastructure impact

## Related concepts
[[TLS/SSL]] [[FIPS 140-2]] [[Embedded Systems Security]] [[IoT Security]] [[Buffer Overflow]]