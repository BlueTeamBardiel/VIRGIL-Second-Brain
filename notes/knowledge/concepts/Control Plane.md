# Control Plane

## What it is
Think of the control plane as the air traffic control tower — it doesn't carry passengers, but it decides where every plane goes. In networking and cloud environments, the control plane is the layer responsible for making routing and policy decisions (how traffic *should* flow), while the data plane is the runway that actually moves the packets. It's the management and signaling layer that governs infrastructure behavior.

## Why it matters
In software-defined networking (SDN) and cloud environments, the control plane is a high-value attack target because compromising it gives an attacker god-mode over network behavior. In 2022, attackers targeting BGP (Border Gateway Protocol) — a core internet control plane protocol — demonstrated route hijacking, redirecting traffic through malicious autonomous systems to intercept or drop communications at scale. Defenders must segment and harden control plane access with strict ACLs, out-of-band management networks, and mutual authentication.

## Key facts
- The control plane is **separated from the data plane** in SDN architectures; the SDN controller is the centralized control plane component
- **BGP, OSPF, and EIGRP** are all control plane protocols — they build routing tables but don't forward user traffic themselves
- Control plane attacks include **route injection, BGP hijacking, and OSPF spoofing** — all of which manipulate forwarding decisions without touching user data directly
- **Control Plane Policing (CoPP)** is a Cisco feature that rate-limits traffic destined for the router's CPU, protecting the control plane from DoS attacks
- In cloud environments (AWS, Azure), the control plane includes APIs and management consoles — **compromising an IAM credential can compromise the entire control plane**

## Related concepts
[[Software-Defined Networking]] [[BGP Hijacking]] [[Data Plane]] [[Network Segmentation]] [[IAM (Identity and Access Management)]]