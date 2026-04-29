# maskprocessor

## What it is
Like a robotic assembly line that can stamp out every possible combination of letters, numbers, and symbols in a pre-defined pattern, maskprocessor is a high-speed word generator that creates candidate passwords based on user-defined masks. It takes a template like `?u?l?l?l?d?d` (uppercase + 4 lowercase + 2 digits) and exhaustively produces every matching string for use as input to password crackers like Hashcat.

## Why it matters
During a penetration test, an analyst discovers a breach of a corporate HR system where passwords are known to follow the policy "one capital, six letters, two numbers." Rather than throwing a 10GB wordlist at the hash, they use maskprocessor to generate only the ~2 billion candidates matching that exact pattern — cutting cracking time from weeks to hours and demonstrating that predictable password policies create exploitable attack surfaces.

## Key facts
- Maskprocessor is a standalone word generator typically paired with **Hashcat** or **John the Ripper** for offline password cracking.
- Mask characters follow Hashcat conventions: `?l` (lowercase), `?u` (uppercase), `?d` (digit), `?s` (special), `?a` (all printable).
- Supports **custom charsets** (`-1`, `-2`, `-3`, `-4`) allowing attackers to target company-specific patterns (e.g., season + year passwords like `Summer2024!`).
- Output is piped directly: `mp64.exe ?u?l?l?l?d?d | hashcat -m 1000 hashes.txt --stdin`
- Maskprocessor attacks are fundamentally a form of **brute-force attack** with pruning — more efficient than pure brute-force but less flexible than dictionary attacks.

## Related concepts
[[Hashcat]] [[Password Spraying]] [[Brute-Force Attack]] [[Rainbow Tables]] [[Credential Stuffing]]