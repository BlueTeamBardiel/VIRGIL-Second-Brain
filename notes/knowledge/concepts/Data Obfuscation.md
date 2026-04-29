# Data Obfuscation

## What it is
Like a spy writing a message in lemon juice — the words are there, but invisible until you know to hold it over a flame — data obfuscation transforms information into a form that conceals its meaning without necessarily encrypting it. Precisely: it is the process of deliberately making data unclear, confusing, or harder to interpret, using techniques like masking, tokenization, scrambling, or substitution to protect sensitive information from unauthorized viewers.

## Why it matters
A healthcare company running analytics on patient records replaces real Social Security Numbers with randomly generated tokens before passing the dataset to third-party analysts — a breach of that dataset yields useless strings, not exploitable PII. Attackers also weaponize obfuscation: malware authors encode PowerShell payloads in Base64 to slip past signature-based AV engines that would catch plaintext commands immediately.

## Key facts
- **Tokenization** replaces sensitive data (e.g., credit card numbers) with a non-sensitive placeholder token; the mapping is stored in a separate, secured token vault — used heavily in PCI-DSS compliance.
- **Data masking** creates a structurally realistic but fictitious version of data (e.g., replacing "John Smith" with "Mark Jones") for use in dev/test environments.
- **Obfuscation ≠ encryption**: obfuscated data is often reversible without a key; encryption provides mathematically provable confidentiality.
- Attackers use obfuscation (Base64, hex encoding, ROT13, character substitution) to evade IDS/IPS signatures — a core technique in **living-off-the-land** attacks.
- Security+ and CySA+ both test that obfuscation is a **compensating control**, not a primary security boundary — never rely on it alone.

## Related concepts
[[Tokenization]] [[Data Masking]] [[Steganography]] [[Encryption]] [[Defense in Depth]]