# cls_flow

## What it is
Like a traffic cop standing at an intersection who decides which cars can proceed based on their license plates, `cls_flow` is a Linux kernel traffic classifier that filters and controls network packets based on flow metadata. Specifically, it is a `tc` (traffic control) classifier that matches packets using a flow dissector, extracting attributes like source/destination IP, port, and protocol to make forwarding or dropping decisions.

## Why it matters
During a DDoS mitigation scenario, a network engineer can deploy `cls_flow` as part of an XDP/tc pipeline to identify and rate-limit traffic flows matching attacker signatures before packets reach the application layer. This allows granular, per-flow policing at kernel speed, reducing the attack surface without requiring expensive dedicated appliances.

## Key facts
- `cls_flow` is part of the Linux `tc` subsystem and operates at the kernel's traffic control layer (Layer 3/4), not in userspace
- It extracts flow keys using the kernel's **flow dissector**, which parses packet headers to identify unique flows by tuples (src IP, dst IP, protocol, ports)
- Can be chained with **qdiscs** (queuing disciplines) like `fq_codel` or `htb` to enforce bandwidth policies per flow
- A misconfigured `cls_flow` rule can create a **traffic blackhole**, silently dropping legitimate flows — a common misconfiguration pitfall in hardened Linux routing environments
- Used in container networking (e.g., Kubernetes CNI plugins) to enforce network policy at the kernel level, making it relevant to cloud-native security architectures

## Related concepts
[[Traffic Control (tc)]] [[XDP (eXpress Data Path)]] [[Network Policy Enforcement]] [[eBPF]] [[DDoS Mitigation]]