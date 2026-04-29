# Firewalls

## What it is
Think of a firewall like a bouncer at a nightclub who checks every person's ID against a guest list — anyone not on the list gets turned away at the door, no exceptions. Technically, a firewall is a network security device (hardware or software) that inspects incoming and outgoing traffic and permits or denies packets based on a defined ruleset. Rules can filter by IP address, port number, protocol, or application-layer content depending on the firewall type.

## Why it matters
In 2003, the SQL Slammer worm exploited UDP port 1434 and infected 75,000 servers within ten minutes — organizations with firewalls blocking unnecessary UDP traffic were largely unaffected. A properly configured firewall that followed the principle of least privilege (deny all, permit by exception) would have stopped Slammer cold at the network perimeter, buying defenders critical time.

## Key facts
- **Stateful vs. Stateless**: Stateless firewalls filter each packet in isolation; stateful firewalls track TCP session state, making them harder to spoof with crafted packets.
- **Next-Generation Firewalls (NGFW)** perform Deep Packet Inspection (DPI) and can identify applications regardless of port, blocking BitTorrent on port 80 for example.
- **Implicit deny** is a foundational rule: any traffic not explicitly permitted is automatically blocked — this is the default in well-configured firewalls.
- **WAFs (Web Application Firewalls)** operate at Layer 7 and specifically defend against SQL injection, XSS, and OWASP Top 10 threats — distinct from network firewalls.
- **ACLs on routers** function like primitive stateless firewalls but lack session tracking; true firewalls are the stronger Security+ exam distinction.

## Related concepts
[[Network Segmentation]] [[DMZ]] [[Intrusion Detection Systems]] [[Access Control Lists]] [[Defense in Depth]]