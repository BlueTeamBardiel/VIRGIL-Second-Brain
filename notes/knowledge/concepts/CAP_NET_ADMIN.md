# CAP_NET_ADMIN

## What it is
Think of it as giving a process the keys to the network control room — but not the master keys to the whole building. `CAP_NET_ADMIN` is a Linux capability that grants a process elevated network administration privileges (interface configuration, firewall rules, routing tables, packet sniffing) without requiring full root (`UID 0`).

## Why it matters
Attackers who escape a Docker container running with `CAP_NET_ADMIN` can manipulate the host's network interfaces, install malicious `iptables` rules, or perform ARP spoofing to intercept traffic from other containers on the same bridge network. This is a common container misconfiguration finding in cloud penetration tests and a key reason why the Docker security principle of "drop all capabilities, add only what's needed" exists.

## Key facts
- `CAP_NET_ADMIN` allows: interface configuration (`ip link`), modifying routing tables, binding to raw sockets, enabling promiscuous mode, and managing `iptables`/`nftables` rules
- Unlike `CAP_NET_RAW`, it doesn't directly allow raw packet crafting — but it enables promiscuous mode, which enables passive sniffing
- In Kubernetes, granting `CAP_NET_ADMIN` inside a pod with `hostNetwork: true` is essentially equivalent to having network-level root on the node
- Linux capabilities were introduced to surgically split the monolithic root privilege — there are ~40 distinct capabilities; `CAP_NET_ADMIN` is one of the most dangerous in containerized environments
- Detection: audit logs showing `capset()` syscalls or tools like `getpcaps <PID>` and `capsh --print` reveal unexpected capability assignments

## Related concepts
[[Linux Capabilities]] [[Docker Container Escape]] [[Principle of Least Privilege]] [[iptables]] [[ARP Spoofing]]