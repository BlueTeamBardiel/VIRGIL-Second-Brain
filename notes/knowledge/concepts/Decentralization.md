# Decentralization

## What it is
Like a hydra that grows two heads for every one cut off, a decentralized system has no single throat to choke — no master node whose failure brings everything down. Precisely defined, decentralization distributes control, data, and processing across multiple independent nodes so that no single point of authority or failure exists. Each node operates autonomously, collectively maintaining system integrity without a central coordinator.

## Why it matters
In 2016, the Dyn DNS attack took down Twitter, Netflix, and Spotify by targeting a single centralized DNS provider with a massive DDoS flood — a textbook demonstration of why single points of failure are catastrophic. Organizations countering this now use decentralized or anycast DNS architectures, spreading authoritative DNS resolution across geographically distributed nodes so no single target can silence the whole system. Blockchain-based certificate transparency logs apply the same principle to prevent undetected fraudulent certificate issuance.

## Key facts
- **Single Point of Failure (SPOF)** elimination is the primary security benefit — attackers must compromise a majority of nodes, not just one
- Blockchain uses decentralization to achieve tamper-evidence: altering one block requires re-mining the entire chain across 51% of nodes
- Decentralized PKI (Web of Trust in PGP) contrasts with centralized PKI (Certificate Authorities) — each model has distinct attack surfaces
- Tor's onion routing is a decentralized anonymity network; no single relay knows both source and destination
- Decentralization trades **availability and resilience** against **consistency and coordination overhead** — relevant to CIA triad analysis on exams

## Related concepts
[[Single Point of Failure]] [[Distributed Denial of Service]] [[Blockchain]] [[Public Key Infrastructure]] [[Fault Tolerance]]