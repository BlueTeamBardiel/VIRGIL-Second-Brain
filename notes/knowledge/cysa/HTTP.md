# HTTP — Hypertext Transfer Protocol

## What it is

In **Fallout 3**, every terminal in the Capital Wasteland speaks the same dialect — you walk up to a Protectron kiosk, a Vault-Tec mainframe, a raider's locked footlocker terminal, and the prompt is the same green-on-black request-response loop. You type a command, the terminal answers, you type another. No memory of who you are between sessions unless someone bolted on a password check. That's HTTP — the universal request-response chatter every web client and server speaks, stateless by design, with bolt-on session tracking only because someone realized "no memory" was a bad idea for shopping carts.

**Plain English:** HTTP is the language browsers and web servers use to ask for pages and send back content. Client sends a request, server sends a response. That's it. The protocol itself remembers nothing between calls.

**Technical:** HTTP is a stateless, application-layer (OSI L7) request-response protocol over TCP port **80** (unencrypted) or **443** when wrapped in TLS as **HTTPS**. It defines methods (GET, POST, PUT, DELETE, HEAD, OPTIONS, PATCH), status codes (1xx-5xx), and a header structure that carries metadata about the request, the client, the content, and any auth tokens or cookies riding along.

For a CySA+ analyst, HTTP is the single most important protocol to read fluently. Most malware C2, most data exfil, most web exploitation, most phishing payload delivery — it all rides HTTP/HTTPS because port 443 is open everywhere and looks like normal browsing.

## Why it matters

CompTIA objective **CS0-003 1.3** is "use appropriate tools or techniques to determine malicious activity." HTTP is where the activity is. Email phishing links point to HTTP. Drive-by downloads use HTTP. Cobalt Strike beacons heartbeat over HTTPS. Data exfil to a Discord webhook is HTTPS POST. If you can't read an HTTP request in Wireshark and tell normal from malicious in 30 seconds, you can't do the job.

The exam will test you on header anomalies, suspicious User-Agent strings, beaconing patterns, and tool selection (Wireshark for packet capture, sandboxes for URL detonation, VirusTotal for IoC lookup). Real ops will test you on the same things at 2am with a queue of 60 tickets.

## Key facts

### Request structure

An HTTP request has three parts: **request line, headers, body**.

```
POST /api/v1/upload HTTP/1.1                        ← request line
Host: cdn.totally-legit-update[.]xyz                ← headers
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64)
Content-Type: application/json
Cookie: session=abc123
Content-Length: 482

{"host":"the primary DC","user":"svc_backup","data":"..."}    ← body
```

The **request line** = method + URI + version. The **headers** = key-value metadata. The **body** = optional payload (GET usually has none, POST usually does).

### Methods worth knowing

| Method | Purpose | Body | SOC interest |
|---|---|---|---|
| GET | Retrieve resource | No | C2 beacons often use GET with data in URI or cookies |
| POST | Submit data | Yes | Exfil, form submissions, webhook abuse |
| PUT | Replace resource | Yes | API abuse, webshell uploads |
| DELETE | Remove resource | No | Destructive API calls |
| HEAD | Headers only, no body | No | Recon, link validators |
| OPTIONS | Allowed methods | No | CORS preflight, also recon |
| CONNECT | Tunnel (proxy) | No | Proxy abuse, can tunnel anything |
| TRACE | Diagnostic echo | No | Should be disabled — XST attacks |

### Status codes — the five families

