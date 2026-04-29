# hardware security module

## What it is
Think of it like a bank vault bolted to the floor that *also* does math — you slide requests through a slot, and cryptographic answers come back, but the keys never leave the vault. An HSM is a dedicated physical computing device that generates, stores, and manages cryptographic keys in tamper-resistant hardware, performing encryption and signing operations internally so keys are never exposed to the host system.

## Why it matters
In 2011, RSA Security's SecurID tokens were compromised partly because seed values weren't adequately protected — an HSM deployment would have kept those secrets hardware-bound and inaccessible even after a network breach. Today, certificate authorities use HSMs to protect root CA private keys, meaning even if a CA server is fully compromised, the attacker still can't forge arbitrary certificates without physically extracting the key from tamper-evident hardware that destroys itself upon intrusion.

## Key facts
- HSMs are validated against **FIPS 140-2/140-3** standards, with Level 3 requiring physical tamper-evidence and Level 4 requiring environmental tamper response (self-destruction)
- They provide **hardware root of trust** — cryptographic operations happen inside the device, keys are never exposed in plaintext to the host OS
- Common use cases: **PKI root key protection**, TLS termination, code signing, payment card processing (PCI DSS requires HSMs for PIN blocks)
- HSMs differ from **TPMs** in that TPMs are soldered to a single motherboard (bound to one machine), while HSMs are network-accessible, shared appliances
- **Key ceremony** procedures — witnessed, logged events for generating root keys — are specifically designed around HSM use to ensure accountability

## Related concepts
[[trusted platform module]] [[public key infrastructure]] [[FIPS 140-2]] [[certificate authority]] [[key management]]