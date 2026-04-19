---
domain: "defense"
tags: [ddos, mitigation, network-security, availability, cloud-security, waf]
---
# DDoS mitigation services

**DDoS mitigation services** are specialized commercial or cloud-native offerings that absorb, filter, and discard malicious traffic from **[[Distributed Denial of Service]]** attacks before it reaches a customer's origin infrastructure. They combine globally distributed **[[Anycast]]** networks, high-capacity **scrubbing centers**, behavioral analytics, and **[[Web Application Firewall|WAF]]** rules to preserve the **availability** leg of the **[[CIA Triad]]** against volumetric, protocol, and application-layer floods.

---

## Overview

DDoS mitigation emerged in the early 2000s when ISPs began offering *remote-triggered black hole* (RTBH) routing to sinkhole attacked prefixes. This crude technique protected the upstream network but completed the attacker's goal — taking the victim offline. Modern mitigation services evolved from this by routing traffic through **scrubbing centers** that selectively drop malicious packets while forwarding legitimate traffic to the origin. Pioneers such as Prolexic (now part of **Akamai**) built the first dedicated anti-DDoS clouds in the mid-2000s, while **Cloudflare** (founded 2009) popularized the "reverse-proxy CDN" model that serves double duty as a mitigation layer.

The market today includes **Cloudflare Magic Transit / Spectrum**, **Akamai Prolexic**, **AWS Shield Advanced**, **Azure DDoS Protection**, **Google Cloud Armor**, **Imperva**, **Radware DefensePro Cloud**, **NETSCOUT Arbor**, and **F5 Silverline**. These providers operate networks with **tens of terabits per second** of edge capacity — Cloudflare reports over 280 Tbps, Akamai over 400 Tbps — specifically so that an attack's bandwidth is smaller than the defender's ingress pipe.

The economic drivers are stark. **Ransom DDoS (RDDoS)** campaigns (Fancy Lazarus, REvil copycats) extort cryptocurrency by demonstrating a small attack and threatening a larger one. **Hacktivist** collectives (Killnet, Anonymous Sudan, NoName057(16)) use DDoS as political expression. **Nation-state** actors use DDoS as smokescreens for data theft or wiper deployments, as seen repeatedly in Russia–Ukraine operations in 2022. **Booter/stresser** services put 1+ Tbps attacks within reach of anyone with a credit card, democratizing a technique once reserved for state actors.

Attack magnitudes have grown exponentially. The **2016 Dyn attack** (Mirai botnet, ~1.2 Tbps) took down Twitter, Spotify, and Reddit. The **2018 GitHub memcached attack** peaked at **1.35 Tbps** and was mitigated by Akamai in under 10 minutes. **AWS Shield** disclosed absorbing a **2.3 Tbps** CLDAP reflection attack in February 2020. Google reported a **398 million RPS** HTTP/2 Rapid Reset attack in 2023 (CVE-2023-44487). Cloudflare announced mitigating **3.8 Tbps** and **5.6 Tbps** UDP floods in late 2024. No on-premises appliance can face these volumes alone; cloud mitigation is now table stakes for any internet-facing service.

Mitigation services differ in *where* they sit in the traffic path. A **CDN-style reverse proxy** only protects HTTP(S) and requires a DNS change; **BGP-based scrubbing** protects entire IP prefixes and any protocol; **on-demand** services activate only when attacks are detected via flow telemetry; **always-on** services inspect 100% of traffic continuously. Most enterprises combine layers — for example, Cloudflare at the web edge plus AWS Shield Advanced on the origin VPC — because no single model covers every attack surface.

---

## How It Works

A DDoS mitigation service interposes itself between the internet and the customer's origin so that every packet destined for the protected asset first traverses the provider's cleaning infrastructure. Three **traffic ingestion models** dominate:

**1. DNS-based (Reverse Proxy, L7):** The customer points `www.example.com` to a CNAME or A record owned by the mitigation provider. The provider's [[Anycast]] IPs are announced from every Point of Presence (PoP); the internet's shortest-path BGP routing steers each client to its nearest PoP. The PoP terminates TCP and TLS, inspects the request, and forwards clean traffic to the hidden origin over HTTPS or a tunnel.

```
Client → Anycast VIP (nearest PoP) → Scrubbing / WAF → Origin (hidden IP)
```

**2. BGP-based (Magic Transit / Prolexic Connect, L3/L4):** The customer delegates routing of a /24 (or larger) prefix to the provider, which announces it from all PoPs via BGP. Return traffic is delivered to the origin over **GRE** or IPsec tunnels, or via direct cross-connects. This protects *any* IP protocol (TCP, UDP, ICMP, GRE, ESP) and is used for mail servers, game backends, and UDP-based services.

