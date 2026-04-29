# Linux network namespace

## What it is
Like giving each tenant in an apartment building their own private mailbox, doorbell, and intercom system — completely invisible to other tenants — a Linux network namespace gives a process its own isolated copy of the entire network stack. Precisely: it virtualizes network resources (interfaces, routing tables, firewall rules, sockets) so processes in different namespaces cannot see or communicate with each other's network activity by default.

## Why it matters
Container runtimes like Docker use network namespaces to isolate container traffic — but a misconfigured container sharing the host network namespace (`--net=host`) eliminates that isolation entirely, allowing a compromised container to sniff host traffic or bind to privileged ports. Attackers who escape a container into the host namespace gain the ability to intercept traffic from all other containers on the same host.

## Key facts
- Created with `ip netns add <name>` or automatically by container runtimes; listed with `ip netns list`
- Each namespace gets its own `lo` (loopback) interface, independent `iptables` rules, and routing table
- Processes communicate across namespaces only through explicitly configured virtual Ethernet pairs (`veth` pairs) or bridges
- `nsenter -t <PID> -n` lets an admin (or attacker with sufficient privileges) enter another process's network namespace — a common lateral movement technique
- Docker's default bridge mode creates one namespace per container; `--net=host` disables this isolation and is a known CIS Docker Benchmark finding

## Related concepts
[[Container Security]] [[Linux Namespaces]] [[Network Segmentation]] [[iptables]] [[Privilege Escalation]]