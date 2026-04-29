# HAFNIUM

## What it is
Think of a master locksmith who doesn't pick your lock — they simply memorized a copy of your key from a data breach and walked right in through the front door. HAFNIUM is a Chinese state-sponsored Advanced Persistent Threat (APT) group, assessed by Microsoft to operate out of China, known for targeting on-premises Microsoft Exchange Server environments using zero-day exploits. They are notable for precision targeting of U.S.-based entities including defense contractors, law firms, and infectious disease researchers.

## Why it matters
In March 2021, HAFNIUM exploited four critical zero-day vulnerabilities in Microsoft Exchange Server (collectively dubbed "ProxyLogon") to achieve pre-authentication remote code execution and deploy web shells. This allowed them — and subsequent opportunistic attackers who reverse-engineered Microsoft's emergency patch — to maintain persistent backdoor access to tens of thousands of organizations worldwide before patches could be applied.

## Key facts
- HAFNIUM exploited **CVE-2021-26855** (SSRF), **CVE-2021-26857**, **CVE-2021-26858**, and **CVE-2021-27065** — the ProxyLogon chain — requiring no valid credentials to initiate
- They staged exfiltrated data to **MEGA** cloud storage and used tools like **Covenant** C2 framework and **Nishang** PowerShell scripts
- Web shells (e.g., China Chopper) were dropped in `C:\inetpub\wwwroot\aspnet_client\` — a key forensic artifact to know
- HAFNIUM operated through **U.S.-based VPS infrastructure** to obscure their Chinese origin — a classic APT tradecraft technique
- Attributed by the U.S. government with **high confidence** to China's Ministry of State Security (MSS) in a July 2021 joint advisory

## Related concepts
[[ProxyLogon]] [[Web Shell]] [[Advanced Persistent Threat]] [[Zero-Day Exploit]] [[Microsoft Exchange Server Vulnerabilities]]