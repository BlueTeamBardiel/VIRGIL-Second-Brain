# Dragonfly Handshake

## What it is
Imagine two people agreeing on a meeting location by each independently solving the same puzzle — neither ever directly tells the other the answer, yet both arrive at the same place. The Dragonfly Handshake (formally defined in RFC 7664) is a password-authenticated key exchange protocol that derives a shared cryptographic key from a password without ever transmitting that password or anything derived from it across the wire. It achieves this through a **commit-then-confirm** structure using elliptic curve or finite field cryptography.

## Why it matters
Dragonfly is the core handshake mechanism behind **WPA3-Personal (SAE — Simultaneous Authentication of Equals)**, replacing the vulnerable 4-way handshake of WPA2-PSK. In 2019, the **Dragonblood** vulnerabilities (CVE-2019-9494) revealed that flawed implementations leaked timing and cache side-channel information, allowing attackers to reconstruct the password offline — ironically mimicking the PMKID attack it was designed to prevent.

## Key facts
- **SAE (WPA3) uses Dragonfly** as its authentication exchange, eliminating the ability to capture a handshake for offline dictionary attacks
- The protocol provides **forward secrecy**: compromising the password after the fact does not expose past session traffic
- Uses a **commit/confirm two-phase** structure — both peers commit to a value derived from the password, then confirm correctness without revealing the password itself
- The **hunting-and-pecking algorithm** maps a password to an elliptic curve point; side-channel vulnerabilities in this step were the root cause of Dragonblood
- Resistant to **passive eavesdropping and offline brute-force**, but early implementations were vulnerable to timing-based **active side-channel attacks**

## Related concepts
[[WPA3]] [[Simultaneous Authentication of Equals (SAE)]] [[Password-Authenticated Key Exchange (PAKE)]] [[Side-Channel Attack]] [[Forward Secrecy]]