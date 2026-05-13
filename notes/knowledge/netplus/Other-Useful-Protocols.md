# Other Useful Protocols

## What it is

In **Demon's Souls**, when you scrawl a bloodstain in the Boletarian Palace, every other player in your world tendency band sees the same red smear on the ground. You didn't message them. They didn't ping you. The server fanned your death out to a group. Drop a soapstone sign and a single phantom touches it — only that one player gets pulled into your world, directed, one-to-one. When a Black Phantom invades, the message *"Black Phantom [Name] has invaded!"* blasts to everyone in the area whether they wanted to know or not. Same game, three delivery models: one-to-one, one-to-group, one-to-everyone.

That's exactly what **traffic types** do — they decide who hears the packet. Underneath those delivery models sit the protocols that actually move the data: TCP for reliable trades, UDP for fire-and-forget messages, ICMP for *"are you still alive?"* pings, IPSec for the encrypted tunnel between regions, GRE wrapping one protocol inside another so it survives the trip.

Technically: this note covers the layer-3 and layer-4 protocols that move packets across IP networks, plus the four addressing/delivery models that determine the recipient set. Per N10-009 Objective 1.4.

## Why it matters

The port-number list everyone memorizes is layer 7. This note is the plumbing underneath. When a [[VPN]] tunnel won't establish, the failure is almost always IPSec — IKE phase 1 or phase 2 negotiation. When [[Routing]] streams updates across the network, it's multicast. When [[DHCP]] hands out leases, the initial discover is broadcast. When a CDN serves you a file from the closest edge node, that's anycast. When [[Traceroute]] works at all, it's ICMP.

Objective 1.4 explicitly names IP, ICMP, TCP, UDP, GRE, IPSec (AH, ESP, IKE), and the four traffic types. CompTIA loves to test which traffic type a given service uses, and whether AH or ESP gives you encryption (spoiler: only ESP).

## Key facts

### TCP vs UDP — the reliability divide

**TCP** is the trade window in Dark Souls. Both parties confirm. You drop the item. They pick it up. The trade can't half-complete. Three-way handshake (SYN, SYN-ACK, ACK), sequence numbers, retransmission on loss, ordered delivery, flow control.

**UDP** is shouting an Orange Guidance message into the void. You send it. You don't know who read it. No handshake, no acks, no retransmission, no order guarantee. Header is 8 bytes vs TCP's 20+.

| Trait | TCP | UDP |
|---|---|---|
| Connection | Connection-oriented | Connectionless |
| Reliability | Guaranteed, in order | Best effort |
| Header overhead | 20+ bytes | 8 bytes |
| Speed | Slower (acks, retransmits) | Faster |
| Use cases | HTTP/HTTPS, SSH, SMTP, file transfer | DNS, DHCP, VoIP, video, gaming |

*Counter-Strike runs on UDP. If a position update drops, the next one is 16ms behind it anyway. Waiting for a retransmit would be worse than the loss.*

### ICMP — the network's heartbeat check

**ICMP** doesn't carry user data. It carries network-about-the-network messages. It rides directly on IP — no port number, because it's layer 3, not layer 4.

Key message types:
- **Echo Request / Echo Reply** — what [[ping]] uses. *"Are you alive?" "Yes."*
- **Destination Unreachable** — router telling you the path is dead
- **Time Exceeded** — TTL hit zero. This is how [[traceroute]] works: send packets with TTL=1, 2, 3, collect the Time Exceeded replies from each router along the way
- **Redirect** — *"there's a better route, use that gateway instead"*

ICMP gets blocked at a lot of corporate edges because attackers used to use it for reconnaissance and tunneling. *Blocking ICMP entirely breaks Path MTU Discovery and makes troubleshooting hell. Rate-limit it, don't kill it.*

### IP types

The protocol number field in the IP header tells the receiver what's inside:

| Protocol number | Carried protocol |
|---|---|
| 1 | ICMP |
| 6 | TCP |
| 17 | UDP |
| 47 | GRE |
| 50 | ESP |
| 51 | AH |

This is why firewalls can block "IPSec" without knowing a port — they filter on IP protocol 50/51. ESP doesn't have a port. It IS the protocol.

### GRE — wrapping a packet in another packet

**Generic Routing Encapsulation** takes a packet of any protocol and stuffs it inside an IP packet. Cisco's invention, now standard. IP protocol 47.

Why you'd do this: send multicast routing traffic across a network that doesn't support multicast. Tunnel IPv6 across an IPv4-only segment. Build a simple point-to-point tunnel between two sites without IPSec negotiation overhead.

*GRE is unencrypted by default.* That's the catch. It's a tunnel, not a secure tunnel. The standard enterprise pattern is **GRE over IPSec** — GRE provides the flexibility (multicast, multi-protocol), IPSec provides the encryption.

### IPSec — the encrypted tunnel

**IPSec** is a framework, not a single protocol. Three moving parts:

**AH — Authentication Header** (IP protocol 51)
- Authenticates the packet — proves origin and integrity
- **Does NOT encrypt the payload.** Anyone sniffing can read it.
- Rarely used alone — doesn't survive NAT (the NAT device changes the IP header, breaks the auth hash)

**ESP — Encapsulating Security Payload** (IP protocol 50)
- Authenticates AND encrypts the payload
- What 99% of real IPSec VPNs actually use
- Survives NAT when wrapped in NAT-T (UDP 4500)

