# NKAbuse

## What it is
Think of it like a parasite that hitches a ride on a postal network nobody's monitoring — instead of TCP/IP, it whispers commands through NKN (New Kind of Network), a blockchain-based peer-to-peer protocol. NKAbuse is a multi-platform Go-based malware that abuses the NKN decentralized communication protocol for C2 (command-and-control), functioning simultaneously as a backdoor and a DDoS bot. Its blockchain-based transport makes traffic attribution and takedown extraordinarily difficult.

## Why it matters
In 2023, NKAbuse was deployed against targets in Mexico, Colombia, and Vietnam — primarily Linux systems and MISP-adjacent infrastructure — by exploiting the Apache ActiveMQ vulnerability (CVE-2023-46604). Because C2 traffic blends into legitimate NKN blockchain communications, traditional perimeter defenses and domain blocklists are largely blind to it, forcing defenders to rely on behavioral detection rather than signature-based tools.

## Key facts
- **Written in Go**, making it cross-platform: Linux (primary), MIPS, ARM, and 386 architectures are all targeted
- **C2 via NKN protocol**: each implant has a unique NKN address; commands are sent peer-to-peer with no central server to sinkhole or block
- **Dual functionality**: operates as a remote access backdoor *and* launches DDoS floods (UDP, TCP, HTTP)
- **Persistence mechanism**: drops a cron job on infected Linux hosts and stores a bot configuration file locally
- **Initial access**: observed exploiting CVE-2023-46604 (Apache ActiveMQ RCE, CVSS 10.0) for initial foothold

## Related concepts
[[Command and Control (C2)]] [[Blockchain-based Evasion]] [[DDoS Botnet]] [[Apache ActiveMQ CVE-2023-46604]] [[Go-based Malware]]