# Tamper Detection

## What it is
Like a wax seal on a medieval letter — if it's broken, you know someone read the message before you did. Tamper detection is the use of mechanisms (hardware, software, or cryptographic) that reveal whether a system, device, or data has been modified or physically accessed without authorization. It answers the question: *has this been touched since I last trusted it?*

## Why it matters
In 2013, attackers compromised point-of-sale terminals at Target by installing skimming malware directly on the hardware. Physical tamper-evident seals on the devices *would have visibly indicated* unauthorized access during routine inspections — a simple control that could have triggered earlier investigation. This attack exposed 40 million credit card numbers.

## Key facts
- **Hardware Security Modules (HSMs)** use active tamper detection — they physically destroy cryptographic keys when the enclosure is breached, preventing key extraction.
- **Integrity verification** via hashing (e.g., SHA-256 file hashes, TPM measurements) is the software equivalent — any bit-level change produces a completely different hash value.
- **HMAC (Hash-based Message Authentication Code)** provides tamper detection for data in transit; without the shared secret key, an attacker cannot forge a valid MAC for modified data.
- **File Integrity Monitoring (FIM)** tools like Tripwire baseline system files and alert when checksums change — directly mapped to the CySA+ exam as a core detection control.
- The **Chain of Custody** in forensics depends entirely on tamper-evident packaging — evidence collected without it can be dismissed in court due to potential modification.

## Related concepts
[[Hash Functions]] [[HMAC]] [[File Integrity Monitoring]] [[Hardware Security Module]] [[Chain of Custody]]