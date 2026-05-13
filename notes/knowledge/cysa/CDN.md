# CDN — Content Delivery Network

## What it is

In **Madden**, when you're running a two-minute drill against a defense stacked at the line, the smart QB doesn't force a bomb to a covered WR1 — he checks down to the slot receiver three yards away who can turn upfield fast. The ball gets where it needs to go through the path of least resistance, not the longest one. That's exactly what a **CDN** does — it serves content from the edge node closest to the user instead of dragging every request back to the origin server.

A **Content Delivery Network** is a distributed mesh of cache servers (edge nodes, points-of-presence/PoPs) geographically scattered across the internet. When a user requests a resource — an image, a JS bundle, a video chunk, an API response — the CDN routes them to the nearest PoP, which either serves a cached copy or fetches from origin and caches it. Cloudflare, Akamai, Fastly, AWS CloudFront, and Azure Front Door dominate the market.

For CySA+, the CDN matters because it sits in front of your **[[origin server]]** as a security control plane: TLS termination, **[[WAF]]** rules, DDoS scrubbing, bot mitigation, rate limiting, and geo-blocking all live at the edge. It's also an inspection point — and an inspection blind spot — depending on how you've architected logging.

## Why it matters

CDNs are foundational **[[infrastructure concepts]]** under CS0-003 Objective 1.1. Most modern web apps front their public surface with one. That makes the CDN both your first line of defense and a control plane that, if misconfigured, hands attackers an architectural shortcut.

Career-wise: every SOC analyst at any company running a public web property will deal with CDN logs, WAF tuning, and origin-protection misconfigurations. If you can read a Cloudflare log line and tell me whether the request hit cache or origin, whether the WAF blocked it or just logged it, and whether the client IP is the real one or the edge IP — you're already useful on day one.

Exam-relevance: CompTIA tests CDN as part of the **network architecture** bullet under 1.1, alongside **[[cloud]]**, **[[on-premises]]**, **[[hybrid]]**, **[[SASE]]**, and **[[zero trust]]** topologies. Expect questions where the CDN is the right answer for DDoS mitigation, latency reduction, or where a misconfigured CDN exposed origin IPs.

## Key facts

### How a CDN actually works

| Step | What happens |
|------|-------------|
| 1. DNS resolution | User's resolver queries `app.example.com`, gets back a CDN edge IP (anycast or geo-DNS) |
| 2. TLS handshake | Client terminates **[[TLS]]** with the CDN edge — not your origin |
| 3. Cache check | Edge checks if the requested object is cached and fresh (TTL not expired) |
| 4. Origin fetch | On cache miss, edge opens a connection to the **[[origin]]** server, fetches, caches |
| 5. Response | Edge returns content to the client; subsequent requests hit cache |

The critical detail: **the client's TCP connection terminates at the edge, not your origin.** That means your origin sees the *CDN's* IP, not the user's. To recover the real client IP, the CDN injects an `X-Forwarded-For` or `True-Client-IP` header. Your **[[log ingestion]]** pipeline has to be configured to read those headers or every connection in your logs looks like it came from Cloudflare.

### Security functions at the edge

