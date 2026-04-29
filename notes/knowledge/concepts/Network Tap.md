# Network Tap

## What it is
Like a wiretap on a phone line that lets you listen without interrupting the call, a network tap is a hardware device inserted inline between two network points that passively copies all traffic flowing through — without disturbing the original data stream. It provides out-of-band access to live traffic, creating a perfect mirror for monitoring tools without touching the active connection.

## Why it matters
In enterprise security operations, a network tap placed between a firewall and core switch feeds a copy of all traffic to an IDS/IPS or packet capture system. This means a SOC analyst can retrospectively examine full packet data after an alert fires — something a SPAN port might drop under heavy load, making the tap the more forensically reliable choice during incident response.

## Key facts
- **Passive vs. active:** Passive optical taps require no power and cannot be detected on the network — they physically split light signals, making them invisible to scanning tools
- **SPAN ports vs. taps:** SPAN (mirror) ports are software-configured on switches and can drop packets under congestion; hardware taps guarantee 100% packet capture fidelity
- **Aggregation taps** combine both directions of a full-duplex link into a single output stream for monitoring tools
- **Failure mode:** Most hardware taps are designed to **fail open** — if the tap loses power, traffic continues flowing, preserving network uptime
- **Legal/ethical boundary:** Deploying a tap on a network you don't own or have explicit authorization for is illegal under the Electronic Communications Privacy Act (ECPA) and similar laws

## Related concepts
[[Packet Sniffing]] [[SPAN Port]] [[Intrusion Detection System]] [[Passive Reconnaissance]] [[Network Forensics]]