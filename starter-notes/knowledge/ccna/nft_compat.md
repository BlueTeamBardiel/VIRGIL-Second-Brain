# nft_compat

## What it is
Like a vintage adapter plug that lets old appliances work in new outlets, `nft_compat` is a kernel module that acts as a compatibility layer allowing legacy `iptables` and `ip6tables` rules to run on top of the modern `nftables` framework. It translates old-style firewall rules into nftables expressions without requiring a full migration, enabling coexistence of both systems on Linux.

## Why it matters
In 2021, researchers identified that misconfigured systems running both `iptables` via `nft_compat` and native `nftables` rules simultaneously could produce unexpected rule evaluation order, causing firewall gaps. An attacker on a misconfigured host could craft packets that passed iptables rules (processed through the compatibility layer) while bypassing native nftables chains entirely, effectively evading host-based firewall enforcement — a critical concern in cloud and container security hardening.

## Key facts
- `nft_compat` is loaded automatically on modern Debian/Ubuntu/RHEL systems when `iptables-nft` (the userspace wrapper) is used instead of legacy `iptables-legacy`
- Rules added via `iptables-nft` appear in a special `compat` table visible with `nft list ruleset`, not in traditional `iptables -L` output — auditors can miss them
- Running both `iptables-legacy` and `iptables-nft` simultaneously on the same system can cause **double-processing** or **rule shadowing**, a known misconfiguration risk
- On container platforms (Docker, Kubernetes), the container runtime may insert iptables rules through `nft_compat`, which interact unpredictably with custom nftables host firewall policies
- CIS Benchmarks recommend explicitly choosing one framework (pure nftables or legacy iptables) and disabling the other to eliminate compatibility layer ambiguity

## Related concepts
[[nftables]] [[iptables]] [[Linux Host Firewall Hardening]] [[Network Packet Filtering]] [[Container Network Security]]
