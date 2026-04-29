# Broadcast Domain

## What it is
Think of a broadcast domain like a town square where anyone who shouts can be heard by everyone present — but the walls of the square stop sound from reaching the next town over. Technically, a broadcast domain is the logical division of a network in which all nodes receive broadcast frames sent to the Layer 2 broadcast address (FF:FF:FF:FF:FF:FF). Routers segment broadcast domains; switches and hubs do not.

## Why it matters
ARP poisoning attacks are confined to — and depend on — shared broadcast domains. An attacker on the same VLAN can broadcast malicious ARP replies to poison a victim's ARP cache and intercept traffic, but they cannot execute this attack across a router boundary. Proper VLAN segmentation shrinks broadcast domains and directly limits the blast radius of Layer 2 attacks like ARP spoofing and DHCP starvation.

## Key facts
- **Routers always separate broadcast domains**; switches separate collision domains but forward broadcasts within the same VLAN by default.
- **Each VLAN = one broadcast domain** — VLAN segmentation is the primary tool for limiting broadcast domain scope in enterprise networks.
- **ARP and DHCP discovery both rely on Layer 2 broadcasts**, making every host in the same broadcast domain a potential target for spoofing attacks.
- **Broadcast storms** can cause denial-of-service within a broadcast domain; Spanning Tree Protocol (STP) exists specifically to prevent loops that trigger them.
- On Security+/CySA+ exams, a flat network (single broadcast domain) is a red flag — it signals poor segmentation and excessive lateral movement potential.

## Related concepts
[[ARP Poisoning]] [[VLAN Segmentation]] [[Network Segmentation]]