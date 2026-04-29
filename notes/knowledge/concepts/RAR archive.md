# RAR archive

## What it is
Like a vacuum-seal bag that compresses your clothes AND locks with a combination, RAR is a proprietary archive format that bundles multiple files into a single compressed container with optional AES-256 encryption and password protection. Developed by Eugene Roshal (Roshal ARchive), it supports multi-volume splitting, recovery records, and stronger compression ratios than ZIP.

## Why it matters
Threat actors routinely use password-protected RAR archives to exfiltrate sensitive data across networks because the encryption renders DLP (Data Loss Prevention) tools blind to the contents — the payload looks like opaque binary. Malware families like Emotet and various APT groups have also delivered RAR-wrapped payloads through phishing emails, exploiting the fact that some endpoint tools fail to recursively inspect nested archives before execution.

## Key facts
- RAR uses **AES-256 encryption** when password-protected, meaning brute-force is the only recovery option without the key — tools like Hashcat support RAR hash cracking
- **Multi-volume RAR** splits archives into numbered parts (`.part1.rar`, `.part2.rar`), a technique abused to bypass file-size-based upload restrictions during exfiltration
- RAR files begin with the magic bytes `52 61 72 21 1A 07` (hex), allowing forensic tools to identify them even if the extension is renamed
- Unlike ZIP, RAR is **proprietary**; WinRAR holds the format, though 7-Zip and others can decompress (not create) RAR files
- **Recovery records** embedded in RAR archives can repair corrupted data — a feature that makes incomplete intercepted archives potentially reconstructible by investigators

## Related concepts
[[Data Loss Prevention (DLP)]] [[AES Encryption]] [[Steganography]] [[File Carving]] [[Malware Delivery Techniques]]