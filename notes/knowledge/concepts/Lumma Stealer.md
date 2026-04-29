# Lumma Stealer

## What it is
Think of it as a silent hotel thief who doesn't steal your luggage — just photographs your passport, wallet contents, and key card before slipping out undetected. Lumma Stealer (also called LummaC2) is a commodity infostealer malware sold as Malware-as-a-Service (MaaS) on Russian-language cybercrime forums since 2022, designed to exfiltrate browser credentials, session cookies, cryptocurrency wallets, and system fingerprint data back to attacker-controlled C2 infrastructure.

## Why it matters
In 2024, Lumma Stealer campaigns distributed via fake CAPTCHA pages ("ClickFix" technique) tricked users into pasting malicious PowerShell commands into their own Run dialog, bypassing traditional email filter defenses entirely. Security teams responding to these incidents found that stolen session cookies allowed attackers to hijack authenticated sessions without ever needing the victim's password, defeating MFA in the process.

## Key facts
- Sold via MaaS subscription model with tiered pricing (~$250–$1,000/month), lowering the technical barrier for threat actors
- Targets Chromium and Firefox browser stores, specifically extracting the `Login Data` SQLite database and cookies to enable session hijacking
- Uses anti-analysis techniques including dead code injection, string obfuscation, and checks for sandbox/VM environments before executing payload
- Exfiltrates data via HTTP POST to rotating C2 domains, often using Telegram bots as a fallback channel
- Classified as a credential-access threat mapped to MITRE ATT&CK **T1555.003** (Credentials from Web Browsers) and **T1539** (Steal Web Session Cookie)

## Related concepts
[[Infostealer Malware]] [[Malware-as-a-Service]] [[Session Hijacking]] [[Credential Dumping]] [[Command and Control (C2)]]