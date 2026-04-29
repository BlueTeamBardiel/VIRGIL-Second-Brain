# tc ingress block

## What it is
Think of it like a bouncer stationed at the *entrance* of a nightclub who can reject guests before they ever step inside — tc ingress block is a Linux Traffic Control (tc) feature that attaches a filter/action block at the ingress hook of a network interface, allowing packets to be inspected, modified, or dropped *before* they reach the kernel's networking stack. It operates using the `clsact` qdisc and BPF/eBPF programs for high-performance, low-latency packet filtering.

## Why it matters
Attackers who compromise a host may attempt to exfiltrate data or receive C2 beacons on non-standard ports. A defender can attach an eBPF program to the ingress block of an interface to silently drop all outbound C2 traffic matching known signatures at wire speed — bypassing iptables entirely and making the filter invisible to standard firewall enumeration tools. This is increasingly used in container security (Cilium) and kernel-bypass honeypot architectures.

## Key facts
- `tc ingress block` uses the `clsact` (classless action) qdisc, which must be added before any filters: `tc qdisc add dev eth0 clsact`
- Operates at the **TC ingress hook**, which fires *before* `netfilter/iptables` — meaning packets can be dropped before any firewall rule evaluates them
- eBPF programs attached here return `TC_ACT_SHOT` (drop) or `TC_ACT_OK` (pass), making them deterministic and auditable
- Unlike XDP (which is even earlier in the pipeline), tc ingress can see *all* packet metadata including skb fields, enabling richer decision logic
- Shared ingress blocks (`block <id>`) allow one eBPF program to police traffic across *multiple* interfaces simultaneously — critical for micro-segmentation in containerized environments

## Related concepts
[[eBPF]] [[XDP (eXpress Data Path)]] [[Network Packet Filtering]] [[iptables]] [[Container Network Security]]