# Blockchain Technology

## What it is

In Destiny, every Guardian's vault, gear, and Light level lives on Bungie's servers — but imagine instead that every player in the world kept an identical copy of the loot ledger, and to forge an Exotic you'd have to convince the majority of the playerbase your fake drop was legitimate. That's exactly what blockchain does — it's a shared, append-only record where everyone holds the same copy, so cheating requires beating the entire network at once.

A **blockchain** is a distributed, cryptographically-linked ledger where each block contains a hash of the previous block, forming a tamper-evident chain validated by a consensus mechanism across decentralized nodes.

## Why it matters

Blockchain provides **integrity** and **non-repudiation** without a trusted central authority — kill the central server and the data still survives across thousands of nodes. For SY0-701, Objective 1.4 lists "Blockchain" and "Open public ledger" as cryptographic concepts you must recognize. CompTIA's favorite trap: confusing blockchain with encryption. Blockchain is **not** confidential by default — public ledgers are readable by anyone. It guarantees that data hasn't been altered, not that nobody can see it.

## Key facts

### Core mechanics

- **Block structure**: each block contains transactions, a timestamp, a [[nonce]], and the [[cryptographic hash]] of the previous block (typically [[SHA-256]]).
- **Chaining**: altering block N forces recomputation of every subsequent block — the chain itself is the tamper-evidence.
- **Decentralization**: copies live on many [[nodes]]; no single point of failure or control.
- **Open public ledger**: anyone can read and verify; transactions are pseudonymous, not anonymous.

### Consensus mechanisms

| Mechanism | How it works | Used by |
|---|---|---|
| **Proof of Work (PoW)** | Nodes race to solve a hash puzzle; winner adds the block | Bitcoin |
| **Proof of Stake (PoS)** | Validators chosen based on stake held; less energy-intensive | Ethereum (post-Merge) |
| **Practical Byzantine Fault Tolerance (PBFT)** | Voting-based; tolerates up to 1/3 malicious nodes | Permissioned chains |

### Security properties delivered

- **Integrity** — hash chaining detects any modification.
- **Non-repudiation** — transactions are signed with the sender's [[private key]] via [[digital signatures]].
- **Availability** — distributed replication survives node loss.
- **NOT confidentiality** — public chains are world-readable. Use [[encryption]] separately if you need privacy.

### Attack surface

- **51% attack**: an attacker controlling majority hash power (PoW) or stake (PoS) can rewrite recent history or double-spend.
- **Sybil attack**: flooding the network with fake nodes to gain disproportionate influence — countered by PoW/PoS cost.
- **Smart contract flaws**: code-level bugs (reentrancy, integer overflow) — the chain is sound, the program on it isn't.
- **Key theft**: lose your private key, lose your assets. The chain has no password reset.

### Real-world security uses beyond cryptocurrency

- **Supply chain integrity** — tracking provenance of pharmaceuticals, food, semiconductors.
- **Public Key Infrastructure** — decentralized [[certificate]] transparency logs.
- **Identity management** — self-sovereign identity, verifiable credentials.
- **Audit logs** — tamper-evident logging where regulators must trust the record.

### Exam-precise distinctions

- **Public blockchain** (Bitcoin, Ethereum): permissionless, anyone joins.
- **Private/permissioned blockchain** (Hyperledger): restricted membership, faster, used by enterprises.
- **Hash chain ≠ blockchain**: a hash chain is the underlying integrity primitive; blockchain adds consensus and decentralization.

## Related concepts

[[Hashing]] · [[Digital Signatures]] · [[Public Key Infrastructure]] · [[Non-repudiation]] · [[Integrity]] · [[Open Public Ledger]] · [[Smart Contracts]] · [[SHA-256]] · [[Cryptographic Nonce]]

---
*Source: VIRGIL knowledge base — 2026-05-08*