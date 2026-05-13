# Remote Access

## What it is

In **Street Fighter 6**, when you queue Ranked from Texas and the matchmaker drops you into a lobby with a player in Tokyo, the game opens a session across 6,000 miles of hostile infrastructure. Inputs from your stick — quarter-circle, punch — have to land on the opponent's machine in under 50ms or the rollback netcode starts hallucinating frames. The session is encrypted, authenticated, and tunneled so nobody in between can inject a fake Shoryuken. That's exactly what remote access does — it builds a trusted, low-latency, encrypted tunnel between two endpoints across an untrusted network, then runs a real-time protocol on top.

**Remote access** is the umbrella term for any technology that lets a user, device, or session reach a resource across an external network — usually the public internet — as if it were local. The N10-009 exam tests it as a stack: the IP types underneath, the transport protocols (TCP/UDP), the diagnostic protocols (ICMP), the tunneling protocols (GRE, IPSec), the cryptographic key exchange (IKE), and the traffic delivery modes (unicast, multicast, anycast, broadcast) that determine how packets find their destinations.

## Why it matters

Every job in IT after about 2020 assumes remote access works. The hybrid worker on the VPN, the sysadmin SSH'd into a rack in another state, the RDP session to a jump box, the SD-WAN tunnel between branch offices — all of it is remote access. When it breaks, productivity stops. When it's misconfigured, it's the single largest attack surface in the org.

N10-009 hits this hard across **Objective 1.4** (ports/protocols/traffic types), Objective 1.5 (transmission media — what the tunnel rides on), and Objective 4.0 (security). Expect questions on IPSec components, IKE phases, port numbers for SSH/RDP/SMB, and the difference between AH and ESP. *If you only memorize one thing on exam day, memorize that AH does not encrypt and ESP does.*

## Key facts

### IP types — the foundation under everything

Remote access rides on IP. You need to know which IP and what it does.

| Type | Notes |
|------|-------|
| **IPv4** | 32-bit, ~4.3 billion addresses, exhausted. NAT exists because of this. |
| **IPv6** | 128-bit, effectively unlimited. Native end-to-end, no NAT needed. |
| **Private IPv4** | RFC 1918: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16. Not routable on the internet. |
| **Public IPv4** | Globally routable. What your ISP hands you. |
| **APIPA** | 169.254.0.0/16. Self-assigned when DHCP fails. *If you see this on a client, DHCP is broken.* |
| **Loopback** | 127.0.0.1 (v4), ::1 (v6). The host talking to itself. |
| **Link-local v6** | fe80::/10. Auto-configured, segment-only. |
| **Unique local v6** | fc00::/7. The v6 equivalent of RFC 1918. |
| **Global unicast v6** | 2000::/3. Routable, public. |

### ICMP — the diagnostic layer

**Internet Control Message Protocol** is how the network tells you what went wrong. No port — it's a protocol number (1), not a TCP/UDP service. ICMP carries:

- **Echo Request / Echo Reply** — what [[ping]] uses
- **Destination Unreachable** — the router telling you "no route, no host, port closed"
- **Time Exceeded** — TTL hit zero, what makes [[traceroute]] work
- **Redirect** — "use a different gateway for this destination"

> **CompTIA exam trap:** ICMP is **not** TCP or UDP and has **no port number**. If a question lists "port 7" for ICMP, it's wrong — port 7 is the Echo service over TCP/UDP, a different thing. ICMP is identified by IP protocol number 1.

ICMP is often blocked at firewalls, which breaks ping but doesn't break the underlying connectivity. *A failed ping does not mean the host is down — it means ICMP didn't get a reply.*

### TCP vs UDP — the transport choice

| | TCP | UDP |
|---|---|---|
| Reliability | Acknowledged, retransmitted | Fire and forget |
| Ordering | Sequenced | None |
| Handshake | 3-way SYN/SYN-ACK/ACK | None |
| Overhead | High | Low |
| Use case | Web, file transfer, SSH, RDP | DNS, voice, video, gaming |

