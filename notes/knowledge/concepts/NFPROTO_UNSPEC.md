# NFPROTO_UNSPEC

## What it is
Like a wildcard suit in a card game that matches any hand, `NFPROTO_UNSPEC` is a protocol-family constant in the Linux Netfilter framework with value `0` that matches *all* protocol families simultaneously. Rather than targeting IPv4 (`NFPROTO_IPV4`) or IPv6 (`NFPROTO_IPV6`) specifically, a hook or rule registered with `NFPROTO_UNSPEC` applies across every address family the kernel processes.

## Why it matters
In 2021, researchers analyzing Linux kernel Netfilter code found that improperly scoped hooks using `NFPROTO_UNSPEC` could be exploited by unprivileged user namespaces to register packet-processing callbacks that affect the entire system's network stack — contributing to privilege escalation paths like CVE-2021-22555. Defenders auditing custom kernel modules must verify that `NFPROTO_UNSPEC` hooks enforce strict permission checks, because a misconfigured hook here bleeds across all network namespaces and protocol families.

## Key facts
- `NFPROTO_UNSPEC` has the integer value **0** in the Linux kernel's `netfilter.h` header
- It is used in `nf_register_net_hook()` calls to register callbacks that fire regardless of whether traffic is IPv4, IPv6, ARP, or other families
- User namespaces (enabled by default on Ubuntu since 16.04) allow unprivileged processes to interact with Netfilter, making `NFPROTO_UNSPEC` hooks a historically recurring privilege escalation surface
- Security tools like **nftables** internally use this constant when creating family-agnostic rule sets, meaning misconfigured firewall rules may silently affect more traffic than intended
- Auditing for `NFPROTO_UNSPEC` in kernel modules is a recommended step in CIS Linux Kernel hardening benchmarks

## Related concepts
[[Netfilter Hooks]] [[Linux Namespaces]] [[Privilege Escalation]] [[iptables vs nftables]] [[Kernel Attack Surface]]