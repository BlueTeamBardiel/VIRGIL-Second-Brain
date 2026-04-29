# Remote Access Trojan

## What it is
Imagine a locksmith who secretly duplicates your house key, hands it to a criminal, and then helpfully pretends nothing happened — that's a RAT. A Remote Access Trojan is malware that disguises itself as legitimate software while establishing a persistent, covert backdoor that gives an attacker full remote control over the victim's system, including file access, webcam, keylogging, and command execution.

## Why it matters
In the 2013 Adobe breach investigation, analysts discovered attackers had used a RAT to maintain persistent access for months, exfiltrating source code and encrypted customer credentials without triggering standard perimeter alerts. This illustrates why RATs are dangerous: they live inside the trust boundary, mimicking normal user behavior while the attacker operates at their leisure.

## Key facts
- RATs achieve persistence through registry run keys, scheduled tasks, or DLL hijacking, ensuring they survive reboots without re-infection
- Command-and-Control (C2) traffic is often disguised over common ports (80, 443) using HTTP/HTTPS to blend with legitimate web traffic and evade firewall rules
- Common delivery vectors include phishing emails, Trojanized software downloads, and malicious macros in Office documents
- Detection relies on behavioral analysis (unusual outbound connections, unexpected process spawning) rather than signature-based AV, since RATs are frequently custom-built or obfuscated
- Notable RAT families include DarkComet, njRAT, and Poison Ivy — each commonly tested as examples of commodity crimeware and APT tooling

## Related concepts
[[Command and Control (C2)]] [[Persistence Mechanisms]] [[Indicators of Compromise]] [[Phishing]] [[Lateral Movement]]