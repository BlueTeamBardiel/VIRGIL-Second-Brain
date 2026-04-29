# Command and Control

## What it is
Like a puppet master pulling strings through a hidden backstage channel, C2 is the communication infrastructure attackers use to remotely issue commands to compromised systems and receive stolen data. After malware infects a host, it "phones home" to a C2 server, establishing a persistent channel the attacker controls. This infrastructure is the nervous system of most advanced attacks.

## Why it matters
During the 2020 SolarWinds attack, threat actors embedded a C2 beacon inside the SUNBURST backdoor that mimicked legitimate Orion software traffic — blending into normal business communications for months before detection. Defenders monitoring for anomalous outbound connections to rare or newly registered domains could have flagged this earlier. Identifying and severing C2 channels is a primary goal during incident response, because cutting that link renders the malware largely blind and mute.

## Key facts
- **Common C2 protocols**: HTTP/HTTPS, DNS tunneling, and IRC — attackers prefer protocols that blend with legitimate traffic and pass through firewalls
- **Beaconing** is the periodic check-in behavior malware uses to contact its C2 server; irregular "jitter" intervals are added to evade detection based on timing patterns
- **Domain Generation Algorithms (DGAs)** automatically produce hundreds of potential C2 domains, making blocklists ineffective without algorithmic detection
- **Fast flux** is a DNS evasion technique where C2 IP addresses rotate rapidly, complicating IP-based blocking
- On the MITRE ATT&CK framework, C2 is Tactic **TA0011**, containing techniques like Ingress Tool Transfer and Protocol Tunneling

## Related concepts
[[Malware]] [[DNS Tunneling]] [[Indicators of Compromise]] [[Lateral Movement]] [[MITRE ATT&CK]]