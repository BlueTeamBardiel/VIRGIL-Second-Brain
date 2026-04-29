# straight-through cables

## What it is
Like a translator who repeats every word in the same order without rearranging anything, a straight-through cable connects each pin on one end directly to the same-numbered pin on the other end. Precisely: a straight-through (patch) cable wires pin 1 to pin 1, pin 2 to pin 2, and so on across both RJ-45 connectors, following either T568A-to-T568A or T568B-to-T568B wiring standards. This allows communication between *unlike* devices — a PC to a switch, or a router to a switch.

## Why it matters
During physical penetration testing, an attacker who gains brief access to a wiring closet must grab the right cable type to quickly plug into a switch port for network reconnaissance. Using a crossover cable by mistake when a straight-through is needed produces no link light, burning precious seconds and raising suspicion. Understanding cable types is also relevant when auditing patch panels — mislabeled or wrong cables can silently break network segments, masking deliberate tampering.

## Key facts
- Straight-through cables connect **unlike devices**: host-to-switch, host-to-hub, router-to-switch.
- Both ends use the **same wiring standard** (T568A↔T568A or T568B↔T568B) — no pin swapping occurs.
- Modern switches use **Auto-MDIX**, which electronically detects and corrects cable type, making straight-through vs. crossover distinctions largely automatic on current hardware — but the concept remains tested.
- The **opposite** is a crossover cable, which swaps the transmit and receive pairs to connect *like* devices (switch-to-switch, PC-to-PC).
- Straight-through is the most common cable found in enterprise environments; T568B is the dominant U.S. standard for patch cables.

## Related concepts
[[crossover cables]] [[T568A T568B wiring standards]] [[network access control]] [[physical security]] [[Auto-MDIX]]