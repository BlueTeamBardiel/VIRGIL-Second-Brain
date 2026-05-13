# DDoS — Distributed Denial of Service

## What it is

In **Overwatch**, watch what happens when the entire enemy team focus-fires the tank holding the choke. Reinhardt's shield has 1,200 HP. Six players dumping damage at once burn it in under three seconds. The shield drops, the team behind it scatters, the point flips. That's not one player being good — it's coordinated load that no single defender was built to absorb. That's exactly what a DDoS does — many sources flood one target until its capacity to serve legitimate traffic collapses.

**Plain English:** a flood of garbage traffic from thousands of machines, aimed at one service, until that service can't respond to real users anymore.

**Technical definition:** a **Distributed Denial of Service** attack is a coordinated effort from multiple distributed sources — typically a botnet of compromised hosts, IoT devices, or rented attacker infrastructure — to exhaust a target's bandwidth, compute, memory, or session state, denying availability to legitimate users. DDoS is an attack on the **Availability** leg of the CIA triad. It does not steal data. It does not change data. It makes the service unreachable.

## Why it matters

Availability is the leg of CIA the business notices first. Confidentiality breaches go public weeks later in a press release. Integrity issues get caught by audit. A DDoS takes the storefront down in real time, the CEO's phone lights up, and someone has to give an ETA. Public-facing web apps, DNS, VPN concentrators, and authentication endpoints are the usual targets. Ransom DDoS (RDDoS) — pay or the flood continues — has been a steady extortion playbook since 2020.

For the exam, DDoS sits squarely in **Objective 1.2 — analyze indicators of potentially malicious activity**, specifically *unusual traffic spikes*, *bandwidth consumption*, *service interruption*, and *activity on unexpected ports*. CompTIA also wants you to recognize when your own host is **participating** in a DDoS — outbound floods, beaconing to C2, unexpected outbound on weird ports — because that's a compromised-asset problem, not a victim problem.

## Key facts

### The three attack categories

CompTIA expects you to distinguish these by what they exhaust.

| Category | What it exhausts | Examples | OSI layer |
|---|---|---|---|
| **Volumetric** | Bandwidth (pipe size, measured in Gbps/Tbps) | UDP flood, ICMP flood, amplification/reflection | L3/L4 |
| **Protocol** | Connection state tables, firewalls, load balancers | SYN flood, ACK flood, Ping of Death, fragmented packets | L3/L4 |
| **Application** | App server CPU, memory, DB connections | HTTP/S GET/POST flood, Slowloris, DNS query flood | L7 |

Volumetric is the loudest and most-reported. Application-layer is the quietest and hardest to filter — the traffic looks like real users hitting real endpoints, just at impossible rates from too many sources.

### Amplification & reflection — the force multiplier

This is the technique behind most record-setting attacks. The attacker spoofs the victim's IP as the source, sends a small query to a misconfigured public service, and that service replies to the victim with a much larger response. Multiply by thousands of reflectors and you get a small attacker pipe generating a massive flood at the target.

| Protocol / port | Amplification factor | Notes |
|---|---|---|
| **DNS** (UDP/53) | ~28–54x | Open resolvers are the classic source |
| **NTP** (UDP/123) | up to ~556x | `monlist` command, mostly patched now |
| **memcached** (UDP/11211) | up to ~51,000x | Drove the 1.35 Tbps GitHub attack (2018) |
| **SSDP** (UDP/1900) | ~30x | UPnP devices, consumer routers |
| **CLDAP** (UDP/389) | ~56–70x | Exposed Active Directory |
| **SNMP** (UDP/161) | ~6x | Network gear with default community strings |

> **CompTIA exam trap:** amplification works because of **UDP's connectionless nature** — no handshake means the source IP isn't validated, so spoofing is trivial. TCP-based amplification exists but is rare. If the question describes a spoofed-source flood with a small request and large reply, the answer is volumetric/amplification, and the underlying protocol is almost always UDP.

### SYN flood — the protocol-layer classic

