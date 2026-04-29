# Bandook

## What it is
Like a locksmith who breaks into your house, installs a hidden back door, and hands a stranger the key — Bandook is a commercial Remote Access Trojan (RAT) that grants attackers persistent, stealthy control over infected Windows systems. First observed around 2007, it has been sold as crimeware and deployed in targeted espionage campaigns by multiple threat actors across decades.

## Why it matters
In 2020, Check Point Research uncovered a Bandook campaign targeting over 100 organizations across 10 sectors — including government, finance, and healthcare — distributed via weaponized Word documents that dropped the payload through a PowerShell loader. Defenders responding to this incident had to hunt for signed Bandook executables (a rare evasion trick) hiding inside legitimate certificate chains to bypass endpoint defenses.

## Key facts
- **Delivery mechanism:** Typically spread via spear-phishing emails with malicious Word/PDF attachments that exploit macros or embedded scripts to download the payload.
- **Code signing abuse:** Bandook samples have been found signed with legitimate (often stolen or fraudulently obtained) certificates to evade signature-based AV detection.
- **Capabilities:** Full RAT feature set — keylogging, screenshot capture, file exfiltration, remote shell, webcam/microphone access, and process injection.
- **Persistence:** Achieves persistence via Windows Registry Run keys and can inject into legitimate processes (e.g., `iexplore.exe`) to masquerade as benign activity.
- **Threat actor use:** Linked to multiple financially motivated and nation-state-adjacent groups, including the "Dark Caracal" APT and actors targeting Middle Eastern and South American governments.

## Related concepts
[[Remote Access Trojan (RAT)]] [[Spear Phishing]] [[Code Signing Abuse]] [[Process Injection]] [[Persistence Mechanisms]]