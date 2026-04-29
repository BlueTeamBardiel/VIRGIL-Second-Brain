# nftables

## What it is
Think of nftables as the upgraded bouncer at a club who replaced three separate staff members (one checking IDs, one managing the VIP list, one watching the back door) with a single, smarter system. Precisely, nftables is the modern Linux kernel packet filtering framework that succeeded iptables, ip6tables, arptables, and ebtables, providing a unified interface for defining firewall rules across IPv4, IPv6, ARP, and bridge traffic through a single coherent ruleset.

## Why it matters
During incident response on a compromised Linux server, an attacker may flush or modify iptables rules to open persistent backdoor access — nftables' atomic rule replacement makes it harder to leave the firewall in a broken intermediate state during updates, reducing that exposure window. Security teams also use nftables' named sets and verdict maps to build high-performance blocklists that can drop thousands of malicious IPs with minimal rule sprawl, which matters when defending against large-scale scanning campaigns.

## Key facts
- nftables uses **tables → chains → rules** hierarchy; chains have types (filter, nat, route) and hook points (input, forward, output, prerouting, postrouting)
- Unlike iptables, **all rule changes are atomic** — the entire ruleset swaps at once, preventing race conditions during firewall updates
- Rules are written in a **single unified syntax** using the `nft` command, replacing four separate legacy tools
- **Named sets** allow grouping of IPs, ports, or prefixes into reusable objects, dramatically simplifying complex rulesets
- Default policy matters: a chain with no default policy **accepts all traffic** unless explicitly set to drop — a common misconfiguration that exposes services

## Related concepts
[[iptables]] [[Linux Host-Based Firewall]] [[Network Access Control]]