# arptables

## What it is
Think of it as a bouncer at the door of a nightclub, but specifically checking ID badges that say "I own this IP address" — only ARP packets get scrutinized here. `arptables` is a Linux kernel-level packet filtering tool that inspects and controls ARP (Address Resolution Protocol) traffic using rule-based chains, similar to how iptables handles IP traffic. It operates at Layer 2 of the OSI model, filtering based on MAC and IP address mappings before they influence the ARP cache.

## Why it matters
ARP spoofing attacks — where an attacker broadcasts forged ARP replies to poison victims' ARP caches — are a foundational technique for man-in-the-middle (MitM) attacks on local networks. A defender can use `arptables` to drop ARP replies from unauthorized MAC addresses or lock down which MAC-to-IP bindings are accepted, directly neutering tools like `arpspoof` or `ettercap`. Without this control, an attacker can silently redirect traffic between a victim and the default gateway, capturing credentials in plaintext.

## Key facts
- `arptables` uses three default chains: **INPUT**, **OUTPUT**, and **FORWARD**, mirroring iptables structure but restricted to ARP traffic only
- Rules can match on source/destination IP, source/destination MAC, and ARP opcode (request vs. reply)
- It operates at **OSI Layer 2**, making it effective where IP-level firewalls have no visibility
- Modern Linux systems are migrating to **nftables**, which unifies iptables, ip6tables, and arptables under a single framework
- `arptables` does **not** persist rules across reboots by default — rules must be saved/restored via scripts or service configurations

## Related concepts
[[ARP Spoofing]] [[iptables]] [[nftables]] [[Man-in-the-Middle Attack]] [[MAC Address Filtering]]
