# nfnetlink_log

## What it is
Think of it as a security camera feed for your Linux kernel's packet filtering system — instead of dropping packets silently into the void, it pipes them to userspace applications that can record, analyze, or alert on them. Precisely: `nfnetlink_log` is a Linux kernel subsystem (part of the Netfilter framework) that uses the `NFLOG` target to capture and multicast network packet data to userspace processes via the Netlink socket protocol.

## Why it matters
Defenders use `nfnetlink_log` as the backbone of host-based packet capture and IDS integration — tools like `ulogd2` consume its output to write firewall events to databases or feed Snort/Suricata without requiring full `tcpdump`-style promiscuous mode access. An attacker who compromises a system and disables or corrupts the `ulogd2` daemon severs this logging pipeline, creating a blind spot where malicious traffic passes through iptables `NFLOG` rules but generates no audit trail — a classic log tampering technique.

## Key facts
- `nfnetlink_log` replaces the older `ULOG` target; `NFLOG` is the modern iptables/nftables logging mechanism and is the default in most distributions since kernel 2.6.14
- Packets are delivered via **multicast group** on Netlink socket family `NETLINK_NETFILTER`, allowing multiple userspace consumers simultaneously
- The kernel module is `nfnetlink_log.ko`; its absence means `NFLOG` rules silently fail, dropping log entries without error
- Log data can include full packet payload (configurable via `--nflog-size`), metadata, interface info, and timestamps — making it forensically richer than syslog-based firewall logs
- `nfnetlink_log` is commonly leveraged by `firewalld`, `ulogd2`, and `libnetfilter_log` — all targets for an attacker seeking to suppress evidence

## Related concepts
[[Netfilter]] [[iptables]] [[Linux Audit Framework]]