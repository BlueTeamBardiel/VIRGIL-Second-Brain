# Packet Flow

## What it is
Like a letter passing through postal sorting facilities — each with their own stamp, redirect, or discard rules — a packet traverses a network by moving through a sequence of interfaces, routing decisions, and security controls. Packet flow describes the end-to-end path data takes from source to destination, including every device, rule, and transformation it encounters along the way. Understanding this path is fundamental to diagnosing misconfigurations, tracing attacks, and designing defensible architectures.

## Why it matters
During a web application breach investigation, analysts replayed captured traffic and traced the attacker's packets from an external IP, through a perimeter firewall, past a misconfigured DMZ router, directly into an internal database server — a path that should have been blocked at the firewall egress rule. Understanding the exact packet flow revealed that NAT translation was occurring *after* the ACL evaluation, allowing traffic that appeared internal to bypass filtering. Fixing the rule order immediately closed the lateral movement path.

## Key facts
- Packets are processed by firewalls **in rule order** (top-down); the first matching rule wins and subsequent rules are not evaluated — rule placement is critical
- Stateful firewalls track the **state table** (SYN → SYN-ACK → ACK) and allow return traffic automatically; stateless ACLs require explicit rules for both directions
- NAT happens at specific points in the flow; **pre-NAT vs. post-NAT** rule evaluation varies by platform (e.g., Palo Alto evaluates security policy on pre-NAT IPs)
- **Ingress filtering** drops packets with spoofed source IPs before they enter the network; egress filtering prevents internal hosts from spoofing external IPs
- Traffic that bypasses inline controls (e.g., going around a firewall via a rogue wireless AP) is called a **firewall bypass** or **traffic steering evasion**

## Related concepts
[[Stateful vs Stateless Inspection]] [[Network Address Translation]] [[Access Control Lists]] [[Firewall Rule Order]] [[Traffic Analysis]]