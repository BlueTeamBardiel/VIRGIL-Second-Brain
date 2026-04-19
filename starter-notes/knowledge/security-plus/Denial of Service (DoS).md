---
domain: "network-security"
tags: [dos, ddos, availability, network-attack, cia-triad, sy0-701]
---
# Denial of Service (DoS)

A **Denial of Service (DoS)** attack is a deliberate attempt to render a computer, service, or network resource unavailable to its intended users by overwhelming it with traffic, exploiting protocol weaknesses, or exhausting finite system resources. DoS attacks strike directly at the **availability** pillar of the [[CIA Triad]], and when launched from many coordinated sources simultaneously become a [[DDoS|Distributed Denial of Service (DDoS)]] attack. Unlike attacks that steal data or escalate privilege, DoS seeks only to deny — making it a favored tool for hacktivists, extortionists, and nation-state actors conducting disruption operations.

---

## Overview

A DoS attack succeeds when a target can no longer service legitimate requests within an acceptable time, regardless of whether the underlying host, link, or application has actually "crashed." The denial may be temporary (while malicious traffic is actively flowing) or persistent (a crash requiring manual recovery, sometimes called a **Permanent DoS** or **PDoS**). Fundamentally, every computing resource — CPU cycles, memory, connection tables, sockets, disk I/O, database locks, or upstream bandwidth — is finite. DoS attacks identify the cheapest resource to exhaust relative to the attacker's cost, then push it past saturation. This cost asymmetry is the root reason DoS remains so durable as an attack class: exhausting a server's 10,000-slot TCP backlog requires far less compute than responding to 10,000 legitimate connections.

The earliest high-profile DoS incident was the **September 1996 attack on Panix**, a New York ISP, which used a TCP SYN flood to knock the provider offline for days and directly spurred the development of [[SYN Cookies]]. Through the late 1990s and early 2000s, DoS evolved from single-source nuisance attacks into coordinated botnet-driven campaigns. The **2016 Dyn attack** leveraged the Mirai botnet — composed of compromised IoT devices such as IP cameras and home routers — to overwhelm major DNS infrastructure, taking Twitter, Netflix, Reddit, and GitHub offline for hours. The **2018 GitHub memcached amplification** attack peaked at 1.35 Tbps without any botnet at all, exploiting thousands of misconfigured public-facing memcached servers. In 2020, **AWS mitigated a 2.3 Tbps CLDAP reflection attack**, then the largest publicly disclosed. In 2023, **Google, AWS, and Cloudflare disclosed the HTTP/2 Rapid Reset attack** (CVE-2023-44487), which reached 398 million requests per second — a record that eclipsed prior records by an order of magnitude.

Motivations vary significantly by threat actor. **Hacktivist groups** such as Anonymous use DoS as digital protest (Operation Payback, 2010, targeting RIAA and MPAA). **Ransom DDoS (RDoS)** actors like Fancy Lazarus and DD4BC extort targets by threatening — or briefly demonstrating — sustained high-volume attacks unless cryptocurrency payments are made. **Nation-state** actors use DoS for pre-conflict disruption, as documented in the 2007 attacks against Estonia, the 2008 campaign alongside the Russo-Georgian War, and the sustained operations against Ukrainian infrastructure since 2022. **Competitive sabotage** is endemic in online gaming, cryptocurrency exchanges, and gambling, where downtime directly translates to lost revenue. Finally, DoS is often used as a **smokescreen**, diverting defender attention and overwhelming log pipelines while a more targeted intrusion — such as [[Data Exfiltration]] or credential theft — proceeds in parallel.

DoS differs from a simple outage in intent: a misconfigured cron job that fills a disk qualifies as an outage but not an attack. It differs from [[Ransomware]] and [[Wiper Malware]] in that no persistence or foothold on the target is required — the attacker never needs to execute code on the victim system. The attack surface is the network protocol stack itself. This is what makes DoS genuinely unique among threat categories, and why the defenses are primarily architectural and network-level rather than endpoint-centric.

---

## How It Works

DoS attacks fall into three broad technical categories, which are often combined in a single campaign:

**1. Volumetric Attacks** saturate the target's ingress bandwidth. The attacker generates more bits per second than the victim's upstream link can carry, so legitimate packets are dropped by routers before they reach the server. Measured in **Gbps or Tbps**. Typical vectors: UDP floods, ICMP floods, and amplification/reflection attacks.

**2. Protocol / State-Exhaustion Attacks** abuse weaknesses in Layer 3/4 protocols to consume finite kernel-level resources such as TCP connection state tables, firewall session tables, or load-balancer slot pools. Measured in **packets per second (pps)**. The canonical example is the SYN flood.

