# Port Filtering

## What it is
Think of a port filter like a bouncer at a club with a strict guest list — certain port numbers get waved through, while others get physically turned away at the door. Port filtering is the practice of selectively permitting or blocking network traffic based on TCP/UDP port numbers at a firewall, router, or host, preventing unauthorized services from being reached even if they're running on the target system.

## Why it matters
During the 2017 WannaCry ransomware outbreak, organizations that had filtered TCP port 445 (SMB) at their network perimeter were largely protected from lateral propagation, while those with open internal SMB traffic saw the worm spread uncontrolled across thousands of hosts. A single egress/ingress filtering rule on that one port would have contained the blast radius significantly.

## Key facts
- **Ingress filtering** blocks inbound traffic on specified ports; **egress filtering** blocks outbound — both are necessary, as attackers use reverse shells on high-numbered ports (e.g., 4444) to exfiltrate data outbound.
- Stateless packet filters check port numbers in isolation; **stateful firewalls** track connection context, distinguishing a legitimate established session from a spoofed packet claiming to be one.
- Common default-deny hardening: close all ports, then explicitly allow only required services (principle of least privilege applied to networking).
- Port filtering does **not** inspect payload content — an attacker tunneling C2 traffic over port 443 (HTTPS) bypasses port-based rules entirely, requiring deep packet inspection (DPI) to catch.
- On Security+/CySA+ exams, port filtering is a core function of **ACLs** on routers and is distinct from application-layer filtering, which operates at Layer 7.

## Related concepts
[[Firewall Rules]] [[Access Control Lists (ACL)]] [[Stateful Inspection]] [[Egress Filtering]] [[Deep Packet Inspection]]