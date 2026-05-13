# WAF — Web Application Firewall

## What it is

In **Fortnite**, when a squad pushes your build, you don't stand in the open and trade shots. You throw up walls, ramps, and a cone — a 1x1 box — between you and the incoming fire. The build absorbs the shotgun blast, the wall eats the pickaxe swing, and you peek out to fire back on your own terms. The enemy never touches you directly; they hit your structures first, and most give up and rotate before they crack the box.

That's exactly what a **WAF** does — it's a 1x1 box around your web app, soaking up hostile traffic before it touches the server.

Technical definition: a **Web Application Firewall** is a Layer 7 (HTTP/HTTPS) filtering control deployed in front of web applications to inspect, log, and block traffic based on rules targeting web-specific attacks — SQL injection, XSS, command injection, file inclusion, path traversal, deserialization, and the rest of the OWASP Top 10. Unlike a [[network firewall]] that filters by IP/port/protocol, a WAF parses the actual HTTP request: headers, URI, query string, body, cookies, method. It runs as a reverse proxy, inline appliance, host-based module (mod_security), or cloud service (AWS WAF, Cloudflare, Akamai, Azure Front Door).

A WAF is not an [[IPS]] and not a [[next-generation firewall]]. It is specialized for the web stack. It does not care about SMB lateral movement or DNS tunneling. It cares that someone just sent `' OR 1=1--` in the login field.

## Why it matters

Web apps are the front door. The marketing site, the customer portal, the API gateway — all of it sits on TCP/443 and gets hammered the second it goes public. **OWASP Top 10** vulns account for a huge slice of real-world breaches. A WAF is the compensating control when your dev team can't patch fast enough, the virtual-patch when a zero-day drops, and the logging tap that gives the SOC visibility into Layer 7 attacks the [[network firewall]] is blind to.

**Exam relevance (CS0-003 Objective 1.1):** the WAF is named in network architecture concepts alongside [[CASB]], [[SASE]], [[SDN]], [[zero trust]], and [[network segmentation]]. CompTIA wants you to know where the WAF sits, what it inspects, what it doesn't, and how it interacts with [[TLS]] termination and [[CDN]] deployment. They also test WAF vs [[RASP]] and WAF vs [[IPS]].

## Key facts

### Where it sits

A WAF is a **reverse proxy** — clients hit the WAF, the WAF inspects, the WAF forwards (or drops).

| Deployment | Where it lives | Typical use |
|---|---|---|
| **Network-based** | Hardware appliance in the DMZ | On-prem, low-latency, expensive |
| **Host-based** | Software module on the web server (mod_security) | Cheap, deep app context, eats server CPU |
| **Cloud-based** | SaaS in front of your DNS (Cloudflare, AWS WAF, Akamai) | DDoS scrubbing included, fastest to deploy |

In [[hybrid]] or [[cloud]] architecture, cloud WAFs dominate because they're part of the [[SASE]] / [[CDN]] bundle. Flow: client → DNS → [[CDN]] / WAF edge → origin server.

### What it inspects (and what it can't)

WAFs inspect **decrypted HTTP**. [[TLS]] termination happens at the WAF — it holds the cert, decrypts, inspects, then re-encrypts to the origin or talks plaintext on the trusted segment. **No TLS termination, no inspection.**

Inspected: HTTP method, URI, query string, headers, cookies, request body (form/JSON/XML/multipart), response body for exfil patterns.

Not inspected (or poorly): WebSocket frames after upgrade, gRPC binary payloads, anything inside an encrypted blob the WAF can't decrypt, non-HTTP protocols entirely.

### Detection models

**Negative security model (blocklist):** signatures of known bad — SQLi patterns, XSS payloads, known scanner User-Agents. Fast to deploy, easy to bypass with encoding tricks. This is the OWASP **Core Rule Set (CRS)** approach.

**Positive security model (allowlist):** define valid traffic — this endpoint accepts POST with this JSON schema, nothing else. Harder to bypass, brutal to tune, breaks every time devs ship a new endpoint without telling you.

Most real WAFs run **hybrid** — CRS for the floor, custom rules for high-value endpoints (login, password reset, payment, admin).

### Modes

- **Detection (monitor / log-only):** the WAF logs what it would have blocked. This is where you start. Always.
- **Prevention (blocking):** the WAF drops, resets, or returns 403. This is where you end up after weeks of tuning.

*Flipping straight to blocking mode without a monitor-only baseline is how the marketing team finds out their bulk-upload form looks exactly like a SQL injection attempt.*

### Common rules and what they catch

| Rule family | Catches | OWASP mapping |
|---|---|---|
| SQLi signatures | `' OR 1=1`, `UNION SELECT`, `WAITFOR DELAY` | A03 Injection |
| XSS signatures | `<script>`, `javascript:`, `onerror=` | A03 Injection |
| Path traversal | `../`, `..%2f`, encoded variants | A01 Broken Access Control |
| RFI/LFI | `php://`, `file://`, remote URL in include params | A03 Injection |
| Command injection | `;`, `|`, backticks, `$()` in unexpected fields | A03 Injection |
| Rate limiting | Login brute-force, credential stuffing | A07 Auth Failures |
| Geo / IP reputation | Traffic from known-bad ASNs, Tor exits | Custom |
| Bot management | Headless Chrome fingerprints, missing JS challenges | Custom |

