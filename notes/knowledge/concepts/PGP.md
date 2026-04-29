# PGP

## What it is
Imagine sending a letter sealed with your personal wax stamp — anyone can verify it's from you, but only your intended recipient has the letter opener to read it. Pretty Good Privacy (PGP) is a cryptographic standard that combines asymmetric encryption (RSA or ECC) for key exchange with symmetric encryption (AES) for bulk data, plus digital signatures, to provide confidentiality, integrity, and authentication for emails and files.

## Why it matters
Edward Snowden required journalists to use PGP before he would share NSA documents — without it, surveillance of plaintext email would have exposed his identity and the leak before it happened. This illustrates PGP's core defense: even if an attacker intercepts traffic at the ISP level, encrypted ciphertext is useless without the recipient's private key.

## Key facts
- PGP uses a **Web of Trust** model instead of a Certificate Authority (CA) hierarchy — users personally sign each other's public keys to vouch for identity
- The **public key** encrypts data and verifies signatures; the **private key** decrypts data and creates signatures — never the reverse
- PGP generates a random **session key** for symmetric encryption of the actual message, then encrypts *that* session key with the recipient's public key (hybrid encryption)
- OpenPGP (RFC 4880) is the open standard; **GnuPG (GPG)** is the most common open-source implementation
- Key fingerprints (e.g., a 40-character hex string) are used to verify public key authenticity out-of-band, preventing man-in-the-middle key substitution

## Related concepts
[[Asymmetric Encryption]] [[Digital Signatures]] [[S/MIME]] [[Public Key Infrastructure]] [[Web of Trust]]