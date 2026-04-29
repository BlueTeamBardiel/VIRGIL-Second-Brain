# Packers and Crypters

## What it is
Like vacuum-sealing leftovers to hide what's inside and make it smaller, packers compress executable code into a new wrapper that self-extracts at runtime, while crypters encrypt the payload so it looks like meaningless noise until executed. Precisely: packers reduce file size and alter binary signatures; crypters apply encryption (plus a decryption stub) to obfuscate malware from static analysis and signature-based AV detection.

## Why it matters
In the 2016 Dridex banking trojan campaigns, attackers used custom crypters to wrap the malware payload, causing it to appear as benign traffic to signature-based antivirus engines — allowing credential theft at scale before defenders updated detection rules. This is why modern EDR tools rely on behavioral analysis and memory scanning rather than file-hash matching alone, since the unpacked/decrypted payload only appears in memory at runtime.

## Key facts
- **UPX (Ultimate Packer for eXecutables)** is the most common legitimate packer, frequently repurposed by malware authors to evade hash-based detection
- Crypters use a **decryption stub** — a small piece of plaintext code that decrypts and executes the hidden payload in memory, which is where detection must occur
- **Runtime unpacking** means the true malicious code only exists in RAM, making disk-based forensics insufficient without memory acquisition tools like Volatility
- Packers alter **PE (Portable Executable) header entropy** — high entropy values (approaching 8.0) in sections like `.text` are a strong indicator of packed/encrypted content
- Antivirus evasion using packers is classified under **MITRE ATT&CK T1027 (Obfuscated Files or Information)** and sub-technique T1027.002 (Software Packing)

## Related concepts
[[Obfuscation]] [[Static vs Dynamic Analysis]] [[PE File Structure]] [[Memory Forensics]] [[Antivirus Evasion Techniques]]