# CDP

## What it is
Like neighbors shouting their home address, phone number, and floor plan over the fence to anyone who'll listen — CDP (Cisco Discovery Protocol) is a Layer 2 proprietary protocol that automatically advertises device identity, IP addresses, IOS version, interface details, and capabilities to directly connected Cisco devices. It operates at the data link layer, meaning it doesn't need IP configured to function.

## Why it matters
In a real-world reconnaissance scenario, an attacker who gains access to a single network segment can run `show cdp neighbors detail` (or sniff raw CDP frames) to instantly map the entire network topology — discovering device types, software versions, and IP addresses without sending a single active probe. This passive intelligence gathering dramatically accelerates lateral movement planning. Disabling CDP on all external-facing and untrusted interfaces is a fundamental hardening step in CIS and NSA network security benchmarks.

## Key facts
- CDP is **enabled by default** on all Cisco interfaces; it must be explicitly disabled with `no cdp run` (globally) or `no cdp enable` (per-interface)
- Operates at **Layer 2 (Data Link)** using multicast MAC address `01:00:0C:CC:CC:CC` — it never crosses a router
- Broadcasts device details every **60 seconds** with a holdtime of **180 seconds**
- Exposes high-value recon data: device hostname, IOS version, platform model, native VLAN, IP addresses, and duplex settings
- **LLDP (Link Layer Discovery Protocol)** is the vendor-neutral IEEE 802.1AB equivalent — both carry similar risks and should be treated identically in hardening checklists

## Related concepts
[[LLDP]] [[Network Reconnaissance]] [[VLAN Hopping]] [[Network Hardening]] [[Layer 2 Attacks]]