# Key Management System

## What it is
Think of a KMS like a heavily-guarded key lockbox at a hotel — front desk staff can retrieve the right room key for the right guest without ever exposing the master key. A Key Management System is the infrastructure and policies governing the full lifecycle of cryptographic keys: creation, distribution, storage, rotation, and destruction. It ensures keys are available when needed but never exposed to unauthorized parties.

## Why it matters
In 2019, attackers compromised a misconfigured AWS S3 bucket partly because hardcoded encryption keys were embedded in source code — a classic KMS failure. A properly implemented KMS would have stored those keys in a dedicated service (like AWS KMS or HashiCorp Vault), enforcing role-based access so no developer's stolen credentials could expose raw key material.

## Key facts
- **Key lifecycle phases**: generation → distribution → storage → rotation → suspension → destruction (all six must be managed)
- **Separation of duties**: The entity that uses a key should not be the same entity that manages or escrows it
- **Key escrow**: A copy of the key is held by a trusted third party (e.g., law enforcement access scenarios); creates a deliberate backup — and deliberate risk
- **Hardware Security Modules (HSMs)** are physical devices that store keys and perform cryptographic operations without ever exposing the raw key material to software
- **NIST SP 800-57** is the authoritative guidance document for key management best practices, referenced on Security+ and CySA+ exams

## Related concepts
[[Hardware Security Module]] [[Public Key Infrastructure]] [[Certificate Lifecycle Management]] [[Cryptographic Key Rotation]] [[Separation of Duties]]