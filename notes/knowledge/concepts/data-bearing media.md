# data-bearing media

## What it is
Think of data-bearing media like a sticky note that remembers everything written on it, even after you think you've erased it. Precisely, data-bearing media refers to any physical storage device or material capable of retaining digital or analog information — including hard drives, SSDs, USB drives, optical discs, magnetic tapes, and even printer drums. The critical security concern is that data persists beyond its perceived deletion.

## Why it matters
In 2012, researchers purchased used hard drives from eBay and recovered sensitive corporate and personal data from drives that had been "deleted" but not properly sanitized. This illustrates why organizations must enforce formal media sanitization policies before surplus equipment is donated, resold, or disposed of — otherwise decommissioned hardware becomes a data exfiltration vector requiring zero network access.

## Key facts
- **Three NIST-approved sanitization methods** (NIST SP 800-88): Clear (overwriting), Purge (degaussing or cryptographic erase), and Destroy (physical shredding/incineration)
- **SSDs require special handling** — traditional multi-pass overwriting is unreliable due to wear leveling; cryptographic erasure (erasing the encryption key) is the preferred method
- **Degaussing** renders magnetic media (HDDs, tapes) unreadable by disrupting magnetic domains, but is ineffective on SSDs or optical media
- **Chain of custody documentation** is required for classified media destruction to prove sanitization occurred and who handled the media
- **Residual data risk** exists even in RAM (cold boot attacks can recover encryption keys from powered-down systems within minutes)

## Related concepts
[[data remanence]] [[media sanitization]] [[cold boot attack]] [[chain of custody]] [[cryptographic erasure]]