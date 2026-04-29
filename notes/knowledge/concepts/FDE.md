# FDE

## What it is
Like shrink-wrapping every item in a warehouse so that even if a thief breaks in, they can't read the labels or use the contents — Full Disk Encryption scrambles every bit on a storage device so that without the correct key, the raw data is meaningless gibberish. FDE encrypts the entire drive at the hardware or OS level, including the OS itself, swap space, and temp files, with decryption occurring transparently at boot via a pre-boot authentication step.

## Why it matters
In 2017, a Veterans Affairs employee left an unencrypted laptop in a car; it was stolen, exposing 26 million veterans' personal records. Had FDE been enabled, the physical theft would have been irrelevant — the attacker would have a brick, not a data breach. This is the canonical justification for FDE as a **data-at-rest** control for mobile endpoints.

## Key facts
- FDE protects **data at rest** only — once the drive is unlocked and the OS is running, encryption offers no protection against a live attacker
- **BitLocker** (Windows) uses AES-128 or AES-256 and integrates with TPM to bind the key to the hardware; **FileVault 2** is macOS's equivalent
- The **TPM (Trusted Platform Module)** stores the encryption key and performs integrity checks on the boot process — if the bootloader is tampered with, the TPM refuses to release the key
- **Pre-boot authentication (PBA)** requires a PIN or password before the OS loads, adding a second factor beyond TPM alone
- FDE does **not** protect against Evil Maid attacks if pre-boot authentication is weak or absent — an attacker with repeated physical access can install a bootkit

## Related concepts
[[TPM]] [[BitLocker]] [[Data at Rest]] [[Pre-Boot Authentication]] [[Evil Maid Attack]]