**3. Application-Layer (Layer 7) Attacks** mimic valid client behavior but exploit expensive server-side operations — slow reads, costly database queries, TLS handshakes, or HTTP/2 stream resets. Measured in **requests per second (rps)**. Significantly stealthier and harder to distinguish from organic flash-crowd traffic.

---

### SYN Flood (Protocol/State Exhaustion)

TCP requires a three-way handshake: SYN → SYN-ACK → ACK. The server allocates a **Transmission Control Block (TCB)** in its backlog queue when it receives a SYN, awaiting the final ACK before promoting the connection to established. An attacker exploiting this sends a high volume of SYN packets with **spoofed source IPs**. The server returns SYN-ACKs that are never acknowledged, and the backlog fills until no new legitimate connections can be accepted.

```bash
# ⚠️ Lab-only — run only against hosts you own on an isolated network.
sudo hping3 -S -p 80 --flood --rand-source 10.0.0.50
#   -S             Set the SYN flag
#   --flood        Send packets as fast as possible, do not read replies
#   --rand-source  Randomize the spoofed source IP per packet
```

**Observe state exhaustion on the victim:**
```bash
# Count half-open (SYN_RECV) connections on victim
ss -ntp state syn-recv | wc -l

# View current backlog ceiling
cat /proc/sys/net/ipv4/tcp_max_syn_backlog
```

---

### UDP Amplification / Reflection

The attacker **spoofs the victim's IP** as the source address of small UDP queries directed at publicly reachable services that return responses disproportionately larger than the request. The service "reflects" the amplified traffic at the victim without the attacker maintaining any state. Key metric: the **Bandwidth Amplification Factor (BAF)**.

| Protocol   | Port  | BAF (approx.) | Notes                             |
|------------|-------|---------------|-----------------------------------|
| DNS (ANY)  | 53    | ~54×          | ANY queries largely deprecated    |
| NTP monlist| 123   | ~557×         | Returns last 600 clients queried  |
| SSDP       | 1900  | ~30×          | UPnP devices, common in homes     |
| CLDAP      | 389   | ~56×          | Connectionless LDAP (Windows DC)  |
| Memcached  | 11211 | ~51,000×      | Highest known BAF; used in GitHub attack |

A **203-byte memcached request** can produce a **~10 MB response** — sent to the victim — making this the most efficient amplifier ever weaponized. The attacker's only cost is sending spoofed small packets; upstream providers absorb the damage.

---

### Slowloris (Application-Layer, Low-and-Slow)

Slowloris opens hundreds or thousands of partial HTTP connections and keeps them alive by sending an incomplete HTTP header — dripping one additional header line (`X-a: b\r\n`) every 10–15 seconds — never completing the request. Each connection occupies an Apache worker thread. When the thread pool is exhausted, legitimate clients receive no response. The total bandwidth consumed is negligible (a few kbps), making volumetric detection useless.

```python
# Conceptual reference — do not point at any third-party system.
import socket, time

socks = []
target = "10.0.0.50"

for _ in range(500):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(4)
    s.connect((target, 80))
    # Send partial HTTP request — missing the final blank line (\r\n)
    s.send(b"GET / HTTP/1.1\r\nHost: " + target.encode() + b"\r\nUser-Agent: Mozilla\r\n")
    socks.append(s)

while True:
    for s in socks:
        try:
            # Drip one more header — server resets timeout, connection stays open
            s.send(b"X-Keep-Alive: b\r\n")
        except:
            pass  # Reconnect logic omitted for brevity
    time.sleep(10)
```

Nginx is largely immune to Slowloris by default because its event-driven architecture can hold thousands of idle connections cheaply; Apache `prefork` and `worker` MPMs are far more vulnerable without `mod_reqtimeout`.

---

### HTTP/2 Rapid Reset (CVE-2023-44487)

HTTP/2 multiplexes multiple logical **streams** over a single TCP connection. A client opens a stream and can immediately cancel it with a `RST_STREAM` frame. Opening a stream commits server-side resources (parsing, routing, handler dispatch); resetting it commits essentially none on the client. An attacker can cycle stream open → `RST_STREAM` at extreme speed over a small number of connections, generating hundreds of thousands of effective requests per second with minimal client state. Observed attack rate: **398 million RPS** in October 2023. Mitigated via server-side stream rate caps, patched in nginx ≥ 1.25.3, Apache httpd ≥ 2.4.58, and corresponding releases of Envoy, HAProxy, Caddy, and Go's `net/http`.

---

## Key Concepts

