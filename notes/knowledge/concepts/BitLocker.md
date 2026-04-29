# BitLocker

## What it is
Think of it like a combination lock bolted directly to a safe's internals — even if someone steals the entire safe, they can't access the contents without the combination. BitLocker is Microsoft's full-disk encryption (FDE) feature built into Windows that encrypts entire volumes using AES (128-bit or 256-bit), rendering data unreadable without proper authentication credentials or a recovery key.

## Why it matters
A laptop containing employee PII is stolen from a conference room. Without BitLocker, an attacker boots from a USB drive, bypasses Windows login entirely, and reads every file directly off the disk. With BitLocker enabled and TPM-backed authentication, the drive's contents remain encrypted ciphertext — the stolen hardware yields nothing useful, turning a potential breach into a non-event.

## Key facts
- BitLocker uses the **TPM (Trusted Platform Module)** chip to store encryption keys and verify boot integrity; if the boot environment changes (e.g., BIOS modification), the drive locks and demands the 48-digit recovery key
- Supports multiple protector types: **TPM only, TPM + PIN, TPM + USB key**, and password — each adding additional authentication factors
- The **BitLocker Recovery Key** should be stored in Active Directory, Azure AD, or a separate secure location — losing it means permanent data loss
- **BitLocker To Go** extends encryption to removable drives (USB sticks, external HDDs)
- Encrypts at the **volume level**, not individual files — complementary to EFS (Encrypting File System), which encrypts per-file

## Related concepts
[[Full-Disk Encryption]] [[Trusted Platform Module (TPM)]] [[Data at Rest]] [[Cold Boot Attack]] [[Encrypting File System (EFS)]]