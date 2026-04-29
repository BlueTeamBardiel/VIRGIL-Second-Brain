# bcrypt

## What it is
Like a combination lock that deliberately takes 10 seconds to open instead of 1 millisecond — bcrypt is a password hashing algorithm specifically designed to be *slow*. It applies a computationally expensive Blowfish cipher-based function with a configurable work factor, producing a salted hash that resists brute-force attacks even on modern hardware.

## Why it matters
In 2012, 6.5 million LinkedIn passwords were leaked as unsalted SHA-1 hashes. Attackers cracked the majority within hours using precomputed rainbow tables. Had LinkedIn used bcrypt, the same attack would have taken centuries — bcrypt's built-in salt eliminates rainbow tables, and its slowness makes GPU-accelerated cracking economically impractical.

## Key facts
- **Work factor (cost factor)** is logarithmic: cost=12 means 2¹² iterations (~4,096). Increasing cost by 1 doubles computation time, allowing the algorithm to scale with hardware improvements.
- bcrypt **automatically generates and embeds a unique 128-bit salt** in each hash output, making identical passwords produce different hashes.
- Output is a **60-character string** containing the algorithm identifier, cost factor, salt, and hash — everything needed for verification is stored together.
- bcrypt has a **72-byte (576-bit) maximum password length** — passwords longer than 72 bytes are silently truncated, a common implementation gotcha.
- Preferred over MD5 and SHA-family for passwords because those algorithms are designed for **speed** (useful for file integrity, catastrophic for passwords).

## Related concepts
[[Password Hashing]] [[Rainbow Table Attack]] [[Salting]] [[Key Stretching]] [[Argon2]]