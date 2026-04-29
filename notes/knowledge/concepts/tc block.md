# tc block

## What it is
Like a bouncer with a blacklist at a club door — if your name's on the list, you don't get past the velvet rope, no matter what. `tc block` is a Linux traffic control (`tc`) feature that uses the kernel's eBPF/XDP or classifier-action framework to drop or redirect packets at the network interface level, before they ever reach the firewall or application stack.

## Why it matters
During a volumetric DDoS attack, a defender can use `tc block` with eBPF programs to drop malicious traffic at wire speed on the NIC ingress path — far earlier and cheaper than letting packets climb the full network stack to iptables. This reduces CPU exhaustion and keeps legitimate traffic flowing even under heavy flood conditions.

## Key facts
- `tc block` operates at the **Traffic Control (qdisc) layer** of the Linux kernel, specifically using the `clsact` qdisc to attach filters to ingress and egress hooks.
- Shared blocks (`block <id>`) allow a **single filter ruleset to be applied across multiple interfaces simultaneously**, reducing configuration duplication.
- It integrates with **eBPF classifiers**, enabling programmable, high-performance packet decisions compiled into the kernel at runtime.
- Unlike iptables/nftables, `tc` filters can act on traffic **before connection tracking (conntrack)** processes it, making it faster for raw drop operations.
- Common actions include `drop`, `pass`, `redirect`, and `mirred` (mirroring to another interface for monitoring/IDS purposes).

## Related concepts
[[eBPF]] [[XDP (eXpress Data Path)]] [[iptables]]