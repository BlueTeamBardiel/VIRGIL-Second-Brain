# Evil Maid Attack

## What it is
Like a hotel maid who sneaks into your room while you're at breakfast and photographs your diary before putting it back perfectly in place — an Evil Maid attack occurs when an adversary gains brief, unsupervised physical access to an unattended device to install malware, extract data, or compromise encryption, leaving no visible trace of tampering. The device is returned looking untouched, but it's now owned.

## Why it matters
Security researcher Joanna Rutkowska demonstrated this against TrueCrypt-encrypted laptops in 2009: an attacker with 2-minute physical access could replace the bootloader with a malicious one that captured the encryption passphrase on next login. This is why full-disk encryption alone does **not** protect against physical access threats — the attacker doesn't crack the encryption, they intercept the key.

## Key facts
- Targets devices left unattended in semi-trusted environments (hotel rooms, conferences, border crossings)
- Bypasses full-disk encryption (e.g., BitLocker, VeraCrypt) by tampering with the pre-boot environment or firmware
- Countermeasures include **Secure Boot**, **TPM with measured boot**, tamper-evident seals, and never leaving devices unattended in hostile environments
- **Cold boot attacks** are a related vector — freezing RAM to extract encryption keys after device shutdown
- UEFI/BIOS passwords and Secure Boot attestation help detect bootloader modification, but are not foolproof against sophisticated nation-state actors

## Related concepts
[[Physical Security Controls]] [[Full Disk Encryption]] [[Secure Boot]] [[Cold Boot Attack]] [[Supply Chain Attack]]