# key escrow

## What it is
Like giving a spare house key to a trusted neighbor so emergency services can get in even if you're unreachable — key escrow is a system where a copy of a cryptographic key is held by a trusted third party (the "escrow agent"), allowing authorized recovery of encrypted data without the original key holder's direct involvement.

## Why it matters
In 2021, law enforcement agencies repeatedly hit walls when attempting to access encrypted evidence on seized devices — key escrow would theoretically solve this by allowing court-ordered decryption. However, the Clipper Chip controversy of the 1990s demonstrated the core tension: the NSA's SKIPJACK algorithm with built-in escrow was abandoned after researchers found the key-handoff protocol (EES) was cryptographically flawed and created a dangerous single point of compromise for millions of communications.

## Key facts
- Key escrow differs from key recovery: escrow stores keys proactively with a third party; recovery reconstructs keys after the fact from stored material
- The **Clipper Chip** (1993) is the canonical failed escrow system — it used an 80-bit LEAF (Law Enforcement Access Field) that was shown to be bypassable by Matt Blaze in 1994
- Escrow agents can be internal (enterprise IT holds employee keys) or external (government-mandated trusted third party)
- **M-of-N key splitting** (secret sharing via Shamir's scheme) is a safer escrow variant — requires M of N key custodians to cooperate for recovery, preventing single-party abuse
- On Security+/CySA+: key escrow is tested in the context of **key management**, **PKI**, and the **privacy vs. law enforcement** debate

## Related concepts
[[key management]] [[public key infrastructure]] [[secret sharing]] [[hardware security module]] [[data recovery]]