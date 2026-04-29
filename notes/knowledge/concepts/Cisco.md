# Cisco

## What it is
Like the plumbing and electrical systems of a building that nobody sees but everyone depends on, Cisco is the dominant manufacturer of the networking infrastructure — routers, switches, firewalls, and wireless controllers — that moves virtually all enterprise traffic. Cisco devices form the backbone of most corporate, government, and ISP networks worldwide, running proprietary operating systems like IOS and NX-OS.

## Why it matters
In 2016, the Shadow Brokers leak revealed NSA-developed exploits specifically targeting Cisco ASA firewalls (notably CVE-2016-6366, "EXTRABACON"), allowing unauthenticated remote code execution via SNMP. This demonstrated that compromising a single Cisco device could give an attacker invisible, persistent control over an entire organization's traffic — a chokepoint attack that no endpoint security tool could detect.

## Key facts
- Cisco IOS (Internetwork Operating System) is the proprietary firmware running on most Cisco routers and switches; misconfigurations here are a primary attack surface
- Cisco ASA (Adaptive Security Appliance) is their flagship firewall/VPN product, frequently targeted in CVEs; patching ASA is a critical hardening priority
- Default credentials and SNMP community strings (default: "public"/"private") on Cisco devices are a common initial access vector in penetration tests and real attacks
- Cisco's **TACACS+** protocol (vs. RADIUS) provides granular per-command authorization for network device administration — a key AAA distinction on Security+ exams
- The Cisco Smart Install feature (TCP port 4786) has been repeatedly exploited for unauthenticated remote configuration changes and should be disabled if unused

## Related concepts
[[Network Segmentation]] [[SNMP]] [[AAA Authentication]] [[Firewall]] [[CVE]]