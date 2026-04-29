# Threat Scope Reduction

## What it is
Like sealing off unused rooms in a mansion to reduce the number of windows a burglar could break through, threat scope reduction is the deliberate act of eliminating unnecessary attack surface. Precisely: it is the practice of disabling, removing, or restricting features, services, accounts, and access points that are not required for a system to fulfill its purpose, thereby shrinking the number of viable vectors an attacker can exploit.

## Why it matters
In the 2017 Equifax breach, attackers exploited Apache Struts through a web-facing application that should have been patched — but the deeper failure was that the system exposed far more functionality and network access than it needed to. Had unused components been disabled and network segmentation enforced, the attacker's lateral movement would have been dramatically constrained, potentially containing the breach to a single system instead of exposing 147 million records.

## Key facts
- **Hardening** is the primary implementation mechanism — removing default accounts, disabling unused ports/protocols, and uninstalling unnecessary software
- **Principle of Least Privilege (PoLP)** directly supports threat scope reduction by ensuring accounts and processes have only the minimum permissions required
- **Attack surface** is the measurable output: threat scope reduction shrinks it; every open port, enabled service, and active account is a potential entry point
- CIS Benchmarks and STIG guides provide prescriptive checklists for systematically reducing threat scope on specific operating systems and applications
- Disabling SMBv1 is a canonical real-world example — it eliminated the attack vector that WannaCry and NotPetya weaponized in 2017

## Related concepts
[[Attack Surface Management]] [[Principle of Least Privilege]] [[System Hardening]] [[Network Segmentation]] [[Defense in Depth]]