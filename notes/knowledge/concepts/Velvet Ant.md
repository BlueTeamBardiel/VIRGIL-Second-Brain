# Velvet Ant

## What it is
Like a burglar who lives inside your walls for years, eating your food and reading your mail before you ever notice them, Velvet Ant is a sophisticated Chinese state-sponsored threat actor known for extreme operational patience and stealth. Specifically, it is an Advanced Persistent Threat (APT) group that conducted a prolonged intrusion campaign against a large U.S. organization, maintaining persistence for approximately **three years** before detection. Their defining trait is redundant, deeply embedded persistence mechanisms that survive standard incident response efforts.

## Why it matters
In 2024, Sygnia researchers disclosed that Velvet Ant had compromised a major enterprise network and, after initial remediation attempts, **pivoted to legacy F5 BIG-IP appliances** as a persistent foothold — devices often excluded from standard EDR monitoring. This case illustrates why network edge devices and legacy infrastructure represent critical blind spots: threat actors deliberately target them knowing defenders typically lack visibility there.

## Key facts
- Attributed to a **Chinese state-sponsored nexus**; motivations are espionage and long-term intelligence collection
- Used **F5 BIG-IP network appliances** as a covert command-and-control (C2) staging point after endpoint-based persistence was disrupted
- Demonstrated **multi-layered persistence**: when one foothold was removed, pre-planted secondary footholds activated automatically
- Leveraged **PlugX malware** (a hallmark Chinese APT tool) for remote access and lateral movement
- The 3-year dwell time highlights failures in **threat hunting and anomaly detection** — not just prevention controls

## Related concepts
[[Advanced Persistent Threat (APT)]] [[PlugX Malware]] [[Lateral Movement]] [[Threat Hunting]] [[Living Off the Land (LotL)]]