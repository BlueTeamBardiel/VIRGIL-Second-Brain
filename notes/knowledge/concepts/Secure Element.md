# Secure Element

## What it is
Think of a bank vault bolted inside a building — even if thieves own the whole building, they still can't crack the vault. A Secure Element (SE) is a tamper-resistant microchip embedded in a device (phone, smart card, or SIM) that stores cryptographic keys and executes sensitive operations in an isolated hardware environment, completely shielded from the host operating system.

## Why it matters
In 2011, researchers demonstrated that Android devices storing payment credentials in software memory were vulnerable to malware extracting private keys directly from RAM. Modern NFC payment systems like Apple Pay counter this by processing card tokens exclusively inside the SE — even a fully compromised OS cannot read the keys because the SE physically refuses external memory access. This hardware isolation is why contactless payment fraud remains negligible compared to card skimming.

## Key facts
- Secure Elements are certified under Common Criteria EAL4+ or higher, meaning they're independently tested against physical and logical attack resistance
- They differ from a Trusted Execution Environment (TEE): an SE is a **separate physical chip**, while a TEE is an isolated zone within the **main CPU** — SE provides stronger guarantees
- SE stores private keys such that the key **never leaves the chip** — cryptographic operations happen inside, only results exit
- Three common form factors: embedded SE (soldered chip), UICC/SIM-based SE, and removable microSD SE
- FIDO2/WebAuthn hardware tokens (like YubiKey) use SE architecture to prevent private key extraction even under sophisticated software attacks

## Related concepts
[[Trusted Execution Environment]] [[Hardware Security Module]] [[TPM (Trusted Platform Module)]]