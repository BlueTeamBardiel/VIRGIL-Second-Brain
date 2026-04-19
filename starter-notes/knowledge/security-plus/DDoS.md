---
domain: "network-security"
tags: [ddos, denial-of-service, network-attack, availability, botnet, amplification]
---
# DDoS

A **Distributed Denial-of-Service (DDoS)** attack is a coordinated attempt to exhaust a target's network, compute, or application resources by directing traffic from many compromised or complicit sources simultaneously, rendering the service unavailable to legitimate users. DDoS attacks target the **Availability** pillar of the [[CIA Triad]] and are typically launched from [[Botnet|botnets]], [[Reflection Attack|reflectors]], or rented "booter/stresser" services, making them distinct from single-source [[DoS|Denial-of-Service]] attacks because the distributed nature defeats simple IP-based blocking. The defining challenge of DDoS is that the attack traffic is structurally indistinguishable from a sudden surge of legitimate demand — it arrives on valid protocols, at valid ports, from globally dispersed sources.

---

## Overview

DDoS attacks evolved from simple **DoS** attacks in the late 1990s when attackers realized that a single source could be throttled or filtered, but thousands of sources at once could not. The first widely publicized DDoS campaign — against Yahoo, eBay, CNN, and Amazon in February 2000, orchestrated by a Canadian teenager known as "Mafiaboy" using a tool called Stacheldraht — demonstrated that the commercial internet had no built-in defense against coordinated flooding. Since then, DDoS has matured into a commodity threat, with **stresser/booter** services selling attacks for a few dollars per hour and nation-state actors using DDoS as both a standalone weapon and as cover for data-theft operations.

The underlying reason DDoS works is structural: the internet's end-to-end design gives any host the ability to send packets to any other host, and bandwidth, connection state, and CPU are finite at the victim. Asymmetry fundamentally favors the attacker — a reflected and amplified request of 60 bytes can trigger a 60,000-byte response directed at the victim, meaning the attacker need not possess bandwidth equal to the flood they generate. This is why even small botnets, or a handful of misconfigured public servers, can overwhelm well-provisioned targets.

DDoS attacks are classified into three broad categories. **Volumetric attacks** — UDP floods, ICMP floods, DNS/NTP/Memcached amplification — saturate the victim's internet uplink and are measured in bits per second (bps). **Protocol/state-exhaustion attacks** — SYN floods, ACK floods, Ping of Death, fragmented-packet attacks — exhaust finite data structures in firewalls, load balancers, and OS kernels, measured in packets per second (pps). **Application-layer (Layer 7) attacks** — HTTP floods, Slowloris, cache-busting GET storms — mimic legitimate requests to consume backend CPU, database connections, or application threads, measured in requests per second (rps). Each tier requires a fundamentally different mitigation strategy, and sophisticated attack campaigns often chain all three simultaneously.

Notable real-world incidents illustrate the scale and consequence of modern DDoS. The **Mirai botnet** attack on DNS provider **Dyn in October 2016** — peaking at approximately 1.2 Tbps — took down Twitter, Netflix, Reddit, and Spotify for hours by hijacking IoT cameras and DVRs via default credentials. **GitHub suffered 1.35 Tbps in February 2018** from Memcached amplification with an amplification factor up to 51,000×. **AWS reported mitigating a 2.3 Tbps CLDAP reflection attack in February 2020**. In October 2023, the **HTTP/2 Rapid Reset vulnerability (CVE-2023-44487)** enabled attack peaks above 398 million requests per second, the largest Layer 7 attacks ever recorded, simultaneously affecting Cloudflare, Google, and AWS.

Motivations span the entire threat-actor spectrum: extortion (**Ransom DDoS / RDoS**), hacktivism (groups such as Anonymous and Killnet), competitive sabotage in gaming and e-commerce, state-sponsored political disruption (Estonia 2007, Georgia 2008, Ukraine ongoing since 2014), and **smokescreen operations** where the DDoS distracts a Security Operations Center while intruders silently exfiltrate data via a separate intrusion. Understanding motivation matters for threat modeling — a hacktivist group targets reputation; an RDoS actor targets business continuity; a nation-state actor may be concealing a second-stage operation entirely.

---

## How It Works

A DDoS attack has three logical components: the **attacker/operator**, the **attack infrastructure** (botnet nodes, open reflectors, or booter APIs), and the **target** (an IP address, DNS name, URL, or subnet). Execution follows a consistent pattern regardless of which specific vector is deployed.

### 1. Recruitment and C2 Establishment

The attacker builds or rents attack capacity. A botnet is assembled by exploiting vulnerable devices — unpatched SSH/Telnet with default credentials (Mirai scanned TCP/23 and TCP/2323 exclusively), vulnerable router firmware (Mozi), exposed Docker APIs, or compromised web servers. Bots contact a **Command-and-Control (C2)** channel — IRC historically, now HTTPS callbacks, DNS-over-HTTPS, Tor hidden services, or peer-to-peer protocols that make takedown harder.

