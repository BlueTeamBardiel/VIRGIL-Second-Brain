# Conficker

## What it is
Imagine a sleeper agent who sneaks into a building through an unlocked side door, then quietly recruits every employee into a secret network — waiting for orders that may never come. Conficker is a self-replicating worm that exploited the Windows MS08-067 vulnerability (a Server Service buffer overflow) to infect machines, disable security tools, and enlist them into a massive botnet, all while communicating through a rotating domain generation algorithm (DGA) to receive commands.

## Why it matters
At its 2009 peak, Conficker infected an estimated 9–15 million machines — including hospital systems in the UK's NHS and military networks in France and Germany — demonstrating how a single unpatched vulnerability can cascade into a global crisis. Defenders learned hard lessons about patch management urgency and the importance of blocking NetBIOS/SMB traffic (TCP 445) at network boundaries, both of which remain core exam topics today.

## Key facts
- Exploited **MS08-067** (CVE-2008-4369), a critical flaw in Windows Server Service; Microsoft released an emergency out-of-band patch in October 2008
- Used a **Domain Generation Algorithm (DGA)** — generating up to 250 pseudo-random domain names daily — making C2 sinkholing extremely difficult
- Spread via **three vectors**: network shares exploiting MS08-067, removable drives (autorun.inf), and weak/default administrator passwords
- Disabled **Windows Update, Windows Security Center, and antivirus tools** upon infection to maintain persistence
- The **Conficker Working Group** — a coalition of Microsoft, ICANN, and security vendors — coordinated mass domain pre-registration to sinkhole C2 channels, a landmark industry defensive collaboration

## Related concepts
[[MS08-067]] [[Domain Generation Algorithm]] [[Botnet]] [[Worm]] [[SMB Vulnerability]] [[Patch Management]]