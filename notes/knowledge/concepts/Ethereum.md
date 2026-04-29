# Ethereum

## What it is
Think of Ethereum as a global vending machine that nobody owns — you put in code and cryptocurrency, and it executes exactly as programmed with no middleman. Technically, it is an open-source, decentralized blockchain platform that supports **smart contracts**: self-executing programs stored on-chain that run deterministically when triggered by transactions. Unlike Bitcoin, which is primarily a ledger for value transfer, Ethereum is a programmable execution environment.

## Why it matters
In 2016, the DAO (Decentralized Autonomous Organization) hack exploited a **reentrancy vulnerability** in an Ethereum smart contract — the attacker's malicious contract recursively called the withdrawal function before balances updated, draining ~$60 million in ETH. This demonstrated that immutable code deployed on a public blockchain creates a permanent, unpatched attack surface, making smart contract auditing a critical security discipline. Defenders now use tools like Slither and formal verification before deployment.

## Key facts
- Ethereum uses **Solidity** as its primary smart contract language; vulnerabilities in Solidity code (reentrancy, integer overflow, access control flaws) are common attack vectors
- The **Ethereum Virtual Machine (EVM)** is a sandboxed runtime that executes contract bytecode — all nodes run the same code, making consensus deterministic but exploits globally reproducible
- Smart contracts are **immutable once deployed** unless specifically designed with upgrade proxies, meaning vulnerabilities cannot be patched like traditional software
- Ethereum transactions require **gas fees** paid in ETH; gas exhaustion attacks (griefing) can render contracts unusable
- Ethereum shifted from **Proof of Work to Proof of Stake** ("The Merge," 2022), changing its consensus threat model — 51% attacks now require controlling 51% of staked ETH rather than hash power

## Related concepts
[[Smart Contracts]] [[Blockchain Security]] [[Cryptographic Hash Functions]] [[Decentralized Applications (DApps)]] [[Reentrancy Attack]]