### 2. Target Acquisition and Command Issuance

The operator issues a command specifying target IP, port, URL, attack vector, duration, and thread concurrency. A Mirai-style C2 command might look like:

```
!* udpflood 203.0.113.10 80 120 32
```

This instructs every active bot to UDP-flood `203.0.113.10:80` for 120 seconds using 32 concurrent threads per node.

### 3. Attack Delivery by Vector

**SYN Flood (TCP, Layer 4)**
Bots send TCP SYN packets with spoofed source IPs. The target allocates a Transmission Control Block (TCB) per SYN and responds with SYN-ACK, waiting for the final ACK that never arrives. The half-open connection table fills, preventing legitimate connections from completing the three-way handshake. Virtually every OS imposes a hard limit on this table.

```bash
# Lab-only — run ONLY against your own isolated VM
sudo hping3 -S -p 80 --flood --rand-source 192.168.56.20
```

Monitor on the victim:

```bash
watch -n1 'ss -ant | grep SYN-RECV | wc -l'
```

**UDP Amplification (Layer 3/4)**
The attacker spoofs the victim's IP address and queries open third-party reflectors. Because UDP has no handshake, the reflector has no way to verify the source. The reflector, trying to answer the "requester," directs its response — often many times larger than the query — at the victim. Key amplification factors:

| Protocol | Port | Approx. BAF |
|---|---|---|
| Memcached | UDP/11211 | ~51,000× |
| NTP monlist | UDP/123 | ~556× |
| DNS ANY | UDP/53 | ~54× |
| CLDAP | UDP/389 | ~56× |
| SSDP | UDP/1900 | ~30× |

```bash
# Example: DNS ANY query — when the source is spoofed, this reply floods the victim
dig ANY isc.org @8.8.8.8 +edns=0 +dnssec
```

**HTTP Flood (Layer 7)**
Bots generate genuine, valid HTTP GET or POST requests, often randomizing URLs, query strings, and User-Agent headers to bypass signature-based detection. These requests reach application servers, trigger database queries, and consume worker threads — all at a "legitimate" request volume that no simple packet filter can distinguish from real traffic.

**Slowloris (Layer 7, connection exhaustion)**
Slowloris opens a maximum number of TCP connections to the target web server and sends partial HTTP request headers at intervals just fast enough to keep each connection alive, but never completing the request. Servers with a finite number of worker threads — particularly Apache with a static `MaxClients` — exhaust their connection pool and deny service to legitimate users while the attacking client uses almost no bandwidth.

**HTTP/2 Rapid Reset (CVE-2023-44487)**
The attacker opens an HTTP/2 stream and immediately sends a `RST_STREAM` frame, aborting it before the server completes processing. Because HTTP/2 allows many concurrent streams on one TCP connection, this cycle can repeat tens of thousands of times per second per connection, generating server-side work with near-zero attacker-side cost. Servers that account for streams opened but not streams cancelled accumulate unbounded queue depth.

### 4. Effect on the Target

At the victim, one or more resource ceilings are hit: the internet uplink saturates causing ISP-level congestion upstream, the stateful firewall or load balancer runs out of connection slots, the web server's worker pool is exhausted, or the database connection pool blocks all application threads. Legitimate users observe timeouts, HTTP 503 errors, ICMP unreachable responses, or complete packet loss.

### 5. Attribution Evasion

Source IPs in volumetric attacks are almost always spoofed. Traffic in botnet attacks originates from legitimate residential and corporate IP addresses of unwitting victims. This is why [[BCP38]] (RFC 2827), which mandates that ISPs drop packets from their customers bearing source IPs not assigned to those customers, is considered the most impactful single mitigation against amplification attacks — and why its widespread non-adoption remains a root cause of the global DDoS problem.

---

## Key Concepts

