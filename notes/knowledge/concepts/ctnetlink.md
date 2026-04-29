# ctnetlink

## What it is
Think of ctnetlink as a live ticker feed from your firewall's memory — a real-time stream of every connection the kernel is tracking, delivered over a socket to any program that asks. Precisely, ctnetlink is a Netlink-based subsystem in the Linux kernel that exposes the connection tracking (conntrack) table, allowing userspace processes to read, modify, subscribe to events for, or delete NAT and stateful firewall entries.

## Why it matters
In 2014, researchers discovered that unprivileged local users inside Linux containers (e.g., Docker) could open a `NETLINK_NETFILTER` socket and flood the host with conntrack dump requests, causing a denial-of-service by exhausting kernel memory — CVE-2014-0181. This exposure became a critical container escape risk, leading to hardened seccomp profiles and capability restrictions (`CAP_NET_ADMIN`) that block ctnetlink access in most production container runtimes today.

## Key facts
- ctnetlink operates over `NETLINK_NETFILTER` socket family and requires `CAP_NET_ADMIN` for write operations; read access was historically less restricted
- It is used by tools like `conntrack -L` (conntrack-tools) and intrusion detection systems (Suricata, Snort via nfq) to inspect live session state
- Attackers who gain container breakout or local privilege escalation can abuse ctnetlink to **delete conntrack entries**, disrupting stateful firewall rules and allowing traffic that would otherwise be blocked
- The conntrack table stores tuple data: source IP, destination IP, ports, protocol, and connection state (NEW, ESTABLISHED, RELATED) — all readable via ctnetlink
- Hardening countermeasures include seccomp syscall filtering (`socket` with `AF_NETLINK`), dropping `CAP_NET_ADMIN`, and using user namespaces to isolate netlink visibility

## Related concepts
[[Netlink Sockets]] [[Linux Capabilities]] [[Netfilter]] [[Container Escape]] [[Stateful Firewall]]