```bash
# Example: origin-side GRE tunnel (Linux) for BGP scrubbing return traffic
ip tunnel add gre1 mode gre remote 203.0.113.1 local 198.51.100.10 ttl 255
ip addr add 192.0.2.2/30 dev gre1
ip link set gre1 up
# Route return traffic back through the scrubbing provider
ip route add 0.0.0.0/0 via 192.0.2.1 dev gre1 table 100
```

**3. On-Demand (Traffic Swing):** Normal traffic flows directly to the origin. Flow telemetry (NetFlow/sFlow/IPFIX) from upstream routers feeds a detection engine; when thresholds trip, BGP announcements shift the prefix to the scrubbing cloud within minutes. Cheaper than always-on, but the victim experiences a brief outage (~1–5 min) during the swing.

Inside a scrubbing PoP, packets pass through a **tiered filtering pipeline** of increasing computational cost:

1. **ACLs / bogon filtering** — Drop obviously spoofed or RFC 1918/5737 reserved source addresses at line rate using ASICs, DPDK, or **[[XDP]]** (eXpress Data Path) hooks in the Linux kernel.
2. **Stateless signatures** — Match known amplification reflector patterns: memcached UDP/11211, NTP monlist UDP/123, DNS ANY UDP/53, SSDP UDP/1900, CLDAP UDP/389, chargen UDP/19. Entire packet classes are dropped without state tracking.
3. **Rate limiting** — Applied per source IP, per /24, per ASN, or per geography. Per-destination-port budgets catch UDP reflection floods before they saturate links.
4. **TCP state validation** — Uses **SYN cookies** or TCP proxying to defeat SYN floods. The proxy completes the three-way handshake on behalf of the origin and only forwards validated, established connections.
5. **Behavioral anomaly detection** — Baselines normal traffic shape (packet size distribution, PPS-to-bps ratio, TLS JA3 fingerprints, HTTP method mix) and auto-generates mitigation rules during live attacks using ML classifiers.
6. **Layer-7 challenges** — Target application-layer floods that appear legitimate at L4. Techniques include JavaScript challenges, CAPTCHA, proof-of-work (Cloudflare Managed Challenge, hCaptcha), and **TLS fingerprinting** (JA3/JA4) to distinguish real browsers from `curl`, Go, or Python HTTP clients.
7. **WAF rules** — Block exploit attempts riding the flood (SQLi, RCE, path traversal) and enforce per-URI rate limits.

```nginx
# Nginx leaky-bucket rate limiting (origin-side complement to cloud mitigation)
limit_req_zone $binary_remote_addr zone=perip:10m rate=10r/s;
limit_req_zone $server_name        zone=persrv:10m rate=1000r/s;

server {
    location /login {
        limit_req zone=perip  burst=20  nodelay;
        limit_req zone=persrv burst=200;
    }
}
```

Providers deploy **Anycast** as their load-spreading weapon. A 1 Tbps attack from a Mirai botnet spread across 100 countries is automatically split across 300+ PoPs, so no single site sees more than a few Gbps — well within that PoP's filtering capacity. This architectural principle is why anycast + distributed scrubbing defeats any centralized appliance approach regardless of appliance throughput.

**BGP FlowSpec (RFC 5575)** complements this by distributing fine-grained ACL rules — encoded as BGP NLRI — to every peering router simultaneously. A single control-plane rule can match on source/destination IP, protocol, TCP flags, packet length, and DSCP, with actions like discard, rate-limit to *N* bps, or DSCP remark. This allows mitigation decisions made in a scrubbing center to propagate to every internet exchange point within seconds.

```
# FlowSpec rule example (BIRD2 syntax)
# Drop all UDP port 11211 to protected prefix
flow4 table fs_table;
protocol bgp cloudflare_fs {
  ipv4 { table fs_table; };
  flowspec ipv4 { table fs_table; export all; };
}
# Inject rule: discard UDP/11211 destined to 203.0.113.0/24
route 203.0.113.0/24 flow4 {
    dst 203.0.113.0/24; proto = udp; dport = 11211;
} blackhole;
```

---

## Key Concepts

