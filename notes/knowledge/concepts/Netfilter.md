# netfilter

## What it is
Think of netfilter as a series of toll booths built directly into a highway's asphalt — traffic can't bypass them because they're part of the road itself. Netfilter is a framework embedded in the Linux kernel that provides hooks at key points in the network stack, allowing software like `iptables` or `nftables` to inspect, modify, accept, or drop packets at the kernel level before they ever reach a user-space application.

## Why it matters
In a Linux-based intrusion scenario, an attacker who achieves root access can silently modify netfilter rules to redirect all outbound traffic through an attacker-controlled proxy — or worse, punch a hole through the host firewall to expose an internal service. Defenders use netfilter-backed rules to implement stateful packet inspection, blocking ACK-only packets that don't correspond to established sessions, neutralizing certain TCP session hijacking attempts.

## Key facts
- Netfilter defines five built-in hook points: **PREROUTING, INPUT, FORWARD, OUTPUT, and POSTROUTING** — each intercepting packets at a distinct phase of kernel routing.
- `iptables` is the traditional userspace tool that writes rules into netfilter; `nftables` is its modern replacement (default in Debian/Ubuntu since 2019).
- Rules are processed in **chain order with a default policy** (ACCEPT or DROP) applied if no rule matches — a misconfigured default ACCEPT is a common hardening failure.
- **NAT (Network Address Translation)** is implemented via netfilter's POSTROUTING chain using MASQUERADE or SNAT targets — critical for understanding how Linux routers and container networking (Docker) function.
- Kernel modules like `ip_conntrack` extend netfilter to perform **stateful inspection**, tracking connection state (NEW, ESTABLISHED, RELATED, INVALID).

## Related concepts
[[iptables]] [[packet filtering]] [[stateful inspection]] [[NAT]] [[Linux hardening]]