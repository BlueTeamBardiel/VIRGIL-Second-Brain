# Autonegotiation

## What it is
Like two strangers at a door simultaneously saying "after you" until they agree on who walks through first, autonegotiation is the protocol Ethernet devices use to automatically agree on the fastest mutually supported speed and duplex mode before transmitting data. Defined in IEEE 802.3, it operates over the physical layer using Fast Link Pulses (FLPs) to advertise and select optimal link parameters without manual configuration.

## Why it matters
Autonegotiation mismatches create a classic network stability vulnerability: if one end is forced to full-duplex while the other autonegotiates to half-duplex, the result is a duplex mismatch causing massive packet loss and retransmissions — a condition attackers can exploit to degrade availability or make traffic interception easier. Network engineers who hard-code switch ports without matching the NIC settings frequently introduce this "slow link" condition, which is often misdiagnosed as a DoS attack rather than a misconfiguration.

## Key facts
- Autonegotiation occurs at OSI **Layer 1 (Physical)**, not Layer 2, making it invisible to most protocol analyzers unless you capture at the physical level
- A **duplex mismatch** — one side full-duplex, the other half-duplex — causes late collisions and throughput drops of 50–90%, a common misconfiguration on enterprise switches
- Autonegotiation does **not** negotiate VLAN membership, PoE power levels negotiation is separate (LLDP-MED), or link encryption
- On copper Ethernet, FLPs carry an **advertised ability field** — attackers with physical access could theoretically force a slower, less stable link by manipulating this field with rogue hardware
- Best practice for high-security environments: **hard-code speed and duplex** on critical ports (servers, firewalls) to eliminate autonegotiation ambiguity and reduce attack surface

## Related concepts
[[Duplex Mismatch]] [[Ethernet Frame Structure]] [[Network Tap]] [[LLDP]] [[Physical Layer Security]]