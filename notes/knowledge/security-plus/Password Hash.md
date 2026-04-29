# password hash

## What it is
Like a meat grinder that turns steak into ground beef — you can't reverse the process — a password hash is a one-way mathematical transformation of a plaintext password into a fixed-length string. Algorithms like bcrypt, SHA-256, or NTLM process the input and produce a deterministic digest that is stored instead of the password itself. Even a single character change produces a completely different output (avalanche effect).

## Why it matters
In the 2012 LinkedIn breach, 6.5 million password hashes were dumped publicly — but they used unsalted SHA-1, allowing attackers to crack millions of passwords in hours using precomputed rainbow tables. Had LinkedIn used bcrypt with unique salts, the same dump would have taken centuries to crack. This breach directly illustrates why algorithm choice and salting aren't optional hardening steps.

## Key facts
- **Salting** adds a unique random value to each password before hashing, defeating precomputed rainbow table attacks even when two users share the same password
- **NTLM hashes** (used in Windows) are considered weak — they're unsalted and fast to compute, making them prime targets for pass-the-hash attacks without even cracking them
- **bcrypt, scrypt, and Argon2** are intentionally slow (adaptive cost factor), making brute-force attacks computationally expensive — preferred over MD5/SHA-1 for password storage
- **Pass-the-hash** is an attack where the hash itself is used as authentication credential, bypassing the need to know the plaintext — common in lateral movement on Windows networks
- A hash is **not encryption** — there is no key and no legitimate decryption path; "cracking" a hash means finding a matching input through brute force or lookup tables

## Related concepts
[[rainbow table]] [[pass-the-hash attack]] [[credential stuffing]] [[salting]] [[NTLM authentication]]