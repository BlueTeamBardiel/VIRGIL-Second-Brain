# Volt Typhoon

## What it is
Like a tenant who moves into your house, unplugs your security cameras, and quietly maps every room for years before ever stealing anything — Volt Typhoon is a Chinese state-sponsored advanced persistent threat (APT) group specializing in pre-positioning inside critical infrastructure networks without deploying traditional malware. They operate almost entirely through "living off the land" (LotL) techniques, using built-in system tools to blend into normal administrative activity.

## Why it matters
In 2023–2024, CISA and the FBI confirmed Volt Typhoon had silently infiltrated U.S. communications, energy, water, and transportation networks — not to steal data, but to pre-position for potential disruption during a future geopolitical conflict, particularly regarding Taiwan. Defenders discovered the intrusions largely through anomalous use of tools like `netsh`, `wmic`, and `ntdsutil` rather than any malware signatures.

## Key facts
- **TTPs**: Relies almost exclusively on living-off-the-land binaries (LOLBins) — `certutil`, `wmic`, `PowerShell`, `ntdsutil` — to avoid endpoint detection
- **Initial Access**: Primarily exploits internet-facing appliances (VPNs, routers, firewalls) rather than phishing — notably targeting Fortinet, Cisco, and SOHO routers
- **Objective**: Strategic pre-positioning for future destructive or disruptive attacks, NOT immediate espionage or financial gain
- **Dwell Time**: Known for exceptionally long dwell times — measured in years — inside victim networks before discovery
- **Detection Challenge**: Because no custom malware is used, signature-based AV/EDR is largely ineffective; behavioral analytics and baseline deviation detection are required

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Living Off the Land (LotL)]] [[Critical Infrastructure Security]] [[Threat Hunting]] [[Lateral Movement]]