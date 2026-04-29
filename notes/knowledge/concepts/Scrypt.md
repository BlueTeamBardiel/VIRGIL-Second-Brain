# scrypt

## What it is
Like making a smoothie that requires not just time but also a specific amount of blender capacity — you can't speed it up by adding more blenders in parallel. scrypt is a password-based key derivation function (KDF) designed to be computationally expensive in *both* CPU time and memory, making it resistant to brute-force attacks using ASICs or GPU farms.

## Why it matters
When attackers compromise a password database, they typically spin up GPU clusters or rent ASIC hardware to crack hashes at billions of guesses per second. scrypt's memory-hardness requirement (configurable to require gigabytes of RAM per attempt) makes parallelizing these attacks economically prohibitive — cracking 1 million passwords simultaneously would require 1 million × N gigabytes of RAM, forcing attackers to crack sequentially and slowly.

## Key facts
- scrypt has three tuning parameters: **N** (CPU/memory cost), **r** (block size), and **p** (parallelization factor) — allowing administrators to scale difficulty with hardware improvements
- Memory-hardness is the key differentiator from bcrypt and PBKDF2, which can be parallelized cheaply on GPUs
- scrypt is used as the underlying algorithm in **Litecoin's** proof-of-work system, demonstrating real-world resistance to ASIC optimization
- The recommended minimum parameters for password storage are N=2¹⁴ (16,384), r=8, p=1 per Colin Percival's original guidance
- scrypt was designed by Colin Percival in 2009 and formally published as **RFC 7914** in 2016

## Related concepts
[[bcrypt]] [[PBKDF2]] [[Argon2]] [[key derivation function]] [[rainbow table attack]]