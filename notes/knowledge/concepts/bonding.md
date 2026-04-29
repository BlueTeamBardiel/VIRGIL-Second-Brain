# bonding

## What it is
Like a highway with multiple lanes merging into one road — if a lane closes, traffic keeps flowing without interruption. Network bonding (also called NIC teaming or link aggregation) combines two or more physical network interfaces into a single logical interface, providing redundancy, increased throughput, or both depending on the bonding mode configured.

## Why it matters
During a denial-of-service attack or hardware failure, a single NIC going offline can sever a server's network connection entirely. With bonding configured in active-backup mode, the secondary interface automatically takes over within milliseconds — meaning a critical authentication server or firewall remains reachable even as one physical link is attacked or fails. Attackers targeting physical infrastructure or flooding one interface cannot fully isolate the system.

## Key facts
- **Active-Backup (Mode 1):** Only one NIC is active at a time; the backup activates on failure — pure redundancy, no throughput gain.
- **802.3ad / LACP (Mode 4):** The most common enterprise mode; uses Link Aggregation Control Protocol to dynamically negotiate bonded links, requiring switch support on both ends.
- **Round-Robin (Mode 0):** Distributes packets sequentially across all interfaces — increases throughput but can cause out-of-order packet delivery.
- **Bonding increases availability** (part of the CIA triad's "A") and is a key high-availability control alongside clustering and failover configurations.
- **Misconfigured bonding can be a vulnerability:** If both interfaces share the same switch, you have a single point of failure at the switch level — defeating the redundancy purpose.

## Related concepts
[[high availability]] [[network redundancy]] [[fault tolerance]] [[CIA triad]] [[load balancing]]