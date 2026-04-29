# NFPROTO_ARP

## What it is
Like a bouncer stationed specifically at the velvet rope for ARP guests rather than TCP/IP partygoers, NFPROTO_ARP is a protocol family identifier in the Linux Netfilter framework that tells the kernel to apply firewall hooks exclusively to ARP (Address Resolution Protocol) traffic. It is a numeric constant (value `3`) passed to `nf_register_net_hook()` or `arptables` to attach inspection logic at the ARP processing layer, below the IP stack entirely.

## Why it matters
ARP spoofing attacks — where an attacker floods a LAN with forged ARP replies to poison victims' caches and redirect traffic through an attacker-controlled machine — operate entirely outside IP-layer firewalls. A defense tool using `NFPROTO_ARP` (via `arptables`) can inspect and drop malicious ARP replies before they corrupt the cache, something `iptables` simply cannot do because it only sees IP packets.

## Key facts
- `NFPROTO_ARP` has the integer value **3** in the Linux kernel's `netfilter.h` header, distinct from `NFPROTO_IPV4` (2) and `NFPROTO_IPV6` (10)
- It is the protocol family used by **`arptables`**, the ARP-specific packet filtering tool analogous to `iptables` for IPv4
- Hooks registered under `NFPROTO_ARP` fire **before** the kernel updates the ARP cache, making them effective for preemptive spoofing defense
- Dynamic ARP Inspection (DAI) in enterprise switches performs a similar function at the hardware level; `NFPROTO_ARP` is its Linux software equivalent
- Tools leveraging this hook can enforce **ARP whitelisting** — only allowing known MAC-to-IP bindings — a key defense against man-in-the-middle attacks on Layer 2

## Related concepts
[[ARP Spoofing]] [[Netfilter Framework]] [[Dynamic ARP Inspection]] [[arptables]] [[Man-in-the-Middle Attack]]