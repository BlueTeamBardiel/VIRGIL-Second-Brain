# Spamhaus

## What it is
Think of Spamhaus as the "most wanted" list posted at the post office — mail carriers check it before delivering, and if your address appears on it, your letters get thrown out. Spamhaus is a nonprofit organization that maintains real-time DNS-based blocklists (DNSBLs) tracking IP addresses, domains, and networks known to originate spam, malware, and other malicious traffic. Mail servers and network appliances query these blocklists to reject or filter traffic from flagged sources before it ever reaches end users.

## Why it matters
In March 2013, Spamhaus was targeted in one of the largest DDoS attacks ever recorded at the time — peaking at ~300 Gbps — after it listed the hosting provider Cyberbunker for spam activity. Attackers weaponized DNS amplification, exploiting open resolvers to flood Spamhaus infrastructure, demonstrating that blocklist providers themselves are high-value targets whose disruption can affect global email filtering.

## Key facts
- Spamhaus maintains several distinct lists: **SBL** (Spam Block List), **XBL** (Exploits Block List), **PBL** (Policy Block List), and **DBL** (Domain Block List)
- Organizations query Spamhaus via **DNS lookups** — if a queried IP returns a specific response (e.g., 127.0.0.2), the address is listed
- The 2013 Spamhaus DDoS attack used **DNS amplification**, achieving ~300× traffic multiplication using open recursive resolvers
- Being listed on the SBL can cause legitimate organizations to lose nearly all email deliverability — making delisting a critical incident response task
- Spamhaus data feeds into commercial security products including firewalls, email gateways, and SIEM threat intelligence integrations

## Related concepts
[[DNS Blocklist (DNSBL)]] [[DDoS Amplification Attack]] [[Email Security]] [[Threat Intelligence Feeds]] [[DNS Amplification]]