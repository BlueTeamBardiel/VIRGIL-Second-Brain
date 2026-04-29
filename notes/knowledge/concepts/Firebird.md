# Firebird

## What it is
Like a master key that's been secretly duplicated without the locksmith's knowledge, Firebird is a Remote Access Trojan (RAT) that gives attackers covert, persistent control over compromised systems. Specifically, Firebird (also tracked as "Backdoor.Firebird") is a sophisticated RAT associated with the APT group known as SideCopy, primarily targeting South Asian government and military entities. It communicates over encrypted channels to evade detection while enabling full remote command execution on victim machines.

## Why it matters
In documented campaigns against Indian defense and government networks, SideCopy operators deployed Firebird through spear-phishing emails containing malicious LNK files, ultimately establishing persistent footholds that exfiltrated sensitive documents over weeks before detection. Defenders using network behavioral analysis spotted anomalous outbound C2 beacon traffic with consistent polling intervals — a classic RAT signature — which triggered incident response. This illustrates why traffic pattern analysis matters as much as signature-based detection.

## Key facts
- Firebird is attributed to the SideCopy APT group, believed to be a sub-group of Transparent Tribe (APT36), linked to Pakistani state-sponsored interests
- Delivered primarily via spear-phishing with malicious LNK shortcut files or weaponized Office documents exploiting macro execution
- Provides full RAT capabilities: keylogging, screenshot capture, file exfiltration, remote shell access, and plugin loading for modular expansion
- Uses encrypted C2 communication to blend with legitimate HTTPS traffic, making perimeter filtering alone insufficient
- Achieves persistence via Windows Registry run keys and scheduled tasks — standard persistence mechanisms flagged by MITRE ATT&CK T1547 and T1053

## Related concepts
[[Remote Access Trojan (RAT)]] [[Command and Control (C2)]] [[Spear Phishing]] [[APT Groups]] [[Persistence Mechanisms]]