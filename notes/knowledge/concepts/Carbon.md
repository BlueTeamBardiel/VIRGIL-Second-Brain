# Carbon

## What it is
Like a security camera that silently records everything a burglar does without triggering the alarm, Carbon is a covert backdoor and espionage framework. Specifically, it is a sophisticated second-stage malware platform attributed to the Russian APT group Turla, designed to establish persistent, stealthy command-and-control infrastructure within compromised networks.

## Why it matters
In documented Turla campaigns targeting European government ministries and embassies, Carbon was deployed after initial access was established, creating a peer-to-peer C2 network that allowed attackers to pivot laterally while hiding communications inside legitimate-looking HTTP traffic. Defenders analyzing these intrusions found Carbon's modular architecture made it exceptionally difficult to fully remediate — removing one component left others dormant and functional.

## Key facts
- Carbon is attributed to Turla (also known as Snake or Uroburos), a Russian state-sponsored APT active since at least 2004
- It operates as a multi-component framework: an installer, a communication module (HTTPS-based C2), a task scheduler, and an orchestrator that manages all components
- Carbon uses encrypted configuration files and named pipes for inter-process communication, enabling lateral movement without noisy network traffic
- It mimics legitimate software names and paths to evade cursory file-system inspection — a living-off-the-land adjacent technique
- Indicators of compromise include suspicious named pipes, encrypted blob files in temp directories, and anomalous HTTPS beaconing to actor-controlled infrastructure

## Related concepts
[[Turla APT]] [[Command and Control (C2)]] [[Backdoor]] [[Lateral Movement]] [[Indicators of Compromise]]