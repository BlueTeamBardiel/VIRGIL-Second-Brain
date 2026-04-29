# X.25

## What it is
Think of X.25 like sending a registered letter through a post office network — each envelope gets stamped, tracked, and routed through a series of relay stations with error-checking at every stop. X.25 is a packet-switched WAN protocol standardized by the ITU-T in the 1970s that establishes virtual circuits across public data networks (PDNs), providing built-in error correction and flow control at every node. It was the backbone of early financial networks and ATM systems before Frame Relay and IP displaced it.

## Why it matters
Legacy industrial control systems (ICS) and ATM networks in developing countries still run X.25, creating a persistent attack surface. In penetration tests against legacy financial infrastructure, attackers have exploited X.25 PAD (Packet Assembler/Disassembler) interfaces — which translate asynchronous terminal traffic into X.25 packets — to gain unauthorized access to banking mainframes, since these old systems often lack modern authentication controls. Discovering an exposed X.25 NUI (Network User Identifier) prompt is essentially finding an unlocked side door into 1980s-era infrastructure still processing live transactions.

## Key facts
- Operates at **Layers 1–3** of the OSI model (physical, data link, and network)
- Uses **virtual circuits**: Permanent Virtual Circuits (PVCs) are pre-established; Switched Virtual Circuits (SVCs) are on-demand
- Built-in **error correction at every node** — a deliberate design choice for unreliable telephone lines, making it slower but more robust than Frame Relay
- The **PAD (X.3/X.28/X.29 standards)** allowed dumb terminals to connect to X.25 networks — a common legacy attack vector
- X.25 addresses use **X.121 format** (up to 14 digits), analogous to telephone numbers for network endpoints

## Related concepts
[[Frame Relay]] [[Virtual Circuits]] [[Legacy Protocol Security]] [[SCADA/ICS Security]] [[OSI Model]]