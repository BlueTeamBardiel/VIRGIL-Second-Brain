# InvisibleFerret

## What it is
Like a spy who slips into your house, memorizes everything, and radios it home — all while pretending to be a maintenance worker — InvisibleFerret is a Python-based backdoor malware that masquerades as legitimate software to exfiltrate data and maintain persistent remote access. It is a lightweight, multi-stage infostealer and remote access tool (RAT) attributed to North Korean threat actors (specifically the Lazarus Group / DPRK-linked operators) and delivered via fake job interview lures.

## Why it matters
In 2024, DPRK-linked attackers used InvisibleFerret as the second-stage payload in "Contagious Interview" campaigns, where developers were tricked into running malicious npm packages during fake technical job interviews. Once executed, InvisibleFerret harvested browser credentials, cryptocurrency wallet data, and SSH keys — directly funding North Korea's weapons programs through crypto theft.

## Key facts
- **Delivery chain**: Typically dropped by BeaverTail (a JavaScript-based first-stage malware), making InvisibleFerret the second-stage persistent implant
- **Written in Python**, making it cross-platform — confirmed samples targeting macOS, Windows, and Linux environments
- **Capabilities include**: keylogging, clipboard monitoring, browser credential theft (Chrome, Brave, Opera), and full remote shell access
- **Exfiltration method**: Uses attacker-controlled servers over HTTP/HTTPS, with harvested data often encoded to evade DLP tools
- **Attribution**: Linked to Lazarus Group's financially motivated subcluster; part of a broader pattern of IT worker infiltration and supply chain targeting

## Related concepts
[[BeaverTail]] [[Lazarus Group]] [[Supply Chain Attack]] [[Remote Access Trojan (RAT)]] [[Infostealer Malware]]