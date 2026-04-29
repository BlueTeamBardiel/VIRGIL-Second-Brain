# LACP

## What it is
Think of LACP like a pair of dock workers who continuously flash ID badges at each other to prove they're still both legitimate employees before moving cargo together. Link Aggregation Control Protocol (LACP) is an IEEE 802.3ad standard that allows multiple physical network links to be bundled into a single logical channel, with both ends negotiating and maintaining the bond dynamically through periodic PDU exchanges.

## Why it matters
An attacker with physical access to a switch could attempt to inject a rogue device into an LACP bundle, hoping to intercept or redirect traffic flowing across the aggregated link. If port security and proper LACP authentication aren't enforced, the rogue switch could negotiate itself into the bundle and perform a man-in-the-middle attack on high-throughput server traffic. This makes LACP configuration a physical security and network hardening concern, not just a performance feature.

## Key facts
- LACP operates at **Layer 2** and uses **LACPDU (Link Aggregation Control Protocol Data Units)** sent every 1 second (fast mode) or 30 seconds (slow mode) to verify link health
- Defined in **IEEE 802.3ad**, later incorporated into **IEEE 802.1AX**
- Ports can be in **Active** (initiates negotiation) or **Passive** (waits for negotiation) mode; two passive ports will never form a bond
- LACP increases **bandwidth and redundancy** — if one physical link fails, traffic automatically shifts to remaining links without session interruption
- Misconfigured LACP (e.g., one side set static, the other dynamic) can cause **spanning tree loops** or silent traffic drops — a common misconfiguration reviewed during network audits

## Related concepts
[[Port Security]] [[Spanning Tree Protocol]] [[802.1X]] [[Network Segmentation]]