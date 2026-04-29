# Data Encapsulation

## What it is
Like a Russian nesting doll where each layer wraps the one inside — adding its own label and envelope — encapsulation is the process by which each OSI layer adds its own header (and sometimes trailer) to data as it travels down the stack from application to physical. At each layer, the payload from above becomes the data, and the current layer stamps its own control information around it: segments become packets, packets become frames, frames become bits.

## Why it matters
Attackers exploit encapsulation to hide malicious traffic inside legitimate protocols — a technique called **tunneling**. For example, DNS tunneling encodes command-and-control traffic inside DNS query strings; because DNS (port 53) is rarely blocked at firewalls, the malicious payload rides inside a trusted protocol's envelope, bypassing perimeter defenses entirely. Defenders use deep packet inspection (DPI) to unwrap and inspect inner payloads rather than trusting the outer header.

## Key facts
- **Layer-specific names**: Data → Segment (Layer 4) → Packet (Layer 3) → Frame (Layer 2) → Bits (Layer 1)
- **Headers vs. trailers**: Layer 2 (Data Link) is unique in adding *both* a header and a trailer (e.g., Ethernet FCS for error detection)
- **De-encapsulation** occurs on the receiving end — each layer strips its own header before passing data up
- **Protocol Data Unit (PDU)** is the formal term for data at each layer; knowing PDU names is directly tested on Security+
- **Tunneling attacks** (GRE, DNS, ICMP, HTTP tunneling) all abuse encapsulation by nesting one protocol inside another to evade inspection

## Related concepts
[[OSI Model]] [[Protocol Tunneling]] [[Deep Packet Inspection]] [[Network Protocols]]