- **1xx informational** (rare, mostly 100 Continue)
- **2xx success** — 200 OK, 201 Created, 204 No Content
- **3xx redirect** — 301 permanent, 302 found, 304 Not Modified. Phishing kits love 302s to fingerprint targets before serving payload.
- **4xx client error** — 401 Unauthorized (needs auth), 403 Forbidden (auth doesn't help), 404 Not Found. A spike in 401/403 from one source = credential stuffing or directory brute force.
- **5xx server error** — 500 Internal, 502 Bad Gateway, 503 Unavailable. A spike in 5xx after a deploy = the deploy. A spike in 5xx with weird URIs = someone fuzzing the app looking for an injection.

### Headers that matter to a SOC analyst

| Header | What it says | What goes wrong |
|---|---|---|
| **Host** | Which virtual host you want | DGA domains, typosquats, freshly-registered domains |
| **User-Agent** | Client software string | Empty, mismatched, Python/curl/PowerShell in browser traffic = automation |
| **Referer** | Previous page | Missing on phishing landings; spoofed on click fraud |
| **Cookie** | Session/auth tokens | Base64 blobs that decode to commands = C2 |
| **Authorization** | Basic/Bearer credentials | Basic auth in plaintext over HTTP = harvested |
| **Content-Type** | Body MIME type | `application/octet-stream` on a "image upload" endpoint = payload delivery |
| **X-Forwarded-For** | Original client IP through proxies | Spoofable, but useful for tracking |
| **Origin** | Where the request came from (CORS) | Mismatched = CSRF/SSRF attempts |

### HTTP vs HTTPS — the visibility cliff

HTTP on port 80 is plaintext. Your Zeek/Suricata sensors see everything — URI, headers, body, cookies, posted credentials.

HTTPS on 443 is TLS-encrypted. Without TLS inspection (SSL decrypt at the proxy), you see only:
- Source/dest IP
- SNI (Server Name Indication, in TLS ClientHello — the domain)
- JA3/JA3S fingerprints (TLS client/server fingerprints)
- Cert details
- Byte counts and timing

This is why **beaconing detection** shifts from URI analysis to **timing analysis** (regular intervals), **size analysis** (consistent small POSTs), and **JA3 hashing** (unusual TLS client fingerprints — a Python `requests` JA3 hash showing up on a finance workstation is loud).

> **CompTIA exam trap:** HTTPS does not mean "safe." The lock icon means the channel is encrypted, not that the destination is trustworthy. Phishing kits have used Let's Encrypt certs since 2016. If a question says "user sees padlock therefore site is safe" — wrong. The padlock proves TLS, nothing else.

### Tools for reading HTTP

- **[[Wireshark]] / tcpdump** — packet capture. Filter `http` or `tcp.port == 80`. For HTTPS, you can decrypt if you have the session keys (`SSLKEYLOGFILE`) or are doing inline MITM at the proxy.
- **[[Zeek]] (formerly Bro)** — generates `http.log` with one line per request: method, host, URI, status, user-agent, response size. This is what your SIEM correlates.
- **Burp Suite / mitmproxy** — interactive proxies, mostly for app testing but useful for IR replay.
- **[[Sandboxing]] — Cuckoo Sandbox, Joe Sandbox, [[VirusTotal]] detonation** — submit a URL or sample and watch what HTTP it generates. The sandbox's network log tells you C2 domains, beacon intervals, and exfil destinations.
- **`curl` / `wget`** — manual request crafting. Every analyst should be fluent.

### Reading suspicious HTTP — the patterns

**Beaconing (C2 heartbeat):**
- Same source, same destination, regular interval (every 60s ± jitter)
- Small request, small response
- Often GET with cookie or POST with tiny body
- Domain is freshly registered, DGA-style, or a hijacked legitimate site

**Exfil:**
- Large POST bodies (or chunked over many small POSTs)
- Outbound to unusual destination
- Off-hours timing
- Content-Type lies (claims image, body is base64 archive)

**Webshell interaction:**
- Inbound POST to a path that shouldn't accept POSTs (`.jsp`, `.aspx`, `.php` in upload dirs)
- POST body contains commands (`cmd=whoami`, base64-encoded PowerShell)
- Server response carries command output

**Reconnaissance / scanning:**
- High volume of 404s from one source
- User-Agent is `Nmap NSE`, `Nikto`, `sqlmap`, `Nuclei`, or blank
- Sequential URI patterns (`/admin`, `/login`, `/wp-admin`, `/.env`)

**Living-off-the-land HTTP:**
- `User-Agent: Microsoft BITS/7.8` for unexpected downloads — BITS is a LOLBin
- PowerShell's default UA: `Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1...` — out of place on a non-admin host
- `python-requests/2.x` or `curl/7.x` on user workstations during business hours

### IoC enrichment workflow

When an HTTP IoC drops in your queue:

1. **Hash the payload** if you have it — MD5/SHA-256 to [[VirusTotal]] for reputation
2. **WHOIS the domain** — registration date, registrar, registrant. Domain registered 4 days ago = high suspicion
3. **AbuseIPDB the IP** — community reports of abuse
4. **DNS history** — passive DNS shows what else lived on that IP
5. **TLS cert** — SAN entries often reveal related infrastructure
6. **Search SIEM** — has anyone else in the org talked to this destination?

### CompTIA exam traps

> **Exam trap:** "Stateless" doesn't mean "no sessions." HTTP itself is stateless — the *protocol* doesn't track you. Sessions are bolted on via **cookies**, **tokens**, or **server-side session storage**. CompTIA may try to imply HTTP can't do logins. It can — through cookies.

> **Exam trap:** Tool selection questions. **[[Wireshark]]** = live or saved packet capture analysis. **[[Cuckoo Sandbox]] / [[Joe Sandbox]]** = automated malware detonation, observe behavior including HTTP. **[[VirusTotal]]** = reputation/IoC lookup, not live capture. **Strings** = pull printable strings from a binary, not network analysis. Match the tool to the verb in the question stem.

> **Exam trap:** Port confusion. HTTP = **80**. HTTPS = **443**. HTTP proxy alt = **8080** or **8443**. CompTIA will absolutely give you a port and ask the protocol, or vice versa.

> **Exam trap:** Methods vs status codes. A **POST** is a request method. A **201 Created** is a status code. CompTIA might list both in the answer choices and bank on you mixing them up.

## SOC reality

- **The alert:** SIEM fires "HTTP POST to newly-registered domain from finance workstation." You pivot to the Zeek `http.log`, see one POST every 90 seconds, body size 312 bytes consistent. That's beaconing. You don't have time to do this manually for every ticket — you tune the rule so newly-registered-domain + periodicity is one signal, not two alerts.

- **The first move:** Pull the [[PCAP]] or Zeek logs. Look at User-Agent, Host header, URI, response size, timing. If HTTPS, get JA3 and SNI. If you can't see content, you can still see shape.

- **The CISO question:** "Did data leave?" You answer in bytes outbound, not in feelings. "412KB POSTed over 47 minutes to a domain registered Tuesday" is an answer. "It looks bad" is not.

- **The escalation point:** L1 confirms beaconing pattern + suspicious domain → escalate to L2/IR. IR decides containment (block at proxy, isolate host, or watch-and-learn for attribution). L1 does not pull the network cable on a CFO's laptop without a call.

- **What never to promise:** *"We've blocked the C2."* You've blocked one domain. The implant has a fallback list, a DGA, or a backup channel over [[DNS]] or a CDN. Containment is a hypothesis until eradication closes it out.

- *The lesson from the war room: HTTP is loud if you know how to listen, and silent if you don't. The pcap was always there. The analyst who could read it was the variable.*

## Related concepts

[[HTTPS]] · [[TLS]] · [[Wireshark]] · [[Zeek]] · [[PCAP]] · [[SIEM]] · [[Beaconing]] · [[Command and Control]] · [[VirusTotal]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[WHOIS]] · [[AbuseIPDB]] · [[User Agent]] · [[JA3 Fingerprint]] · [[Webshell]] · [[Phishing]] · [[Data Exfiltration]] · [[DNS]] · [[Regular Expressions]]

*Source: VIRGIL knowledge base — 2026-05-11*