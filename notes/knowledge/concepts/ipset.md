# ipset

## What it is
Think of ipset as a bouncer with a laminated list instead of checking every ID one-by-one — it stores IP addresses, networks, and ports in a hash table so the kernel can match packets against thousands of entries in a single lookup. Precisely, ipset is a companion tool to iptables/nftables on Linux that maintains named sets of network objects (IPs, subnets, MACs, ports) which firewall rules can reference atomically. This makes it dramatically faster and more scalable than writing individual iptables rules for each address.

## Why it matters
During a DDoS mitigation response, a SOC analyst can dynamically add the source IPs of attacking hosts to a named ipset called `blocklist` with a single command (`ipset add blocklist 198.51.100.0/24`), and the existing iptables DROP rule referencing that set instantly enforces the block — no rule reloading required. Without ipset, blocking 50,000 individual IPs would require 50,000 separate iptables rules, causing severe performance degradation as the kernel performs linear rule traversal.

## Key facts
- ipset uses hash-based data structures, enabling **O(1) lookups** regardless of set size, versus iptables' linear O(n) rule matching
- Sets are **typed**: `hash:ip`, `hash:net`, `hash:ip,port`, `bitmap:port` — you must declare the type at creation
- Entries support **timeout values**, automatically expiring after a set period (useful for temporary threat blocks)
- ipset rules **survive iptables flushes** — the set data persists independently of firewall rules until explicitly destroyed
- Commonly used in **threat intelligence automation**: SIEM/SOAR platforms push malicious IP feeds directly into ipset for real-time enforcement

## Related concepts
[[iptables]] [[nftables]] [[firewall rules]] [[DDoS mitigation]] [[network access control]]