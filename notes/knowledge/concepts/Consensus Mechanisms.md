# Consensus Mechanisms

## What it is
Imagine a courtroom where no single judge exists — instead, a jury of thousands must agree before any verdict is recorded permanently. Consensus mechanisms are the protocols that allow distributed nodes in a blockchain network to agree on a single valid state of the ledger without trusting any central authority. They replace institutional trust with mathematical and economic rules enforced collectively.

## Why it matters
In a **51% attack**, a malicious actor acquires majority control of a Proof-of-Work network's hash rate, allowing them to rewrite recent transaction history and double-spend cryptocurrency. This is not theoretical — the Ethereum Classic network suffered documented 51% attacks in 2019 and 2020, resulting in millions of dollars in fraudulent double-spends. Understanding consensus mechanisms explains precisely *why* controlling majority compute power breaks the security guarantee.

## Key facts
- **Proof of Work (PoW):** Nodes compete to solve computationally expensive puzzles; security derives from the cost of energy and hardware — rewriting history requires re-doing all that work
- **Proof of Stake (PoS):** Validators lock up ("stake") cryptocurrency as collateral; attacking the network means risking destruction of your own stake via "slashing"
- **51% Attack threshold:** An attacker needs >50% of PoW hash rate or >33% of PoS validators (Byzantine Fault Tolerance) to disrupt finality, depending on implementation
- **Byzantine Fault Tolerance (BFT):** The theoretical basis for consensus — a system can tolerate up to ⌊(n-1)/3⌋ malicious nodes while still reaching correct agreement
- **Finality:** PoW has *probabilistic* finality (more blocks = safer); many PoS systems offer *absolute* finality, meaning confirmed transactions cannot be reversed

## Related concepts
[[Blockchain Security]] [[Double-Spend Attack]] [[Byzantine Fault Tolerance]] [[Cryptographic Hashing]] [[Distributed Ledger Technology]]