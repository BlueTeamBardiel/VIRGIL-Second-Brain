# APT29

## What it is
Think of a master locksmith who doesn't just break in once — they quietly duplicate every key in the building, then slip in and out for years without anyone noticing. APT29 (also known as "Cozy Bear") is a Russian state-sponsored threat actor attributed to the SVR (Foreign Intelligence Service), operating since at least 2008 and specializing in long-term, stealthy espionage campaigns against government, defense, and critical infrastructure targets.

## Why it matters
In the 2020 SolarWinds supply chain attack, APT29 trojanized a legitimate software update (Orion platform) that was pushed to roughly 18,000 organizations, including multiple U.S. federal agencies. Defenders learned the hard way that even trusted, digitally-signed vendor updates can be weaponized — making software supply chain integrity verification a mandatory control, not an afterthought.

## Key facts
- **Attribution**: Linked to Russia's SVR intelligence service; distinct from APT28 (GRU/military intelligence), which is louder and more destructive
- **TTPs**: Uses living-off-the-land techniques, WMI, PowerShell, and custom implants like SUNBURST and MiniDuke to blend into normal traffic
- **Persistence method**: Favors stealthy backdoors with long dwell times — the SolarWinds breach went undetected for roughly 9 months
- **Target sectors**: Government agencies, think tanks, healthcare (COVID-19 vaccine research), and defense contractors — classic intelligence-gathering priorities
- **MITRE ATT&CK**: Heavily mapped under techniques T1195 (Supply Chain Compromise), T1078 (Valid Accounts), and T1027 (Obfuscated Files or Information)

## Related concepts
[[Advanced Persistent Threat]] [[Supply Chain Attack]] [[MITRE ATT&CK Framework]] [[Living Off the Land]] [[Threat Intelligence]]