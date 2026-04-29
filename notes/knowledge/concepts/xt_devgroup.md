# xt_devgroup

## What it is
Like a bouncer checking which entrance of a club a guest came through before deciding to let them in, `xt_devgroup` is a Linux netfilter/iptables match extension that filters network packets based on the **device group** of the network interface they arrive on or depart from. It allows firewall rules to target logical groupings of network interfaces rather than naming each interface individually.

## Why it matters
In a multi-tenant server environment with dozens of virtual interfaces (VLANs, containers, VPNs), an administrator can assign all internal management interfaces to device group `0x1` and all untrusted guest interfaces to group `0x2`, then write a single iptables rule blocking SSH from group `0x2` — rather than maintaining a fragile, ever-growing list of individual interface names. This dramatically reduces misconfiguration risk when new interfaces are added and forgotten in firewall rules.

## Key facts
- Device groups are assigned to network interfaces via the `net_dev_group` sysctl or `ip link set dev <iface> group <id>` command
- Match syntax in iptables: `-m devgroup --src-group 0x1` (source interface group) or `--dst-group 0x1` (destination interface group)
- Supports range matching using `--src-group 0x1/0xff` (value/mask notation), enabling flexible grouping hierarchies
- Part of the **netfilter** subsystem; available in Linux kernel since 3.3 and requires `xt_devgroup` kernel module to be loaded
- Commonly used alongside `xt_physdev` and interface-based rules in bridge/container firewall architectures to prevent interface enumeration attacks bypassing per-interface rules

## Related concepts
[[iptables]] [[netfilter]] [[network segmentation]] [[Linux firewall hardening]] [[xt_physdev]]