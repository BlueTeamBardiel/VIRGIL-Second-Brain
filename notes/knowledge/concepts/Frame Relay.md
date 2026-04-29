# Frame Relay

## What it is
Think of Frame Relay like a highway system where you rent a dedicated lane (a virtual circuit) rather than owning the road — you share the physical infrastructure but get your own logical path. It is a packet-switched WAN protocol that uses virtual circuits (PVCs and SVCs) to connect geographically dispersed sites over a carrier's network, operating at Layer 2 of the OSI model. It replaced older leased-line technology by multiplexing traffic across shared infrastructure at higher speeds with lower cost.

## Why it matters
Frame Relay networks are a classic target for traffic injection and spoofing attacks because the protocol has virtually no built-in authentication or encryption — an attacker who gains access to a carrier's Frame Relay switch can inject frames onto a victim's PVC by simply using the correct DLCI (Data Link Connection Identifier). Legacy industrial control systems (SCADA/ICS) still connected over Frame Relay are particularly at risk because encrypted overlays like VPNs were rarely deployed on these links. Defenders securing legacy WAN infrastructure must recognize Frame Relay as an unencrypted, trust-based transport requiring IPsec tunneling as a compensating control.

## Key facts
- Frame Relay operates at **OSI Layer 2** and uses **DLCIs** to identify virtual circuits — not IP addresses
- **PVCs (Permanent Virtual Circuits)** are always-on logical connections; **SVCs (Switched Virtual Circuits)** are established on demand
- **CIR (Committed Information Rate)** defines the guaranteed bandwidth; traffic above CIR is marked **DE (Discard Eligible)** and dropped under congestion
- Frame Relay provides **no encryption, no authentication**, making data confidentiality entirely the customer's responsibility
- Largely replaced by **MPLS** in modern enterprise WANs, but persists in legacy and government systems

## Related concepts
[[MPLS]] [[Virtual Private Network (VPN)]] [[OSI Model]] [[WAN Security]] [[SCADA Security]]