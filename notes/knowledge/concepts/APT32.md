# APT32

## What it is
Like a corporate spy who speaks perfect Vietnamese, dresses locally, and blends into the market while photographing trade secrets, APT32 is a nation-state threat actor that operates with deep regional camouflage. Formally known as **OceanLotus**, it is a Vietnamese state-sponsored advanced persistent threat group (attributed to Vietnam's Ministry of Public Security) that conducts espionage against foreign governments, corporations, and journalists primarily across Southeast Asia.

## Why it matters
In 2019, APT32 targeted BMW and Hyundai networks using trojanized JavaScript and custom malware, seeking automotive trade secrets ahead of Vietnam's emerging vehicle manufacturing ambitions. This illustrates how APT groups conduct **economic espionage**, not just geopolitical spying — defenders must treat intellectual property as a high-value target requiring the same protections as classified data.

## Key facts
- **Primary attribution**: Vietnam's Ministry of Public Security; active since at least 2012
- **Signature tools**: Custom backdoors (Denis, Cobalt Strike abuse, Kerrdown dropper), macro-laced Office documents, and signed malicious executables to bypass application whitelisting
- **TTPs**: Spearphishing with job postings or news lures, watering hole attacks on Vietnamese-language sites, and living-off-the-land techniques using PowerShell and WMI
- **Targets**: Southeast Asian governments, journalists, dissidents, NGOs, and multinational corporations with regional interests — particularly automotive, hospitality, and media sectors
- **MITRE ATT&CK**: Heavily mapped under techniques T1566 (Phishing), T1059 (Command and Scripting Interpreter), and T1078 (Valid Accounts) for persistence

## Related concepts
[[Advanced Persistent Threat]] [[Spearphishing]] [[Living Off the Land]] [[Watering Hole Attack]] [[MITRE ATT&CK Framework]]