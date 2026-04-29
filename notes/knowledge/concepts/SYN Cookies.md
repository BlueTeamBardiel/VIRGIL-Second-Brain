# SYN Cookies

## What it is
Imagine a busy nightclub bouncer who, instead of holding a reservation list (which could fill up), encodes your reservation details into a unique stamp on your hand — so he needs no list at all. SYN cookies work the same way: when a server receives a TCP SYN, instead of storing half-open connection state in memory, it encodes connection parameters into the initial sequence number (ISN) sent back to the client. Only when a valid ACK returns can the server reconstruct the connection, requiring zero memory reservation during the handshake.

## Why it matters
During a SYN flood attack, an adversary sends thousands of spoofed SYN packets, exhausting the server's TCP backlog queue and denying service to legitimate users. With SYN cookies enabled, the server never writes to its backlog queue, so the flood consumes no meaningful server resources — the attacker is essentially stamping millions of hands for a party they'll never attend.

## Key facts
- SYN cookies use a cryptographic hash (typically including source/destination IP, port, and a timestamp secret) to generate the ISN, making them computationally infeasible to forge.
- They are activated automatically under load on Linux systems via the kernel parameter `net.ipv4.tcp_syncookies = 1`.
- TCP options (such as window scaling and SACK) negotiated during the SYN phase are lost when SYN cookies are active, causing a minor performance degradation for legitimate connections.
- SYN cookies defend against SYN flood DoS attacks (MITRE ATT&CK T1499) without requiring stateful firewall rules.
- The technique was invented by Daniel J. Bernstein (djb) and Eric Schenk in 1996 and remains a standard Linux/BSD kernel mitigation today.

## Related concepts
[[SYN Flood Attack]] [[TCP Three-Way Handshake]] [[Denial of Service (DoS)]] [[Stateful Firewalls]]