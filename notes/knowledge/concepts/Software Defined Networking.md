# Software Defined Networking

## What it is
Think of a traditional network like a highway system where every intersection has its own hardwired traffic light logic — SDN is like replacing all those local controllers with a single air traffic control tower that reprograms every light in real time. Software Defined Networking separates the **control plane** (decisions about where traffic goes) from the **data plane** (the actual forwarding of packets), centralizing routing logic in a software-based controller. This abstraction lets administrators manage the entire network topology through APIs and software policies rather than configuring individual devices.

## Why it matters
In 2021, attackers targeting SDN controllers discovered that compromising a single controller gave them the ability to reroute or drop traffic across an entire data center — a "single pane of glass" that cuts both ways. Defenders use this same centralization to push microsegmentation policies instantly across thousands of virtual switches, isolating a ransomware outbreak within seconds by quarantining infected network segments without touching physical hardware.

## Key facts
- SDN controllers (e.g., OpenDaylight, ONOS) represent a **high-value single point of failure** — controller compromise = network-wide control
- Uses **OpenFlow** as the dominant southbound API protocol between controller and network devices
- Enables **microsegmentation**: granular east-west traffic policies within a data center to contain lateral movement
- SDN shifts the attack surface from individual devices to the **northbound API** (apps talking to controller) — often REST-based and vulnerable to API attacks
- Relevant to **zero trust architecture**: SDN can dynamically enforce least-privilege network access based on identity and context

## Related concepts
[[Microsegmentation]] [[Zero Trust Architecture]] [[Network Access Control]] [[API Security]] [[Lateral Movement]]