Remote access uses both. **RDP (3389)** is TCP — you want every keystroke. **VoIP (SIP 5060/5061)** is UDP for the media — you want speed and you can tolerate a dropped packet. **SSH (22)** is TCP. **VPN tunnels** vary: IPSec can run over UDP (500/4500), OpenVPN over either.

### GRE — the simplest tunnel

**Generic Routing Encapsulation** is Cisco's protocol-agnostic tunneling protocol. Protocol number 47. It wraps any payload (IPv4, IPv6, multicast, even non-IP) inside an IP packet and ships it. *No encryption.* It's a tunnel, not a secure tunnel.

You use GRE when you need to carry traffic that wouldn't otherwise route — like multicast across the internet, or IPv6 over an IPv4-only path. In practice, GRE is almost always combined with IPSec (**GRE over IPSec**) to add the encryption GRE lacks.

### IPSec — the heavy hitter

**Internet Protocol Security** is a suite, not a single protocol. It provides authentication, integrity, and (optionally) encryption at Layer 3, meaning every protocol above it gets protected without modification. The exam wants you to know the components.

**Two modes:**
- **Transport mode** — only the payload is encrypted. Host-to-host. Original IP header stays visible.
- **Tunnel mode** — the entire original packet is encapsulated in a new IP packet. Gateway-to-gateway. What site-to-site VPNs use.

**Two protocols inside IPSec:**

| Protocol | What it does | Protocol # | Encryption? |
|----------|-------------|-----------|-------------|
| **AH (Authentication Header)** | Authentication + integrity of the whole packet | 51 | **No** |
| **ESP (Encapsulating Security Payload)** | Authentication + integrity + **encryption** of the payload | 50 | **Yes** |

> **CompTIA exam trap:** **AH does NOT encrypt. ESP does.** If a question asks "which IPSec protocol provides confidentiality?" — that's ESP, always. AH only guarantees the packet wasn't tampered with. Almost every modern IPSec deployment uses ESP because confidentiality is the point.

**AH + NAT don't get along.** AH authenticates the entire packet including the IP header, and NAT rewrites the IP header. NAT breaks AH. ESP in tunnel mode survives NAT, especially with **NAT-Traversal (NAT-T)** which wraps ESP in UDP 4500.

### IKE — the key exchange

**Internet Key Exchange** is how the two IPSec peers agree on encryption keys before any data flows. Without IKE, you'd have to manually configure pre-shared keys on every device. UDP **500** (and **4500** for NAT-T).

**Two phases:**

1. **IKE Phase 1** — establishes the **ISAKMP SA**, a secure channel for negotiating the real keys. Uses Diffie-Hellman. Authenticates peers (PSK or certificates). Two modes: **Main mode** (6 messages, secure) or **Aggressive mode** (3 messages, faster, leaks identity).
2. **IKE Phase 2** — establishes the **IPSec SA**, the keys that actually encrypt traffic. Faster, runs inside the Phase 1 channel. Negotiates whether to use AH or ESP, encryption ciphers, etc.

**IKEv2** is the modern version — fewer messages, built-in NAT-T, mobile-friendly (MOBIKE allows roaming between networks without dropping the tunnel). *If you're building a VPN today and the options are IKEv1 or IKEv2, the answer is IKEv2.*

### Traffic types — how packets find recipients

| Type | Pattern | Real-world |
|------|---------|------------|
| **Unicast** | One-to-one | Your laptop to one server. 99% of traffic. |
| **Broadcast** | One-to-all (on segment) | ARP requests, DHCP DISCOVER. IPv4 only. **IPv6 has no broadcast.** |
| **Multicast** | One-to-many (subscribers) | Streaming video, OSPF hello packets, IPTV. 224.0.0.0/4 in v4, ff00::/8 in v6. |
| **Anycast** | One-to-nearest | Same IP advertised from many locations; routing picks the closest. DNS root servers, CDNs. |

