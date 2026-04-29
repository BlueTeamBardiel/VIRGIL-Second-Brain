# VeraCrypt

## What it is
Like a bank vault hidden behind a bookshelf that can *also* reveal a fake storage room if someone forces you to open it — VeraCrypt is an open-source disk encryption tool that creates encrypted volumes or encrypts entire drives, with an optional "plausible deniability" feature using hidden volumes. It is the actively maintained successor to the discontinued TrueCrypt project, using AES, Twofish, and Serpent encryption algorithms.

## Why it matters
A journalist arrested at a border crossing is compelled to unlock their laptop. Because they stored sensitive sources inside a VeraCrypt hidden volume — with a separate decoy password revealing only innocuous vacation photos — the adversary sees nothing incriminating. The outer volume satisfies the coercion demand while the inner volume remains cryptographically invisible, with no metadata distinguishing it from random noise.

## Key facts
- **Hidden volume deniability**: VeraCrypt supports two passwords on one container — one opens a decoy outer volume, one opens the real hidden volume; no forensic tool can prove the hidden volume exists
- **Algorithm support**: Encrypts with AES-256, Twofish, Serpent, or cascaded combinations (e.g., AES-Twofish-Serpent)
- **Pre-boot authentication (PBA)**: Can encrypt the entire system drive, requiring a password before the OS loads — similar to BitLocker's TPM-based approach but without hardware dependency
- **Cross-platform**: Runs on Windows, macOS, and Linux, making it relevant for BYOD and multi-platform forensic scenarios
- **Not a TrueCrypt drop-in**: VeraCrypt uses a higher iteration count for key derivation (PBKDF2 with 500,000 iterations vs. TrueCrypt's 1,000), making brute-force attacks significantly slower

## Related concepts
[[Full Disk Encryption]] [[BitLocker]] [[Plausible Deniability]] [[AES-256]] [[Data at Rest Protection]]