# MD5

## What it is
Like a meat grinder that always produces the same texture from the same cut — but two completely different cuts can come out looking identical. MD5 (Message Digest Algorithm 5) is a cryptographic hash function that produces a fixed 128-bit (32 hex character) digest from any input. It was designed for integrity verification but is now considered cryptographically broken due to collision vulnerabilities.

## Why it matters
In 2012, the Flame malware exploited an MD5 collision to forge a fraudulent Microsoft code-signing certificate, making malicious code appear legitimately signed by Microsoft. Defenders today still encounter MD5 in legacy file integrity checks, password databases, and forensic hash verification — knowing it's untrustworthy for security-critical purposes while still useful for non-adversarial checksums is essential triage knowledge.

## Key facts
- Produces a **128-bit hash** output, displayed as a 32-character hexadecimal string
- **Collision attacks are computationally feasible** — two different inputs can produce the same hash; fully broken for certificate/signature use cases
- **Preimage resistance is still relatively intact** — finding an input from a known hash remains difficult, but don't rely on it for passwords
- MD5 is **NOT recommended** by NIST for any new cryptographic applications; SHA-256 or SHA-3 are preferred replacements
- Still commonly seen in **file download checksums** and **forensic evidence hashing** (chain of custody tools like FTK/Autopsy may still log MD5 alongside SHA-1)

## Related concepts
[[SHA-256]] [[Hash Collision Attack]] [[Digital Signatures]] [[Password Hashing]] [[File Integrity Monitoring]]