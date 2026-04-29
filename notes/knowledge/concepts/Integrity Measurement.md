# Integrity Measurement

## What it is
Like a wax seal on a medieval letter — if the seal is broken or mismatched, you know someone tampered with the contents before it reached you. Integrity measurement is the process of generating and comparing cryptographic hashes (or other metrics) of system components — files, firmware, boot sequences — to detect unauthorized modifications. It establishes a known-good baseline and continuously validates that the system state hasn't deviated from it.

## Why it matters
In 2020, the SolarWinds supply chain attack injected malicious code into legitimate software builds. A robust integrity measurement system, like the Linux **Integrity Measurement Architecture (IMA)**, could have flagged the altered binary by comparing its runtime hash against a trusted baseline stored in a TPM, potentially catching the compromise before deployment. Without integrity measurement, the tampered files appeared completely normal to antivirus tools.

## Key facts
- **TPM (Trusted Platform Module)** stores integrity measurements (PCR values) taken during the boot process — this is the foundation of Measured Boot and remote attestation
- The **Linux IMA (Integrity Measurement Architecture)** logs SHA-256 hashes of executed files and can enforce policy to block unmeasured binaries
- **NIST SP 800-155** defines BIOS integrity measurement guidelines — a common reference for exam questions
- Integrity measurement differs from integrity *verification*: measurement records the state; verification compares it against a trusted reference
- **File Integrity Monitoring (FIM)** tools like Tripwire implement integrity measurement at the OS layer by hashing critical system files and alerting on changes — directly relevant to CySA+ incident response scenarios

## Related concepts
[[Trusted Platform Module (TPM)]] [[File Integrity Monitoring]] [[Secure Boot]] [[Hash Functions]] [[Supply Chain Security]]