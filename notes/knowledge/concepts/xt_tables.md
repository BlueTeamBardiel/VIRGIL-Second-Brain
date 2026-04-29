# xt_tables

## What it is
Think of xt_tables as the shared ingredient cabinet that both iptables and ip6tables cook from — a kernel-level framework in Linux that provides the common matching and target modules used across all Netfilter-based packet filtering tools. Precisely, xt_tables is a Linux kernel subsystem that registers and manages shared extension modules (matches and targets) for use by multiple table-based packet filtering frameworks simultaneously.

## Why it matters
During incident response on a compromised Linux server, an attacker may load a malicious kernel module that hooks into xt_tables to silently drop forensic traffic or redirect connections — all while `iptables -L` shows nothing suspicious in the ruleset itself. Understanding xt_tables helps defenders recognize that firewall manipulation can happen at the module level, not just the rule level, making rootkit detection tools like `rkhunter` or kernel module auditing essential companions to firewall log review.

## Key facts
- xt_tables lives in kernel space (`net/netfilter/x_tables.c`) and is loaded as a module; its presence can be verified with `lsmod | grep xt_`
- It exposes match modules (e.g., `xt_conntrack`, `xt_string`, `xt_multiport`) and target modules (e.g., `xt_REDIRECT`, `xt_LOG`) shared across iptables, ip6tables, arptables, and ebtables
- Malicious actors with root/kernel access can register fake xt_tables extensions to intercept or manipulate traffic invisibly at the hook level
- Security-relevant modules include `xt_conntrack` (stateful inspection) and `xt_LOG`/`xt_NFLOG` (packet logging for SIEM ingestion)
- Hardening guidance includes restricting kernel module loading via `kernel.modules_disabled=1` sysctl after boot and auditing loaded modules with `auditd`

## Related concepts
[[Netfilter]] [[iptables]] [[Linux Kernel Modules]]