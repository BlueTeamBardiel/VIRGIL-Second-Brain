# Bot

## What it is
Like a puppet on strings controlled by a puppeteer, a bot is an infected machine that silently obeys commands from a remote attacker. Precisely, a bot (short for *robot*) is a compromised host running malware that connects to a command-and-control (C2) infrastructure, allowing an attacker to automate malicious tasks at scale.

## Why it matters
During the 2016 Mirai botnet attack, hundreds of thousands of IoT devices (routers, cameras, DVRs) were infected and directed to flood Dyn's DNS servers with traffic, taking down Twitter, Reddit, and Netflix. The attack demonstrated that bots don't require powerful hardware — sheer volume of compromised nodes is the weapon. Defenders counter this by monitoring for anomalous outbound traffic patterns and blocking known C2 IP ranges at the perimeter.

## Key facts
- Bots communicate with C2 servers via IRC, HTTP/HTTPS, or peer-to-peer protocols to evade detection and maintain resilience
- A collection of bots under unified control is called a **botnet**; operators may rent botnet access to other criminals (Crime-as-a-Service)
- Common uses: DDoS attacks, credential stuffing, spam campaigns, cryptocurrency mining, and click fraud
- Bots often use **beaconing** — periodic check-ins to the C2 server — which appears as regular, low-volume outbound traffic that SIEM tools can detect through baseline deviation analysis
- The **Necurs botnet** at its peak controlled over 9 million infected hosts, making it one of the largest spam and malware distribution platforms ever documented

## Related concepts
[[Botnet]] [[Command and Control (C2)]] [[DDoS Attack]] [[Malware]] [[Beaconing]]