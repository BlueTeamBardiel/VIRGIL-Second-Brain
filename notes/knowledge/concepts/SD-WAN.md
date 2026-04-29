# SD-WAN

## What it is
Think of SD-WAN like a smart traffic dispatcher standing above a highway interchange — instead of cars being locked into one road, it dynamically routes them across MPLS, LTE, or broadband based on real-time conditions. Software-Defined Wide Area Network (SD-WAN) decouples network control logic from physical hardware, using a centralized software controller to intelligently route enterprise traffic across multiple WAN links. It replaces rigid, expensive MPLS-only architectures with flexible, policy-driven connectivity.

## Why it matters
Many organizations deploy SD-WAN to route branch office traffic directly to cloud services (like Microsoft 365) without backhauling through headquarters — a practice called "local internet breakout." This dramatically expands the attack surface: a compromised branch SD-WAN appliance with direct internet access can be used as a pivot point into the corporate network, bypassing perimeter controls that assumed all traffic flows through a central firewall. In 2022, vulnerabilities in Cisco SD-WAN products (CVE-2022-20855) allowed authenticated attackers to escape to the host OS and escalate privileges.

## Key facts
- SD-WAN uses **centralized orchestration** to apply traffic policies (QoS, security, routing) across distributed sites from a single control plane
- Local internet breakout **increases exposure** by eliminating the traditional "funnel everything through HQ" security model
- SD-WAN must be paired with **SASE (Secure Access Service Edge)** or a cloud-delivered security stack to maintain consistent policy enforcement
- SD-WAN appliances are **network edge devices** — they are high-value targets and must receive timely firmware patches
- **Zero-trust principles** should be applied within SD-WAN environments since east-west traffic between branches is otherwise implicitly trusted

## Related concepts
[[SASE]] [[Zero Trust Architecture]] [[Network Segmentation]] [[VPN]] [[Attack Surface Management]]