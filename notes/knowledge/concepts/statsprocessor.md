# statsprocessor

## What it is
Think of it as a word factory that systematically assembles every possible combination of ingredients before handing them off to a chef — except the "chef" is a password cracker and the "ingredients" are character sets. Statsprocessor (sp64) is a standalone word generator that creates Markov-chain-based wordlists by analyzing the statistical frequency of character sequences in existing password datasets, producing candidates ordered by probability of success.

## Why it matters
During a red team engagement, an attacker recovers a partial password dump from a company's legacy system. Rather than brute-forcing blindly, they feed the dump into statsprocessor to generate a statistically optimized wordlist that front-loads the most likely password patterns specific to that organization's users. This dramatically reduces cracking time compared to exhaustive brute force, enabling credential reuse attacks against other company systems before defenders can respond.

## Key facts
- Statsprocessor ships as a **companion utility to Hashcat** and is purpose-built to generate Markov-model wordlists fed directly into Hashcat's stdin
- It uses **n-gram frequency analysis** — specifically character transition probabilities — to order password candidates from most to least statistically likely
- The `--threshold` flag controls Markov chain "depth," allowing tuners to balance coverage versus speed (lower threshold = fewer, higher-probability candidates)
- Outputs can be **piped directly into Hashcat** using `-` as the wordlist argument, enabling real-time candidate generation without storing massive wordlist files to disk
- Statsprocessor's effectiveness depends entirely on the **quality and relevance of the training corpus** — a dataset of corporate passwords produces better results against corporate targets than generic rockyou-style lists

## Related concepts
[[Hashcat]] [[Markov Chain Attack]] [[Password Cracking]] [[Wordlist Generation]] [[Credential Stuffing]]