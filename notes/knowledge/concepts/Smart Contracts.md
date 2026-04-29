# Smart Contracts

## What it is
Think of a vending machine: you insert coins, press a button, and the machine dispenses your item automatically — no cashier needed, no negotiation possible. A smart contract is exactly that, but written in code and living on a blockchain: a self-executing program that automatically enforces agreement terms when predefined conditions are met, with no intermediary required and no possibility of unilateral modification once deployed.

## Why it matters
In 2016, the DAO (Decentralized Autonomous Organization) hack exploited a **reentrancy vulnerability** in an Ethereum smart contract — the attacker's malicious contract recursively called the withdrawal function before the balance was updated, draining ~$60 million in ETH. This attack illustrates that immutability is a double-edged sword: once a vulnerable contract is deployed, patching it requires deploying an entirely new contract, and the old one remains exploitable forever.

## Key facts
- Smart contracts run on blockchain platforms (primarily **Ethereum**) and are written in languages like **Solidity**; they are immutable once deployed, making pre-deployment auditing critical
- The **reentrancy attack** is the most famous smart contract vulnerability: calling back into the vulnerable contract before state changes are committed
- **Logic flaws** are the primary attack surface — the code does exactly what it says, so if the logic is wrong, the exploit is deterministic and repeatable
- Smart contracts have no built-in access to external data; they rely on **oracles** (external data feeds), which introduce a separate trust and attack surface
- From a compliance perspective, smart contracts raise questions about **legal enforceability** and jurisdiction — relevant for governance, risk, and compliance (GRC) domains in security roles

## Related concepts
[[Blockchain Security]] [[Cryptographic Hashing]] [[Supply Chain Attacks]] [[Code Injection]] [[Zero Trust Architecture]]