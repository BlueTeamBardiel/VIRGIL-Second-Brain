# Root Bridge Election

## What it is

In **Demon's Souls**, the Nexus is the one place every path leads back to — defeat an Archstone boss anywhere in Boletaria and you're yanked back to that hub, every world organized around it. Root bridge election does the same thing for switches: every switch in a [[VLAN]] agrees on a single **root bridge** to serve as the Nexus of the [[Spanning Tree Protocol|spanning tree]], and every other switch calculates its shortest path home.

The election isn't a fight — it's a recognition. Switches flood [[BPDU]] messages claiming their identity, and the one with the lowest credentials wins by default. No combat, no ceremony, just math.

Technically: the root bridge is the switch with the **lowest [[Bridge ID]] (BID)** in a broadcast domain, elected via [[BPDU]] exchange, and serves as the logical center from which a loop-free Layer 2 topology is built.

## Why it matters

The root bridge dictates which links forward traffic and which get blocked — meaning a badly placed root sends your traffic on scenic detours through your slowest access switch. Worse, if you don't manually elect a root, STP picks whichever switch has the lowest MAC address, which is usually the oldest, dustiest box in the closet. On the exam: expect to compare BIDs digit-by-digit and identify the winner, and to know the exact command that forces the outcome.

## Key facts

### Bridge ID composition (the 8-byte ID)

Modern [[PVST+]] and [[Rapid PVST+]] use the **Extended System ID** format:

| Field | Size | Notes |
|---|---|---|
| **Bridge Priority** | 4 bits | Multiples of 4096; default **32768** |
| **System ID Extension** | 12 bits | Holds the **[[VLAN]] ID** |
| **MAC Address** | 48 bits | Switch's base MAC, tiebreaker |

Total: **64 bits / 8 bytes**. The priority + VLAN ID combine into a single 16-bit value you'll see in `show` output (e.g., VLAN 10 with priority 32768 → BID priority field reads **32778**).

### Election rules

1. **Lowest priority wins.**
2. **Tie on priority → lowest MAC address wins.**
3. Every switch boots up declaring *itself* root in outgoing [[BPDU]]s, then concedes when it hears a better BID.
4. Election is **per-VLAN** in PVST+ — each VLAN can have a different root.

### Manual configuration

```
! Force this switch to be root for VLAN 10
Switch(config)# spanning-tree vlan 10 root primary

! Backup root — takes over if primary dies
Switch(config)# spanning-tree vlan 10 root secondary

! Or set priority directly (must be multiple of 4096)
Switch(config)# spanning-tree vlan 10 priority 24576
```

What those macros actually do:
- **`root primary`** → sets priority to **24576** (or 4096 below current root, whichever is lower).
- **`root secondary`** → sets priority to **28672**.
- Defaults: **32768**. Valid range: **0–61440** in steps of **4096**.

### Verification

```
Switch# show spanning-tree vlan 10
Switch# show spanning-tree root
```

Look for `This bridge is the root` — if absent, you're not it.

### Failure and re-election

When the root stops sending [[BPDU]]s, downstream switches wait **Max Age** (default **20 seconds** in classic STP) before declaring it dead and re-electing. [[Rapid PVST+]] reacts faster via active BPDU handshakes. The next-lowest BID becomes the new root — which is exactly why `root secondary` exists: pre-stage the backup instead of letting the closet dinosaur win by default.

### BPDU role in the election

[[BPDU]]s (sent every **2 seconds** by default — Hello timer) carry the sender's **Root BID** and **Sender BID**. A switch updates its belief when it receives a BPDU advertising a *lower* Root BID than the one it currently believes in. Eventually all switches converge on advertising the same Root BID — election complete.

## Related concepts

[[Spanning Tree Protocol]] · [[Bridge ID]] · [[BPDU]] · [[Root Port]] · [[Designated Port]] · [[PVST+]] · [[Rapid PVST+]] · [[Path Cost]] · [[VLAN]] · [[STP Convergence]]

---
*Source: VIRGIL knowledge base*