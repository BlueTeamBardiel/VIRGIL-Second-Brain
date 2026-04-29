# Key Store

## What it is
Think of a key store like a bank vault with individual safety deposit boxes — each box holds a cryptographic key or certificate, and you need the right credentials to open any specific box. Precisely, a key store is a secured repository (file, database, or hardware module) that stores cryptographic keys, certificates, and secrets used for encryption, authentication, and signing operations. Access to the store itself is typically protected by a master password or hardware authentication.

## Why it matters
In 2017, attackers targeting Android apps discovered that developers frequently hardcoded keystore passwords directly in source code, or used weak default passwords like "changeit" — exposing private keys that could be extracted to sign malicious APKs with legitimate certificates. A compromised key store means an attacker can impersonate your server, decrypt historical TLS traffic, or forge signed software — essentially inheriting your cryptographic identity entirely.

## Key facts
- Java KeyStore (JKS) and PKCS#12 (.p12/.pfx) are the two most common key store formats tested on Security+ and CySA+
- Hardware Security Modules (HSMs) are the gold-standard key store implementation — keys never leave the hardware in plaintext
- Key stores hold both **private keys** and **trusted certificates** (trust stores); these are logically distinct roles sometimes combined in one file
- The default password for many Java keystores is literally `changeit` — a notorious misconfiguration vector
- Key stores should enforce **key lifecycle management**: generation, rotation, expiration, and revocation policies

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Management]] [[Hardware Security Module (HSM)]] [[Transport Layer Security (TLS)]] [[Cryptographic Key Management]]