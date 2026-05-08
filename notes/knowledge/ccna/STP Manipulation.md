# STP Manipulation

## What it is

In Final Fantasy VI, Kefka poisons the water supply at Doma Castle by impersonating an officer of the Empire — once the guards trust his uniform, they let him walk straight to the well. STP manipulation is the network version: an attacker convinces every switch in the broadcast domain that *their* rogue device should be the root bridge, the trusted center of the spanning tree. Once crowned, traffic reroutes through the attacker's box, and they get a front-row seat to the entire Layer 2 segment.

Spanning Tree Protocol (802.1D) was built to prevent switching loops by electing one root bridge and blocking redundant paths. Switches gossip about who should be root using **Bridge Protocol Data Units (BPDUs)** — small frames that advertise a bridge priority and MAC address. Lowest priority wins. The attacker plugs into an access port, fires off crafted BPDUs claiming a priority of 0 (or anything lower than the current root), and the switches dutifully recalculate the topology with the attacker's device at the top.

The kicker: STP has **zero authentication**. No password, no certificate, no signature on a BPDU. Whoever shouts the lowest number wins the election. It's the Empire handing out uniforms at the front gate and never checking who's wearing them.

## Why it matters

Becoming root bridge is like getting the spectator camera in Counter-Strike 2 except you can also reach into the match and grab loot. Traffic that used to take optimal paths now bends through the attacker's machine, giving them full Layer 2 visibility — the exact position needed to launch ARP spoofing, harvest plaintext credentials, hijack sessions, or just quietly mirror everything for later.

The protocol is from 1990. It was designed when the threat model was "loops will melt the network," not "someone malicious is on the LAN." That assumption stopped being safe roughly the moment Wi-Fi and unattended conference room jacks became normal. If you don't actively defend STP, you're running on trust alone — and every access port in the building is a potential entry point.

## Key facts

### The attack
- **Superior BPDU injection**: attacker sends BPDUs with a bridge priority lower than the current root (priority 0 is the nuclear option). Switches accept it because BPDUs are unauthenticated.
- **Topology recalculation**: like everyone in a Discord raid suddenly @everyone-ing a new channel — switches drop what they're doing and redraw the tree around the attacker.
- **Result**: man-in-the-middle position at Layer 2. Pairs naturally with ARP spoofing, credential sniffing (anything cleartext — HTTP, FTP, Telnet, SNMPv1/2c), and session hijacking.

### BPDU Guard
- The bouncer at the access-port door. Any BPDU shows up on a protected port? Port goes into `err-disabled` state immediately — no questions, no recovery without admin intervention (or errdisable recovery timer).
- Applied to **access ports** — the ports where end users plug in laptops, printers, IP phones. End devices have no business sending BPDUs ever.
- This is the real defense against STP manipulation on user-facing ports.

### Root Guard
- The bodyguard for your *legitimate* root bridge. If a port starts hearing BPDUs that are "superior" to the current root, Root Guard puts the port in `root-inconsistent` state until the rogue BPDUs stop.
- Applied to ports facing **other switches you don't fully trust as root candidates** — typically downstream switches in the distribution/access layer.
- Different job than BPDU Guard: Root Guard tolerates BPDUs (because switch-to-switch trunks need them), it just refuses to let *better* ones win the election.

### PortFast
- Skips the listening and learning states so a port jumps straight to forwarding. Like skipping the loadout screen in Call of Duty and spawning instantly.
- Convenience feature for access ports — DHCP clients hate waiting 30+ seconds for STP to converge.
- **PortFast does NOT block BPDUs.** A PortFast port still happily processes a malicious BPDU and recalculates topology.
- Rule: **PortFast + BPDU Guard, always together.** PortFast for speed, BPDU Guard for safety. One without the other is a trap.

### Quick defense cheat sheet
| Feature | Where | What it does |
|---|---|---|
| BPDU Guard | Access ports | Shuts port down on any BPDU |
| Root Guard | Trunk ports to downstream switches | Blocks superior BPDUs only |
| PortFast | Access ports | Faster forwarding (not security) |

## Related concepts
[[Spanning Tree Protocol]]
[[BPDU]]
[[Root Bridge Election]]
[[ARP Spoofing]]
[[Layer 2 Attacks]]
[[DHCP Snooping]]
[[Dynamic ARP Inspection]]
[[VLAN Hopping]]
[[Port Security]]
[[MAC Flooding]]