# Winnti Group

## What it is
Like a locksmith who secretly copies your master key while installing your new lock, Winnti Group embeds itself inside software supply chains to steal code-signing certificates and backdoor legitimate software. It is a Chinese state-sponsored APT collective (tracked as APT41 by Mandiant) active since at least 2010, targeting gaming companies, pharmaceuticals, telecommunications, and government entities across Asia, Europe, and North America.

## Why it matters
In 2020, Winnti compromised Taiwanese semiconductor giant TSMC's supply chain environment, and earlier operations poisoned legitimate gaming software updates — meaning players who downloaded patches unknowingly installed a rootkit signed with a stolen, trusted certificate. This illustrates why certificate validation and software integrity monitoring are insufficient alone when the signing infrastructure itself is compromised.

## Key facts
- **Winnti malware** is a modular RAT/rootkit that uses a kernel-level driver to hide processes and network connections; it runs in ring-0 (kernel space), making detection extremely difficult
- The group is notorious for **stealing code-signing certificates** from gaming and software companies to sign malicious payloads, bypassing application whitelisting controls
- Operates under multiple aliases: **APT41, Barium, Double Dragon** — unique in that it conducts both espionage (state-directed) and financially motivated attacks (ransomware, virtual currency theft) simultaneously
- Known for **ShadowPad**, a sophisticated backdoor distributed through legitimate software updates (NetSarang, CCleaner supply chain incidents)
- Uses **living-off-the-land** techniques (certutil, mshta, PowerShell) to blend malicious activity with normal system administration traffic

## Related concepts
[[APT (Advanced Persistent Threat)]] [[Supply Chain Attack]] [[Code Signing]] [[ShadowPad]] [[Living Off the Land (LotL)]]