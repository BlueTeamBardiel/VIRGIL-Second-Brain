# tc ingress

## What it is
Like a bouncer checking IDs *before* people walk through the door (not after they're already inside), `tc ingress` is a Linux Traffic Control hook that intercepts and processes packets *as they arrive* on a network interface, before the kernel's routing and netfilter stack ever sees them. It is the ingress queueing discipline (`qdisc`) attachment point used by tools like `tc` and eBPF programs to filter, redirect, or drop inbound traffic at wire speed.

## Why it matters
Defenders use `tc ingress` with eBPF/XDP-style filters to implement high-performance DDoS mitigation — dropping spoofed or volumetric attack packets before they consume CPU cycles in the full kernel network stack. A red teamer who gains root on a Linux host can attach a malicious `tc` filter to silently redirect or clone specific inbound traffic (e.g., credentials in HTTP) to an attacker-controlled socket without disrupting the original connection, making it a stealthy, rootkit-grade interception primitive.

## Key facts
- `tc ingress` operates at the **Traffic Control layer**, *before* `iptables`/`nftables` INPUT rules — meaning firewall rules do not catch tc-dropped packets.
- Attached using: `tc qdisc add dev eth0 ingress` followed by `tc filter add dev eth0 ingress ...`
- eBPF programs attached via `tc ingress` can return `TC_ACT_SHOT` (drop), `TC_ACT_OK` (pass), or `TC_ACT_REDIRECT` (steer to another interface/socket).
- Unlike XDP (which runs at the driver layer), `tc ingress` has access to a fully parsed `__sk_buff`, enabling richer packet inspection.
- Persistence of malicious `tc` filters survives reboots only if re-added via init scripts — detection involves running `tc qdisc show` and `tc filter show` on all interfaces.

## Related concepts
[[eBPF]] [[XDP (eXpress Data Path)]] [[iptables]] [[Linux Traffic Control (tc)]] [[packet filtering]]