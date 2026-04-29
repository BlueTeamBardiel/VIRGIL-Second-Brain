```yaml
---
domain: "threats-attacks"
tags: [dos, ddos, network-attack, availability, denial-of-service, sy0-701]
---
```

# DoS

A **Denial-of-Service (DoS)** attack is a malicious attempt to make a computing resource, service, or network unavailable to its intended users by overwhelming it with traffic, exhausting its finite resources, or exploiting software flaws that cause crashes or hangs. DoS attacks primarily target the **availability** pillar of the [[CIA Triad]] and range from trivial single-packet exploits to massive distributed campaigns ([[DDoS]]) orchestrated across millions of compromised hosts in a [[Botnet]]. The attack category is foundational to cybersecurity because virtually every internet-facing system carries some level of DoS exposure by design.

---

## Overview

Denial-of-service is one of the oldest recognized categories of network attack, predating the commercial Internet. Early examples emerged in the 1990s as attackers discovered that TCP/IP stacks often assumed cooperative peers; malformed or excessive traffic could reliably crash or hang hosts. The 1996 *Panix* attack — a SYN flood against a New York ISP — is widely cited as the first high-profile DoS incident and directly motivated the standardization of SYN cookies. Since then, DoS has evolved from a nuisance into a strategic weapon used for extortion (ransom DoS, or **RDoS**), competitive sabotage, hacktivism, distraction during data theft, and nation-state coercion.

DoS exists because computing systems have finite resources — CPU cycles, memory, socket tables, bandwidth, database connections, concurrent thread pools — and protocols were historically designed to trust peers rather than defend against them. Any resource that is bounded and consumed by requests can theoretically be exhausted. Attackers exploit three broad weaknesses: (1) **asymmetry**, where a small attacker input forces a large victim response; (2) **statefulness**, where the victim must remember something about each request before the exchange completes; and (3) **protocol ambiguity**, where edge cases in RFCs are handled inconsistently across implementations.

The distinction between **DoS** and **DDoS** ([[Distributed Denial of Service]]) is source multiplicity. A classic DoS originates from a single host and is relatively easy to block by source IP. A DDoS uses hundreds to millions of sources — typically compromised IoT devices (e.g., the [[Mirai Botnet]]), residential routers, or hijacked cloud instances — making simple IP blocking infeasible. Modern **reflection/amplification** attacks (DNS, NTP, memcached, CLDAP) use spoofed source addresses to weaponize innocent third-party servers, combining distribution with response-size amplification that can exceed 50,000×.

Real-world context is sobering. The February 2018 GitHub attack peaked at **1.35 Tbps** using memcached reflection with amplification factors exceeding 50,000×. The October 2016 **Dyn** attack, leveraging Mirai-infected IoT devices, took down Twitter, Spotify, Netflix, and Reddit across much of the US East Coast by saturating a critical DNS provider. Cloudflare mitigated a **71 million request-per-second** HTTP/2 Rapid Reset attack (CVE-2023-44487) in 2023. These incidents demonstrate that DoS is now a bandwidth-and-economics problem as much as a purely technical one.

DoS is rarely used in isolation by sophisticated adversaries. It is often a **diversion** — keeping the SOC occupied while data exfiltration or lateral movement proceeds elsewhere — or a **coercion tool** paired with a ransom demand. Understanding DoS is therefore foundational for both blue team detection engineering and red team operational planning alike.

---

## How It Works

DoS attacks fall into three technical categories, each targeting a different layer of the stack.

### 1. Volumetric Attacks (Layer 3/4)

Volumetric attacks saturate the victim's network pipe. The goal is to consume more bandwidth than the victim's uplink can carry, so legitimate packets are dropped upstream at the ISP before ever reaching the target host. Common techniques include UDP floods, ICMP floods, and **amplification attacks** using DNS, NTP (`monlist` command), SSDP, memcached (UDP port 11211), and CLDAP. The amplification model works by exploiting the asymmetry between request size and response size over UDP:

```bash
# NTP monlist amplification — attacker spoofs victim's source IP
# A 234-byte request triggers up to 48 KB of response (~206× amplification factor)
ntpdc -n -c monlist <vulnerable_ntp_server>
```

The attacker sends a small request packet with the **victim's IP spoofed as the source address**; the vulnerable third-party server then replies to the victim with a much larger payload. Because UDP has no handshake, the server cannot verify the source. When scaled across thousands of reflectors, this creates a firehose the victim cannot absorb.

### 2. Protocol / State Exhaustion Attacks (Layer 3/4)

These attacks consume connection tables, firewall state tables, or load-balancer session entries rather than raw bandwidth. The archetype is the **SYN flood**, which exploits the three-way TCP handshake:

```
Attacker                            Victim
   | ---- SYN (spoofed src IP) ----> |  [allocates TCB entry, half-open]
   | <--- SYN-ACK ----------------- |  [victim retransmits up to 5× over ~180s]
   | (ACK never arrives)             |  [TCB entry held until timeout]
```