- **Scrubbing center** — A data center node within the provider's network where attack traffic is decapsulated, inspected through the filter pipeline, and bad packets are discarded. Providers operate dozens globally to keep filtering geographically close to attack sources, minimizing latency for legitimate users.
- **Anycast routing** — Announcing the same IP prefix from multiple geographic locations simultaneously so BGP's shortest-path algorithm naturally distributes inbound traffic across the provider's entire edge. This transforms a massive volumetric flood into many smaller, manageable streams.
- **Always-on vs. on-demand** — *Always-on* inspects 100% of traffic continuously, achieving the lowest detection-to-mitigation latency (sub-second) but at higher cost. *On-demand* swings traffic to the cloud only when a threshold-based attack is detected via flow telemetry, cheaper but with a window of exposure during activation.
- **BGP FlowSpec (RFC 5575)** — A BGP extension that distributes fine-grained, protocol-aware ACL rules as BGP NLRI across a network. Used by ISPs and enterprises to push real-time mitigation decisions (drop, rate-limit, redirect) to every edge router simultaneously without manual ACL deployment.
- **Remote Triggered Black Hole (RTBH)** — A legacy mitigation technique where the victim advertises its own IP with a community tag (e.g., `65000:666`), causing upstream routers to discard all traffic destined for that IP. Effective at stopping the attack but achieves the attacker's goal of taking the victim offline; used only as a last resort.
- **Ransom DDoS (RDDoS)** — Extortion campaigns where threat actors demand cryptocurrency under threat of a sustained, service-destroying DDoS attack. Attackers often demonstrate capability with a brief flood, then send a ransom note, impersonating groups like Fancy Lazarus or Lazarus Group.
- **Amplification / reflection attack** — The attacker spoofs the victim's source IP and queries UDP services that return much larger responses, directing the amplified reply flood at the victim. Amplification factors: memcached up to 51,000×, NTP monlist ~556×, DNS ANY ~54×, CLDAP ~70×. Mitigation services defeat these with stateless port-based filtering.
- **Origin IP leak** — The single most common mitigation bypass. Attackers discover the real origin IP via historical DNS records, certificate transparency logs (`crt.sh`), email headers `Received:` fields, misconfigured subdomains (`mail.`, `ftp.`, `staging.`), or Shodan scans for unique TLS certificate serial numbers. Once discovered, the attacker bypasses the scrubbing cloud entirely by targeting the origin directly.
- **Authenticated Origin Pulls (mTLS)** — A Cloudflare feature (and analogous capability on other providers) where the provider presents a client TLS certificate when connecting to the origin. The origin validates this certificate and rejects connections that don't present it, blocking direct-to-origin attacks even if the IP is discovered.

---

## Exam Relevance

**SY0-701 objectives directly addressed:**

| Objective | Topic |
|-----------|-------|
| **2.4** | Analyze indicators of malicious activity — DDoS, amplified DDoS, reflected DDoS |
| **3.2** | Secure enterprise infrastructure — load balancers, reverse proxies, CDN/WAF |
| **4.5** | Modify enterprise capabilities — web filters, DDoS protection, rate limiting |

**Common question patterns:**

- **Scenario:** "A company's website is unreachable; logs show millions of small UDP/53 packets with randomized source IPs." → Identify as a **reflected/amplified DNS DDoS**; the correct mitigation is a **cloud-based DDoS service** plus **ingress filtering (BCP38/uRPF)**.
- **Scenario:** "An on-premises firewall rated at 10 Gbps is overwhelmed by a 300 Gbps attack." → The answer is **cloud-based scrubbing**, not purchasing a higher-throughput appliance. No on-prem device wins a volumetric race.
- **Scenario:** "Attacker sends thousands of HTTP GET requests per second that each open a large file download." → L7 application-layer flood; answer is **rate limiting + WAF**, not a bigger pipe.
- **Distractor:** Load balancers are often listed as DDoS mitigation. They distribute *legitimate* load but will fail under a volumetric attack because they only have as much bandwidth as the upstream link.

**Key gotchas:**

- A **CDN** provides inherent L7 DDoS protection as a side effect of proxying, but it does not protect L3/L4 UDP services unless paired with a BGP-based service like Magic Transit.
- **Anycast** is a routing technique for *distribution* — it is not encryption, not authentication, and not synonymous with redundancy.
- **RTBH** achieves the attacker's goal of unavailability and is never a "good" answer unless framed as protecting the rest of the network at the expense of the victim.
- The exam often conflates "DoS" and "DDoS" — know that DDoS uses multiple (often compromised) sources and that source-IP blocking is ineffective.

---

## Security Implications

DDoS attacks are frequently **diversionary**: while the SOC is firefighting a flood, adversaries may simultaneously execute account takeover, data exfiltration, or fraudulent wire transfers. The FBI and CISA have repeatedly warned that RDDoS extortion notes often accompany or immediately precede ransomware staging operations.

**Mitigation services themselves have attack surface:**

- **Origin IP disclosure** — Not a CVE but a pervasive operational failure. Tools like `CloudFail`, `CloakQuest3r`, and manual `crt.sh` queries routinely find origin IPs in minutes. Once discovered, attacker traffic bypasses all scrubbing infrastructure.
- **HTTP/2 Rapid Reset — CVE-2023-44487** — A protocol-level flaw in which a client repeatedly sends and immediately cancels HTTP/2 streams faster than the server can handle. A single connection can generate millions of RPS of server-side work. Drove a 398 Mrps attack on Google, 201 Mrps on Cloudflare. Fixed by vendors via stream-count limits and by server patches (nginx 1.25.3, Envoy 1.27.1, Go 1.21.3). All major mitigation providers updated edge software within 24 hours of disclosure.