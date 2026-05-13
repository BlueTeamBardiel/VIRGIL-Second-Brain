# Understanding the OSI Model

## What it is

In **Mortal Kombat**, a fatality executes in a chain. Down, Down, Forward, Back, Triangle — each input has to land in order, at the right distance, on a stunned opponent, or Shao Kahn's voice mocks you and the screen goes red. Miss the spacing (Layer 1). Drop an input (Layer 2). Hit the buttons in the wrong sequence (Layer 3 through 7). The fatality fails not because any single piece was wrong in isolation — it failed because the stack didn't execute cleanly top to bottom.

That's exactly what the OSI model describes. A packet leaving your machine is a fatality input chain. Seven layers, each one doing its job, each one depending on the layer below it. If Layer 1 isn't there — no cable, no signal — none of the layers above it matter. Doesn't matter how clean your HTTPS request is if the Ethernet port is dead.

The **Open Systems Interconnection reference model** is a seven-layer conceptual framework defined by ISO that describes how data moves from an application on one host, across a network, to an application on another host. It is not a protocol. It is not how any single real network actually implements itself end-to-end. It is the shared vocabulary engineers use to talk about *where* a problem lives.

## Why it matters

Every network troubleshooting conversation in your career will reference OSI layers. A senior engineer says "that's a layer 2 issue" and the room narrows the problem to switches, MAC addresses, and VLANs in three seconds. A help desk tech says "I think it's a layer 8 problem" and everyone knows the user is the issue. The model is the lingua franca of network work.

For **N10-009 Objective 1.1**, CompTIA expects you to know all seven layers in order, what each one does, what devices and protocols live there, and what kind of failure manifests at each layer. They will test you with scenario questions: "A user can ping by IP but not by hostname — which layer?" (DNS = Layer 7). "The link light is off — which layer?" (Layer 1). Memorize the layers, then learn to map symptoms to layers. That's the whole game.

## Key facts

### The seven layers, bottom to top

| # | Layer | Job | Lives at | Example protocols/devices |
|---|---|---|---|---|
| 1 | **Physical** | Move bits as electrical, optical, or radio signals | Cables, ports, radios | Cat6, fiber, RJ45, hubs, repeaters |
| 2 | **Data Link** | Move frames between adjacent nodes on the same network | NICs, switches | Ethernet, MAC addresses, ARP, 802.1Q VLANs |
| 3 | **Network** | Route packets between different networks | Routers | IPv4, IPv6, ICMP, OSPF, BGP |
| 4 | **Transport** | End-to-end delivery, reliability, segmentation | OS network stack | TCP, UDP, port numbers |
| 5 | **Session** | Open, manage, and close conversations between hosts | OS / app | NetBIOS, RPC, SQL sessions |
| 6 | **Presentation** | Translate, encrypt, compress data formats | OS / app | TLS/SSL, JPEG, ASCII, character encoding |
| 7 | **Application** | Interface for user-facing network services | Apps | HTTP, HTTPS, DNS, SMTP, FTP, SSH |

Mnemonic, bottom to top: **P**lease **D**o **N**ot **T**hrow **S**ausage **P**izza **A**way. Top to bottom: **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing.

### Layer 1 — Physical

Bits as signals. Voltage on copper, photons on fiber, RF in the air. No addressing here. No concept of "frame" or "packet" — just 1s and 0s as physics. If the cable is unplugged, the link light is dark, or the patch panel port is dead — that's Layer 1.

Devices: cables ([[Twisted Pair Cabling]], [[Fiber Optic Cabling]]), connectors (RJ45, LC, SC), hubs, repeaters, transceivers, [[SFP and SFP+ Transceivers]].

Failures: dead port, bad cable, wrong pinout, attenuation past 100m on copper, dirty fiber connector, wrong duplex setting (technically a Layer 1/2 boundary issue).

### Layer 2 — Data Link

Frames between adjacent nodes. This is the layer of **MAC addresses** — 48-bit hardware identifiers burned into every NIC. Switches live here. A switch reads the destination MAC in a frame's header and forwards it to the correct port. It does not know or care about IP addresses.

Layer 2 has two sublayers: **LLC** (Logical Link Control) and **MAC** (Media Access Control). For N10-009 you mostly care that MAC addressing, [[ARP]], [[VLANs and 802.1Q Tagging]], [[Spanning Tree Protocol]], and frame error checking (FCS) all live here.

Failures: MAC flapping, ARP poisoning, broadcast storms, VLAN misconfig, switching loops, duplex mismatch.

### Layer 3 — Network

Packets between networks. This is the layer of **IP addresses** — logical, software-assigned, routable. Routers live here. A router reads the destination IP, consults its routing table, and forwards the packet toward the correct next hop on a different network.

Protocols: [[IPv4 Addressing]], [[IPv6 Addressing]], ICMP (ping, traceroute), routing protocols ([[OSPF]], [[BGP]], EIGRP, RIP), [[NAT and PAT]].

Failures: bad default gateway, missing route, wrong subnet mask, asymmetric routing, ICMP blocked by firewall (breaks traceroute), TTL expiry.

### Layer 4 — Transport

End-to-end delivery between processes on hosts. This is where **port numbers** live. Two protocols matter:

- **[[TCP]]** — connection-oriented, reliable, ordered, acknowledged. Three-way handshake (SYN, SYN-ACK, ACK). Retransmits lost segments. Slower, heavier. Used by HTTP/S, SSH, SMTP, FTP — anything that can't tolerate loss.
- **[[UDP]]** — connectionless, fire-and-forget, no acknowledgment. Faster, lighter. Used by DNS queries, DHCP, VoIP, video streaming, online gaming — anything where retransmits would hurt more than loss.

