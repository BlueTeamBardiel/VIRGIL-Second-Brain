# GRE

## What it is
Think of GRE like a shipping envelope inside a shipping envelope — you slip one packet inside another so it can travel through networks that wouldn't normally understand it. Generic Routing Encapsulation (GRE) is a tunneling protocol developed by Cisco that wraps one network protocol inside another, allowing packets to traverse incompatible networks by adding a GRE header between the outer IP header and the inner payload.

## Why it matters
Attackers use GRE tunnels to exfiltrate data covertly — because many firewalls permit GRE traffic (used legitimately by VPNs and MPLS networks), malicious actors embed command-and-control traffic or stolen data inside GRE packets to bypass inspection. Defenders monitoring for data exfiltration must specifically configure DPI (Deep Packet Inspection) tools to look *inside* GRE encapsulation, since standard perimeter controls often treat the outer IP header as sufficient.

## Key facts
- GRE operates at **Layer 3** and uses **IP Protocol Number 47** (not a port number — a common exam trap)
- GRE itself provides **no encryption and no authentication** — it is purely an encapsulation mechanism; security requires pairing it with IPsec
- The GRE header adds a minimum of **4 bytes** of overhead; the full header with optional fields can be larger
- GRE supports **multicast and non-IP traffic**, making it useful where IPsec alone cannot tunnel routing protocols like OSPF
- **GRE over IPsec** is a common enterprise VPN architecture: GRE handles multicast/routing, IPsec handles confidentiality and integrity

## Related concepts
[[IPsec]] [[VPN Tunneling]] [[Protocol Encapsulation]] [[Deep Packet Inspection]] [[Data Exfiltration]]