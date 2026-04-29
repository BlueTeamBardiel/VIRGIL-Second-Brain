# media sanitization

## What it is
Like shredding a secret document versus just tossing it in the recycling bin — simply deleting a file leaves the data recoverable until overwritten. Media sanitization is the deliberate process of rendering data on storage media unrecoverable, using methods scaled to the sensitivity of the data and the media's intended disposition (reuse, donation, or destruction).

## Why it matters
In 2006, the UK's HMRC lost discs containing 25 million child benefit records — discs that were never properly sanitized before being transferred through interdepartmental mail. An attacker or opportunistic finder with basic forensic tools could recover every record. Proper sanitization policy would have made the data irrecoverable regardless of the disc's fate.

## Key facts
- **NIST SP 800-88** defines three sanitization categories: **Clear** (overwrite for reuse in same organization), **Purge** (cryptographic erase or degaussing — resists lab-level recovery), and **Destroy** (physical destruction — shredding, incineration, disintegration)
- **Deleting a file and emptying the recycle bin is NOT sanitization** — it only removes the pointer; the data remains until overwritten
- **Degaussing** destroys data on magnetic media by demagnetizing it, but is ineffective on SSDs or optical media
- **Cryptographic erasure** (crypto-shred) destroys the encryption key for self-encrypting drives, rendering ciphertext meaningless — the fastest method for large storage
- **SSDs complicate traditional overwriting** because wear-leveling algorithms may preserve data in sectors the OS cannot directly address — purge or destroy methods are required

## Related concepts
[[data remanence]] [[cryptographic erasure]] [[chain of custody]] [[data classification]] [[secure disposal]]