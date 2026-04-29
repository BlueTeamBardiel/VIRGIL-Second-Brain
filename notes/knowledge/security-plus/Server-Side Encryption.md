# Server-Side Encryption

## What it is
Like a hotel safe where the *hotel staff* locks your luggage rather than you — the server encrypts your data after it arrives, using keys it manages on your behalf. Formally, Server-Side Encryption (SSE) means the cloud or storage provider encrypts data at rest on its infrastructure, transparently handling key generation, storage, and decryption when authorized requests arrive.

## Why it matters
In 2019, a Capital One breach exposed over 100 million records from AWS S3 buckets. While SSE protected the raw storage layer from physical disk theft, the attacker exploited a misconfigured WAF to obtain IAM credentials — demonstrating that SSE does not protect against authenticated API abuse. This illustrates SSE's core limitation: if the server can decrypt (because it holds the keys), so can anyone who compromises server-side credentials.

## Key facts
- **Three SSE variants in AWS**: SSE-S3 (AWS manages keys), SSE-KMS (AWS Key Management Service, with audit trail via CloudTrail), and SSE-C (customer provides keys per request — AWS never stores them)
- SSE protects **data at rest**, not data in transit; TLS/HTTPS is still required separately for in-flight protection
- SSE-KMS provides **envelope encryption**: a data encryption key (DEK) encrypts the data; a key encryption key (KEK) encrypts the DEK — only the KEK lives in KMS
- Under **shared responsibility model**, SSE is typically the provider's responsibility, but key management policy (rotation, access control) remains the customer's responsibility
- SSE does **not** protect against a malicious insider at the cloud provider who has legitimate key access — that threat requires client-side encryption instead

## Related concepts
[[Client-Side Encryption]] [[Encryption at Rest]] [[Key Management Service]] [[Envelope Encryption]] [[Shared Responsibility Model]]