# network reconnaissance

## What it is
Like a burglar walking a neighborhood to note which houses have dogs, alarm stickers, and weak locks before ever touching a doorknob — network reconnaissance is the systematic process of gathering information about a target network before launching an attack. It encompasses both passive techniques (observing without touching) and active techniques (probing systems directly) to map topology, identify live hosts, open ports, running services, and OS fingerprints.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries spent months in quiet reconnaissance — mapping internal networks, identifying high-value targets, and understanding trust relationships — before executing their payload. Defenders who monitor for reconnaissance signatures (unusual ICMP sweeps, sequential port scans, abnormal DNS queries) can detect intrusions weeks earlier than those who only watch for exploitation events.

## Key facts
- **Passive reconnaissance** uses public sources (WHOIS, DNS records, Shodan, LinkedIn) and generates no direct traffic to the target — legally safest, hardest to detect
- **Active reconnaissance** includes tools like Nmap, which sends crafted packets to elicit responses; detectable via IDS signatures and firewall logs
- **Footprinting** (external info gathering) precedes **scanning** (direct enumeration) in the cyber kill chain's reconnaissance phase
- **Banner grabbing** — reading service responses from ports 21, 22, 80, etc. — reveals exact software versions, enabling CVE matching
- ICMP ping sweeps and TCP SYN scans (half-open scans) are the two most common active recon signatures flagged in Security+ exam scenarios

## Related concepts
[[port scanning]] [[OSINT]] [[cyber kill chain]] [[enumeration]] [[network mapping]]