> **CompTIA exam trap:** **IPv6 has no broadcast.** It uses multicast instead. If a question lists "broadcast" as an IPv6 traffic type, it's wrong. IPv6 replaces broadcast with multicast groups like the all-nodes group (ff02::1).

Anycast is the one that throws people. Same IP, multiple physical servers, BGP advertises the route from each location, and the network sends your packet to whichever is closest. *Google's 8.8.8.8 is not one server — it's anycast across dozens of data centers, and the "nearest" one answers your DNS query.*

### The protocols that ride remote access

| Protocol | Port | Purpose | Notes |
|----------|------|---------|-------|
| **SSH** | 22/TCP | Encrypted shell, secure tunneling | Replaces Telnet for everything |
| **Telnet** | 23/TCP | Cleartext shell | **Never use over untrusted networks.** Cleartext passwords. |
| **RDP** | 3389/TCP | Windows graphical remote desktop | Heavily attacked — never expose to the internet without VPN/jump host. |
| **SFTP** | 22/TCP | File transfer over SSH | Same port as SSH because it *is* SSH. |
| **HTTPS** | 443/TCP | TLS-encrypted web | Foundation of clientless VPN portals, SASE. |
| **SIP** | 5060/5061 | VoIP signaling | 5060 cleartext, 5061 TLS. |
| **L2TP** | 1701/UDP | Tunneling, always paired with IPSec | L2TP alone has no encryption. |

> **CompTIA exam trap:** **SFTP is not FTPS.** SFTP runs over SSH (port 22). FTPS is FTP wrapped in TLS (ports 989/990). Different protocols, different ports, different mechanisms. CompTIA loves this swap.

### CompTIA exam traps

> **Trap:** GRE provides **no encryption**. If a question asks "which tunneling protocol provides confidentiality?", the answer is IPSec (or GRE-over-IPSec), never GRE alone.

> **Trap:** IKE uses **UDP 500**, and **UDP 4500 for NAT-T**. If a VPN tunnel works on the LAN but fails from behind a hotel NAT, suspect NAT-T (4500) being blocked.

> **Trap:** Tunnel mode encrypts the entire original packet including the original IP header. Transport mode leaves the original IP header visible. Site-to-site VPN = tunnel mode. Host-to-host = transport mode.

## Helpdesk reality

- User says *"the VPN won't connect from the hotel."* Check whether the hotel is blocking UDP 500/4500. Many hotels and coffee shops block IPSec wholesale — failover to SSL VPN over 443 if you have it.
- User says *"my RDP keeps dropping."* First, never expose RDP to the internet. Second, check MTU — large frames over a tunnel can fragment and cause sessions to die mid-screen-redraw. *Lowering the tunnel MTU to ~1400 fixes more RDP issues than any vendor admits.*
- User says *"I can ping the server but I can't connect."* Layer 3 works, Layer 4 doesn't. Check the firewall, check the service is listening (`netstat`, `ss`), check the port.
- User says *"the VPN is slow."* Verify the user is hitting the right concentrator. Split tunneling matters — if every Netflix packet is being routed through corporate, of course it's slow.
- Never promise an SLA on home internet. The tunnel is only as reliable as the worst hop, and the user's ISP is not your problem to fix.

## Related concepts

[[VPN]] · [[IPSec]] · [[SSH]] · [[RDP]] · [[Tunneling]] · [[NAT]] · [[NAT Traversal]] · [[TCP-vs-UDP]] · [[ICMP]] · [[Ping]] · [[Traceroute]] · [[IPv4]] · [[IPv6]] · [[Multicast]] · [[Anycast]] · [[Broadcast]] · [[GRE]] · [[IKE]] · [[Authentication-Header]] · [[ESP]] · [[Split-Tunneling]] · [[SASE]] · [[Zero-Trust]]

*Source: VIRGIL knowledge base — 2026-05-11*