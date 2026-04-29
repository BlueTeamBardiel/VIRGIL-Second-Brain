# Connection State

## What it is
Like a bouncer who remembers which guests already passed the velvet rope, a stateful firewall tracks the full lifecycle of each network conversation. Connection state refers to the tracked record of a network session — including source/destination IP, ports, sequence numbers, and which phase of the handshake (SYN, ESTABLISHED, FIN) the connection is currently in.

## Why it matters
In a SYN flood attack, an attacker sends thousands of half-open TCP connections (SYN packets with no follow-up ACK), exhausting the server's state table. A stateful firewall or SYN cookie mechanism tracks these incomplete handshakes and can drop them before they consume all available connection slots — a defense that only works *because* the device understands connection state.

## Key facts
- **Stateful inspection** firewalls track the state table; **stateless** packet filters evaluate each packet in isolation with no memory of prior packets
- TCP connection states include: `SYN_SENT`, `SYN_RECEIVED`, `ESTABLISHED`, `FIN_WAIT`, `TIME_WAIT`, and `CLOSED`
- The state table stores 5-tuple information: source IP, destination IP, source port, destination port, and protocol
- A **session hijacking** attack exploits connection state by predicting TCP sequence numbers to inject packets into an established session
- State table exhaustion is itself an attack vector — filling the table denies new legitimate connections (a form of DoS)

## Related concepts
[[Stateful Firewall]] [[TCP Three-Way Handshake]] [[Session Hijacking]] [[SYN Flood Attack]] [[Packet Filtering]]