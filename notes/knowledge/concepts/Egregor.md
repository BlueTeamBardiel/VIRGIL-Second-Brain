# Egregor

## What it is
Like a franchise criminal operation where headquarters provides the tools and collects a cut while local operators handle the actual robberies, Egregor is a Ransomware-as-a-Service (RaaS) group that emerged in September 2020 as a successor to the Maze ransomware operation. It operated via affiliates who deployed the ransomware while Egregor's developers took roughly 20-30% of ransom proceeds.

## Why it matters
In late 2020, Egregor struck Barnes & Noble, Ubisoft, and Cencosud within weeks of each other, demonstrating the affiliate model's terrifying scalability — different attackers, same malware infrastructure, simultaneous global victims. The group used a "double extortion" tactic: encrypting files *and* threatening to publish stolen data on their "Egregor News" leak site, pressuring victims even if they had backups. This forced defenders to treat ransomware incidents as data breach incidents simultaneously.

## Key facts
- **Double extortion pioneer**: Egregor threatened to publish stolen data within 72 hours if ransom wasn't paid, combining encryption with data leak pressure
- **Chimera loader**: Egregor was delivered via common initial access vectors including phishing, RDP exploitation, and QakBot/IcedID malware as droppers
- **Short lifespan**: The group was disrupted in February 2021 when Ukrainian and French authorities arrested key members, showing international law enforcement coordination works
- **Obfuscation technique**: Egregor's payload required a specific command-line key to decrypt and execute — a unique anti-analysis sandbox evasion method
- **Maze lineage**: Egregor shared significant code overlap with Maze ransomware, suggesting the same developers rebranded after Maze "retired" in late 2020

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[QakBot]] [[Maze Ransomware]] [[Incident Response]]