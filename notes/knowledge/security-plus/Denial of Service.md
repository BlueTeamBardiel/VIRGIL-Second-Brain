# Denial of Service

## What it is

In Marvel Rivals, when a Jeff the Land Shark ults and swallows your entire team into his belly before spitting you off the map — your team can't contest the point, can't shoot, can't exist as a functional roster for those critical seconds. That's exactly what Denial of Service does — it removes a system's ability to serve its legitimate users by overwhelming, crashing, or exhausting it.

A **Denial of Service (DoS)** attack is a deliberate effort to make a system, service, or network resource unavailable to its intended users by exhausting bandwidth, compute, memory, or connection state.

## Why it matters

DoS attacks turn availability — the **A** in [[CIA Triad]] — into a smoking crater. Customer-facing services go dark, SLAs get violated, revenue evaporates by the minute, and incident response teams spend the night fighting traffic instead of sleeping. Under SY0-701 Objective 2.4, candidates must distinguish **DoS vs. DDoS**, recognize **amplified** and **reflected** variants, and identify the targeted layer (network vs. application). CompTIA's favorite trap: confusing **volumetric** floods with **protocol** or **application-layer** attacks, or mistaking a single-source DoS for a [[DDoS]] (which requires a distributed botnet).

## Key facts

### Core attack categories

| Category | Targets | Example |
|---|---|---|
| **Volumetric** | Bandwidth | UDP flood, ICMP flood, [[DNS Amplification]] |
| **Protocol** | Connection state, OS resources | [[SYN Flood]], Ping of Death, Smurf |
| **Application-layer (L7)** | Web app logic, DB | [[HTTP Flood]], Slowloris, RUDY |

### DoS vs. DDoS

- **[[Denial of Service|DoS]]**: One source, one target. Easier to block — just drop the source IP.
- **[[Distributed Denial of Service|DDoS]]**: Many sources (a [[Botnet]] of compromised hosts or IoT devices like Mirai), making source-based filtering useless.

### Amplification and reflection

- **[[Reflection Attack]]**: Spoof the victim's IP as the source, send queries to a third-party server, which "reflects" responses to the victim.
- **[[Amplification Attack]]**: Choose a protocol where the response is much larger than the request. Amplification factors:
  - **DNS**: ~28–54x
  - **NTP monlist**: ~556x
  - **Memcached**: up to ~51,000x (the 2018 GitHub 1.35 Tbps attack)
- Common amplifiers run on **UDP/53** (DNS), **UDP/123** (NTP), **UDP/11211** (memcached), **UDP/1900** (SSDP).

### Notable techniques

- **SYN Flood**: Half-open TCP connections exhaust the backlog queue. Defense: **SYN cookies**.
- **Slowloris**: Holds HTTP connections open with partial headers, starves the connection pool. Low bandwidth, high pain.
- **Ping of Death / Teardrop**: Malformed or oversized packets crash older stacks. Mostly historical.
- **Permanent DoS (PDoS / "phlashing")**: Bricks firmware so the device must be replaced.

### Defenses

| Defense | What it does |
|---|---|
| **[[DDoS Mitigation Service]]** (Cloudflare, Akamai, AWS Shield) | Scrubs traffic upstream before it reaches origin |
| **[[Rate Limiting]]** | Caps requests per source/endpoint |
| **[[Anycast]] routing** | Spreads load across geographically distributed nodes |
| **[[Load Balancer]]** | Distributes traffic, can absorb modest spikes |
| **[[Web Application Firewall]]** (WAF) | Filters L7 floods, malicious patterns |
| **[[BCP 38]] / Ingress Filtering** | ISPs drop spoofed source IPs — kills reflection at scale |
| **Blackhole / sinkhole routing** | Drops attack traffic at the network edge |
| **SYN cookies** | Stateless TCP handshake validation |

### Exam-relevant nuance

- A **DoS condition** can be unintentional — a viral link, a misconfigured cron job, or a flash crowd. The *intent* distinguishes attack from incident, but the impact is identical.
- **[[Friendly DoS]]** / [[Self-inflicted Outage]] still counts as an availability event for incident response purposes.
- Mitigation is layered — no single control stops all categories. CompTIA expects you to match the **defense to the attack layer**.

## Related concepts

[[DDoS]] · [[Botnet]] · [[SYN Flood]] · [[DNS Amplification]] · [[Reflection Attack]] · [[Web Application Firewall]] · [[Rate Limiting]] · [[CIA Triad]] · [[BCP 38]] · [[Load Balancer]]

---
*Source: VIRGIL knowledge base — 2026-05-08*