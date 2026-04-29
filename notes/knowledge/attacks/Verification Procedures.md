# Verification Procedures

## What it is
Like a pharmacist double-checking a prescription against a patient's ID before dispensing medication, verification procedures are the systematic checks used to confirm that an identity, action, or piece of data is legitimate before granting access or trust. Precisely defined, they are the formal processes an organization uses to validate claims — whether about who someone is, what software is authentic, or whether a change request is authorized.

## Why it matters
In 2020, attackers compromised SolarWinds by inserting malicious code into the build pipeline, and the resulting signed software passed verification checks because the *signature* was valid — the *source* was not. Stronger verification procedures around code provenance (e.g., comparing build artifacts against a known-good hash or using reproducible builds) would have flagged the tampering before distribution.

## Key facts
- **Change management verification** requires that changes to production systems be authorized, tested, and validated by a separate party before implementation — a core control in CySA+ scenarios.
- **Multi-party authorization (MPA)** is a verification procedure requiring two or more individuals to approve sensitive actions, preventing insider threats from acting unilaterally.
- **Hash verification** (e.g., SHA-256) confirms file integrity by comparing a computed digest against a published value — any modification changes the hash entirely.
- **Certificate pinning** is a verification procedure that validates a server's certificate against a hardcoded expected value, preventing man-in-the-middle attacks that present valid-but-wrong certificates.
- **Identity proofing** during account provisioning (confirming a new user's real-world identity before issuing credentials) is a verification procedure that prevents fraudulent account creation.

## Related concepts
[[Chain of Custody]] [[Code Signing]] [[Multi-Factor Authentication]] [[Integrity Monitoring]] [[Change Management]]