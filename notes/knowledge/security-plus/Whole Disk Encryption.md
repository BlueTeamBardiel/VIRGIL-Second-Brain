# Whole Disk Encryption

## What it is
Like a bank vault that locks the entire building instead of just individual safety deposit boxes, Whole Disk Encryption (WDE) encrypts every bit on a storage drive — including the OS, swap space, and temp files — so the raw disk is unreadable without the correct key or passphrase. Unlike file-level encryption, WDE protects data that never consciously gets "saved," such as memory dumps and browser caches.

## Why it matters
In 2020, a healthcare worker left an unencrypted laptop in a car; a thief pulled the hard drive and accessed 9,000 patient records simply by mounting it in another machine. With WDE enabled (e.g., BitLocker), that same drive would return only ciphertext — the physical possession of hardware grants zero data access without the decryption key.

## Key facts
- **BitLocker** (Windows) uses AES-128 or AES-256 and optionally binds the key to a **TPM chip**, preventing decryption on different hardware.
- **Pre-Boot Authentication (PBA)** requires a PIN or USB key before the OS loads, adding a layer beyond TPM-only protection against cold-boot attacks.
- WDE does **not** protect data in transit or data actively in use (memory); it specifically protects **data at rest** on a lost or stolen device.
- The **Volume Boot Record (VBR)** remains partially unencrypted to enable the bootloader — attackers can target this in a **bootkit** attack, which is why Secure Boot is a complementary control.
- **Self-Encrypting Drives (SEDs)** implement encryption in hardware using the **Opal standard**, offloading CPU overhead but requiring trust in the drive vendor's implementation.

## Related concepts
[[BitLocker]] [[Trusted Platform Module (TPM)]] [[Data at Rest]] [[Cold Boot Attack]] [[Self-Encrypting Drive]]