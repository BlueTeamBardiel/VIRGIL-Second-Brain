# RSTP

## What it is
Like a traffic roundabout that instantly reroutes cars the moment one exit closes — rather than making everyone wait for a traffic cop to manually redirect flow — RSTP (Rapid Spanning Tree Protocol) is an IEEE 802.1w enhancement to STP that reduces network convergence time from 30–50 seconds down to under a second. It eliminates Layer 2 switching loops while recovering from topology changes almost instantaneously.

## Why it matters
Attackers can abuse RSTP by connecting a rogue switch configured with a superior Bridge ID, triggering a topology change and forcing the network to re-elect a new root bridge — a technique called a **Root Bridge Attack**. During reconvergence, traffic may briefly flood through the attacker's device, enabling interception or a man-in-the-middle position. Defending against this involves enabling **BPDU Guard** on access ports so any port receiving a BPDU is immediately disabled.

## Key facts
- RSTP (IEEE 802.1w) converges in **~1 second** vs. legacy STP's 30–50 seconds, reducing the attack window during topology changes
- Defines three port roles: **Root Port, Designated Port, and Alternate/Backup Port** (replaces STP's blocking/listening/learning/forwarding states with just Discarding, Learning, Forwarding)
- **BPDU Guard** and **Root Guard** are the primary Layer 2 hardening controls: BPDU Guard shuts ports receiving BPDUs; Root Guard prevents inferior ports from becoming root
- A rogue switch winning root bridge election can cause **network-wide traffic redirection** — all traffic paths recalculate toward the attacker
- RSTP is incorporated into **802.1D-2004**, making it the default spanning tree behavior in modern managed switches

## Related concepts
[[Spanning Tree Protocol (STP)]] [[BPDU Guard]] [[VLAN Hopping]] [[Layer 2 Security]] [[Man-in-the-Middle Attack]]


<!-- merged from: STP.md -->

# STP


