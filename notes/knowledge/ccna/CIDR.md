# CIDR

## What it is

Loadout slots in Call of Duty: you get a fixed budget of "points" to spend, and how you spend them determines what your loadout actually looks like. CIDR (Classless Inter-Domain Routing) works the same way — you have 32 bits to spend on an IPv4 address, and the suffix tells you how many of those bits are locked in as the "network" portion versus left free for individual hosts.

Written as `192.168.1.0/24`, the `/24` means the first 24 bits identify the network, and the remaining 8 bits identify hosts inside it. That `/24` is just shorthand for the subnet mask `255.255.255.0` — same thing, fewer keystrokes.

Before 1993, IP allocation used rigid "classes" (A, B, C) with fixed boundaries at /8, /16, and /24. That's like a character creator that only lets you pick "Warrior, Mage, or Rogue" with no customization — wasteful and inflexible. If you needed 500 hosts, a Class C (254 hosts) was too small and a Class B (65,534 hosts) was absurd overkill. CIDR threw the classes out and let networks be sized at any bit boundary.

## Why it matters

CIDR is the notation you'll see everywhere in security work, not just networking. Firewall rules, ACLs, VPN configs, cloud security groups, scanner inputs — they all speak CIDR. When you tell nmap to scan `10.0.0.0/24`, you're saying "hit these 256 addresses." When you write a firewall rule allowing `172.16.5.0/28`, you're permitting exactly 16 addresses.

It also matters offensively. BGP route hijacking abuses CIDR's "more specific wins" rule: if the legitimate owner advertises `8.8.8.0/24`, an attacker who advertises `8.8.8.0/25` (a smaller, more specific block) can siphon traffic toward themselves. Routers prefer the longer prefix the same way Elden Ring prefers your most specific equipped talisman effect — narrower beats broader.

## Key facts

- **Suffix = network bits.** `/24` means 24 bits locked as network, 8 bits free for hosts. `/16` means 16 locked, 16 free. The bigger the number, the smaller the network.
- **Common sizes:**
  - `/32` — exactly one host. Used for "this single IP" rules, like whitelisting your own laptop.
  - `/24` — 256 total addresses, 254 usable (network address and broadcast are reserved). The classic home/office LAN size.
  - `/16` — 65,536 addresses. A whole campus or a fat cloud VPC.
  - `/8` — 16,777,216 addresses. Entire ISP-sized chunks.
- **Mask equivalence.** `/24` = `255.255.255.0`. `/16` = `255.255.0.0`. Same constraint expressed two ways.
- **Replaced classful routing in 1993.** RFCs 1518 and 1519 are the original spec. The class system is dead; nobody serious uses it for allocation anymore.
- **RFC 1918 private ranges** — the addresses you can use freely behind NAT without anyone owning them:
  - `10.0.0.0/8`
  - `172.16.0.0/12`
  - `192.168.0.0/16`
- **Security tooling speaks CIDR natively.** Shodan filters, nmap target ranges, Nessus scan scopes, AWS security groups, iptables rules — feed them CIDR or feed them nothing. `nmap -sV 10.0.0.0/24` is a one-liner that hits an entire subnet.
- **Firewall rules and ACLs use CIDR to define scope.** "Permit `192.168.1.0/24` to `10.0.0.0/24` on tcp/443" is a complete, unambiguous rule. No CIDR, no rule.
- **BGP hijacking via more-specific advertisement.** Routers always prefer the longest matching prefix. An attacker advertising `/25` beats the legit `/24`, redirecting traffic — the same dirty trick used in real-world incidents against crypto exchanges and DNS providers.

## Related concepts

[[Subnetting]] · [[Subnet Mask]] · [[RFC 1918 Private Addressing]] · [[NAT]] · [[BGP]] · [[BGP Route Hijacking]] · [[ACLs]] · [[Firewall Rules]] · [[nmap]] · [[Shodan]] · [[IPv4 Addressing]] · [[VLSM]]