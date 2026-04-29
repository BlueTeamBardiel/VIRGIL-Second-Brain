# Connection Tracking

## What it is
Like a maître d' who remembers every guest's table, order, and how long they've been seated — connection tracking is the firewall's memory of every active network conversation. It records the state of each TCP/UDP/ICMP flow (source IP, destination IP, ports, protocol state) so the firewall can make intelligent decisions about return traffic without re-evaluating every packet from scratch.

## Why it matters
During a SYN flood attack, connection tracking tables become the target: an attacker sends thousands of half-open TCP connections, exhausting the stateful firewall's memory and causing it to drop legitimate sessions. Defenders monitor conntrack table utilization and tune SYN cookie settings specifically because of this finite-resource vulnerability.

## Key facts
- Connection tracking is the mechanism that makes **stateful inspection** possible — without it, firewalls would be forced to use stateless packet filtering rules alone
- The Linux kernel tracks connections in `/proc/net/nf_conntrack`; each entry has a state: `NEW`, `ESTABLISHED`, `RELATED`, or `INVALID`
- `RELATED` state enables legitimate secondary connections like FTP data channels (port 20) to pass without explicit rules, but also creates an attack surface if misconfigured
- Default conntrack table limits (e.g., `nf_conntrack_max`) are a common denial-of-service chokepoint in high-traffic environments
- UDP and ICMP are **stateless protocols** but connection tracking still pseudo-tracks them using timeouts and tuple matching, not handshake state

## Related concepts
[[Stateful Inspection]] [[SYN Flood Attack]] [[Network Address Translation]] [[Firewall Rule Processing]] [[TCP Three-Way Handshake]]