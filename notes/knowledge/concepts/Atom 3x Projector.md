# Atom 3x Projector

## What it is
Like a slide projector that casts one image onto three different screens simultaneously, the Atom 3x Projector is a network packet replication and traffic projection tool used in security testing environments. It duplicates live network traffic and forwards identical copies to multiple monitoring or analysis destinations without disrupting the original data flow.

## Why it matters
In a blue team defensive scenario, a SOC analyst might use traffic projection to simultaneously feed raw packets to an IDS, a packet capture tool, and a behavioral analytics platform — all from a single tap point. Without this capability, analysts would need multiple physical taps or risk missing events because only one tool could observe the traffic stream at a time.

## Key facts
- Operates at the hardware or low-level network layer, making it transparent to endpoints (no additional latency signatures introduced to monitored hosts)
- Commonly deployed alongside network TAPs (Test Access Points) to passively copy traffic — the TAP captures; the projector distributes
- The "3x" designation typically refers to the output fan-out ratio: one input mirrored to three separate output channels
- Relevant to **passive reconnaissance defense** — because the tool is out-of-band, attackers cannot detect its presence through active probing
- Supports **chain-of-custody integrity** in forensic investigations by ensuring multiple simultaneous captures without packet alteration

## Related concepts
[[Network TAP]] [[Port Mirroring]] [[Intrusion Detection System]] [[Passive Network Monitoring]] [[Packet Capture]]