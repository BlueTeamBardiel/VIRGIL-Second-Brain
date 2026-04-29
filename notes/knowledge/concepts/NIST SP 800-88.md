# NIST SP 800-88

## What it is
Like a chef who doesn't just rinse a cutting board used for raw chicken but sanitizes or destroys it entirely before reuse, NIST SP 800-88 is the federal guideline defining how to properly dispose of storage media so that sensitive data cannot be recovered. It provides three increasingly thorough categories of sanitization: Clear, Purge, and Destroy.

## Why it matters
In 2006, the Department of Veterans Affairs suffered a breach when a laptop with unwiped drives containing 26.5 million veterans' records was stolen — a textbook failure to apply any sanitization standard. Had SP 800-88 procedures been followed, even a recovered drive would yield nothing recoverable, because proper Purging (e.g., cryptographic erase on SSDs) renders data unreadable even with forensic tools.

## Key facts
- **Clear**: Overwrites data using standard write commands; protects against simple recovery tools but not advanced forensic analysis. Suitable for lower-sensitivity media.
- **Purge**: Uses techniques like block erase, cryptographic erase, or degaussing; defeats state-of-the-art laboratory recovery. Required for media leaving organizational control.
- **Destroy**: Physical destruction (shredding, disintegration, incineration); used when media will not be reused and highest assurance is needed.
- **Cryptographic Erase (CE)** is SP 800-88's preferred method for SSDs and self-encrypting drives — destroying the encryption key makes existing ciphertext permanently inaccessible.
- The guide explicitly states that simply deleting files or formatting a drive is **not** considered sanitization under any category.

## Related concepts
[[Data Remanence]] [[Cryptographic Erasure]] [[Media Sanitization Policy]] [[Chain of Custody]] [[Self-Encrypting Drives]]