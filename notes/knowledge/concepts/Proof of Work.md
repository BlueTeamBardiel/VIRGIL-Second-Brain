# Proof of Work

## What it is
Like a bouncer who makes you solve a puzzle before entering a club — ensuring you paid in *effort*, not money — Proof of Work (PoW) is a computational challenge-response mechanism where a requester must perform expensive calculations to prove they expended real resources. It forces asymmetry: the work is hard to do but trivially easy for others to verify.

## Why it matters
PoW is one of the oldest defenses against email spam and denial-of-service amplification attacks. Systems like Hashcash required senders to compute a partial SHA-1 hash collision before sending an email — spamming a million users suddenly costs real CPU time, breaking the economics of bulk abuse. Bitcoin later borrowed this exact mechanism to secure its blockchain consensus.

## Key facts
- **Hashcash** (1997) is the original PoW implementation, used to stamp emails with a computed hash meeting a difficulty target (e.g., leading zeros in the hash output)
- The verifier's cost is *O(1)* — checking a solution takes microseconds — while the prover's cost scales with difficulty, creating intentional asymmetry
- Bitcoin's PoW requires miners to find a nonce such that `SHA-256(SHA-256(block_header))` produces a hash below a dynamic target, currently requiring ~19+ leading zero bits
- Difficulty adjusts automatically to maintain a target rate (Bitcoin: one block per ~10 minutes), making attacks economically prohibitive as network hash rate grows
- PoW is vulnerable to **51% attacks**: if one entity controls majority hash power, they can rewrite recent transaction history (double-spend)

## Related concepts
[[Hashcash]] [[Cryptographic Hash Functions]] [[Denial of Service]] [[Blockchain]] [[Challenge-Response Authentication]]