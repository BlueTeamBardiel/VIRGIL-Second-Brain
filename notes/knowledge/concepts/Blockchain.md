# Blockchain

## What it is
Imagine a town ledger where every citizen keeps an identical copy — to forge one entry, you'd have to rewrite every citizen's book simultaneously. Blockchain is a distributed, append-only ledger where each block contains a cryptographic hash of the previous block, transaction data, and a timestamp, chaining them together such that tampering with any block invalidates all subsequent blocks. Consensus mechanisms (Proof of Work, Proof of Stake) ensure no single party controls the record.

## Why it matters
In certificate transparency, blockchain-like append-only logs publicly record every TLS certificate issued by Certificate Authorities — this is how researchers caught DigiNotar issuing fraudulent Google certificates, exposing a compromised CA before broader damage occurred. Attackers exploiting a rogue CA can no longer silently issue fraudulent certs without the log exposing the discrepancy. This use demonstrates blockchain's core defense: tamper-evident public accountability.

## Key facts
- **Immutability via hashing:** SHA-256 hashes link blocks; changing one byte in block #50 produces a completely different hash, breaking the chain from block #51 onward
- **51% attack:** An attacker controlling >50% of network hash power can rewrite transaction history — this is the primary attack vector against smaller cryptocurrencies
- **Smart contracts** are self-executing code stored on-chain; vulnerabilities (e.g., reentrancy bugs) have led to exploits like the 2016 Ethereum DAO hack ($60M stolen)
- **Public vs. private blockchains:** Public chains (Bitcoin) are permissionless; private/consortium chains (Hyperledger) are used in enterprise security for supply chain integrity verification
- **Non-repudiation:** Transactions are signed with private keys, creating cryptographically verifiable proof of origin — directly relevant to Security+ non-repudiation objectives

## Related concepts
[[Public Key Infrastructure]] [[Cryptographic Hashing]] [[Digital Signatures]] [[Certificate Transparency]] [[Non-Repudiation]]