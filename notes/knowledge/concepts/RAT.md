# RAT

## What it is
Like a hidden cat door installed by a burglar — one that lets them walk in and out of your house whenever they want, long after you've forgotten they were ever there. A Remote Access Trojan (RAT) is malware that gives an attacker persistent, covert administrative control over a compromised system, typically disguising itself as legitimate software while opening a backdoor channel to a command-and-control (C2) server.

## Why it matters
In the 2013 Target breach, attackers used a RAT to maintain persistent access inside the network after initial compromise, moving laterally until they reached the point-of-sale systems that exfiltrated 40 million credit card numbers. Defenders hunting RATs look for anomalous outbound connections — especially beaconing patterns where the RAT phones home to its C2 server at regular intervals — using network traffic analysis tools like Zeek or Wireshark.

## Key facts
- RATs provide full remote control: keylogging, webcam access, file exfiltration, shell execution, and screenshot capture
- They typically use **reverse shell connections** — the victim machine initiates outbound traffic to the attacker, bypassing inbound firewall rules
- Common delivery vectors include phishing attachments, trojanized software, and drive-by downloads
- **Beaconing** — periodic, regular check-ins to a C2 server — is a primary behavioral indicator of RAT infection detectable via SIEM correlation rules
- Well-known RATs include **DarkComet**, **njRAT**, **Poison Ivy**, and **AsyncRAT**; some are sold as crimeware on dark web forums

## Related concepts
[[Command and Control (C2)]] [[Trojan]] [[Persistence Mechanisms]] [[Lateral Movement]] [[Beaconing]]