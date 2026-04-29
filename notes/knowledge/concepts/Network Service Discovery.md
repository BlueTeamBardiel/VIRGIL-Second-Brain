# Network Service Discovery

## What it is
Like a burglar walking down a street, jiggling every door handle to see which ones open and what's behind them — network service discovery is the process of systematically probing a network to identify active hosts, open ports, and the services running on those ports. Attackers and defenders both use it to build an accurate picture of what's exposed on a network.

## Why it matters
During the SolarWinds supply chain attack, adversaries performed careful, low-and-slow service discovery to map internal networks after initial compromise — identifying high-value targets like Active Directory and backup servers without triggering rate-based alerts. Defenders who perform regular authorized discovery scans first can baseline their environment and immediately spot unauthorized or shadow services before attackers find them.

## Key facts
- **Nmap** is the gold-standard tool; a full SYN scan with service versioning uses the flag `nmap -sS -sV <target>` and requires root/admin privileges
- **Port states** reported by scanners are: open, closed, and filtered — "filtered" typically indicates a firewall is dropping packets silently
- MITRE ATT&CK maps this behavior under **T1046 (Network Service Scanning)**, classifying it as a Discovery tactic used post-compromise
- **Banner grabbing** is a sub-technique where the scanner reads the service's self-reported version string (e.g., `Apache/2.4.49`), directly enabling vulnerability matching
- Passive discovery (listening to traffic with tools like **Wireshark or Zeek**) can map services without sending a single probe packet, making it undetectable to the target

## Related concepts
[[Port Scanning]] [[Banner Grabbing]] [[Enumeration]] [[Nmap]] [[MITRE ATT&CK Framework]]