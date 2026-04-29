# Discord

## What it is
Think of Discord like a massive apartment complex where anyone can rent a private room, hang a "gaming club" sign on the door, and invite strangers in — with zero background checks at the front desk. Precisely: Discord is a VoIP, instant messaging, and community platform built around persistent "servers" (invite-based chat rooms) supporting text, voice, video, and file sharing, accessible via app or browser.

## Why it matters
Threat actors increasingly abuse Discord's CDN (cdn.discordapp.com) to host and deliver malware payloads, because the domain is widely trusted and rarely blocked by corporate firewalls. In documented campaigns, attackers drop a malicious executable into a Discord channel, then embed the CDN link in phishing emails — the file downloads cleanly past many URL filters because it originates from a legitimate Microsoft-adjacent infrastructure. Defenders must treat Discord CDN links the same as any unknown file-hosting URL.

## Key facts
- **Discord webhooks** are frequently weaponized as C2 exfiltration channels — malware POSTs stolen credentials or keylogger output directly to an attacker-controlled Discord channel using a simple HTTPS POST request.
- Discord's **bot API** can be exploited to automate credential harvesting, spam, or malware distribution at scale within compromised servers.
- **Token theft** is a major attack vector: Discord stores plaintext authentication tokens in local browser/app storage (`%AppData%\discord\Local Storage`), making them a high-value target for infostealers like RedLine.
- Discord is classified as a **Living-off-Trusted-Sites (LoTS)** vector — abusing legitimate platforms to blend malicious traffic with normal business traffic.
- Many organizations' **DLP and proxy solutions** whitelist Discord entirely for legitimate use, creating a blind spot that adversaries deliberately exploit.

## Related concepts
[[Command and Control (C2)]] [[Phishing]] [[Data Exfiltration]] [[Infostealer Malware]] [[Living off the Land]]