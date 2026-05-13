# ARP And DNS Poisoning

## What it is

In **Halo 2** multiplayer on Xbox Live, there was a notorious exploit called the "standby button" — a host with a dual-router setup could press a button that froze packets in flight while their game kept running. Everyone else lag-warped while the host walked behind them with a sword. The trick wasn't beating you. The trick was sitting between you and the network and deciding which packets the server believed. That's exactly what **ARP poisoning** and **DNS poisoning** do — they don't break the network, they sit in the middle of it and lie about who's who.

In plain English: ARP poisoning lies about MAC addresses on the local segment so traffic flows through the attacker. DNS poisoning lies about which IP a hostname resolves to so the victim connects to the wrong server. Both are **on-path attacks** (the modern term for man-in-the-middle).

Technical definition: **ARP poisoning** (or **ARP spoofing**) is the broadcasting of forged Address Resolution Protocol replies on a local broadcast domain, causing victim hosts to bind a legitimate IP address to the attacker's MAC in their ARP cache. **DNS poisoning** (or **DNS spoofing**) is the injection of fraudulent records into a DNS resolver's cache or response stream, causing the victim to receive an attacker-controlled IP for a legitimate hostname.

## Why it matters

Objective N10-009 4.2 lists DNS poisoning, ARP spoofing, and on-path attacks as core attack types. CompTIA will test you on which layer the attack lives at, what protocol it abuses, and what defense stops it.

Career stakes: these are bread-and-butter attacks on any flat layer-2 network and any environment with a misconfigured DNS resolver. Coffee-shop Wi-Fi, conference networks, poorly segmented corporate LANs, hotel networks — all hunting grounds. Understand these two attacks deeply and you understand the whole on-path family, because the pattern is the same: corrupt a trust-by-default protocol and watch the traffic walk into your lap.

## Key facts

### Address Resolution Protocol — the trust-by-default problem

**ARP** operates at Layer 2. Its job: given an IP on the local subnet, find the MAC that owns it.

1. Host A wants to talk to 192.168.1.1 (the gateway).
2. Host A broadcasts: *"Who has 192.168.1.1? Tell me."*
3. The gateway replies unicast: *"192.168.1.1 is at AA:BB:CC:DD:EE:FF."*
4. Host A caches that binding and sends frames.

The fatal flaw: **ARP has no authentication.** Any host can send a reply at any time — even without being asked. These are **gratuitous ARP** replies, and the receiving host will happily overwrite its cache. ARP was designed in 1982 for a world where every device on the wire was trusted. That world is gone. The protocol stayed.

### ARP poisoning mechanics

The attacker on the same broadcast domain blasts forged ARP replies:

- To the victim: *"The gateway (192.168.1.1) is at MY MAC."*
- To the gateway: *"The victim (192.168.1.50) is at MY MAC."*

Now every packet between victim and gateway flows through the attacker. The attacker forwards it on so the connection doesn't break, but reads, modifies, or logs everything in between. Tools: `arpspoof`, `ettercap`, `bettercap`. Thirty seconds to set up on an unhardened network.

Once on-path the attacker can:
- Strip TLS on misconfigured sites (SSLstrip-style downgrades)
- Inject content into unencrypted HTTP
- Capture credentials in cleartext protocols (FTP, Telnet, HTTP basic, SMTP without STARTTLS)
- Steal session cookies
- Pivot into [[DNS poisoning]] by answering DNS queries before the real resolver does

*The attacker doesn't need to break encryption. They just need to be the path. Most "secure" traffic is only secure if the endpoints actually verified each other — and most users click through cert warnings.*

### ARP poisoning defenses

| Defense | What it does | Layer |
|---|---|---|
| **Dynamic ARP Inspection (DAI)** | Switch validates ARP replies against a DHCP snooping binding table; drops forgeries | L2 switch |
| **DHCP snooping** | Switch tracks legitimate DHCP leases per port; required by DAI | L2 switch |
| **Static ARP entries** | Hard-code critical bindings (gateway MAC) on endpoints | Endpoint |
| **Port security** | Limit MACs per switch port | L2 switch |
| **802.1X** | Authenticate the device before it gets a port at all | L2 |
| **Network segmentation** | Smaller [[VLAN]]s mean fewer hosts per broadcast domain | L2/L3 |
| **Encrypted protocols** | TLS, SSH, IPsec — content is opaque even if intercepted | L4-L7 |

The single most effective enterprise control is **DAI plus DHCP snooping** on access switches. That combination kills ARP poisoning at the port.

### DNS poisoning mechanics

DNS resolves hostnames to IPs. The attacker's goal: make `bank.com` resolve to an IP they control. Three main flavors:

**1. On-path DNS spoofing.** The attacker is already on the path (often via ARP poisoning first). When the victim sends a DNS query, the attacker races the real resolver and answers first with a forged record. UDP/53 is connectionless — first response wins.

**2. Cache poisoning.** The attacker injects forged records into a recursive resolver's cache. Classic Kaminsky attack (2008): flood the resolver with forged responses guessing the transaction ID for a query the attacker triggered. Once cached, every downstream client gets the poisoned record until TTL expires. Modern mitigation: source-port randomization, DNSSEC.

