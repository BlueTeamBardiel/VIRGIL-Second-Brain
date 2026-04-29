# netlink

## What it is
Think of netlink like a dedicated intercom system between the kernel and user-space programs — instead of shouting across a noisy hallway, processes get a private channel directly to the OS core. Precisely, netlink is a Linux IPC (Inter-Process Communication) socket family (`AF_NETLINK`) that allows user-space applications to communicate with kernel subsystems for tasks like configuring network interfaces, routing tables, and firewall rules.

## Why it matters
Attackers with local access can abuse netlink sockets to silently manipulate routing tables or iptables rules without touching common monitored tools like `ifconfig` or `iptables`. For example, a rootkit can use raw netlink calls to add malicious routes or disable firewall rules, bypassing audit logs that only watch traditional command-line utilities. Defenders using eBPF-based tools like **Falco** can monitor netlink socket creation and anomalous kernel communication to catch this technique.

## Key facts
- Netlink uses socket family `AF_NETLINK` (value `16`) and operates via `socket()`, `bind()`, `sendmsg()`, and `recvmsg()` syscalls
- Common netlink families include `NETLINK_ROUTE` (routing/interfaces), `NETLINK_NETFILTER` (iptables/nftables), and `NETLINK_AUDIT` (kernel audit subsystem)
- Requires `CAP_NET_ADMIN` capability for most privileged operations, making privilege escalation a prerequisite for weaponization
- The `ss` and `iproute2` tools (`ip` command) use netlink internally — they are essentially wrappers around netlink messages
- Malicious use of netlink is a known technique in the MITRE ATT&CK framework under **T1562.004** (Impair Defenses: Disable or Modify System Firewall)

## Related concepts
[[Linux Capabilities]] [[iptables]] [[privilege escalation]] [[eBPF]] [[kernel security]]