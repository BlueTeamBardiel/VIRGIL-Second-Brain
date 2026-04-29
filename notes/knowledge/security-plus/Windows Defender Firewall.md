# Windows Defender Firewall

## What it is
Think of it as a bouncer at a nightclub who checks every person entering or leaving against a guest list — if your name isn't on it, you're not getting through. Windows Defender Firewall is a host-based, stateful packet filtering firewall built into Windows OS that controls inbound and outbound network traffic based on configurable rules tied to port, protocol, program, or IP address.

## Why it matters
During the 2017 WannaCry ransomware outbreak, machines with Windows Defender Firewall properly blocking SMB port 445 on public network profiles were significantly less exposed to lateral movement. Organizations that had left 445 reachable internally with no host-based firewall rules suffered rapid worm propagation across entire subnets, demonstrating that perimeter firewalls alone are insufficient.

## Key facts
- Operates in three network profiles: **Domain**, **Private**, and **Public** — rules can differ per profile, so a machine on public Wi-Fi can be far more restrictive than on a corporate domain
- Uses **Windows Filtering Platform (WFP)** as its underlying architecture, which also supports third-party security software integration
- Supports **connection security rules** using IPsec for authentication and encryption between endpoints, beyond simple allow/deny filtering
- The advanced snap-in (`wf.msc`) exposes granular controls; the basic Control Panel UI hides most of this depth — exam questions often test knowledge of both interfaces
- By default, **inbound connections are blocked** and **outbound connections are allowed**, a common misconfiguration risk since malware beaconing outbound is often unrestricted

## Related concepts
[[Host-Based Firewall]] [[Stateful Packet Inspection]] [[IPsec]] [[Network Profiles]] [[Lateral Movement]]