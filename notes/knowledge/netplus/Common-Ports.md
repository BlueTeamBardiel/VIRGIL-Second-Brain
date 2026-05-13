# Common Ports

## What it is

In **Final Fantasy I**, you walk up to the town of Pravoka and every NPC has a job. The weapon shopkeeper handles steel. The white magic shopkeeper handles cures. The inn handles HP. The pub handles rumors. You don't walk into the weapon shop and ask for a Cure spell — you go to the right door, because each door is for one thing. The town works because the jobs are assigned to fixed locations.

That's exactly what **ports** do. A port is a numbered door on a host. The IP address gets the packet to the building (the server). The port number tells the OS which service inside the building should handle it. Port 80 is the HTTP shopkeeper. Port 25 is the SMTP postmaster. Port 3389 is the RDP innkeeper. Same server, different doors, different jobs.

**Technical definition:** A port is a 16-bit number (0–65535) in the TCP or UDP header that identifies a specific process or service on a host. Combined with the IP address, it forms a **socket** (e.g., `192.0.2.10:443`). The IANA-assigned **well-known ports** (0–1023) map to standard services. **Registered ports** (1024–49151) are assigned to specific applications. **Ephemeral ports** (49152–65535) are short-lived ports the client picks for the return trip.

## Why it matters

Ports are the most-tested topic in N10-009 Objective 1.4. CompTIA will throw at least 4–6 port questions at you, and they will be ugly: SMTP vs SMTPS, LDAP vs LDAPS, SNMP 161 vs trap 162, DHCP 67 vs 68, SIP 5060 vs 5061. Memorize them cold or lose easy points.

In the field, ports are how you debug everything. Can't reach the web server? `telnet server 80` or `Test-NetConnection server -Port 80`. Firewall blocking the SQL app? Check 1433. RDP not connecting? 3389 closed somewhere. *Every "the application isn't working" ticket eventually becomes a port conversation.*

## Key facts

### The memorization table — burn this in

| Port | Protocol | Transport | What it does |
|------|----------|-----------|--------------|
| 20/21 | [[FTP]] | TCP | File transfer (20 data, 21 control) — cleartext |
| 22 | [[SSH]] / [[SFTP]] | TCP | Encrypted shell, encrypted file transfer |
| 23 | [[Telnet]] | TCP | Cleartext remote shell — dead, never use |
| 25 | [[SMTP]] | TCP | Mail server-to-server, cleartext relay |
| 53 | [[DNS]] | UDP/TCP | Name resolution (UDP normal, TCP for zone transfers / >512B) |
| 67/68 | [[DHCP]] | UDP | Server 67, client 68 |
| 69 | [[TFTP]] | UDP | Lightweight file transfer — config backups, PXE boot |
| 80 | [[HTTP]] | TCP | Web, cleartext |
| 123 | [[NTP]] | UDP | Time synchronization |
| 161/162 | [[SNMP]] | UDP | 161 polling, 162 traps |
| 389 | [[LDAP]] | TCP/UDP | Directory queries, cleartext |
| 443 | [[HTTPS]] | TCP | Web, TLS-encrypted |
| 445 | [[SMB]] | TCP | Windows file/printer sharing |
| 514 | [[Syslog]] | UDP | Log shipping |
| 587 | [[SMTPS]] | TCP | Mail submission with STARTTLS |
| 636 | [[LDAPS]] | TCP | LDAP over TLS |
| 1433 | [[SQL Server]] | TCP | Microsoft SQL |
| 3389 | [[RDP]] | TCP | Windows remote desktop |
| 5060/5061 | [[SIP]] | TCP/UDP | VoIP signaling — 5060 cleartext, 5061 TLS |

### CompTIA exam traps

> **CompTIA exam trap:** SMTP is **25** for server-to-server relay. SMTP **submission** from a client is **587** (with STARTTLS). Port **465** is legacy SMTPS — CompTIA lists 587 as the secure mail port for N10-009. If you see "secure SMTP" on the exam, answer **587**.

