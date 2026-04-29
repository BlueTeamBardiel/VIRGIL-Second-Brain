# Team Viewer

## What it is
Think of it as handing someone a spare key to your house — but the key works over the internet from anywhere on the planet. TeamViewer is a remote access and desktop sharing application that allows users to view and control another computer in real time over an encrypted connection, commonly used for IT support and remote work.

## Why it matters
In 2016, attackers exploited users who had reused credentials from other breaches to hijack TeamViewer sessions and drain PayPal and bank accounts — a credential stuffing attack against a legitimate remote access tool. Defenders use this case to illustrate why remote access software must enforce MFA and why monitoring for unusual session origins is critical. TeamViewer also appears frequently in social engineering attacks where victims are tricked into installing it and granting access to "tech support" scammers.

## Key facts
- TeamViewer communicates over TCP/UDP port **5938** (primary), with fallback to port 443 and 80, making it hard to block without deep packet inspection
- Each session is identified by a unique **9-digit ID** and temporary password, but persistent unattended access can be configured — a major risk if left open
- Traffic is encrypted using **AES-256** with key exchange via RSA-2048, so it *looks* secure but the trust model depends entirely on who holds the credentials
- It is a common **living-off-the-land** style tool abused by threat actors (notably TA505 and ransomware groups) because it is whitelisted by many AV solutions
- Security controls should include: allowlisting approved TeamViewer versions, enabling **two-factor authentication**, and logging all remote sessions via SIEM integration

## Related concepts
[[Remote Access Trojans (RAT)]] [[Credential Stuffing]] [[Living Off the Land (LOTL)]] [[Multi-Factor Authentication]] [[VPN]]