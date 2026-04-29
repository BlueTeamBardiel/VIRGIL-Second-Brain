# PuTTY

## What it is
Think of PuTTY as a telephone handset for servers — it gives you a way to pick up and talk securely to a remote machine across the network. Precisely, PuTTY is a free, open-source terminal emulator and SSH/Telnet client for Windows that enables encrypted remote administration of systems using protocols like SSH, Telnet, SCP, and SFTP.

## Why it matters
In 2023, PuTTY versions 0.68–0.80 were found to contain a critical vulnerability (CVE-2024-31497) where the ECDSA key generation for NIST P-521 keys was biased, allowing an attacker who observed roughly 58 signatures to mathematically recover the private key — effectively stealing your server credentials from your own client. This serves as a sharp reminder that even trusted, widely-deployed admin tools can become the weakest link in remote access security.

## Key facts
- PuTTY uses SSH (port 22 by default) to provide encrypted, authenticated remote shell access, replacing the cleartext-transmitting Telnet (port 23)
- PuTTY stores saved session configurations and SSH private key paths in the Windows Registry under `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY` — a common target for credential harvesting malware
- PuTTYgen, the companion key generator tool, creates RSA, DSA, ECDSA, and Ed25519 key pairs for SSH public-key authentication
- Attackers use PuTTY legitimately as a living-off-the-land (LotL) technique: since it's a trusted admin tool, its traffic may not trigger security alerts
- Pageant is PuTTY's SSH authentication agent that holds decrypted private keys in memory, making it a target for key extraction attacks similar to Mimikatz-style credential dumping

## Related concepts
[[SSH]] [[Telnet]] [[Remote Access Trojan (RAT)]] [[Living Off the Land (LotL)]] [[Credential Dumping]]