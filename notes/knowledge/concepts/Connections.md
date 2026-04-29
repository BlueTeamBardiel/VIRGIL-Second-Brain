# Connections

## What it is
Like a phone call that must be "answered" before conversation begins, a network connection is a stateful communication channel established between two endpoints. Precisely, a connection is a tracked, bidirectional flow of packets between a source and destination IP/port pair, maintained in a state table by firewalls, routers, or the OS network stack.

## Why it matters
Attackers exploit connection mechanics directly in SYN flood attacks — they hammer a target with TCP SYN packets but never complete the three-way handshake, filling the server's connection table with half-open sessions until legitimate users are denied service. Defenders counter this with SYN cookies, which allow the server to avoid storing state until the handshake is actually completed.

## Key facts
- A TCP connection follows a strict three-way handshake: **SYN → SYN-ACK → ACK** before data flows; UDP has no equivalent handshake and is considered connectionless
- Stateful firewalls track connections in a **state table** and only permit return traffic that matches an established session — this is why they block unsolicited inbound packets automatically
- The maximum number of simultaneous connections is bounded by the **ephemeral port range** (typically 1024–65535), making port exhaustion a viable denial-of-service vector
- **TIME_WAIT** state keeps a TCP connection entry alive for up to 4 minutes after close, preventing delayed duplicate packets from corrupting new sessions — attackers can exploit lingering entries
- Connection logs (source IP, destination IP, port, protocol, duration) are primary artifacts used in **network forensics** and are captured by tools like NetFlow/IPFIX

## Related concepts
[[TCP/IP Model]] [[Stateful Inspection]] [[SYN Flood Attack]] [[Ephemeral Ports]] [[Network Flow Analysis]]