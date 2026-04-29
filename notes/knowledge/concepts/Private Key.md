# Private Key

## What it is
Think of a private key like the master stamp used to seal royal letters with wax — only the king holds it, and anything sealed with it proves it came from him. Precisely: a private key is a secret cryptographic value known only to its owner, used in asymmetric encryption to decrypt ciphertext or to digitally sign data. It is mathematically paired with a public key, and exposure of the private key completely compromises the entire key pair.

## Why it matters
In 2011, certificate authority DigiNotar was breached and attackers accessed private keys used to issue SSL certificates — they then forged certificates for Google, enabling man-in-the-middle attacks against Iranian Gmail users. This demonstrates that private key compromise doesn't just break encryption; it breaks *trust* in the entire PKI chain. DigiNotar was subsequently revoked by every major browser and went bankrupt.

## Key facts
- Private keys in RSA are typically 2048 or 4096 bits; anything under 1024 bits is considered broken
- In asymmetric encryption: **public key encrypts, private key decrypts**; in digital signatures: **private key signs, public key verifies**
- Private keys should never traverse a network unencrypted; storage should use password-protected formats like PKCS#8 or hardware security modules (HSMs)
- If a private key is lost with no backup, data encrypted to the paired public key becomes permanently inaccessible — there is no recovery path
- Certificate Authorities protect their root private keys in air-gapped HSMs because a compromised CA root key invalidates the entire trust chain it signed

## Related concepts
[[Public Key Infrastructure]] [[Digital Signatures]] [[Certificate Authority]] [[Asymmetric Encryption]] [[Key Escrow]]