- **TLS / SSL termination** — CDN holds the cert, terminates **[[SSL]]**/TLS, re-encrypts (or doesn't) to origin. Lets the CDN inspect traffic for WAF rules.
- **[[WAF]] (Web Application Firewall)** — OWASP Top 10 rule sets at the edge: SQL injection, XSS, command injection, path traversal blocked before reaching origin.
- **DDoS mitigation** — anycast absorbs volumetric attacks; rate limiting and challenge pages handle L7 floods.
- **Bot management** — fingerprinting, JS challenges, CAPTCHA for credential stuffing and scraping.
- **Geo-blocking / IP reputation** — drop traffic from sanctioned countries or known-bad ASNs at the edge.
- **mTLS for API origins** — origin only accepts connections presenting a CDN-issued client cert, locking out direct-to-origin bypass.
- **Bot-detection logs feed [[SIEM]]** — every blocked request, every challenge, every rate-limit hit becomes a telemetry event.

### CDN and the rest of the stack

CDN is a **[[network architecture]]** primitive that pairs with:

- **[[SASE]]** (Secure Access Service Edge) — SASE bundles CDN-style edge + ZTNA + CASB + SWG into one service. CDN is a *subset* of the SASE story.
- **[[CASB]]** (Cloud Access Security Broker) — different layer. CASB sits between users and SaaS apps to enforce DLP, **[[encryption]]**, and access policy. CDN sits between users and your web property. Don't confuse them.
- **[[Zero trust]]** — origin should treat the CDN as untrusted by default. mTLS, signed requests, IP allowlists for CDN egress ranges only.
- **[[PKI]]** — the CDN manages your edge certs (Let's Encrypt, sectigo, or BYOC). Cert rotation is automated; cert mis-rotation is a Sev-1 outage.

### Origin protection — the part juniors miss

The single biggest CDN mistake: leaving the origin reachable on its public IP. If an attacker resolves your real origin IP (via historical DNS records, SSL cert transparency logs, leaked subdomain, or a misconfigured email server on the same host), they bypass the CDN entirely. WAF gone. DDoS protection gone. Rate limit gone.

Proper origin protection:

1. **Firewall allowlist** — origin only accepts inbound TCP/443 from the CDN's published IP ranges
2. **mTLS or shared secret header** — origin validates a CDN-injected token before serving
3. **No A records on the origin hostname** — origin lives on a non-public DNS name not in cert transparency logs
4. **Separate mail/management subdomains** — never share an IP between your origin and `mail.example.com`

> **CompTIA exam trap:** CDN does not make you DDoS-proof. If the attacker finds your origin IP and routes around the CDN, the volumetric attack hits your origin directly. CDN is one *layer* in defense-in-depth — not a substitute for origin-level hardening, **[[system hardening]]**, and **[[network segmentation]]**.

### Logging — the inspection blind spot

CDN logs are gold and CDN logs are a trap. The gold: every HTTP request, geo, ASN, WAF action, cache hit/miss, response code, latency. The trap: those logs live in the *CDN's* platform, not your SIEM, until you wire them up.

| Field to alert on | Why it matters |
|-------------------|----------------|
| WAF block count spike from one ASN | Recon scan or active exploit attempt |
| 5xx error rate on specific paths | Origin compromise or backend instability |
| Cache miss ratio spike | Possible cache-busting attack or origin scraping |
| New user-agent strings at volume | Bot campaign |
| Geo-anomaly on auth endpoints | Credential stuffing |
| Path traversal / SQLi patterns logged but not blocked | WAF in monitor-only mode — fix this immediately |

**[[Time synchronization]]** matters: CDN edge logs are in UTC, your origin probably is too, but your SIEM correlator needs every clock aligned to **[[NTP]]** or your timeline reconstruction breaks during IR.

### CDN log formats and SIEM ingest

- Cloudflare → Logpush → S3/Splunk/Sentinel
- Akamai → DataStream → SIEM connector
- CloudFront → S3 → Athena or SIEM ingestion
- Fastly → real-time log streaming via syslog or HTTPS POST

Logging levels matter — debug/verbose at the CDN can blow up your **[[log ingestion]]** quota. Tune to: WAF events, 4xx/5xx, auth-path requests, admin-path requests. Sample the rest.

### CDN and sensitive data

CDNs cache content. If your app accidentally returns **[[PII]]**, **[[CHD]]** (cardholder data), or session tokens with `Cache-Control: public`, the CDN caches that response and may serve it to the next user requesting the same URL. This is a real incident pattern.

- Cache control headers must be `private` or `no-store` for any authenticated response
- **[[DLP]]** at the edge can scan outbound responses for PII/CHD patterns
- PCI DSS scoping: a CDN that terminates TLS for CHD-bearing traffic is **in scope** for PCI assessment
- **[[Sensitive data protection]]** review must include CDN cache behavior, not just origin behavior

### CompTIA exam traps

> **CompTIA exam trap:** CDN ≠ CASB ≠ SASE. CDN delivers content to users from edge caches. CASB brokers user access to SaaS apps. SASE is the umbrella that includes CDN-like edge functions plus ZTNA, CASB, SWG, and FWaaS. The exam will offer all four as options when one fits — read the question for whether the asset being protected is *your web property* (CDN) or *third-party SaaS* (CASB).

> **CompTIA exam trap:** TLS terminates at the CDN edge by default. Your origin sees the CDN's IP, not the user's IP. Without `X-Forwarded-For` parsing, every alert in your SIEM appears to originate from one of 10 Cloudflare IPs. Junior analysts chase the CDN as the attacker. The right answer: configure log enrichment to substitute the real client IP from the forwarded header.

> **CompTIA exam trap:** A CDN does not encrypt data at rest in your origin database, does not handle **[[IAM]]**, and does not provide **[[MFA]]**. It's a network-layer / application-layer edge control. If the exam asks about authentication or **[[SSO]]** or **[[passwordless]]** — CDN is wrong. If it asks about latency, DDoS, WAF, or edge inspection — CDN is right.

## SOC reality

- At 3am, the dashboard you check first is the CDN console — request volume, WAF block rate, error rate per origin. A CDN seeing 80k req/s on `/login` with 90% from one ASN is a credential stuffing campaign, not a marketing win.
- L1's first move on a "site is slow" page: check CDN cache hit ratio. If it dropped from 95% to 40% in five minutes, someone is cache-busting with random query strings (`?_=12345`) — apply a normalizing cache key rule at the edge.
- The IR lead asks: "Is the origin still reachable directly?" If yes, the CDN is decorative. Verify firewall rules on origin restrict inbound to CDN egress ranges only — *every* time, not just at deploy.
- Never tell leadership "we're protected by the CDN" — tell them "the CDN absorbs L3/L4 and most L7 volumetric attacks; origin hardening covers the rest; we have mTLS between edge and origin." Specificity is credibility.
- Escalation: L1 sees WAF spike → L2 reviews rule efficacy and false-positive rate → IR triggers if exploitation succeeded → app team patches origin → post-incident, the WAF rule gets tuned and a detection signature lands in **[[SIEM]]**.

## Related concepts

[[WAF]] · [[SASE]] · [[CASB]] · [[SSL]] · [[TLS]] · [[PKI]] · [[DDoS]] · [[network architecture]] · [[zero trust]] · [[network segmentation]] · [[log ingestion]] · [[time synchronization]] · [[DLP]] · [[PII]] · [[CHD]] · [[system hardening]] · [[cloud]] · [[hybrid]] · [[on-premises]] · [[SIEM]]

*Source: VIRGIL knowledge base — 2026-05-11*