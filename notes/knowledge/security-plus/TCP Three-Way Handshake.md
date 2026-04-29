# TCP Three-Way Handshake

## What it is
Like two strangers confirming they can both hear each other on a walkie-talkie ("Testing — do you read me?" / "Read you loud and clear — do you read *me*?" / "Loud and clear, out"), TCP establishes a connection through a synchronized exchange before any data flows. Precisely: a client sends SYN, the server responds with SYN-ACK, and the client confirms with ACK — establishing sequence numbers and mutual readiness on both ends.

## Why it matters
The SYN flood attack weaponizes this handshake directly: an attacker sends thousands of SYN packets with spoofed source IPs, forcing the server to allocate memory for half-open connections waiting for final ACKs that never arrive. This exhausts the server's connection table, causing denial of service — and is why SYN cookies were invented as a stateless mitigation.

## Key facts
- **SYN** (client → server): "I want to connect, my starting sequence number is X"
- **SYN-ACK** (server → client): "Acknowledged X, my starting sequence number is Y"
- **ACK** (client → server): "Acknowledged Y — connection established"
- Half-open connections (after SYN but before final ACK) are tracked in the server's **backlog queue**, which has a finite size — the target of SYN flood attacks
- TCP operates at **Layer 4 (Transport)** of the OSI model; the handshake only establishes the connection, not authentication — making IP spoofing during this phase historically dangerous (see: Mitnick attack, 1994)
- Tools like **Wireshark** and **Nmap** expose handshake behavior; Nmap's `-sS` (stealth scan) sends SYN but never completes the ACK, leaving half-open connections

## Related concepts
[[SYN Flood Attack]] [[TCP/IP Model]] [[Denial of Service]] [[Nmap Scanning Techniques]] [[SYN Cookies]]