By sending millions of SYNs with randomized spoofed source addresses, the attacker fills the victim's **backlog queue** (the kernel's half-open connection table). Legitimate SYN packets are then refused with a RST or silently dropped. Mitigation: **SYN cookies** (RFC 4987), which encode the TCB state cryptographically into the TCP Initial Sequence Number so the server allocates no memory until the final ACK proves the client's IP is reachable.

```bash
# Enable SYN cookies on Linux
sysctl -w net.ipv4.tcp_syncookies=1

# Monitor half-open connections during an attack
ss -ant | grep SYN_RECV | wc -l
```

Other protocol attacks include:

- **Ping of Death** — oversized ICMP echo request (>65,535 bytes fragmented) caused stack overflows; patched but historically significant (CVE-1999-0128).
- **Teardrop** — overlapping IP fragment offsets confuse reassembly code, causing crashes.
- **Smurf** — ICMP echo to a broadcast address with victim's IP spoofed; every host on the subnet replies to the victim.
- **LAND** — TCP SYN with source IP = destination IP, causing some stacks to loop.
- **Christmas Tree (Xmas) Scan** — TCP packet with FIN, URG, and PSH flags all set; some stacks handle this poorly.

### 3. Application-Layer Attacks (Layer 7)

These attacks mimic legitimate HTTP/HTTPS or application-protocol requests but target computationally expensive backend operations — database queries, template rendering, cryptographic operations, file I/O — to exhaust CPU, threads, or memory rather than bandwidth.

**Slowloris** opens many concurrent HTTP connections and sends partial request headers indefinitely, tying up Apache worker threads that cannot time out:

```bash
# Slowloris: 500 concurrent "incomplete" HTTP connections
python3 slowloris.py 192.168.56.20 -p 80 -s 500 -v
# Each connection sends: "GET / HTTP/1.1\r\nHost: victim\r\n" then stalls
```

**R.U.D.Y. ("R U Dead Yet?")** sends a legitimate POST with a valid `Content-Length` header but delivers the body one byte every ~10 seconds, tying up threads for the declared content-length duration.

**HTTP floods** (GET or POST) hit URLs that trigger expensive operations:

```bash
# Siege HTTP GET flood (authorized lab use only)
siege -c 500 -t 60s http://192.168.56.20/search?q=expensive_query
```

**HTTP/2 Rapid Reset (CVE-2023-44487)** abuses the `RST_STREAM` frame to initiate and immediately cancel streams, forcing the server to do full request processing work while the attacker never receives data — enabling a single client to generate millions of rps against unpatched servers.

A minimal hping3 SYN flood for isolated lab demonstration:

```bash
# -S SYN flag | --flood max packet rate | --rand-source spoof source IPs | -p 80 target port
sudo hping3 -S --flood --rand-source -p 80 192.168.56.20
```

Detection of active DoS relies on: packet-rate baselining via NetFlow/IPFIX/sFlow, anomalous `SYN_RECV` state counts, TCP flag distribution analysis, per-source request rate tracking in WAF/IPS, and TTL uniformity analysis across ostensibly distributed sources (botnet traffic often shows uniform TTLs revealing a common real source).

---

## Key Concepts

- **Availability**: The [[CIA Triad]] property DoS attacks exclusively target — ensuring authorized users have timely, uninterrupted access to resources. DoS does not directly violate confidentiality or integrity, a critical distinction for exam scenarios.
- **Amplification Factor**: The ratio of response byte-size to request byte-size in a reflection attack. Memcached (UDP 11211) can exceed 50,000×; DNS `ANY` queries reach ~50×; NTP `monlist` ~206×. Higher amplification = less attacker bandwidth required per unit of victim saturation.
- **Reflection**: Sending a spoofed UDP request to a third-party server so its reply is directed at the victim. Requires the protocol to run over connectionless UDP (no handshake verifies source) and for the server to be publicly accessible and misconfigured to respond to arbitrary sources.
- **Low-and-Slow**: An application-layer DoS style using very few connections and near-baseline bandwidth, intentionally staying beneath volumetric detection thresholds while exploiting per-connection or per-thread server limits. Slowloris and R.U.D.Y. are canonical examples.
- **Ransom DoS (RDoS)**: An extortion model in which attackers demand cryptocurrency payment to stop or refrain from launching an attack. Groups including *Fancy Lazarus* and *DD4BC* industrialized this technique against banks, exchanges, and CDN providers.
- **Botnet**: A network of compromised hosts ([[Bot]]s) under common [[C2]] infrastructure used to coordinate distributed attacks. Modern botnets like Mirai, Mēris, and XorDDoS target IoT devices and Linux servers with weak credentials.
- **Blackholing / Null Routing**: An upstream mitigation where all traffic destined for the victim's IP is dropped at the ISP or IX level — sacrificing availability of that specific IP entirely to protect the surrounding infrastructure from congestion.
- **Scrubbing Center**: A cloud-based traffic inspection facility (operated by Cloudflare, Akamai Prolexic, AWS Shield Advanced, Arbor/NETSCOUT) that receives attack traffic via BGP rerouting, filters malicious packets, and tunnels clean traffic back to the origin.

