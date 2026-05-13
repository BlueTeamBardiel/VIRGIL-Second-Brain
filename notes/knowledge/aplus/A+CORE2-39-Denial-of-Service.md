# Denial of Service

## What it is

You're three rounds deep in a ranked match and the entire lobby rubber-bands. Ping spikes to 4000ms, then the connection drops. Someone in the server is running a booter against the host. Game's over before it ended.

That's denial of service in its purest form: take a thing that works, drown it in noise until it stops working. No data stolen. No accounts compromised. Just a service that can't serve.

Plain English: a DoS attack makes a system unavailable to the people who need it by overwhelming it with traffic, requests, or malformed input. The system doesn't get hacked — it gets exhausted. The network stack (the machine's voice and ears) gets shouted over until it can't hear legitimate users.

Technical definition: a denial-of-service attack consumes a finite resource on a target — bandwidth, CPU, memory, connection table slots, application threads — until that resource is exhausted and legitimate requests are dropped, timed out, or rejected. A **distributed denial-of-service (DDoS)** attack does the same thing from thousands or millions of compromised endpoints simultaneously — a botnet of infected machines, IoT cameras, home routers, anything with an internet connection and a vulnerability.

## Why it matters

DoS is on the 220-1202 exam under Objective 2.5 as a threat, alongside DDoS. CompTIA wants you to know the difference between the two, recognize the symptoms when a user calls in, and know what you can and cannot do about it at the helpdesk tier.

Career relevance: this is the attack you'll *experience* before you ever investigate one. Every IT worker eventually sits through an outage where the web team is screaming "we're getting hammered" and the network team is staring at a graph that looks like a vertical line. You don't need to be the one mitigating it. You need to recognize it, escalate correctly, and tell users the truth: "the site is down because someone is attacking it, we're working with our provider, ETA unknown."

Real-world stakes: DoS attacks against hospitals delay surgeries. Against banks, they cost millions per hour. Against game servers, they ruin esports tournaments. The 2016 Mirai botnet took down Dyn DNS and broke half the internet for a day — Twitter, Reddit, Netflix, Spotify all unreachable. The attack came from compromised security cameras.

## In your build, in the enterprise

**Beat 1 — Technical depth.** DoS attacks come in three flavors. **Volumetric** attacks flood bandwidth — UDP floods, ICMP floods, amplification attacks (DNS, NTP, memcached reflection where a small spoofed query triggers a massive response to the victim). **Protocol** attacks exhaust state tables — SYN floods leave half-open TCP connections rotting in the server's connection table until it can't accept new ones. **Application-layer (Layer 7)** attacks look like legitimate traffic but hammer expensive endpoints — Slowloris keeps thousands of HTTP connections open by trickling headers one byte at a time, HTTP floods POST to search endpoints that trigger database queries.

DDoS multiplies all of this. A single attacker with a 1Gbps uplink is annoying. A botnet of 100,000 compromised routers each contributing 10Mbps is 1Tbps of traffic — more than most enterprise pipes can handle. Mitigation isn't done at the target — it's done upstream, at the ISP or a scrubbing service like Cloudflare or AWS Shield, where the bad traffic gets filtered before it reaches you.

**Beat 2 — Feynman example via gaming/homelab.**

**You host a Minecraft server for friends.** Public IP, port 25565 forwarded. Someone in the Discord gets mad about getting griefed, leaves, and 20 minutes later your server lags to death. They paid $5 for a booter service and pointed it at your home IP. *Your 500Mbps cable connection got drowned by a 50Gbps UDP flood from a botnet.*

**Your only real fix is hiding.** Move the server behind a proxy that absorbs the attack — TCPShield for Minecraft, Cloudflare for web. Your home IP becomes a secret. The attacker shoots at the proxy; the proxy has terabits of capacity and shrugs. *You can't out-bandwidth a botnet. You can only put something bigger in front of you.*

**Then you check your router.** Because the attacker knew your IP, which means either you doxxed yourself in voice chat (Discord used to leak IPs through old voice servers), or your IoT doorbell is part of someone else's botnet leaking telemetry. *DoS defense starts with not being a target — and not being a participant.*

**The kicker:** your ISP doesn't care. Residential support will tell you to reboot the modem. Some ISPs will null-route your IP for 24 hours to make the attack stop hurting their network — which is itself a denial of service, just one performed by your provider. *At the consumer tier, "mitigation" means waiting it out.*

**Beat 3 — Bridge from homelab to enterprise.** Same fundamental question — *how do I keep a service available when someone is trying to take it down?* — different answers at different scales.

At home: your defense is a CDN/proxy in front of your homelab and a router that doesn't have UPnP wide open. Cost: $0–20/month. Capacity: whatever Cloudflare's free tier gives you.

At a small business: a hosted web app behind Cloudflare or AWS, basic rate limiting on the WAF, geographic blocking if you only serve one country. Cost: a few hundred a month. The IT person's job during an attack: confirm it's an attack (not a misconfiguration), enable "I'm under attack" mode, call the provider, communicate to leadership.

In the enterprise: dedicated DDoS scrubbing contracts (Akamai Prolexic, AWS Shield Advanced, Cloudflare Magic Transit), BGP route announcements that can redirect traffic to scrubbing centers in seconds, on-prem appliances from Arbor or Radware for the traffic that makes it through. There's a SOC watching NetFlow graphs 24/7. There's a runbook. There's a war room bridge that opens within five minutes of a sustained anomaly. Mitigation is automated — humans confirm and tune, they don't react from scratch.

