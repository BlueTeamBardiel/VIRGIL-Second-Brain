# PSTN

## What it is
Think of it as the world's oldest and most sprawling copper pipe network — except instead of water, it carries voice calls through physical circuit-switched connections that have existed since the 1870s. The Public Switched Telephone Network (PSTN) is the aggregate of interconnected, government-regulated telephone infrastructure — copper lines, fiber, switching centers, and cellular handoffs — that enables traditional landline and analog phone communication globally. Unlike packet-switched networks, PSTN establishes a dedicated physical circuit for the entire duration of a call.

## Why it matters
Wardialing — made famous by the movie WarGames — exploits PSTN by automatically scanning telephone number ranges to discover modems, fax machines, or PBX systems attached to corporate networks. An attacker who finds a modem-connected legacy server on a corporate PSTN line can bypass every modern firewall and intrusion detection system entirely, since the entry point exists completely outside the IP network perimeter. This attack vector is still relevant because many industrial control systems and emergency services infrastructure retain analog PSTN connections for failover.

## Key facts
- PSTN uses **circuit switching**, meaning a dedicated path is reserved end-to-end for the call duration — unlike VoIP's packet switching
- **SS7 (Signaling System 7)** is the protocol stack that controls PSTN call setup/teardown and is notoriously vulnerable to eavesdropping and call redirection attacks
- Legacy PSTN connections are a **PCI-DSS concern** because older IVR (Interactive Voice Response) systems processing card data may lack encryption
- PSTN modems operate at **56 Kbps max (V.92 standard)** and represent out-of-band network access points that bypass perimeter defenses
- **Vishing (voice phishing)** attacks are delivered over PSTN infrastructure, making caller ID spoofing a direct threat vector

## Related concepts
[[SS7 Attack]] [[Vishing]] [[War Dialing]] [[VoIP Security]] [[PBX Hacking]]