**IKE — Internet Key Exchange** (UDP 500)
- The negotiation protocol. Both ends agree on encryption algorithms, authenticate, exchange keys
- **Phase 1**: establish a secure channel for the negotiation itself (the ISAKMP SA)
- **Phase 2**: negotiate the actual data-traffic SAs (the IPSec SA)
- IKEv2 is the modern version — faster, cleaner, handles mobile clients better

**Modes:**
- **Transport mode** — only the payload is encrypted, original IP header preserved. Host-to-host.
- **Tunnel mode** — entire original packet encrypted and wrapped in a new IP header. Site-to-site between VPN gateways. This is enterprise.

> **CompTIA exam trap:** AH does NOT provide encryption. If the question asks which IPSec component encrypts the payload, the answer is **ESP**. AH only authenticates.

> **CompTIA exam trap:** IKE uses **UDP 500**. NAT Traversal (NAT-T) uses **UDP 4500**. ESP itself has no port — it's IP protocol 50. If a firewall question asks what to allow for an IPSec VPN: UDP 500, UDP 4500, and IP protocol 50.

### Traffic types — who hears the packet

**Unicast — one-to-one**
- One sender, one specific receiver. The vast majority of traffic on any network.
- *Demon's Souls equivalent:* a phantom answering your specific soapstone summon

**Broadcast — one-to-everyone-on-the-segment**
- Destination address `255.255.255.255` (limited broadcast) or the subnet broadcast address
- Used by ARP, DHCP discover, NetBIOS name resolution
- **IPv6 has no broadcast.** Killed off in favor of multicast.
- *Demon's Souls equivalent:* the "Black Phantom has invaded" message blasting to everyone

**Multicast — one-to-a-group**
- Multiple specific receivers who have joined a group
- IPv4 multicast range: `224.0.0.0/4`
- Used by [[OSPF]] (224.0.0.5/6), [[EIGRP]] (224.0.0.10), IPTV, video conferencing
- IGMP is the protocol hosts use to join/leave groups
- *Demon's Souls equivalent:* bloodstains visible only to players in your world tendency band

**Anycast — one-to-the-nearest-of-a-group**
- Same IP advertised from multiple locations; routing delivers to the closest one
- Killer use case: **root DNS servers**. 13 logical root servers, hundreds of physical instances worldwide, all sharing the same IP via anycast.
- How modern [[CDN]]s work — same IP, different physical server depending on where you are
- *Demon's Souls equivalent:* the matchmaker pulling you into the closest viable phantom's world

| Type | Destination | Receiver count | Example |
|---|---|---|---|
| Unicast | Specific host IP | One | HTTP request to a server |
| Broadcast | 255.255.255.255 or subnet bcast | All on segment | DHCP discover, ARP request |
| Multicast | 224.0.0.0/4 | Group members | OSPF hellos, IPTV |
| Anycast | Shared IP, distributed | Nearest one | Root DNS, CDN edge |

> **CompTIA exam trap:** IPv6 does not use broadcast — it uses multicast for what IPv4 would broadcast. Neighbor Discovery (the IPv6 replacement for ARP) uses solicited-node multicast. If you see "IPv6 broadcast" as an answer choice, it's wrong.

> **CompTIA exam trap:** Anycast vs multicast. Anycast delivers to **one** recipient (the nearest). Multicast delivers to **all** group members. Same-sounding, opposite delivery.

### Where this shows up in the port list

- **DHCP (67/68)** uses **broadcast** for discover/request — the client has no IP yet
- **DNS (53)** uses **UDP** for queries, **TCP** for zone transfers and responses over 512 bytes
- **NTP (123), SNMP (161/162), Syslog (514)** — all **UDP**
- **SIP (5060/5061)** signaling is TCP or UDP; the actual voice (RTP) is always UDP
- **HTTP/HTTPS, SSH, SMTP, FTP, RDP, SMB, SQL, LDAP** — all **TCP**

*If the protocol cares about every byte arriving in order, it's TCP. If it cares about speed and can tolerate loss, it's UDP. Almost no exceptions on the exam.*

## Helpdesk reality

- **"My VPN won't connect"** — 80% of the time it's IKE phase 1 failing. Check that UDP 500 and 4500 are allowed outbound from the user's network. Hotel Wi-Fi and some coffee shops block them on purpose.
- **"Ping doesn't work but the website loads"** — ICMP being blocked at the edge. The application traffic is fine. Don't waste an hour troubleshooting a "network problem" that's just a firewall policy doing its job.
- **"Internet is slow on video calls only"** — VoIP and video are UDP. They suffer from jitter and loss in ways TCP file downloads don't. Check QoS, check wireless signal, check for a saturated uplink.
- **Never promise a VPN tunnel will come back up "in a minute."** IKE renegotiation, dead peer detection timeouts, and ISP-side path changes can stretch recovery to 15+ minutes.
- **Escalation point:** if the client can reach the VPN concentrator's public IP, IKE is allowed through the firewall, and credentials are correct, but the tunnel still won't establish — that's a network/security team ticket. Capture the client logs before you hand it off.

## Related concepts

[[Common Ports and Protocols]] · [[VPN]] · [[IPSec Tunnel Configuration]] · [[OSI Model]] · [[DHCP]] · [[DNS]] · [[ARP]] · [[Traceroute]] · [[Ping]] · [[IPv6 Addressing]] · [[Multicast Routing]] · [[CDN]] · [[QoS]] · [[Firewall Rules]]

*Source: VIRGIL knowledge base — 2026-05-11*