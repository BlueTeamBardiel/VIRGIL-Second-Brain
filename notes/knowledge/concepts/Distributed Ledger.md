# Distributed Ledger

## What it is
Imagine every transaction at a bank simultaneously recorded in thousands of identical notebooks held by strangers worldwide — altering one requires rewriting all of them simultaneously. A distributed ledger is a decentralized database replicated and synchronized across multiple nodes or locations, where no single authority controls the master copy. Each participant holds an identical, cryptographically verified record of all transactions.

## Why it matters
In supply chain security, a distributed ledger can expose firmware tampering: if a hardware component's cryptographic hash is recorded at manufacture and every custody transfer is logged immutably, an attacker inserting a malicious chip cannot alter the ledger retroactively without detection across thousands of nodes. This is why NIST guidelines increasingly reference blockchain-based provenance tracking for critical hardware supply chains.

## Key facts
- **Immutability via consensus:** Altering a record requires controlling >50% of participating nodes (a "51% attack"), making retroactive fraud computationally expensive or impossible in large networks
- **Blockchain is a subset:** Blockchain organizes distributed ledger entries into cryptographically chained blocks; not all distributed ledgers use blocks (e.g., IOTA uses a DAG structure)
- **Public vs. permissioned ledgers:** Public ledgers (Bitcoin) are open to all; permissioned/private ledgers (Hyperledger Fabric) restrict participation — relevant for enterprise security architectures
- **Non-repudiation:** Transactions are digitally signed, creating an auditable trail where participants cannot deny their recorded actions — directly maps to the Security+ non-repudiation objective
- **Smart contracts:** Self-executing code stored on a ledger can automate access control or enforce policy, but also introduce attack surfaces (e.g., the 2016 DAO hack drained $60M via a reentrancy vulnerability)

## Related concepts
[[Blockchain Security]] [[Non-Repudiation]] [[Public Key Infrastructure]] [[Supply Chain Risk Management]] [[Smart Contract Vulnerabilities]]