### Virtual patching

When a CVE drops on your web framework and the patch will take three weeks through change control, the WAF gets a **virtual patch** — a custom rule that blocks the specific exploit pattern. Buys time. Not a real fix. *A virtual patch is a tourniquet, not a transplant — and tourniquets that stay on too long cause their own damage.*

### WAF vs the neighbors

| Control | Layer | Scope |
|---|---|---|
| **Network firewall** | L3/L4 | IP, port, protocol |
| **[[NGFW]]** | L3–L7 | Adds app-ID, user-ID, basic IPS |
| **[[IPS]]** | L3–L7 | Network-wide attack signatures, not web-specialized |
| **WAF** | L7 (HTTP) | Web app traffic only, deep HTTP parsing |
| **[[RASP]]** | Inside the app | Runtime, sees the actual code path being executed |
| **[[CASB]]** | L7 SaaS API | Visibility and policy on cloud apps |

### CompTIA exam traps

> **CompTIA exam trap:** WAF vs IPS. An IPS is general-purpose network attack prevention; it parses HTTP shallowly. A WAF is HTTP-specialized — it understands cookies, sessions, request bodies. CompTIA will give you a SQL injection scenario and the wrong answer will be "IPS." The right answer is WAF.

> **CompTIA exam trap:** WAF and TLS. A WAF cannot inspect what it cannot decrypt. If the question says "the WAF is missing attacks" and mentions end-to-end encryption to the origin with no TLS termination at the edge — that's the gap.

> **CompTIA exam trap:** WAF is not a substitute for secure coding. The exam will ask "best long-term mitigation for SQL injection." WAF is *a* mitigation. **Parameterized queries / prepared statements** is the answer. WAF is compensating control, not root-cause fix.

> **CompTIA exam trap:** WAF placement in zero trust. In a [[zero trust]] architecture, the WAF is one of several enforcement points — it does not replace [[MFA]], [[IAM]], or [[microsegmentation]]. Don't pick "WAF" when the question is really about identity.

### Logging and SIEM integration

WAF logs are gold for the [[SOC]]. Every block ships to the [[SIEM]] via syslog, CEF, or a cloud connector. What you want in the log:

- Source IP, geo, ASN
- Full request line (method, URI, query)
- Matched rule ID and rule family
- Action taken (allow, log, block, challenge)
- Session/correlation ID for tying to app logs
- Response code and size
- TLS fingerprint (JA3/JA4 if available)

[[Log ingestion]] of WAF data feeds threat hunts: spike in 403s from a single ASN = scanner sweep; sudden flood of 200s with anomalous URIs after a CVE drop = exploit attempt that *got through*. Cross-reference with app logs and [[time synchronization]] — if [[NTP]] drift between WAF and app server exceeds a few seconds, you cannot correlate the same request across both, and your investigation falls apart.

### Tuning is the job

A WAF out of the box throws false positives at every CMS and every weird-but-legitimate API call. Tuning means:

1. Run in detection mode for 2–4 weeks per app
2. Pull the top firing rules
3. For each: real attack, false positive, or noise?
4. Exception, refine, or promote to block
5. Repeat forever

*Untuned WAFs get bypassed by attackers and disabled by developers. Both outcomes are the same: you have no WAF.*

## SOC reality

- **The 3am alert** rarely says "WAF blocked attack." It says "WAF rule SQLI-942100 fired 18,000 times in 10 minutes from 47 source IPs." That's a scan or a real campaign — you check rule confidence, payload, and whether *any* requests got through before blocking turned on.
- **L1's first move:** confirm block action (not just detect), pull the source IPs, check threat intel reputation, check if any 200 responses came back to the same IPs. If a single 200 went through during the window, escalate to L2 — assume the app saw the payload.
- **What the IR lead asks:** "Was the WAF in blocking mode for that rule? When did we last tune it? Are origin servers reachable directly, bypassing the WAF?" If your origin has a public IP and DNS points anywhere else, the WAF is bypassable and the attacker probably knows.
- **Never promise leadership** "the WAF stopped it." Promise "the WAF logged X blocks; we are validating origin logs to confirm no successful exploitation." A WAF alert is not a contained incident.
- **Handoff:** L1 triages WAF noise. L2 tunes rules and writes virtual patches. IR owns the incident if origin logs show the payload landed. AppSec owns the root-cause code fix.

## Related concepts

[[Network firewall]] · [[NGFW]] · [[IPS]] · [[RASP]] · [[CASB]] · [[SASE]] · [[CDN]] · [[Zero trust]] · [[Network segmentation]] · [[TLS]] · [[SSL]] · [[OWASP Top 10]] · [[SQL injection]] · [[XSS]] · [[SIEM]] · [[Log ingestion]] · [[Time synchronization]] · [[Virtual patching]] · [[Reverse proxy]] · [[SDN inspection]]

*Source: VIRGIL knowledge base — 2026-05-11*