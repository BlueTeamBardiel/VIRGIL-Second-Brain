# IRC

## What it is
Think of IRC like a massive switchboard of CB radio channels — anyone can tune in, create a channel, or broadcast anonymously with minimal accountability. Precisely, Internet Relay Chat (IRC) is a real-time text-based messaging protocol operating over TCP (typically port 6667 unencrypted, 6697 over TLS) that organizes communication into topic-based channels on federated servers.

## Why it matters
Historically, IRC has been the command-and-control (C2) backbone for botnets — malware infects a host, connects it to a hidden IRC channel, and the attacker issues commands to thousands of zombies simultaneously by simply typing in that channel. Defenders watch for unexpected outbound connections on port 6667 as a botnet indicator of compromise (IoC), and modern threat hunting still references IRC-based C2 as a foundational attack pattern documented in MITRE ATT&CK (T1071.003).

## Key facts
- **Default ports:** 6667 (plaintext), 6697 (SSL/TLS) — both are exam-relevant for firewall rule and traffic analysis questions
- **Botnet C2 mechanism:** Infected hosts join a pre-configured IRC channel; the bot-herder issues commands to all connected bots simultaneously, making it a one-to-many control structure
- **Anonymity risk:** IRC allows pseudonymous connections and minimal authentication, making it attractive for threat actors coordinating attacks or data exfiltration
- **DDoS historical link:** Many early DDoS attacks (e.g., trinoo, TFN) evolved into IRC-controlled botnets in the late 1990s and early 2000s
- **Detection signature:** Repeated beaconing to external IPs on port 6667 with short, regular intervals is a classic network-based IoC for IRC-based malware

## Related concepts
[[Botnet]] [[Command and Control (C2)]] [[Port Numbers]] [[Indicators of Compromise]] [[Network Traffic Analysis]]