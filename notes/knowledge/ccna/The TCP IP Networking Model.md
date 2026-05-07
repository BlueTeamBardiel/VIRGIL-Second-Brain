# The TCP/IP Networking Model

## What it is

A raid team in Helldivers 2 has clear roles: someone calls the strategem, someone clears the trash, someone hauls the objective, someone watches the dropship. Nobody tries to do all four at once — it would be chaos. Networking works the same way: instead of one giant blob of code trying to handle "make the internet work," the job is split into layers, each with one specific responsibility.

There are two models for slicing up that work:

- **OSI model** — 7 layers. The academic, full-detail breakdown.
- **TCP/IP model** — 4 layers. The practical, real-world version that actually runs the internet.

The TCP/IP layers, top to bottom:

| TCP/IP Layer | OSI Equivalent | What it does |
|---|---|---|
| Application | 5, 6, 7 (Session, Presentation, Application) | The app you actually use — browser, email client, SSH |
| Transport | 4 | Gets data from process to process, reliably or not |
| Internet | 3 | Routes packets across networks using IP addresses |
| Link | 1, 2 (Physical, Data Link) | Cables, Wi-Fi radios, MAC addresses, frames |

When you send data, it travels **down** the stack on your machine, each layer slapping on its own header — that's **encapsulation**, like wrapping a Christmas present, then putting that in a box, then putting that box in a shipping crate. On the receiving end, **de-encapsulation** unwraps each layer in reverse.

Each layer also has its own name for the chunk of data it handles:
- Application: **message** (or just "data")
- Transport: **segment** (TCP) or **datagram** (UDP)
- Internet: **packet**
- Link: **frame**

## Why it matters

Cyberpunk 2077's netrunning sequences only work because each piece of the net does its own job — ICE handles defense, daemons execute payloads, the access point negotiates entry. If one component had to know how every other component worked internally, nothing would scale. Real networking is the same. The layered model means a Wi-Fi engineer can redesign the radio protocol without breaking your browser, and a web developer can ship a new app without knowing how Ethernet frames are clocked onto copper.

It also gives troubleshooting a map. When something breaks, you climb the stack: cable plugged in (Link)? IP address valid (Internet)? Port reachable (Transport)? Server responding (Application)? Without layers, "the internet is broken" has no entry point.

## Key facts

### Transport layer: TCP vs UDP

TCP is the Dark Souls co-op summon — handshake first, confirmed connection, every message acknowledged, retry if dropped. UDP is shouting "GG" in match chat — fire and forget, nobody confirms anything.

- **TCP**: connection-based, reliable, ordered delivery, flow control, congestion control. Higher overhead.
- **UDP**: connectionless, unreliable, no ordering guarantees. Lower overhead, faster.
- **IP itself is connectionless** — TCP's reliability is built *on top of* an unreliable foundation.

### Internet layer protocols

- **IP** — the address system. IPv4 = 32-bit addresses, IPv6 = 128-bit addresses.
- **ICMP** — the "is anyone home?" knock. `ping` and `traceroute` ride on ICMP.
- **IGMP** — manages multicast group membership (think Twitch stream subscriber lists, but at the network level).

### Link layer

- **Ethernet** defines the frame format and MAC addressing.
- **ARP** translates IP addresses to MAC addresses — like looking up a Discord username to find the actual user ID the system uses internally.
- **PPP** handles point-to-point WAN links.
- **MAC addresses** are 48 bits, burned into the NIC.

### Ports — the apartment numbers at an IP address

An IP gets you to the building. The port gets you to the right apartment (process). Ranges:

- **Well-known**: 0–1023 — reserved for the big-name services.
- **Registered**: 1024–49151 — vendors register these for specific apps.
- **Ephemeral**: 49152–65535 — temporary ports your client grabs for outgoing connections, like a burner phone for one conversation.

A **socket pair** — source IP, source port, destination IP, destination port — uniquely identifies any connection on the internet. It's the full delivery address: which building, which apartment, talking to which other building, which other apartment.

### Application layer protocols and ports

| Protocol | Port(s) | What it does |
|---|---|---|
| HTTP | 80 | Unencrypted web |
| HTTPS | 443 | Encrypted web (TLS-wrapped) |
| FTP | 20, 21 | File transfer with login (21 control, 20 data) |
| TFTP | 69 | Trivial file transfer, no auth — used for firmware/config grabs on trusted LANs |
| SSH | 22 | Encrypted remote shell |
| Telnet | 23 | Unencrypted remote shell — basically yelling your password across a crowded mall |
| SMTP | 25 | Sending email |
| POP3 | 110 | Downloads email and deletes from server (one-device workflow) |
| IMAP | 143 | Keeps email on server, syncs across devices (modern Gmail-style behavior) |
| DNS | 53 | Name → IP lookups. UDP for queries, TCP for zone transfers between DNS servers |
| DHCP | 67, 68 | Auto-assigns IP addresses when you join a network — the front-desk handing you a room key |

### Quick mnemonics for the layers

- HTTP/SSH/DNS chatter? **Application**.
- Port numbers and reliability? **Transport**.
- IP addresses and routing? **Internet**.
- MAC addresses and cables? **Link**.

## Related concepts

[[OSI Model]]
[[TCP Three-Way Handshake]]
[[UDP]]
[[IPv4 Addressing]]
[[IPv6 Addressing]]
[[ARP]]
[[DNS Resolution Process]]
[[DHCP DORA Process]]
[[Encapsulation and De-encapsulation]]
[[Sockets and Port Numbers]]
[[ICMP and Network Troubleshooting]]
[[Ethernet Frame Format]]