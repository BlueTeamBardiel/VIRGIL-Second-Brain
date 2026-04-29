# Stateful Firewall

## What it is
Like a nightclub bouncer who doesn't just check your ID at the door but remembers you came in — so when you try to re-enter, they know you belong — a stateful firewall tracks the full context of active network connections, not just individual packets. It maintains a **state table** recording each connection's source/destination IP, port, protocol, and session phase, allowing it to permit return traffic that legitimately belongs to an established session. Packets are evaluated against this table rather than static rules alone.

## Why it matters
Without stateful inspection, attackers can craft unsolicited packets with the ACK flag set to sneak through a firewall that naively permits all "established" TCP traffic — because the rule matches the flag, not whether a real handshake occurred. A stateful firewall rejects that ACK packet immediately because no corresponding SYN entry exists in the state table, defeating the attack without needing a specific rule for it.

## Key facts
- The state table tracks TCP sessions through **SYN → SYN-ACK → ACK** transitions; UDP and ICMP are tracked by timeout heuristics since they're connectionless.
- Operates at **Layer 4 (Transport Layer)** of the OSI model, distinguishing it from packet-filtering firewalls (also Layer 4, but stateless) and application-layer firewalls (Layer 7).
- Default behavior: **deny unsolicited inbound traffic** automatically, because no matching state entry exists for it.
- State tables are finite — a **SYN flood attack** can exhaust the table by creating thousands of half-open connections, causing the firewall to drop legitimate traffic (a resource exhaustion DoS).
- On Security+/CySA+: stateful firewalls are contrasted with **next-generation firewalls (NGFW)**, which add deep packet inspection, application awareness, and IPS functionality beyond basic session tracking.

## Related concepts
[[Packet Filtering Firewall]] [[Next-Generation Firewall (NGFW)]] [[SYN Flood Attack]] [[TCP Three-Way Handshake]] [[Network Access Control]]