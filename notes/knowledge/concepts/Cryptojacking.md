# Cryptojacking

## What it is
Imagine someone secretly plugging their phone charger into your outlet 24/7 — you pay the electricity bill while they get the power. Cryptojacking is exactly that: an attacker covertly hijacks a victim's CPU/GPU cycles to mine cryptocurrency, typically Monero (XMR), without authorization. It can be delivered via malicious scripts injected into websites (browser-based) or through malware installed persistently on endpoints.

## Why it matters
In 2018, attackers compromised the Browsealoud accessibility plugin used by thousands of government websites — including the UK's NHS and US court systems — injecting CoinHive's JavaScript miner into every visitor's browser. No data was stolen, but every visitor unknowingly donated CPU resources to the attackers, demonstrating that cryptojacking can achieve massive scale through a single supply chain compromise without triggering traditional data-loss alerts.

## Key facts
- **CoinHive** was the most notorious browser-based cryptomining script (retired 2019); its detection signatures are still a baseline for many IDS tools
- Cryptojacking is often **fileless in its browser form** — no binary drops to disk, making endpoint AV detection difficult; behavioral monitoring (CPU spike detection) is the primary countermeasure
- **Monero (XMR)** is preferred over Bitcoin because it is CPU-minable and privacy-focused, making transactions harder to trace
- Key indicators of compromise (IOCs): **sustained high CPU usage** (>80%), increased power consumption, system slowdowns, and unusual outbound connections to mining pool domains
- On Security+/CySA+, cryptojacking is classified under **resource hijacking** — a threat that impacts **availability and integrity** rather than confidentiality

## Related concepts
[[Malware]] [[Drive-by Download]] [[Fileless Malware]] [[Supply Chain Attack]] [[Behavioral Analytics]]