> **CompTIA exam trap:** DHCP uses **both** 67 and 68. Server listens on **67**, client listens on **68**. The DISCOVER goes from client:68 → server:67. The OFFER comes back server:67 → client:68. Get this backwards on the exam and you lose the point.

> **CompTIA exam trap:** SNMP **161** is for polling (manager → agent). SNMP **162** is for **traps** (agent → manager, unsolicited alerts). CompTIA will give you a scenario where a device sends an unsolicited alert and ask which port — answer 162, not 161.

> **CompTIA exam trap:** DNS is UDP **53** for normal queries but TCP **53** for zone transfers and any response over 512 bytes (which is most DNSSEC traffic now). If the question mentions zone transfer or DNSSEC, answer TCP.

> **CompTIA exam trap:** SIP **5060** is cleartext, **5061** is SIP over TLS. CompTIA also expects you to know **RTP** (the actual voice payload, not signaling) runs on dynamic UDP ports negotiated by SIP — usually 16384–32767 on Cisco gear.

### Transport layer — TCP vs UDP

Ports live in the transport layer. There are two transports that matter:

- **[[TCP]] (Transmission Control Protocol)** — connection-oriented. Three-way handshake (SYN, SYN-ACK, ACK). Every segment acknowledged. Retransmits on loss. Reliable, ordered, slower. The trade chat where every message gets confirmed received.
- **[[UDP]] (User Datagram Protocol)** — connectionless. Fire and forget. No handshake, no ack, no retransmit. Fast, lossy, lightweight. The voice chat where if a packet drops, oh well — by the time you retransmitted it, the moment is gone.

**Rule of thumb:** if the application can't tolerate a missing byte (web pages, file transfer, SQL queries, SSH), it uses TCP. If the application would rather drop the packet than wait (DNS lookups, NTP, VoIP audio, video streaming, SNMP), it uses UDP. *Gaming uses UDP for the same reason voice does — a stale position update is worse than a missing one.*

### Network layer protocols — not ports, but tested together

CompTIA bundles these with ports in Objective 1.4:

- **[[IP]] (Internet Protocol)** — Layer 3 addressing and routing. IPv4 (32-bit) and IPv6 (128-bit). The envelope address. No reliability — that's TCP's job.
- **[[ICMP]] (Internet Control Message Protocol)** — Layer 3 control messages. `ping` (echo request/reply), `traceroute`, "destination unreachable", "time exceeded." No port numbers — ICMP rides directly on IP as protocol number 1. Firewalls that block all ICMP break path MTU discovery and traceroute.
- **[[GRE]] (Generic Routing Encapsulation)** — Protocol 47. Tunneling. Wraps any L3 payload inside an IP packet so it can ride across a network that doesn't natively route it. No encryption by itself — pair with IPSec.

### IPSec — the VPN protocol suite

[[IPSec]] is the standard for encrypted site-to-site and remote-access VPNs. It's not one protocol — it's a suite. CompTIA will test the components:

- **AH (Authentication Header)** — protocol 51. Provides integrity and authentication, **no encryption**. Almost never used alone in modern deployments because no confidentiality.
- **ESP (Encapsulating Security Payload)** — protocol 50. Provides encryption *and* integrity *and* authentication. This is what people actually mean when they say "IPSec."
- **IKE (Internet Key Exchange)** — UDP **500** (and **4500** when NAT traversal is in play). Negotiates the cryptographic parameters and exchanges keys before ESP starts encrypting the data plane.

> **CompTIA exam trap:** AH does **not** encrypt. ESP does. If the question asks "which IPSec component provides confidentiality," the answer is **ESP**. If it asks "which provides integrity only," AH is a valid answer (so does ESP, but if AH is an option and the scenario specifies no encryption needed, pick AH).

