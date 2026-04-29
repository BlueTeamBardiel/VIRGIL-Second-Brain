# MuddyWater

## What it is
Like a chameleon that steals other animals' camouflage patterns, MuddyWater is an Iranian state-sponsored threat actor that constantly borrows and repurposes publicly available offensive tools to blend in with generic cybercriminal activity. Precisely defined, MuddyWater (also tracked as TEMP.Zagros, Static Kitten, and Mercury) is an advanced persistent threat group operating since approximately 2017, attributed to Iran's Ministry of Intelligence and Security (MOIS), primarily targeting government and telecommunications sectors across the Middle East, Europe, and North America.

## Why it matters
In 2022, CISA and FBI issued a joint advisory warning that MuddyWater was using the legitimate remote administration tool ScreenConnect alongside custom PowerShell-based malware to establish persistent access inside victim networks — making detection difficult because the traffic resembled normal IT administration. Defenders responding to this campaign had to focus on behavioral analytics rather than signature detection, since the group deliberately avoids unique custom malware fingerprints.

## Key facts
- MuddyWater heavily relies on **living-off-the-land (LotL)** techniques, abusing PowerShell, WMI, and legitimate remote management tools to evade detection
- The group uses **spear-phishing emails with malicious attachments** (often Excel files with macros) as its primary initial access vector
- Attribution: linked to **Iran's MOIS**, distinguishing it from IRGC-affiliated groups like APT33 or APT34
- The actor frequently deploys **PowGoop**, a custom PowerShell-based backdoor designed to masquerade as a legitimate Google update mechanism
- MuddyWater is classified as an **APT (Advanced Persistent Threat)** and appears on CISA's top routinely exploited threat actor list

## Related concepts
[[Advanced Persistent Threat]] [[Living Off the Land Attacks]] [[Spear Phishing]] [[PowerShell Obfuscation]] [[Threat Attribution]]