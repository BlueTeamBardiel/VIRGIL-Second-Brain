# FLSM

## What it is
Like cutting a pizza into equal slices regardless of how hungry each person is — some get too much, others not enough. Fixed Length Subnet Masking (FLSM) is a subnetting strategy where every subnet within a network is assigned the same subnet mask, resulting in equal-sized address blocks regardless of actual host requirements.

## Why it matters
In network segmentation for defense-in-depth, an organization using FLSM might allocate a /24 to both a 3-device IoT sensor network and a 200-device office floor. That wasted address space in the IoT subnet becomes a larger attack surface — more unused IPs that an attacker can probe or spoof without triggering alerts tied to legitimate hosts. Proper segmentation planning (often using VLSM instead) reduces this exposure.

## Key facts
- **Equal masks everywhere**: Every subnet uses the same prefix length (e.g., all /26), producing identical host counts per subnet
- **Address waste is the core problem**: A /24 subnet assigned to a 5-host network wastes 249 usable addresses, inflating broadcast domains unnecessarily
- **Classful networking legacy**: FLSM reflects older classful IP design (Class A/B/C); modern networks use VLSM for efficiency
- **Relevant to network security design**: Security+ expects you to understand subnetting as a segmentation control — FLSM's inefficiency can undermine isolation goals
- **Simple to calculate**: With FLSM, you divide the address space into equal blocks using powers of 2 (e.g., 256 addresses ÷ 4 subnets = 64 addresses each, /26 mask)

## Related concepts
[[VLSM]] [[Network Segmentation]] [[Subnetting]] [[CIDR]] [[Broadcast Domain]]