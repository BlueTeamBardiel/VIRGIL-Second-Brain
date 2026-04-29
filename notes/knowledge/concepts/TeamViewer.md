# TeamViewer

## What it is
Think of it as a glass tunnel between two computers — whoever holds the key can see and control everything on the other end, from anywhere on Earth. TeamViewer is a commercial remote desktop and remote access tool that uses its own relay infrastructure to traverse firewalls and NAT without requiring port forwarding, authenticating sessions via unique device IDs and passwords.

## Why it matters
Attackers frequently abuse TeamViewer as a Living-off-the-Land (LotL) technique during intrusions — once installed, it blends into legitimate IT traffic, making detection difficult. In the 2021 Oldsmar water treatment facility incident, investigators found TeamViewer installed on the compromised system, highlighting how legitimate remote access tools become attack vectors when left unpatched and exposed with weak credentials.

## Key facts
- TeamViewer operates over TCP/UDP port 5938 (primary), falling back to port 443 or 80, making it very difficult to block without deep packet inspection
- Sessions are end-to-end encrypted using AES-256, but the relay server model means traffic routes through TeamViewer's infrastructure, creating a third-party trust dependency
- Attackers use "ghost" TeamViewer installations for persistent backdoor access — classified as a Remote Access Tool (RAT) when used maliciously, despite being legitimate software
- Default unattended access requires a fixed password, which becomes a critical vulnerability if credentials are reused or leaked
- Security teams should monitor for TeamViewer processes in EDR alerts, especially when spawned by unusual parent processes like `mshta.exe` or `powershell.exe`

## Related concepts
[[Remote Access Trojan (RAT)]] [[Living off the Land (LotL)]] [[Endpoint Detection and Response (EDR)]] [[Lateral Movement]] [[Defense Evasion]]