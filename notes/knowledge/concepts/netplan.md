# netplan

## What it is
Like a blueprint handed to a contractor who then handles all the actual construction, Netplan is a YAML-based network configuration abstraction layer that delegates the real work to backend renderers. It is the default network configuration utility on Ubuntu 17.10+ systems, allowing administrators to define network settings declaratively in `/etc/netplan/*.yaml` files, which are then rendered by either NetworkManager or systemd-networkd.

## Why it matters
During a Linux hardening engagement, a misconfigured Netplan file with overly permissive settings—such as disabling MAC address randomization or statically assigning a predictable IP—can make a host easier to fingerprint and target. Conversely, defenders use Netplan configurations to enforce static IP assignments on critical servers, preventing DHCP-based attacks like rogue DHCP server poisoning that could redirect traffic through an attacker-controlled gateway.

## Key facts
- Configuration files live in `/etc/netplan/` with `.yaml` extension; changes are applied with `netplan apply` or tested temporarily with `netplan try` (auto-reverts after 120 seconds if not confirmed)
- Supports two backends: **NetworkManager** (desktop environments) and **systemd-networkd** (servers/headless systems); the backend is specified with the `renderer` key
- MAC address randomization for Wi-Fi can be explicitly configured under `wifi` blocks using `macaddress: random`, relevant for privacy and 802.1X bypass considerations
- Improper YAML indentation in Netplan files causes silent failures or boot-time network outages—a common misconfiguration that results in loss of remote access to servers
- Netplan replaced the legacy `/etc/network/interfaces` file system; understanding both is necessary when auditing mixed Ubuntu environments

## Related concepts
[[systemd-networkd]] [[DHCP Spoofing]] [[Network Interface Hardening]]