**Beat 4 — The point.** Same question — *can my service stay up when attacked?* — at every scale. The home answer is "hide behind something bigger." The enterprise answer is "contract with something bigger and rehearse the response." Get this question into your bones: when a user calls about an outage, the first branch in your head is "is this a failure or is this an attack?" Treating an attack like a failure wastes hours. Treating a failure like an attack wastes everyone's weekend.

## Key facts

### DoS vs DDoS — the distinction CompTIA tests

| Attribute | DoS | DDoS |
|---|---|---|
| Source | Single attacker, single (or few) source IPs | Thousands to millions of compromised endpoints |
| Mitigation | Block source IP, rate-limit | Upstream scrubbing, traffic engineering |
| Detection | Easy — one IP misbehaving | Hard — traffic looks legitimate, just from everywhere |
| Typical scale | Mbps to low Gbps | 100s of Gbps to multiple Tbps |
| Who runs it | Script kiddie with a booter, disgruntled insider | Organized actor, botnet operator, nation-state |

### Attack categories

- **Volumetric** — UDP/ICMP floods, amplification/reflection. Goal: saturate bandwidth.
- **Protocol** — SYN flood, Ping of Death, fragmented packet attacks. Goal: exhaust state tables and OS resources.
- **Application (Layer 7)** — HTTP flood, Slowloris, expensive query attacks. Goal: exhaust application threads or backend databases. Hardest to detect because traffic looks legitimate.

### Symptoms at the helpdesk

- Users report a site or service is slow, unreachable, or timing out
- Internal services may be fine while external services are dead (or vice versa)
- VPN logins fail or time out — sometimes attackers target the VPN concentrator specifically
- The monitoring dashboard shows traffic spikes correlated with the outage
- Tickets flood in from every department simultaneously — that pattern itself is a signal

### Defensive layers

| Layer | What it does | Where it lives |
|---|---|---|
| ISP/upstream scrubbing | Filters volumetric attacks before they reach you | Provider network |
| CDN / reverse proxy | Absorbs Layer 7 attacks, caches static content | Cloudflare, Akamai, AWS CloudFront |
| WAF (Web Application Firewall) | Blocks malicious HTTP patterns, rate-limits | Edge or appliance |
| Load balancer | Distributes connections, drops malformed traffic | DMZ |
| Firewall rate limiting | Caps connections per source IP | Perimeter |
| Application-level controls | CAPTCHAs, request signing, auth required | App code |

### CompTIA exam traps

> **CompTIA exam trap:** confusing DoS with DDoS. They have different remediation paths. A DoS from a single IP gets blocked at your firewall in 30 seconds. A DDoS from a million IPs cannot be blocked at your firewall — you'd run out of rule space and the traffic still saturates your uplink. If the question implies "we blocked the source IP and it stopped," it's DoS. If the question says "traffic from thousands of countries," it's DDoS.

> **CompTIA exam trap:** thinking DoS is about data theft. It is not. DoS attacks the **availability** leg of the CIA triad (Confidentiality, Integrity, **Availability**). Nothing gets exfiltrated. Nothing gets modified. The service just becomes unreachable. If the question asks "what was breached," DoS breached availability — not data.

> **CompTIA exam trap:** assuming amplification attacks come from the attacker's bandwidth. They don't. In a DNS reflection attack, the attacker sends small spoofed queries to open DNS resolvers; the resolvers send massive responses to the victim. The attacker uses 1Mbps to generate 50Mbps of attack traffic. The amplification factor is the trap — CompTIA likes asking which protocols are abusable (DNS, NTP, memcached, SSDP, SNMP all qualify).

> **CompTIA exam trap:** mixing up "denial of service" the attack with "denial of service" the symptom. A misconfigured firewall rule that blocks legitimate users is *not* a DoS attack — it's a self-inflicted outage. The word "attack" implies intent and an adversary.

## Helpdesk reality

- User: "the website is down." Your job: confirm scope (just them? everyone? one site? everything?), check the status page, check if monitoring is alerting. Don't promise a fix time — you don't have one.
- During a DDoS, leadership wants ETA. The honest answer is "it stops when the attacker stops or when scrubbing catches up." That's not satisfying but it's true. Lying about ETA destroys credibility.
- If a single user is being personally DoSed (gamers, streamers, people with stalkers), the answer at the corporate helpdesk is "change your IP, talk to your ISP, consider a VPN." It's not really your problem to solve, but be human about it.
- Never tell a user "we're under attack" on a public channel before comms has approved messaging. "We're experiencing connectivity issues, engineering is investigating" is the safe phrasing. Attackers watch status pages to gauge their effectiveness.
- Tickets multiply during an outage. Resist the urge to respond to all of them individually — post one update to the status page, link every ticket to that incident, mass-update when it resolves. Otherwise you spend the outage typing instead of helping.

## Related concepts

[[Phishing]] · [[Spoofing]] · [[On-path attack]] · [[Zero-day attack]] · [[Firewall basics]] · [[VPN]] · [[Network troubleshooting]] · [[Incident response]] · [[Botnets and malware]]

*Source: VIRGIL knowledge base — 2026-05-11*