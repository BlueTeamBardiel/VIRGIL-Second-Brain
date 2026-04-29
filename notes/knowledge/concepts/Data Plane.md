# Data Plane

## What it is
Think of a busy highway interchange: cars (packets) flow through constantly without asking for directions — the signs and lane markings just *move* them automatically. The data plane (also called the forwarding plane) is the layer of a network device responsible for actually forwarding, switching, or routing packets based on pre-established rules — it executes decisions rather than making them. It operates independently from the control plane, which handles the logic and policy configuration.

## Why it matters
In a Software-Defined Networking (SDN) environment, attackers who compromise the data plane — such as by injecting malicious forwarding rules via a rogue controller — can silently redirect traffic to an attacker-controlled host without disrupting normal network visibility. This makes data plane attacks particularly dangerous because monitoring tools watching the control plane may see nothing unusual while actual packet flows are being intercepted or manipulated.

## Key facts
- The data plane operates at **wire speed** using ASICs or FPGAs; it cannot wait for CPU-based decisions on every packet
- In SDN architecture, the data plane is physically separated from the control plane — the controller pushes rules (flow tables) down via **OpenFlow** or similar protocols
- **Flow table poisoning** is a known SDN attack where an adversary inserts unauthorized forwarding rules directly into the data plane
- Traditional firewalls that perform **stateless packet filtering** operate at the data plane level — they match header fields against ACLs without tracking session state
- Security monitoring of the data plane typically uses **NetFlow/IPFIX** or port mirroring (SPAN) to capture forwarding-level telemetry for anomaly detection

## Related concepts
[[Control Plane]] [[Software-Defined Networking]] [[NetFlow]] [[Access Control Lists]] [[Packet Filtering]]