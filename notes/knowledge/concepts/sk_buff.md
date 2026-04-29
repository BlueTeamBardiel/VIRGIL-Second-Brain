# sk_buff

## What it is
Think of it as the cardboard box a network packet travels in through the Linux kernel — the box holds the actual contents, but also has labels on the outside tracking where it's been and where it's going. Precisely, `sk_buff` (socket buffer) is the central data structure in the Linux kernel's networking stack used to represent a network packet as it moves between layers. Every packet received, processed, or transmitted on a Linux system lives inside an `sk_buff` during its kernel-space lifetime.

## Why it matters
Vulnerabilities in `sk_buff` handling have led to critical kernel exploits — most notably CVE-2016-10229 (UDP double-fetch) and the "SkullJail" class of bugs where improper bounds checking on `sk_buff` metadata allowed heap overflow attacks giving attackers root privileges. Because `sk_buff` sits at the intersection of every network operation, a single memory corruption bug here can compromise an entire system regardless of application-layer defenses.

## Key facts
- `sk_buff` lives in kernel memory (ring 0), making vulnerabilities here far more dangerous than userspace bugs — successful exploitation typically yields full privilege escalation
- The structure tracks packet metadata: source/destination, protocol headers, transport layer info, and pointers to the actual payload data
- `skb_clone()` creates a reference-counted copy; mishandling reference counts has historically caused use-after-free vulnerabilities
- Netfilter hooks (iptables/nftables) operate directly on `sk_buff` structures — malformed packets can be crafted to trigger edge-case processing bugs in hook handlers
- Kernel mitigations like SMEP, SMAP, and KASLR specifically exist to raise the exploitation cost when `sk_buff` or similar structures are corrupted

## Related concepts
[[Kernel Exploitation]] [[Buffer Overflow]] [[Use-After-Free]] [[Netfilter]] [[Privilege Escalation]]