- **DoS vs. DDoS** — A DoS originates from a **single source machine**; a **DDoS** uses many geographically distributed sources (typically a [[Botnet]] or rented booter service), making IP-based blocklisting and ingress filtering far less effective.
- **Amplification Factor (BAF)** — The ratio of attacker-sent bytes to victim-received bytes in a reflection attack. Memcached's ~51,000× BAF means a 1 Mbps attacker uplink can theoretically deliver ~51 Gbps to the victim.
- **Reflection** — Directing third-party servers to send attack traffic to the victim by forging the victim's IP as the request source. Simultaneously hides the attacker's identity and multiplies traffic volume.
- **Stateful Exhaustion** — Filling finite connection or session state tables in firewalls, NAT gateways, load balancers, or the TCP/IP stack, rather than saturating bandwidth — often achievable with far less raw traffic.
- **Low-and-Slow Attack** — Application-layer DoS using minimal bandwidth to hold server resources hostage indefinitely. Examples include Slowloris, R-U-Dead-Yet (RUDY / slow POST), and slow-read attacks.
- **Smurf Attack** — Legacy ICMP amplification attack that broadcasts spoofed ICMP echo-requests across a network's directed broadcast address, directing all replies at the victim. Largely obsolete since RFC 2644 (1999) deprecated directed broadcast forwarding on routers.
- **Yo-Yo Attack (Economic DoS / EDoS)** — Targets cloud auto-scaling environments by alternating high and low traffic, triggering expensive scale-up and scale-down cycles to inflate the victim's cloud infrastructure costs without necessarily achieving full unavailability.
- **Permanent DoS (PDoS / Phlashing)** — Corrupts device firmware or configuration so severely that physical intervention is required for recovery. BrickerBot (2017) exploited default credentials on Linux-based IoT devices to overwrite flash storage with `dd if=/dev/random`, permanently bricking them.

---

## Exam Relevance

**SY0-701 Domain Mapping**: DoS/DDoS appears primarily in **Domain 2 — Threats, Vulnerabilities, and Mitigations**. It also appears contextually in Domain 4 when discussing security architecture resilience objectives.

**High-probability question patterns:**

- **"Which CIA property does DoS target?"** → Always **Availability**. If an answer choice says confidentiality or integrity, it's a distractor unless the stem explicitly describes a smokescreen scenario.
- **"A network receives millions of SYN packets with no corresponding ACK. What type of attack is this?"** → **SYN Flood**. Follow-up mitigation: **SYN Cookies**.
- **"An attacker sends small DNS queries to open resolvers and the victim receives massive UDP responses it never requested."** → **Amplification/Reflection** attack.
- **"Thousands of compromised IoT cameras flood a target simultaneously."** → **DDoS** (not DoS — distributed sources matter).
- **"A web server's worker threads are exhausted but bandwidth utilization is normal."** → **Slowloris** or application-layer slow attack.

**Gotchas to memorize:**

- **Reflection ≠ Amplification**: Reflection hides the attacker by bouncing traffic off a third party. Amplification magnifies the volume. Most modern attacks do both simultaneously, but the exam distinguishes them — "reflection" emphasizes misdirection, "amplification" emphasizes volume multiplication.
- **DDoS doesn't require a botnet** — a booter/stresser service that rents attack capacity qualifies; so does coordinated human action (e.g., Anonymous Low Orbit Ion Cannon).
- **Mitigations are layered** — a WAF stops Layer 7 attacks but does nothing against a terabit volumetric flood; upstream scrubbing is the only answer to volumetric. The exam may present both as options and require selecting the correct layer.
- **BCP 38** is the community-level solution to spoofing-based attacks (reflection, SYN floods with spoofed IPs). Know this by name.

---

## Security Implications

DoS is cheap to launch and expensive to defend. **Booter/stresser services** advertise DDoS-as-a-service for as little as $5–$50 per attack, delivering hundreds of Gbps to any specified target. The **Mirai source code leak in October 2016** democratized large-scale IoT botnets; dozens of active variants — Satori, Okiru, Mozi, Manga, Echobot — continue to surface and infect millions of devices globally.

**Notable CVEs and incidents:**

| CVE / Incident | Year | Impact |
|---|---|---|
| CVE-2023-44487 (HTTP/2 Rapid Reset) | 2023 | 398M RPS; Google, AWS, Cloudflare affected |
| CVE-2018-1000115 (Memcached UDP) | 2018 | 1.35 Tbps; GitHub offline ~10 min |
| CVE-2014-9295 (NTP monlist) | 2014 | ~400 Gbps attacks; drove mass NTP hardening |
| Dyn DNS DDoS (Mirai) | 2016 | ~1.2 Tbps; cascading outages across US East Coast |
| Estonia National Infrastructure | 2007 | Banks, media, government offline; first nation-state DDoS |
| Ukraine CERT-UA infrastructure | 2022+ | Ongoing state-linked DDoS as conflict component |

**Detection signals to know:**

- **Volumetric**: Sudden spike in inbound traffic to a single IP; disproportionate UDP volume from ports 53, 123, 389, 1900, or 11211; NetFlow/IPFIX showing many sources with identical small payloads.
- **SYN flood**: High ratio of SYN to SYN-ACK/ACK in TCP