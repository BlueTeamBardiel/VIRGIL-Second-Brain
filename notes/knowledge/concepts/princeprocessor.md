# princeprocessor

## What it is
Like a chef who combines ingredients from a known pantry in every possible order to invent new recipes, princeprocessor takes a wordlist and systematically chains words together to generate password candidates. It is a password candidate generator (not a cracker itself) that implements the PRINCE (PRobability INfinite Chained Elements) algorithm, designed to produce high-probability password guesses by combining word elements from an input list.

## Why it matters
During a red team engagement, an attacker recovers a leaked NTLM hash database from a corporate breach. Standard dictionary attacks fail because users followed a "two-word" password policy (e.g., `sunshine2019`). Running princeprocessor against a curated wordlist generates millions of these compound candidates, which are piped directly into Hashcat, cracking a significant portion of hashes within hours — demonstrating that policy-compliant passwords can still be predictable.

## Key facts
- Princeprocessor is a **standalone word combiner**, typically used upstream of Hashcat or John the Ripper via stdin piping (`pp64 --pw-min=8 wordlist.txt | hashcat -a 0 hashes.txt`)
- The PRINCE algorithm generates combinations based on **element chains**, respecting configurable minimum/maximum password length and number of elements per chain
- Unlike brute-force, it exploits **human password behavior** — people concatenate familiar words — making it statistically more efficient than pure character-space attacks
- Key flags include `--elem-cnt-min` / `--elem-cnt-max` (number of words chained), `--pw-min` / `--pw-max` (output password length bounds)
- Developed by **atom** (Jens Steube), the same author as Hashcat, and released as open-source on GitHub under hashcat's organization

## Related concepts
[[Hashcat]] [[Password Cracking]] [[Dictionary Attack]] [[Rule-Based Attacks]] [[NTLM Hashing]]