Segmentation happens here — large application data gets chopped into segments (TCP) or datagrams (UDP) that fit the underlying network's MTU.

Failures: wrong port, firewall blocking the port, MTU/MSS mismatch causing fragmentation, exhausted TCP source ports on a busy NAT.

### Layer 5 — Session

Opens, maintains, and tears down conversations between two endpoints. The session layer handles things like dialog control (who talks when) and checkpointing (if a transfer breaks, resume from the last checkpoint rather than restarting).

In modern networking, Layer 5 is the most blurred layer. TCP arguably handles session state. TLS handshakes establish what feels like a session. The OSI purist will say session is its own thing; the real-world engineer will shrug. Examples cited by CompTIA: NetBIOS session establishment, RPC, SQL session management, named pipes.

### Layer 6 — Presentation

Format translation. The presentation layer makes sure the bytes one host sends mean the same thing to the host receiving them. Character encoding (ASCII vs Unicode), image formats (JPEG, GIF), and — most importantly for the exam — **encryption and compression** live here.

**[[TLS and SSL]] is the canonical Layer 6 protocol** in CompTIA's framing. When HTTPS encrypts your traffic, the TLS handshake and the encryption/decryption work happens at Layer 6, even though TLS technically operates across layers. CompTIA wants you to associate encryption with Layer 6 on the exam.

### Layer 7 — Application

The layer the user actually sees. Not the application itself — the *network interface* the application uses. Your browser is not Layer 7. The HTTP protocol your browser speaks is Layer 7.

Protocols: HTTP, HTTPS, [[DNS]], [[DHCP]], SMTP, IMAP, POP3, FTP, SFTP, SSH, SNMP, LDAP, NTP. If a user-facing service talks to a server, the protocol it speaks lives at Layer 7.

Failures: DNS resolution broken, HTTP 500 errors, expired TLS cert (technically L6 but surfaces at L7), wrong API endpoint, application timeout.

### Encapsulation — how data moves down the stack

When you click a link, your browser hands data to the OS. Each layer wraps it with its own header (and sometimes trailer):

- L7 → produces application data (HTTP request)
- L4 → adds TCP header with source/dest ports → **segment**
- L3 → adds IP header with source/dest IP → **packet**
- L2 → adds Ethernet header with source/dest MAC + FCS trailer → **frame**
- L1 → transmits as bits on the wire

The receiving host reverses the process — strips each header as the data climbs back up the stack. This is **decapsulation**. Knowing the data unit name at each layer is exam gold: **bits, frames, packets, segments** for L1-L4.

### CompTIA exam traps

> **CompTIA exam trap:** Encryption lives at **Layer 6 (Presentation)** on the exam, not Layer 7. TLS sits at L6 in CompTIA's model even though in the real world TLS operates between Layers 4 and 7. If the question says "which layer encrypts the data," the answer is 6.

> **CompTIA exam trap:** A **switch is Layer 2, a router is Layer 3**, a hub is Layer 1, a firewall is *usually* Layer 3/4 but can be Layer 7 (next-gen firewalls do deep packet inspection). A **multilayer switch** is L2+L3 — it switches frames AND routes packets. Read the question carefully.

> **CompTIA exam trap:** "Can ping by IP but not by hostname" = **Layer 7 (DNS)** is broken. IP works → L1, L2, L3, L4 all fine. Don't pick "network layer" because the word "ping" appears. The failure is name resolution.

> **CompTIA exam trap:** Port numbers are **Layer 4**, IP addresses are **Layer 3**, MAC addresses are **Layer 2**. CompTIA mixes these in distractors constantly. A "MAC address conflict" is L2. An "IP conflict" is L3. A "port already in use" is L4.

## Helpdesk reality

- User says: *"The internet is down."* You ask: *"Is the link light on the back of your computer on?"* That's Layer 1 first. Always. 60% of "internet is down" tickets resolve at L1 or L2 — cable unplugged, switch port dead, Wi-Fi disabled.
- User says: *"I can get to Google but not the company portal."* That's almost certainly Layer 7 — DNS, the portal's web server, or an expired cert. Layers 1-4 are working because Google loads.
- User says: *"It's slow."* "Slow" is not a layer. Get specifics: slow to load, slow to type, slow to download? Each maps to different layers. Run a [[traceroute]] and a speed test before you guess.
- Never promise *"I'll fix it in five minutes"* on a network ticket. You don't know yet whether it's a loose cable (2 minutes) or a routing protocol misconfiguration upstream (4 hours and a network team escalation).
- Escalation rule: if you've verified L1 (cable, link light), L2 (correct VLAN, MAC learned), and L3 (correct IP, gateway reachable, DNS resolving) on the client side and it's still broken — it's a network team ticket. Document what you tested. Don't make them repeat your work.

The OSI model is anatomy. You don't troubleshoot Layer 7 before checking that the patient is breathing at Layer 1. Always work bottom-up unless the symptom screams otherwise.

*The first lesson of network troubleshooting is humility: the cable is unplugged more often than the routing protocol is broken.*

## Related concepts

[[TCP IP Model]] · [[Encapsulation and Decapsulation]] · [[Ethernet Frames]] · [[IPv4 Addressing]] · [[TCP]] · [[UDP]] · [[DNS]] · [[ARP]] · [[VLANs and 802.1Q Tagging]] · [[Switches vs Routers]] · [[TLS and SSL]] · [[Network Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*