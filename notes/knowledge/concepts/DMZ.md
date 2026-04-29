# DMZ

## What it is
Like the buffer zone between North and South Korea — neutral ground where neither side fully trusts the other — a DMZ (Demilitarized Zone) is a network segment that sits between the untrusted internet and your trusted internal network. It hosts public-facing services (web servers, email gateways, DNS) while keeping them isolated from core systems, so a compromise there doesn't hand attackers your crown jewels.

## Why it matters
In 2013, Target's breach began through an HVAC vendor's credentials that accessed a network segment with a path to point-of-sale systems. A properly architected DMZ would have ensured vendor-accessible systems had no route into the internal payment network. Containment is the entire point — the DMZ is your sacrificial lamb that protects the flock.

## Key facts
- A DMZ is typically created using **two firewalls**: one between the internet and DMZ, another between DMZ and the internal network (three-legged perimeter or dual-firewall architecture)
- **Single-firewall DMZ** uses three interfaces (internet, DMZ, internal) — cheaper but a single point of failure
- Hosts in a DMZ should **never initiate connections inward** to the trusted network; traffic flow is strictly controlled
- Common DMZ residents: **web servers, reverse proxies, jump servers, email relays, and honeypots**
- DMZ aligns with the **principle of least privilege** at the network layer — services get only the connectivity they functionally require

## Related concepts
[[Firewall]] [[Network Segmentation]] [[Bastion Host]] [[Proxy Server]] [[Defense in Depth]]