**3. Rogue resolver.** Push victims onto an attacker-controlled DNS server via [[DHCP]] (rogue DHCP hands out the attacker's IP as the resolver) or via malware editing `/etc/resolv.conf` or Windows DNS settings.

### DNS poisoning defenses

| Defense | What it does |
|---|---|
| **DNSSEC** | Cryptographically signs DNS records; resolvers verify and reject forgeries |
| **DNS over HTTPS (DoH) / DNS over TLS (DoT)** | Encrypts queries to a trusted resolver — attacker can't see or modify |
| **Source port randomization** | Makes blind cache poisoning computationally infeasible |
| **Locked-down resolvers** | Internal-only recursive resolvers, not open to the internet |
| **DHCP snooping** | Stops rogue DHCP from pushing a malicious resolver address |
| **HSTS** | Browser refuses HTTP fallback for known sites, limiting redirect damage |

*DNSSEC is the right answer on the exam. In the real world adoption is patchy and most clients don't validate. DoH/DoT covers more cases in practice.*

### The family resemblance — on-path attacks

CompTIA dropped "man-in-the-middle" in favor of "on-path" in N10-009 — same attack, less loaded term. The pattern is universal:

1. Insert yourself into the conversation
2. Corrupt the protocol that decides who's who
3. Relay traffic so nobody notices
4. Read, modify, or redirect at will

Related on-path techniques: **evil twin** [[AP]] (fake Wi-Fi with the same SSID), **rogue DHCP** server (hands out attacker as gateway/DNS), **BGP hijacking** (L3, internet-scale), rogue devices plugged into open ports.

### CompTIA exam traps

> **CompTIA exam trap:** ARP operates at **Layer 2**, but it resolves a **Layer 3** address (IP) to a **Layer 2** address (MAC). CompTIA will ask which layer ARP lives at — the answer is L2.

> **CompTIA exam trap:** **DNS spoofing** and **DNS poisoning** are often used interchangeably, but technically *spoofing* is the act of sending a forged response and *poisoning* is the state of having that forged data persist in a cache. If both appear as choices, read the stem — if it mentions "cached" or "subsequent queries," pick poisoning.

> **CompTIA exam trap:** The defense for ARP poisoning is **Dynamic ARP Inspection (DAI)** — not port security alone, not 802.1X alone. Port security limits MAC counts per port; it doesn't validate ARP message contents. DAI does.

> **CompTIA exam trap:** DNSSEC provides **integrity and authentication** of DNS records. It does **not** encrypt DNS traffic. If the question asks about confidentiality of DNS queries, the answer is **DoH** or **DoT**, not DNSSEC.

> **CompTIA exam trap:** An **on-path attack** is the umbrella. ARP spoofing, DNS spoofing, evil twin, and rogue DHCP are all **methods** of achieving an on-path position. If the question describes "intercepted and modified traffic between two hosts," the category is on-path; the specific technique depends on the protocol abused.

### How the attacks chain in real life

A common chain on public Wi-Fi:

1. Attacker connects to the same Wi-Fi as the victim.
2. ARP poison the victim and the gateway — now on-path at L2.
3. Intercept DNS queries and answer with forged IPs.
4. Victim's browser hits the attacker's web server thinking it's the real site.
5. Attacker presents a self-signed cert or a strip-to-HTTP downgrade.
6. Victim clicks through the warning. Credentials captured.

Defenses stack: WPA3 client isolation kills step 1, [[VLAN]] segmentation limits step 2, DNSSEC/DoH break step 3, HSTS preload breaks step 5, user training reduces step 6. *A firewall is not an IDS, a VPN is not zero trust, and TLS is not protection if the user clicks through the warning.*

## Helpdesk reality

- User says: *"My browser keeps warning me about the certificate on every site at the coffee shop."* That's not a browser bug — that's the browser doing its job. Someone on that Wi-Fi is running an on-path attack, or the captive portal is misconfigured. Tell the user to disconnect and use cell data.
- User says: *"I'm being sent to a weird login page for my bank."* Check DNS settings on their machine — malware loves to rewrite `/etc/resolv.conf` or the Windows resolver. Run `ipconfig /all` and confirm DNS is what corporate hands out, not 8.8.8.8 or worse.
- Never promise: *"Public Wi-Fi is safe if you use a VPN."* A VPN protects the tunnel. It doesn't protect a user who clicked through a cert warning before the VPN came up, or whose DNS leaks outside the tunnel. Better, not bulletproof.
- The escalation: ARP cache entries with duplicate MACs on critical IPs (gateway showing two MACs in short succession) is not a glitch — it's an active on-path attack. Pull the user off the network and ticket it to security immediately.
- For DNS oddness across multiple users: check the DHCP scope. A **rogue DHCP server** handing out a malicious resolver will hit every device that renews its lease.

## Related concepts

[[ARP]] · [[DNS]] · [[On-path attack]] · [[Evil twin AP]] · [[Rogue DHCP]] · [[DNSSEC]] · [[DNS over HTTPS DoH]] · [[Dynamic ARP Inspection DAI]] · [[DHCP snooping]] · [[Port security]] · [[802.1X]] · [[VLAN hopping]] · [[MAC flooding]] · [[Social engineering]] · [[Phishing]] · [[Rogue devices]]

*Source: VIRGIL knowledge base — 2026-05-11*