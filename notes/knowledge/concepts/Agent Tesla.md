# Agent Tesla

## What it is
Think of it as a remote keylogger-for-hire that works like a cheap surveillance camera someone mailed to themselves — easy to deploy, hard to notice, streams everything back home. Agent Tesla is a .NET-based Remote Access Trojan (RAT) and keylogger-as-a-service (KaaS) sold on underground forums since 2014, capable of harvesting credentials, screenshots, clipboard data, and keystrokes from compromised Windows systems.

## Why it matters
In 2020, CISA and FBI warnings highlighted Agent Tesla as one of the most prolific malware strains targeting U.S. organizations via COVID-19-themed phishing emails. Attackers embedded it in malicious Excel or Word attachments; once opened, it exfiltrated corporate VPN credentials directly to attacker-controlled SMTP servers or Telegram channels, enabling follow-on network intrusion within hours.

## Key facts
- **Delivery vector**: Primarily spear-phishing via malicious Office documents exploiting CVE-2017-11882 (Equation Editor buffer overflow) or weaponized PDF attachments
- **Exfiltration methods**: Uses SMTP, FTP, HTTP POST, and Telegram Bot API — legitimate protocols to blend with normal traffic and evade basic firewall rules
- **Credential targets**: Harvests stored passwords from 50+ applications including Chrome, Firefox, Outlook, FileZilla, and VPN clients
- **Persistence mechanism**: Achieves persistence via Windows Registry Run keys, Task Scheduler, or startup folder entries — all classic persistence locations tested on Security+
- **Obfuscation**: Heavily obfuscated .NET code; frequently packed or wrapped in a crypter/loader (e.g., GuLoader, SnakeKeylogger dropper chain) to evade signature-based AV detection

## Related concepts
[[Keylogger]] [[Spear Phishing]] [[Remote Access Trojan]] [[Credential Harvesting]] [[CVE-2017-11882]]