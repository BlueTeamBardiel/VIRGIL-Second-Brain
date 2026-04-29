# Botnets

## What it is
Think of a botnet like a puppeteer controlling hundreds of marionettes simultaneously — each puppet (infected host) moves on command while the audience (user) notices nothing. Precisely, a botnet is a network of internet-connected devices compromised by malware and controlled by a threat actor (the "bot herder") through a Command and Control (C2) infrastructure. Each infected device is called a "bot" or "zombie."

## Why it matters
In 2016, the Mirai botnet compromised over 600,000 IoT devices (cameras, routers) and launched a 1.2 Tbps DDoS attack against Dyn DNS, taking down Twitter, Netflix, and Reddit for hours. Defenders responding to botnets must identify C2 traffic patterns using DNS sinkholes and block known malicious IPs — because killing the bot herder's command channel neuters the entire army even if individual bots remain infected.

## Key facts
- **C2 communication models**: Centralized (IRC/HTTP — easy to take down) vs. Peer-to-Peer (decentralized — much harder to disrupt)
- **Common uses**: DDoS attacks, spam campaigns, credential stuffing, cryptomining, and ransomware distribution
- **Infection vector**: Drive-by downloads, phishing, unpatched vulnerabilities, and weak IoT credentials are primary entry points
- **Detection indicators**: Unusual outbound traffic, beaconing behavior (regular check-in intervals to C2), and unexpected DNS queries are key IOCs
- **Takedown method**: Law enforcement and vendors use **DNS sinkholes** and **ISP cooperation** to redirect C2 traffic and neutralize bot herders; the Emotet botnet was dismantled this way in January 2021

## Related concepts
[[Command and Control (C2)]] [[DDoS Attacks]] [[Malware]] [[DNS Sinkhole]] [[Zombie/Bot]]