> **CompTIA exam trap:** IPSec VPNs traversing NAT need **UDP 4500** (NAT-T) in addition to UDP 500. If a remote-access VPN works in the office but fails from a home network behind NAT, 4500 is your suspect.

### Traffic types — who hears the packet

The transport ports tell you *what* service. The traffic type tells you *who* receives it:

- **[[Unicast]]** — one sender, one receiver. The default for nearly everything. Your laptop to the web server. Point-to-point.
- **[[Broadcast]]** — one sender, every host on the subnet. IPv4 only — IPv6 killed broadcast. Used by ARP, DHCP DISCOVER, old NetBIOS name resolution. The destination is `255.255.255.255` (limited) or the subnet broadcast (`192.168.1.255` for a /24). *Broadcasts don't cross routers — that's why they're a layer 2 / subnet-scoped phenomenon.*
- **[[Multicast]]** — one sender, a *group* of subscribed receivers. Used by OSPF (`224.0.0.5`), EIGRP (`224.0.0.10`), streaming video, IPTV. Receivers opt in via IGMP. Efficient: the sender transmits once, the network replicates as needed.
- **[[Anycast]]** — one address, *many* possible receivers, routed to the **nearest** one. The basis of how DNS root servers and CDNs work. You query `1.1.1.1` and you hit whichever Cloudflare POP is closest by BGP. The sender doesn't know or care which physical server answered.

> **CompTIA exam trap:** IPv6 has **no broadcast**. Anything that was broadcast in IPv4 (ARP, DHCP discovery) is replaced by multicast in IPv6 — neighbor discovery uses the solicited-node multicast address. If the exam asks "which traffic type does not exist in IPv6," answer broadcast.

### How a connection actually uses ports

When you open `https://example.com` in a browser:

1. Your OS picks a random **ephemeral port** (say 54321) for the return traffic.
2. It sends a TCP SYN from `yourIP:54321` to `example.com:443`.
3. The server replies SYN-ACK from `serverIP:443` to `yourIP:54321`.
4. The full socket pair is `(yourIP:54321, serverIP:443)` — that 4-tuple is what makes the connection unique.

That's why your laptop can have ten browser tabs open to the same site simultaneously — each tab gets its own ephemeral source port, so each socket is unique.

## Helpdesk reality

- **"The website is down"** — Try it yourself first. If it loads for you, it's their DNS, their proxy, or their firewall. `Test-NetConnection example.com -Port 443` from their machine. If 443 is unreachable, it's a path problem — check their VPN, their host firewall, then escalate.
- **"My email won't send but I can receive"** — Outbound 587 (or 25 if it's a legacy relay) is blocked. Hotel and guest Wi-Fi block 25 constantly to stop spam bots. Workaround is the corporate VPN.
- **"Remote desktop won't connect"** — 3389. Is the target on? Is the user allowed RDP? Is a firewall in the path? `Test-NetConnection target -Port 3389` will tell you in two seconds whether it's a port problem or an auth problem.
- **Never promise** the user that "opening a port" will fix it. Sometimes the port is open and the service is down. Sometimes the service is up and ACLs upstream block it. The port test tells you *where* the problem is, not *what* it is.
- **Escalation point:** if you've confirmed the client can reach the port on the server but the application still fails, it's an app-team or server-team ticket, not network. Document the successful port test in the ticket so the next tier doesn't redo your work.

## Related concepts

[[TCP]] · [[UDP]] · [[IP]] · [[ICMP]] · [[IPSec]] · [[DNS]] · [[DHCP]] · [[HTTPS]] · [[SSH]] · [[RDP]] · [[SMTP]] · [[SNMP]] · [[Syslog]] · [[LDAP]] · [[SIP]] · [[Unicast]] · [[Multicast]] · [[Anycast]] · [[Broadcast]] · [[Firewall Rules]] · [[OSI Model]]

*Source: VIRGIL knowledge base — 2026-05-11*