# Fast Link Pulse

## What it is
Like a heartbeat signal between two friends agreeing they're still on the same call, Fast Link Pulse (FLP) is the handshake mechanism used in 100BASE-TX and higher Ethernet to negotiate connection speed and duplex settings. It extends the older Normal Link Pulse (NLP) used in 10BASE-T, transmitting bursts of pulses that encode capability information between two NICs before data transmission begins.

## Why it matters
In a network reconnaissance or physical-layer attack scenario, an adversary with physical access can plug a rogue device into a switch port and rely on FLP auto-negotiation to silently establish a full-duplex gigabit connection — no manual configuration required. Defenders who disable auto-negotiation and hard-code speed/duplex on sensitive switch ports eliminate this silent entry point, though mismatched settings can introduce duplex mismatch errors that degrade performance and are easy to miss.

## Key facts
- FLP operates at **Layer 1 (Physical Layer)** of the OSI model, occurring before any Layer 2 frames are exchanged
- Auto-negotiation via FLP can be exploited to cause **duplex mismatch**: one side negotiates full-duplex, the other falls back to half-duplex, causing collisions and degraded throughput — a subtle DoS symptom
- FLP bursts consist of **17–31 pulses** encoding a 16-bit Link Code Word advertising supported speeds and duplex capabilities
- Disabling auto-negotiation is a **CIS Benchmark hardcoded recommendation** for high-security switch ports to prevent capability advertisement to unknown devices
- FLP is defined in **IEEE 802.3u** (the Fast Ethernet standard), later extended in 802.3ab for Gigabit Ethernet

## Related concepts
[[Auto-Negotiation]] [[Duplex Mismatch]] [[Network Access Control]] [[Switch Port Security]] [[OSI Physical Layer]]