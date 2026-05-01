# dnsmasq

## What it is
Think of it as a Swiss Army knife postal clerk for small networks — it simultaneously handles address lookups (DNS) and hands out IP leases (DHCP) without needing separate heavy-duty servers. Precisely, dnsmasq is a lightweight, open-source DNS forwarder and DHCP server commonly deployed on routers, embedded devices, and small LANs to provide local name resolution and address assignment from a single daemon.

## Why it matters
In 2020, researchers disclosed **DNSpooq** — a bundle of seven CVEs in dnsmasq affecting billions of devices including routers from major vendors. Attackers could exploit buffer overflows and cache poisoning flaws to redirect victims' DNS queries to malicious servers, enabling phishing and traffic interception without the user ever knowing their "trusted" DNS had been hijacked.

## Key facts
- **DNSpooq (CVE-2020-25681 through 25687)** affected dnsmasq versions before 2.83; patching to 2.83+ is the remediation.
- dnsmasq is present in Android, many home routers (DD-WRT, OpenWrt), and IoT firmware — making its attack surface enormous and often unpatched.
- It is vulnerable to **DNS cache poisoning** if DNSSEC validation is not enabled, because older versions used predictable transaction IDs and source ports.
- dnsmasq supports **DNSSEC validation** as a compile-time and runtime option, which is a key defense against spoofing attacks.
- Because it combines DNS + DHCP, a compromised dnsmasq instance can perform both **DNS spoofing** and **rogue DHCP** (default gateway/DNS server manipulation) simultaneously — a powerful pivot point.

## Related concepts
[[DNS Cache Poisoning]] [[DNSSEC]] [[Rogue DHCP Server]] [[CVE Exploitation]] [[Network Segmentation]]
