# FileVault

## What it is
Like wrapping every file on your Mac in a combination safe that only unlocks when you log in with your password, FileVault is Apple's full-disk encryption (FDE) solution for macOS. It uses XTS-AES-128 encryption with a 256-bit key to encrypt the entire startup volume, rendering data unreadable without proper authentication credentials.

## Why it matters
When a MacBook is stolen from a coffee shop, FileVault is the difference between the thief reading every document and password keychain versus staring at encrypted gibberish. Without FileVault enabled, an attacker can simply boot from external media, mount the drive, and access all data — bypassing macOS login entirely. With FileVault active, the stolen hardware becomes a useless brick unless the attacker also knows the user's password or recovery key.

## Key facts
- FileVault 2 (introduced in OS X Lion) encrypts the full volume using XTS-AES-128 with a 256-bit key, a significant upgrade from the original home-folder-only encryption
- A **Recovery Key** is generated during setup — if both the user password and recovery key are lost, data is permanently unrecoverable by design
- FileVault integrates with **iCloud** or institutional **Institutional Recovery Keys (IRK)** for enterprise key escrow and recovery management
- Decryption happens transparently at login via the Secure Enclave (on Apple Silicon) or the T2 chip (on Intel Macs), meaning performance impact is negligible on modern hardware
- FileVault does **not** protect data while the Mac is running and logged in — encryption only protects data at rest when the system is powered off or locked

## Related concepts
[[Full Disk Encryption]] [[BitLocker]] [[Key Escrow]] [[Data at Rest]] [[Trusted Platform Module]]