The attacker sends a flood of TCP SYN packets, often with spoofed source IPs. The server allocates a half-open connection in its state table and sends SYN-ACK. The ACK never comes back. The state table fills, legitimate connections get refused. Defense: **SYN cookies** (don't allocate state until the ACK arrives), connection rate limiting at the edge.

### Application-layer floods — the sneaky ones

- **HTTP GET flood** — thousands of bots hit `/login` or `/search?q=` at high rate. Each request looks legitimate. Traffic volume may be modest in Gbps but lethal in requests-per-second.
- **HTTP POST flood** — worse than GET because POSTs typically hit the database.
- **Slowloris** — the opposite of a flood. Open many connections, send headers one byte at a time, never finish the request. The web server holds connections open until its worker pool is exhausted. Defeats volumetric detection because traffic volume is near zero.

### Indicators in the SIEM

What the analyst actually sees, mapped to the [[Objective 1.2]] indicator vocabulary:

- **Unusual traffic spikes / bandwidth consumption** — NetFlow shows ingress to the perimeter jumping from baseline 800 Mbps to 40 Gbps in 90 seconds
- **Service interruption** — synthetic monitoring (Pingdom, internal health checks) fails for the public web tier
- **Activity on unexpected ports** — inbound UDP/11211 (memcached) to your web servers, which should never receive memcached traffic
- **Unexpected outbound / beaconing** — if you're the *source*, you see outbound UDP floods or HTTP requests to a third party at impossible rates. That's a compromised host in your environment participating in someone else's DDoS.
- **Processor / memory consumption** on the target host — app servers pegged at 100% CPU, connection pools exhausted, OOM kills in the kernel log
- **Application logs** — web server access logs flooded with identical or near-identical requests from thousands of source IPs, often missing or spoofed User-Agent strings
- **Rogue devices on the network** — IoT devices (cameras, printers) you didn't know were exposed are being recruited into botnets like Mirai

### Botnets — where the traffic actually comes from

Most DDoS volume comes from botnets — networks of compromised hosts under a single C2. Mirai (2016) recruited IoT devices with default credentials and generated the 1.2 Tbps Dyn attack that took down Twitter, Netflix, and Reddit. Modern botnets rent themselves out as **booter/stresser services** — a teenager with $50 can buy a 100 Gbps attack on a Discord rival.

If your host is part of a botnet, you'll see:
- **Beaconing** — periodic outbound to a C2 IP on an unusual port, even when no user is active
- **Unexpected outbound** to ports like UDP/53, UDP/123, UDP/11211 in volumes that don't match the host's role
- **Abnormal OS process behavior** — processes you don't recognize, often with random names, sometimes masquerading as svchost or kthreadd
- **Unauthorized scheduled tasks** or cron entries maintaining persistence

### Mitigations the analyst will actually recommend

| Control | What it does | Where it lives |
|---|---|---|
| **Anycast / CDN** (Cloudflare, Akamai, AWS Shield, Azure Front Door) | Absorbs volumetric attacks across global edge | Internet edge |
| **Scrubbing service** | Reroutes traffic via BGP to a cleaning center during attack | Upstream of your ASN |
| **Rate limiting** | Caps requests/sec per source IP | WAF, load balancer, app server |
| **WAF rules** | Filters L7 attacks by signature or behavior | In front of app tier |
| **SYN cookies** | Defeats SYN floods without state allocation | Host kernel / firewall |
| **Blackhole / null route** | Drop all traffic to victim IP — saves the rest of the network | ISP / edge router |
| **Geo-blocking** | Drop traffic from countries you don't serve | Edge / WAF |
| **BCP 38 (ingress filtering)** | Prevents your ASN from sourcing spoofed packets | ISP-level, not the victim's problem to fix |

> **CompTIA exam trap:** **blackholing** (RTBH — remotely-triggered black hole) saves the *network* by sacrificing the *target*. The victim service stays down, but every other service on the same uplink survives. CompTIA will frame this as a tradeoff question. The right answer depends on scope — if one service is being targeted and the rest of the business is at risk, you blackhole. If it's the only service that matters, you scrub.

### DDoS vs DoS

A single source attack is a **DoS**. Distributed = many sources = harder to filter by source IP. CompTIA tests the distinction. A logic bomb that crashes a server is DoS. A botnet of 50,000 IoT cameras flooding port 80 is DDoS.

> **CompTIA exam trap:** an attack is **DDoS** based on **source distribution**, not on traffic volume. A coordinated 100-host SYN flood at 50 Mbps is still DDoS. A single host pushing 5 Gbps is DoS. The "distributed" is about who's sending, not how much.

## SOC reality

- **The 3am alert:** synthetic monitoring fails, NetFlow dashboard goes vertical, the on-call's Slack lights up with "site is down" from three different VPs. L1 acknowledges, opens the runbook, validates it's not a deploy or a cert expiry first — *not every outage is an attack, and calling DDoS on a bad load-balancer config is how you lose credibility with the network team*.
- **First triage questions:** is the traffic actually anomalous (compare to baseline), is it volumetric or app-layer (Gbps vs requests/sec), is the source distribution global or concentrated, do we have scrubbing on retainer and is it engaged?
- **What the CISO asks:** "Are we down? What's our ETA? Is this extortion — did we get a ransom note? Is data also being exfiltrated, or is this just availability?" — DDoS is sometimes a **smokescreen** for data theft on a different vector, so the IR team checks egress logs even while mitigating the flood.
- **Never promise:** "we've blocked it." DDoS sources rotate. You've mitigated the current wave. The next wave may shift from L3 to L7 the moment you turn on volumetric filtering. *The attacker watches your mitigations adapt and adapts back — same as a tank swap mid-fight in Overwatch.*
- **Handoff:** L1 confirms the alert, L2 engages the scrubbing provider and tunes WAF rules, network team coordinates BGP changes with the ISP, IR lead manages comms with business and legal. If extortion is involved, legal and FBI/IC3 get looped in before any payment discussion — and the answer to payment is almost always no.

## Related concepts

[[Botnet]] · [[C2]] · [[Beaconing]] · [[Mirai]] · [[NetFlow]] · [[WAF]] · [[CDN]] · [[Anycast]] · [[BGP]] · [[SYN flood]] · [[Amplification attack]] · [[Reflection attack]] · [[CIA triad]] · [[Availability]] · [[Slowloris]] · [[Rate limiting]] · [[Blackhole routing]] · [[RDDoS]] · [[IoT security]] · [[Objective 1.2]]

*Source: VIRGIL knowledge base — 2026-05-11*