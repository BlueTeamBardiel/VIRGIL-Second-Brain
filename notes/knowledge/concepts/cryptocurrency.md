# cryptocurrency

## What it is
Like digital gold stored in a public ledger that everyone can read but only the rightful owner can spend, cryptocurrency is a decentralized digital currency secured by cryptographic proof rather than central bank authority. Transactions are validated through consensus mechanisms (proof-of-work or proof-of-stake) and recorded immutably on a blockchain. No single entity controls it — the math does.

## Why it matters
Ransomware operators demand payment exclusively in cryptocurrency (typically Monero or Bitcoin) because it offers pseudonymity and cross-border transfer without banking intermediaries — making fund recovery and attacker attribution extremely difficult for law enforcement. The 2021 Colonial Pipeline attack demanded ~75 Bitcoin (~$4.4M), though the FBI later recovered roughly half by seizing the attacker's private key. This case illustrates that "crypto = untraceable" is a myth — blockchain forensics firms like Chainalysis can follow the money.

## Key facts
- **Pseudonymous, not anonymous**: Bitcoin wallet addresses are public; chain analysis can de-anonymize transactions by correlating exchange KYC data with on-chain activity
- **Monero (XMR)** uses ring signatures and stealth addresses to provide true privacy — preferred by threat actors for this reason
- **Cryptojacking** is the unauthorized use of victim systems to mine cryptocurrency; it's detectable via sudden CPU/GPU spikes and anomalous outbound traffic to mining pools
- **Private key = ownership**: losing or exposing a private key means permanent loss or theft of funds — no password reset exists
- **Blockchain immutability** means fraudulent transactions cannot be reversed, making crypto a preferred vehicle for money laundering and ransomware payment

## Related concepts
[[blockchain]] [[ransomware]] [[cryptojacking]] [[public key infrastructure]] [[threat actor attribution]]