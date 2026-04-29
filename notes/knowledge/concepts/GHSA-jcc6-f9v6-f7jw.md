# GHSA-jcc6-f9v6-f7jw

## What it is
Like a forged letter of recommendation that bypasses a hiring manager's background check, this vulnerability involves improper verification of cryptographic signatures in the `tough` crate (a Rust implementation of The Update Framework, TUF). Specifically, it allowed attackers to bypass threshold signature validation, meaning a repository could be accepted as legitimate even without the required number of valid signatures.

## Why it matters
TUF was designed to protect software update systems against supply chain attacks — if an attacker compromises one signing key, threshold requirements ensure they cannot push malicious packages alone. This vulnerability in `tough` (used notably in Amazon's Bottlerocket OS update infrastructure) undermined that defense, meaning a single compromised key could potentially authorize a malicious software update that would otherwise require multiple keys to sign.

## Key facts
- Affects `tough` versions prior to 0.7.1; the fix was released in `tough` 0.7.1 (2021)
- Root cause: the signature verification logic counted signatures incorrectly, failing to enforce the threshold (minimum N-of-M valid signatures) requirement
- CVSS score is rated **High** — remote attackers with access to one valid signing key could exploit this to deliver tampered update metadata
- The Update Framework (TUF) is specifically designed to provide a security layer on top of package distribution systems, defending against freeze, rollback, and arbitrary software injection attacks
- This is a **logic flaw**, not a memory-safety or injection bug — the cryptographic primitives were fine; the count/enforcement logic was broken

## Related concepts
[[The Update Framework (TUF)]] [[Supply Chain Security]] [[Code Signing]] [[Signature Verification Bypass]] [[Threshold Cryptography]]