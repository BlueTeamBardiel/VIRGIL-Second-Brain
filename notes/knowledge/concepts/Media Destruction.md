# Media Destruction

## What it is
Like shredding a diary instead of tossing it whole in the trash, media destruction is the deliberate, irreversible elimination of data storage devices so that no information can be recovered. It goes beyond deletion or formatting — it physically or cryptographically renders the storage medium unreadable by any means. It is the final, unambiguous answer to "can anyone recover this data?"

## Why it matters
A hospital disposing of old MRI workstations simply formatted the hard drives and sold them at auction. A security researcher purchased one for $20 and recovered thousands of patient records using freely available tools — a direct HIPAA violation. Proper media destruction (degaussing or shredding) would have made recovery physically impossible.

## Key facts
- **DoD 5220.22-M** was the classic standard for overwriting media; NIST SP 800-88 ("Guidelines for Media Sanitization") is the current authoritative reference, defining Clear, Purge, and Destroy as the three sanitization categories.
- **Degaussing** destroys data on magnetic media (HDDs, tapes) by exposing it to a powerful magnetic field; it is ineffective against SSDs and flash storage.
- **Physical destruction methods** include shredding, disintegration, melting, pulverizing, and incineration — SSDs require shredding to particle sizes ≤2mm to prevent recovery.
- **Cryptographic Erasure (Crypto-Erase)** destroys the encryption key of a self-encrypting drive (SED), rendering all data undecipherable without physically destroying the hardware.
- A **Certificate of Destruction** is a formal document provided by a third-party destruction vendor proving compliant disposal — required for regulatory audits under HIPAA, PCI-DSS, and GDPR.

## Related concepts
[[Data Sanitization]] [[NIST SP 800-88]] [[Data Remanence]] [[Degaussing]] [[Chain of Custody]]