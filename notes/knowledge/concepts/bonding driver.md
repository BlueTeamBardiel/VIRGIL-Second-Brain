# bonding driver

## What it is
Like a traffic manager merging multiple highway lanes into one smooth expressway, the Linux bonding driver combines multiple physical network interfaces into a single logical interface. It operates at the kernel level, aggregating NICs to provide redundancy, increased throughput, or both simultaneously through configurable bonding modes.

## Why it matters
In a high-availability server environment, an attacker who compromises a single network path cannot sever connectivity if bonding is configured in active-backup mode — the failover to a secondary NIC happens automatically and transparently. Conversely, a misconfigured bonding setup (e.g., both interfaces on the same switch) creates a single point of failure that negates the redundancy entirely, a common finding in network security audits.

## Key facts
- **Seven bonding modes exist**: Mode 0 (round-robin), Mode 1 (active-backup), Mode 4 (802.3ad LACP) are the most exam-relevant; Mode 1 is the go-to for fault tolerance
- **Mode 4 (LACP)** requires switch-side configuration to enable IEEE 802.3ad link aggregation — misconfiguration causes silent traffic drops
- **MAC address behavior**: In active-backup mode, all slaves share the primary interface's MAC; in round-robin, the MAC may rotate, which can confuse ARP tables and trigger IDS alerts
- **Availability triad relevance**: Bonding directly supports the "Availability" pillar of the CIA triad by eliminating single-NIC failure as a downtime vector
- **Monitoring file**: `/proc/net/bonding/bond0` exposes real-time slave status, link speed, and active interface — a key diagnostic artifact during incident response on Linux systems

## Related concepts
[[network interface card (NIC)]] [[high availability]] [[link aggregation (LACP)]] [[CIA triad]] [[network redundancy]]