# QSFP

## What it is
Think of QSFP like a power strip for fiber optic signals — instead of running four separate cables, you bundle four lanes of data into one hot-swappable module. QSFP (Quad Small Form-factor Pluggable) is a compact, high-density transceiver standard used in network switches, routers, and data center equipment to carry 40Gbps (QSFP+) or 100Gbps (QSFP28) of optical or electrical traffic over a single interface. It is physically inserted into a port and can be replaced without powering down the device.

## Why it matters
In a data center segmentation scenario, a misconfigured QSFP uplink between core switches can inadvertently collapse VLAN boundaries, allowing an attacker who has compromised one segment to laterally move into a supposedly isolated network. Defenders performing network audits must verify that high-speed inter-switch links using QSFP modules have 802.1Q trunk configurations locked down and that port security policies are enforced, since the raw throughput (40–100Gbps) makes undetected exfiltration devastatingly fast once access is established.

## Key facts
- QSFP+ supports **40Gbps** by aggregating four 10Gbps lanes; QSFP28 supports **100Gbps** via four 25Gbps lanes
- Modules are **hot-swappable**, meaning they can be physically inserted or removed by an attacker with brief physical access without triggering a system reboot
- Used heavily in **spine-leaf data center architectures** as uplink connections between access and core switching layers
- Counterfeit or third-party QSFP modules have been used in supply chain attacks to introduce hardware implants at the physical layer
- Security monitoring of QSFP-linked interfaces requires **NetFlow/IPFIX** at the switch level, since traditional endpoint agents don't see this traffic

## Related concepts
[[Physical Security Controls]] [[Supply Chain Attack]] [[Network Segmentation]] [[Trunk Port]] [[Data Exfiltration]]