---

## Exam Relevance

On the **Security+ SY0-701** exam, DoS and DDoS appear primarily in **Domain 2 (Threats, Vulnerabilities, and Mitigations)**, specifically objective **2.4** ("analyze indicators of malicious activity"). Key patterns and gotchas to know cold:

- **DoS vs. DDoS by source count**: A single attacker exhausting a server = DoS. Thousands of compromised IoT devices acting in concert = DDoS. The exam will provide this detail in the scenario; use it to pick the right term.
- **Always maps to Availability**: Every DoS/DDoS question that asks "which security principle is violated?" answers **Availability**. Never confidentiality, never integrity. This is one of the most reliably tested concepts on the exam.
- **Amplification clue words**: "small request," "large response," "UDP," "spoofed source IP," "DNS/NTP/memcached" — these all point to a **reflection/amplification** attack.
- **Layer 7 vs. volumetric scenario cues**: If a scenario describes low bandwidth but an exhausted web server or full thread pool → think **application-layer / Slowloris / HTTP flood**. If the scenario describes "saturated uplink" or "hundreds of gigabits" → think **volumetric**.
- **Correct mitigation matching**: SYN cookies → SYN flood. Rate limiting + WAF → HTTP flood. Scrubbing center / upstream filtering → volumetric. Disabling `monlist` or open recursion → NTP/DNS reflection prevention.
- **Terminology trap**: Know the difference between **DoS** (single source), **DDoS** (multiple sources), and **DRDoS** (Distributed Reflected DoS, which also spoofs sources through third parties). The exam may use all three terms in the same question set.
- **Fork Bomb is a local DoS**: A [[Fork Bomb]] (e.g., `:(){ :|:& };:` in bash) causes a local denial of service by exhausting process table entries — it is DoS, but not network DoS. Don't confuse the categories.

---

## Security Implications

DoS attacks expose several systemic architectural weaknesses beyond their immediate availability impact. **Single points of failure** — a sole DNS provider, one internet egress link, one load balancer cluster — become catastrophic leverage points during an attack. The 2016 Dyn incident demonstrated that relying on a single DNS provider, regardless of that provider's internal resilience, creates an industry-wide SPOF. **Stateful security devices** such as firewalls and intrusion prevention systems are themselves DoS targets, because their session tracking tables are orders of magnitude smaller than the bandwidth they pass — an attacker who fills the firewall's state table can create an outage even without saturating the pipe.

**Cloud infrastructure** introduces the *Denial-of-Wallet (EDoS)* variant: auto-scaling will absorb the traffic but generate an unsustainable cloud bill within hours, effectively bankrupting the victim's account. Without spending caps and anomaly-based auto-scaling limits, this is a real operational risk.

Notable CVEs and incidents:

- **CVE-2023-44487** — HTTP/2 Rapid Reset. Exploited by a single botnet to generate 398M rps against Google infrastructure and 201M rps against Cloudflare in August–October 2023 — both records at the time.
- **CVE-2018-1000115** — Memcached UDP reflection. Used in the **1.35 Tbps GitHub attack** (February 28, 2018) and a subsequent 1.7 Tbps attack observed by Arbor Networks days later.
- **Mirai (2016)** — Open-source botnet infecting ~600,000 IoT devices via default Telnet credentials. Launched a **620 Gbps** attack against Krebs on Security, **1.1 Tbps** against OVH, and the Dyn attack.
- **Operation Ababil (2012–2013)** — Izz ad-Din al-Qassam Cyber Fighters targeted major US banks (Bank of America, JPMorgan Chase, Wells Fargo) with itsoknoproblembro (Brobot), sustaining multi-day Layer 7 floods that overwhelmed on-premise defenses.
- **CVE-1999-0016** — LAND attack; CVE-1999-0128 — Ping of Death. Historical but illustrative of how protocol edge cases became weapons.

Detection signals include: sudden NetFlow/sFlow volume spikes exceeding 2–3σ above baseline, elevated `SYN_RECV` counts visible via `ss -ant`, anomalous request-per-second rates per source IP in WAF logs, TTL uniformity across ostensibly distributed sources (revealing botnet spoofing patterns), and unusual geographic or ASN distribution in access logs.

---

## Defensive Measures

A layered, defense-in-depth posture is mandatory — no single control is sufficient.

**Network edge and upstream**:
- Deploy **anti-DDoS scrubbing** via Cloudflare Magic Transit, AWS Shield Advanced, Akamai Prolexic, or Radware Cloud DDoS Protection. These provide always-on