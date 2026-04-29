# xdp

## What it is
Think of it like a bouncer standing *at the venue door* who can reject troublemakers before they even enter the building — rather than security guards inside who deal with them after they're already in. XDP (eXpress Data Path) is a Linux kernel framework that hooks directly into network drivers, allowing programs to inspect and act on packets at the earliest possible point — before the kernel's full network stack processes them. It runs eBPF programs at wire speed with near-zero overhead.

## Why it matters
During a volumetric DDoS attack sending millions of packets per second, traditional iptables rules struggle because each packet climbs through multiple kernel layers before being dropped. XDP can drop malicious packets *at the NIC driver level* — Cloudflare demonstrated dropping 17 million packets per second on a single server using XDP, effectively neutralizing floods that would cripple conventional defenses.

## Key facts
- XDP operates in three modes: **native** (fastest, driver-level), **offloaded** (runs on SmartNIC hardware itself), and **generic** (software fallback, slower)
- Actions available to XDP programs: `XDP_DROP`, `XDP_PASS`, `XDP_TX` (bounce back), `XDP_REDIRECT`, and `XDP_ABORTED`
- XDP programs are written in C and compiled to **eBPF bytecode**, verified by the kernel verifier before loading — preventing runaway or malicious kernel code
- Because it bypasses the full network stack, XDP cannot natively access higher-layer context (e.g., established TCP sessions) without additional state tracking
- XDP is increasingly used for **microsegmentation** and **inline packet scrubbing** in cloud-native environments alongside tools like Cilium

## Related concepts
[[eBPF]] [[DDoS Mitigation]] [[Packet Filtering]] [[Network Intrusion Prevention]] [[Kernel Security]]