- **Botnet:** A network of compromised hosts (PCs, servers, IoT devices) under a centralized or distributed attacker C2, used to generate traffic at a scale no single host can achieve. See [[Botnet]] and [[Mirai]].
- **Amplification Factor (BAF — Bandwidth Amplification Factor):** The ratio of response size to request size in a reflection attack. Memcached's BAF of ~51,000 means a 200-byte request packet can generate ~10 MB of traffic directed at the victim — allowing a 1 Gbps attack source to produce ~50 Tbps of victim-side impact.
- **Reflection:** Sending a spoofed-source request to a legitimate third-party server so it unknowingly directs the reply at the victim. Reflection does not require compromising the reflector — only that it responds to UDP requests from arbitrary sources without validation.
- **Volumetric / Protocol / Application Taxonomy:** Measured in bps, pps, and rps respectively. Each tier targets a different finite resource — uplink pipe, stateful session table, or application-logic capacity — and each requires distinct countermeasures deployed at different network layers.
- **Scrubbing Center:** A high-capacity, geographically distributed provider (Cloudflare, Akamai Prolexic, AWS Shield Advanced, Radware, NETSCOUT Arbor) that ingests all of the victim's traffic during an attack via BGP re-announcement, filters malicious packets using flow analysis and behavioral heuristics, and forwards clean traffic to the origin via GRE tunnel or direct interconnect.
- **Anycast:** The practice of announcing the same IP prefix from many geographic PoPs simultaneously, so attack traffic is absorbed and scrubbed at the nearest point of presence rather than at a single datacenter. Foundational to how Cloudflare and Google Public DNS survive Tbps-scale events.
- **Ransom DDoS (RDoS):** An extortion model in which the attacker demands cryptocurrency payment to stop or forestall an attack, often preceded by a short "demonstration" flood. Active groups include DD4BC, Armada Collective, and Fancy Lazarus.
- **Booter / Stresser:** A web-based DDoS-for-hire service marketed as a "network stress testing" tool. Operating, selling, or purchasing attacks from such services is illegal under the US Computer Fraud and Abuse Act (CFAA), UK Computer Misuse Act, and equivalent legislation globally. The FBI's Operation PowerOFF has seized dozens of these platforms since 2018.
- **BCP38 / Source Address Validation:** RFC 2827 best practice where ISPs and network operators drop outbound packets with source IP addresses not belonging to their assigned space, eliminating IP spoofing at the origin and making UDP amplification attacks structurally impossible from compliant networks.
- **Remotely Triggered Black Hole (RTBH):** A BGP-based emergency mitigation where the victim or their ISP announces the targeted IP with a community attribute that causes upstream routers to route all traffic destined for that IP to `null0`, sacrificing availability of the targeted host to protect the surrounding infrastructure.

---

## Exam Relevance

**SY0-701 objectives directly addressed:** 2.4 (Indicators of malicious activity — resource consumption, service disruption), 3.2 (Secure network architecture — load balancers, proxies, CDNs), 4.5 (Mitigation techniques).

- **DDoS always attacks Availability.** The CIA Triad is heavily tested; expect at least one question where three distractors map to Confidentiality or Integrity. DDoS = Availability. Memorize it unconditionally.
- **DoS vs. DDoS distinction is a guaranteed question pattern.** DoS = single source, single IP to block. DDoS = distributed sources, IP blocking is ineffective. The question will present a scenario and ask you to name the attack type.
- **Amplification vs. Reflection — know both terms and their relationship.** Reflection uses a third-party server to bounce traffic at the victim. Amplification is reflection where the response is larger than the request. All amplification attacks are reflection attacks; not all reflection attacks are amplification. The exam tests this nuance.
- **Named historical attacks you must recognize:** Smurf (ICMP broadcast amplification — classic/historical), Fraggle (UDP variant of Smurf), SYN flood, Ping of Death (oversized IP fragment reassembly crash), Teardrop (overlapping IP fragments), Slowloris (HTTP partial headers). Expect a scenario description and a fill-in-the-name.
- **Mitigation vocabulary the exam rewards:** rate limiting, load balancer, CDN, anti-DDoS scrubbing service, flood guard, upstream filtering, anycast, RTBH/blackholing, SYN cookies.
- **Gotcha — DNS amplification uses UDP/53, not TCP/53.** TCP is used for DNS zone transfers and large responses (>512 bytes without EDNS). Amplification exploits the stateless, spoofable nature of UDP. Exam distractors frequently swap this.
- **Gotcha — on-premise firewalls do NOT stop volumetric DDoS.** The upstream internet pipe saturates before traffic even reaches your firewall. This is a conceptual trap; mitigation must occur at the ISP, transit provider, or scrubbing center level.
- **Emerging angle — OT/ICS.** The exam increasingly tests that DDoS against Industrial Control Systems or SCADA can have physical safety consequences, not just availability consequences. A flooded HMI in a power plant is not equivalent to a flooded e-commerce site.

---

## Security Implications

**Key CVEs and Incidents**

- **CVE-2023-44487 (HTTP/2 Rapid Reset, October 2023):** Affected nginx, Apache httpd, Envoy, Go `net/http`, Node.js, F5 BIG-IP, and virtually every HTTP/2 implementation. Enabled 398 million rps peaks — orders of magnitude above all prior records. Mitigation: patch to vendor-fixed versions immediately; disable HTTP/2 temporarily on unpatched infrastructure; deploy WAF rules blocking RST_STREAM abuse patterns.
- **CVE-2018-1000115 (Memcached UDP, 2018):** The Memcached UDP listener was enabled by default, allowing the 1.35 Tbps GitHub attack. Fixed in Memcached 1.5.6 by disabling UDP by default. Any deployment prior to that version with UDP/11211 reachable is a live reflector.
- **Mirai (2016 — no CVE, exploited default credentials):** Source code was publicly released, spawning dozens of descendants (Satori, Okiru, Masuta, Mozi, Meris) that continue driving IoT-based DDoS. The attack on Dyn proved that targeting a shared DNS provider creates cascading outages for thousands of downstream services.
- **Meris