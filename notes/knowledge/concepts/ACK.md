# ACK

## What it is
Think of ACK like saying "message received" at a post office — the recipient confirms they got your package. In TCP, an ACK (acknowledgment) is a control packet sent by the receiver back to the sender confirming that data bytes were successfully received. It contains a sequence number telling the sender which byte it's expecting next, enabling reliable, ordered delivery.

## Why it matters
ACK packets are critical to TCP's reliability, but attackers exploit them in SYN flood attacks. An attacker sends thousands of SYN packets without completing the handshake—the server allocates resources waiting for the final ACK that never arrives, exhausting memory and blocking legitimate connections. Understanding ACKs is essential for defending against connection-state attacks and for crafting rate-limiting rules that prioritize genuine three-way handshakes.

## Key facts
- ACK is the third packet in the TCP three-way handshake (SYN, SYN-ACK, ACK)
- Each ACK contains an acknowledgment number showing the next expected sequence number, preventing duplicate or out-of-order delivery
- A SYN flood attacker sends SYN packets but never sends the final ACK, leaving connections in SYN_RECV state
- Firewalls and load balancers use SYN cookies to defend by validating ACKs before allocating full connection state
- ACKs are also sent for data segments mid-connection (not just during handshake) to confirm receipt

## Related concepts
[[TCP Three-Way Handshake]] [[SYN Flood]] [[Sequence Numbers]] [[Connection State]] [[SYN Cookies]]