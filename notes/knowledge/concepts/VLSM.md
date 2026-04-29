# VLSM

## What it is
Like a landlord subdividing an apartment building into units of different sizes — studios, one-bedrooms, and penthouses — rather than making every unit identical, VLSM (Variable Length Subnet Masking) lets network engineers carve IP address space into subnets of varying sizes. Precisely: VLSM allows a single classful IP block to be divided into multiple subnets with different subnet masks, allocating only as many addresses as each network segment actually needs.

## Why it matters
In network segmentation for defense-in-depth, VLSM enables security architects to isolate sensitive zones (e.g., a /30 for a point-to-point WAN link with only 2 hosts) from larger user VLANs (/24) without wasting addresses. An attacker performing reconnaissance via subnet scanning has a smaller attack surface to sweep when DMZ or server segments are tightly scoped with VLSM rather than over-allocated with wasteful flat /24s. Proper segmentation using VLSM also limits lateral movement — a compromised host in a /28 segment only has 14 potential neighbors to pivot to.

## Key facts
- VLSM requires a **classless routing protocol** (OSPF, EIGRP, BGP, RIPv2) — classful protocols like RIPv1 cannot carry subnet mask information
- A /30 subnet yields exactly **2 usable hosts** — the standard choice for router-to-router point-to-point links
- VLSM conserves IPv4 address space by right-sizing subnets, reducing the chance of IP conflicts and unauthorized host placement
- Subnets must **not overlap** — a common misconfiguration that causes routing failures and potential traffic misdirection exploitable by an attacker
- Used alongside **network segmentation** to enforce security zones: IoT, DMZ, management, and user traffic on separate, appropriately-sized subnets

## Related concepts
[[Network Segmentation]] [[Subnetting]] [[CIDR]] [[DMZ]] [[Defense in Depth]]