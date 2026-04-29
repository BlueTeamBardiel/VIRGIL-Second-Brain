# hashcat-utils

## What it is
Think of it as the prep kitchen for a master chef — before Hashcat can crack passwords at full speed, these utilities chop, sort, slice, and season the raw ingredients (wordlists and hash files) into exactly the right format. hashcat-utils is a collection of small, purpose-built command-line tools that help security professionals prepare, manipulate, and convert data specifically for use with the Hashcat password cracker.

## Why it matters
During a penetration test, a tester dumps an NTLM hash database from a compromised Active Directory environment but discovers the file contains duplicates, unsupported encoding, and mixed hash formats that cause Hashcat to error out. Tools like `splitlen`, `rli` (remove lines), and `combinator` from hashcat-utils let the tester clean duplicates, split wordlists by password length, and combine dictionaries — dramatically reducing crack time and improving hit rates before the first GPU cycle even runs.

## Key facts
- **`combinator`** merges two wordlists by appending every word from list B to every word from list A, enabling compound password attacks (e.g., "summer" + "2024!")
- **`splitlen`** separates a wordlist into sub-files by character length, allowing targeted attacks against known password-length policies
- **`rli`** (Remove Lines) subtracts already-cracked or known passwords from a candidate list, preventing redundant computation
- **`cap2hccapx`** (now partly superseded) converted raw packet captures into Hashcat-compatible WPA handshake formats — critical for Wi-Fi audits
- hashcat-utils is **distinct from Hashcat itself** — it performs no cracking; it only transforms input/output data pipelines

## Related concepts
[[Hashcat]] [[Password Cracking]] [[Wordlist Attack]] [[WPA Handshake Capture]] [[NTLM Hashes]]