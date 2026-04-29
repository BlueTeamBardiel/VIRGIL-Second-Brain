# Mustang Panda

## What it is
Think of a spy who disguises a bomb inside a legitimate-looking embassy briefcase — Mustang Panda operates the same way, hiding malware inside decoy documents that look like real government files. It is a Chinese state-sponsored Advanced Persistent Threat (APT) group (also tracked as TA416 and RedDelta) known for targeting governments, NGOs, and religious organizations through spear-phishing campaigns that deliver the PlugX remote access trojan.

## Why it matters
During the 2020 U.S. election cycle, Mustang Panda targeted the Vatican and Catholic Church organizations, using COVID-themed lure documents to deliver PlugX payloads and establish long-term espionage footholds. Defenders who monitor for suspicious `.lnk` shortcut files inside ZIP archives and unusual `rundll32.exe` executions can catch this group's hallmark delivery chain before persistence is established.

## Key facts
- **Primary malware**: PlugX (also called Korplug) — a modular RAT enabling keylogging, file exfiltration, and shell access
- **DLL sideloading**: Mustang Panda frequently abuses legitimate signed executables (e.g., antivirus binaries) to sideload malicious DLLs, evading signature-based detection
- **Delivery chain**: Spear-phishing email → ZIP attachment → LNK shortcut → legitimate EXE + malicious DLL + encrypted payload (all three files required)
- **Targeting profile**: Southeast Asian governments, Tibetan groups, Myanmar election bodies, European diplomatic entities — aligns with Chinese geopolitical interests
- **Attribution**: Attributed to China's Ministry of State Security (MSS); overlaps with APT41 TTPs but distinct operational focus on espionage over financial crime

## Related concepts
[[PlugX RAT]] [[DLL Sideloading]] [[Spear Phishing]] [[APT Groups]] [[TA416]]