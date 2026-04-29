# xt_target

## What it is
Like a traffic cop who doesn't just wave cars through but decides their fate — ACCEPT, DROP, or redirect — `xt_target` is the kernel module framework in Linux Netfilter that defines what happens to a packet after it matches a rule. Specifically, it is the extension mechanism in `iptables`/`nftables` that provides non-standard packet verdicts beyond the built-in defaults, such as LOG, REJECT, MASQUERADE, or DNAT.

## Why it matters
During incident response on a Linux server, defenders often use the `LOG` xt_target extension to capture suspicious inbound traffic metadata without blocking it — enabling forensic analysis of an active intrusion while the attacker remains unaware. Conversely, attackers with root access have abused kernel module loading to inject malicious xt_target modules that silently redirect or mirror traffic, creating a covert exfiltration channel invisible to userspace monitoring tools.

## Key facts
- `xt_target` modules live in `/lib/modules/<kernel>/kernel/net/netfilter/` and are loaded dynamically when an iptables rule references them (e.g., `-j LOG` loads `xt_LOG.ko`)
- The `MASQUERADE` xt_target enables NAT for dynamic IP interfaces — foundational to how Linux-based firewalls and routers share a single public IP
- `REJECT` sends an ICMP error back to the source; `DROP` silently discards — a key behavioral difference relevant to network reconnaissance detection
- Malicious xt_target kernel modules are a rootkit persistence technique, as they operate below SELinux/AppArmor policy enforcement in many default configurations
- Auditing loaded kernel modules with `lsmod | grep xt_` is a standard hardening check to detect unauthorized Netfilter extensions

## Related concepts
[[iptables]] [[Netfilter]] [[Network Address Translation]] [[Linux Kernel Modules]] [[Packet Filtering]]