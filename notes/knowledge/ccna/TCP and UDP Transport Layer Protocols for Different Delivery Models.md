# TCP and UDP: Transport Layer Protocols for Different Delivery Models

## What it is

In *League of Legends*, TCP is your ranked match's chat with a friend coordinating a gank — every message has to arrive, in order, or the play falls apart ("wait what lane?"). UDP is the positional data streaming from your ADC's champion 30 times a second — if one packet of "Jinx is at coordinate X,Y" gets dropped, nobody wants the client to pause and replay it; you want the *next* position update, right now, so the dodge still matters.

Both live at **Layer 4 (Transport)** of the OSI model, sitting on top of IP. Their job is to take application data and hand it off to the network, but they make wildly different promises about what happens next.

**TCP (Transmission Control Protocol)** is connection-oriented. Before any real data flows, both sides shake hands, agree on sequence numbers, and maintain a stateful conversation. Every segment is numbered, acknowledged, and retransmitted if lost. Think of the champion select lock-in phase — nothing proceeds until every player has confirmed and the server has acknowledged each one.

**UDP (User Datagram Protocol)** is connectionless. No handshake, no state, no acknowledgments. You fire a datagram and hope. This is the real-time game state itself — skillshot trajectories, minion positions, ability cooldowns. If a packet drops, the engine just uses the next one. Stopping the match to redeliver a stale snapshot would be worse than losing it.

## Why it matters

The choice between TCP and UDP determines whether your application feels reliable or feels *fast*, and you usually can't have both maxed out.

Loading a webpage, downloading a game patch, SSHing into a server — anything where a missing byte ruins the whole thing — runs on TCP. Missing one byte of a Steam download means the executable is corrupt. Unacceptable.

Live voice in Discord, a *Counter-Strike 2* match, a Twitch stream's underlying transport, DNS lookups — anything where stale data is worse than missing data — runs on UDP. In CS2, a packet describing where an enemy was 200ms ago is garbage. You want the packet describing where they are *now*, even if you missed the last one. TCP's "let me retransmit that" would feel like rubber-banding hell.

This is also why network defenders care: TCP's handshake gives you something to inspect, log, and block (SYN floods, RST injection, sequence prediction). UDP has none of that ceremony, which makes it both lighter and easier to spoof — a favorite for amplification attacks (DNS, NTP, memcached).

## Key facts

### TCP — the reliable one

- **Connection-oriented** via the **3-way handshake**: SYN → SYN-ACK → ACK. Like matchmaking in *Apex Legends* — both sides confirm they're loaded in before the drop ship leaves.
- **Reliable delivery**: every segment carries a sequence number, every receipt is ACK'd, anything unACK'd by the timeout gets retransmitted. Like a *Helldivers 2* stratagem ball — if the throw didn't land, you throw again.
- **Ordered delivery**: 32-bit sequence numbers let the receiver reassemble out-of-order segments into the correct stream.
- **Flow control** via a 16-bit **window size** field — the receiver tells the sender "I can only handle this much more right now," preventing buffer overflow. Like a raid leader calling "stop pulling, healer's OOM."
- **Congestion control**: TCP backs off when the network is hurting (slow start, congestion avoidance). UDP does not — it floors it regardless.
- **Header**: minimum **20 bytes**, maximum **60 bytes** (extra room for options).
- **Checksum** (16 bits) validates integrity of header + data.

**TCP header fields worth knowing:**
- Source port (16 bits), Destination port (16 bits)
- Sequence number (32 bits), Acknowledgment number (32 bits)
- Flags (9 bits), Window size (16 bits), Checksum (16 bits)

**TCP flags — the control verbs:**
- **SYN**: "Let's start a connection." Initiates the handshake.
- **ACK**: "Got it." Confirms received data.
- **FIN**: "I'm done, closing politely." Graceful shutdown — like typing "gg" before leaving lobby.
- **RST**: "Connection terminated, immediately." The alt-F4 of TCP.
- **PSH**: "Don't buffer this, push it up to the app right now." Used for interactive traffic like SSH keystrokes.
- **URG**: Marks data as urgent (rarely used in practice).

**TCP connection states**: Closed → Listen → SYN Sent → SYN Received → Established → FIN Wait → (eventually) Closed. A whole state machine, like a quest tracker.

### UDP — the fast one

- **Connectionless, stateless**: no handshake, no session, no memory of who you talked to.
- **Best-effort**: no retransmission, no ordering, no flow control, no congestion control. The "send it and forget it" tweet of protocols.
- **Header**: a flat **8 bytes**, period. No options, no negotiation.
- Fields: Source port (16), Destination port (16), Length (16), Checksum (16). That's the whole thing.
- Each **datagram is discrete** — no reassembly across datagrams. What you send is what arrives (or doesn't).
- **Basic checksum only** — detects corruption but doesn't fix it.

### Ports — the apartment numbers on the IP address

A port is a 16-bit number identifying which app on a host should get the data. Same building (IP), different apartments (ports).

- **Well-known**: 0–1023 (reserved for standard services)
- **Registered**: 1024–49151 (vendor-claimed services)
- **Dynamic/Private**: 49152–65535 (ephemeral client-side ports)

**TCP ports you should recognize on sight:**
- **20 / 21** — FTP (data / control)
- **22** — SSH (encrypted remote shell)
- **23** — Telnet (unencrypted remote shell, basically a museum piece)
- **25** — SMTP (sending email)
- **53** — DNS (used over TCP for zone transfers and large responses)
- **80** — HTTP
- **110** — POP3
- **143** — IMAP
- **443** — HTTPS

**UDP ports you should recognize on sight:**
- **53** — DNS (the default — small, fast queries)
- **67 / 68** — DHCP (server / client)
- **69** — TFTP (lightweight file transfer, often for network device configs)
- **123** — NTP (time sync)
- **161** — SNMP (network device monitoring)
- **514** — Syslog (log shipping)
- **5060** — SIP (VoIP signaling)
- **RTP** — variable UDP ports (the actual voice/video media stream)

### Quick mental model

| | TCP | UDP |
|---|---|---|
| Handshake | Yes (3-way) | No |
| Reliability | Guaranteed | Best-effort |
| Ordering | Yes | No |
| Flow control | Yes | No |
| Congestion control | Yes | No |
| Header size | 20–60 bytes | 8 bytes |
| State | Stateful | Stateless |
| Vibe | Certified mail | Paper airplane |

## Related concepts

- [[OSI Model and Layer 4]]
- [[Three-Way Handshake]]
- [[TCP Window Scaling and Flow Control]]
- [[TCP Congestion Control (Slow Start, Reno, CUBIC)]]
- [[Sockets and Port Binding]]
- [[NAT and Port Address Translation]]
- [[SYN Flood and TCP-Based DoS Attacks]]
- [[UDP Amplification Attacks]]
- [[QUIC and HTTP/3]] — UDP underneath, reliability on top
- [[DNS over TCP vs UDP]]
- [[Stateful vs Stateless Firewalls]]