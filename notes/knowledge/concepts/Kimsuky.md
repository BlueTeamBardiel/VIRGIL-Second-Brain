# Kimsuky

## What it is
Like a scholar who breaks into a university library not to vandalize it, but to quietly photocopy classified research and leave without a trace, Kimsuky is a North Korean state-sponsored APT group focused almost exclusively on intelligence gathering through targeted spear-phishing and social engineering. Active since at least 2012, it operates under the Reconnaissance General Bureau and prioritizes stealing geopolitical, military, and nuclear policy intelligence from South Korean, U.S., and European targets.

## Why it matters
In 2023, the U.S. and South Korean governments issued a joint advisory warning that Kimsuky was impersonating journalists, academics, and think-tank researchers to build trust with targets before delivering malicious documents. A policy analyst receiving a seemingly legitimate email about Korean peninsula security could unknowingly execute a macro-laden Word document, granting Kimsuky persistent access to classified briefings and internal communications.

## Key facts
- **Primary TTPs**: Spear-phishing with weaponized HWP (Hangul Word Processor) files — a Korea-specific file format often overlooked by Western security tools
- **Custom malware toolset** includes BabyShark, AppleSeed, and Gold Dragon — lightweight RATs designed for credential harvesting and persistent backdoor access
- **Living-off-the-land**: Frequently abuses legitimate tools like PowerShell, mshta.exe, and regsvr32 to evade detection
- **Reconnaissance-first doctrine**: Unlike destructive groups (e.g., Lazarus), Kimsuky's mission is collection, not sabotage — making detection harder due to low operational noise
- **MITRE ATT&CK**: Mapped to tactics including Initial Access (T1566), Credential Access (T1555), and Collection (T1114 — email collection)

## Related concepts
[[Spear Phishing]] [[Advanced Persistent Threat]] [[Living Off the Land]] [[North Korea Threat Actors]] [[MITRE ATT&CK Framework]]