# Proof of Stake

## What it is
Instead of burning electricity in a race to solve puzzles, validators put up their own cryptocurrency as collateral — like a bouncer who has to post a cash bond that gets seized if they let in trouble. Proof of Stake (PoS) is a blockchain consensus mechanism where validators are selected to create new blocks proportional to the amount of cryptocurrency they "stake" (lock up) as security deposit. If a validator acts dishonestly, their stake is "slashed" — destroyed as punishment.

## Why it matters
A 51% attack against a PoS network requires an attacker to *own* the majority of staked tokens, making attacks economically self-defeating — destroying network value also destroys the attacker's own holdings. In contrast, a 51% attack on Proof of Work (Bitcoin) requires only renting or acquiring majority hash power, which can be done without owning the underlying asset. Ethereum's 2022 "Merge" to PoS was a major security architecture shift that changed the threat model for the world's second-largest blockchain.

## Key facts
- Validators are chosen pseudorandomly, weighted by stake size — larger stake = higher selection probability
- **Slashing** is the penalty mechanism: dishonest or offline validators lose a portion of their staked funds
- PoS reduces the **attack surface** of energy-based Sybil attacks present in Proof of Work
- **Nothing-at-stake problem**: early PoS designs allowed validators to vote on multiple chain forks at no cost; slashing conditions were introduced to solve this
- Ethereum requires 32 ETH minimum stake per validator, creating a quantifiable economic barrier to participation

## Related concepts
[[Blockchain Security]] [[Consensus Mechanisms]] [[Sybil Attack]] [[Cryptographic Hash Functions]] [[Distributed Ledger Technology]]