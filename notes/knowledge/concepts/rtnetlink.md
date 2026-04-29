# rtnetlink

## What it is
Think of it as a dedicated phone line inside the Linux kernel where user-space programs can call in to request routing table changes, interface configurations, and network topology updates — and the kernel calls back with live notifications. Precisely, rtnetlink is a Linux netlink socket family (AF_NETLINK, NETLINK_ROUTE) that provides a structured API for reading and modifying kernel network objects: routes, interfaces, ARP/neighbor tables, and IP addresses.

## Why it matters
Attackers with local access can use rtnetlink to silently manipulate the routing table — injecting a rogue route that redirects traffic through an attacker-controlled gateway without touching `/etc/network/interfaces` or any file-based config, evading file-integrity monitors entirely. Defenders and EDR tools also use rtnetlink to passively monitor network configuration changes in real time, detecting privilege-escalation payloads or container-escape attempts that reroute traffic.

## Key facts
- rtnetlink operates over **netlink sockets** (`AF_NETLINK`, protocol `NETLINK_ROUTE`), not over the network — it's an IPC mechanism between user-space and the kernel
- Requires `CAP_NET_ADMIN` capability to make modifications, making it a target when attackers seek privilege escalation or container privilege misconfigurations
- Tools like `ip`, `ss`, `iproute2`, and `NetworkManager` all use rtnetlink under the hood — `strace -e trace=network` reveals these calls
- Message types include `RTM_NEWROUTE`, `RTM_DELROUTE`, `RTM_GETADDR` — each maps to a specific network object operation
- Malicious use can establish **persistent route hijacking** that survives reboots if paired with a startup script, but the kernel-level change itself is non-persistent across reboots by default

## Related concepts
[[Netlink Sockets]] [[CAP_NET_ADMIN]] [[Linux Privilege Escalation]] [[ARP Poisoning]] [[Container Escape]]