# DNS — Domain Name Service

## What it is

In **Street Fighter**, when you input quarter-circle-forward + punch, you don't actually launch a Hadouken — you launch a request. The game's input interpreter translates that motion into the move binding, fetches the animation, the hitbox data, the sound file, and *then* Ryu throws the fireball. You never see the lookup. You just see the fireball. If the input parser were broken or someone slipped a malicious binding into the move list, you'd press Hadouken and get a Shoryuken to the face from your own character.

That's exactly what **DNS** does — it's the input parser of the internet. Humans type `gmail.com`; the resolver translates that into `142.250.80.101` and hands the connection off. The user never sees the lookup. They just see the page load. And if someone slips a malicious binding into the resolution chain, the user types `gmail.com` and ends up on an attacker's credential-harvesting clone.

**Technical definition:** DNS is the hierarchical, distributed name resolution protocol that maps human-readable domain names to IP addresses (and other records). It runs UDP/53 for standard queries, TCP/53 for zone transfers and large responses, and TCP/853 for DNS-over-TLS. For a SOC analyst, DNS is the single richest source of intent signal on the network — every C2 callback, every phishing click, every data exfil tunnel touches DNS before it touches anything else.

## Why it matters

If you can read DNS logs, you can see almost every attack in motion before the payload even fires. Malware needs to call home. Phishing needs a landing domain. Exfil over DNS tunneling needs thousands of queries. All of it shows up in the resolver logs **before** the firewall or EDR knows anything is wrong. That's why CompTIA puts DNS analysis squarely inside **CS0-003 Objective 1.3** — determining malicious activity from tool output. The analyst who lives in DNS logs catches incidents the analyst who lives in EDR alerts misses by hours.

Career-wise: every SOC tier from L1 triage to senior threat hunter touches DNS. It's also the cheapest, highest-signal data source the org has — no agent required, just point the resolver at a logging sink.

## Key facts

### Record types you will see on the exam and in the queue

| Record | Purpose | Why SOC cares |
|---|---|---|
| **A** | Hostname → IPv4 | Most queries; baseline behavior |
| **AAAA** | Hostname → IPv6 | Often forgotten in egress filtering — exfil hides here |
| **CNAME** | Alias → another name | Used in fast-flux and CDN-fronted C2 |
| **MX** | Mail exchanger | Pivot point for impersonation and spoofing checks |
| **TXT** | Arbitrary text | Holds **SPF**, **DKIM**, **DMARC** records; also abused as a C2 covert channel |
| **NS** | Authoritative nameserver | Hijack detection — did the NS suddenly change? |
| **PTR** | Reverse lookup (IP → name) | Used in log enrichment |
| **SRV** | Service location | Internal AD reconnaissance signal |

### Email authentication trio — all three live in DNS TXT records

CompTIA tests this constantly. All three are **published as DNS TXT records** on the sender's domain, queried by the recipient mail server.

- **SPF (Sender Policy Framework)** — TXT record listing which IPs are allowed to send mail for the domain. Recipient does a DNS query, compares envelope-from IP to the SPF list. Fail = suspect.
- **DKIM (DomainKeys Identified Mail)** — sender signs the message with a private key; recipient pulls the public key from DNS and verifies the signature. Proves the message wasn't altered in transit.
- **DMARC (Domain-based Message Authentication, Reporting, and Conformance)** — policy record that tells the recipient what to do when SPF *or* DKIM fails: `p=none` (monitor only), `p=quarantine` (junk it), `p=reject` (drop it). Also defines where the recipient sends aggregate failure reports.

> **CompTIA exam trap:** SPF authenticates the envelope sender (the SMTP `MAIL FROM`), not the `From:` header the user sees. An attacker can pass SPF and still spoof the visible From address. DMARC closes this gap by requiring **alignment** between the visible From domain and the SPF/DKIM-validated domain. If the question is "which control prevents the user from seeing a spoofed From line," the answer is DMARC, not SPF.

### Malicious DNS patterns the analyst hunts

**Domain Generation Algorithms (DGA)** — malware generates hundreds of pseudo-random domains per day (`xqz4lkj9.biz`, `p8sdfk2m.info`) and tries each one until it hits the attacker's registered C2 of the day. Signal: high volume of NXDOMAIN responses from one endpoint, queries to high-entropy hostnames, short TTLs.

**DNS tunneling** — payload data is base32-encoded into subdomains (`aGVsbG8gd29ybGQ.attacker.com`) and the response carries data back in TXT records. Signal: enormous TXT query volume, abnormally long query names, query rate that doesn't match any legitimate workload. This is **command and control** and exfil hiding in plain sight on UDP/53, which most orgs let out.

**Fast flux** — single domain resolves to dozens of rotating IPs with very short TTL (30–60 seconds). Defeats IP-based blocklists. Signal: low TTL + rapidly changing A records.

**Typosquatting / homoglyph domains** — `paypa1.com`, `microsоft.com` (Cyrillic 'о'). Picked up by string-distance analysis against your known-good corporate domain list.

**Newly registered domains (NRD)** — most phishing campaigns use domains registered within the last 30 days. **WHOIS** lookup gives you registration date. Block or alert on any first-time-seen domain younger than 30 days and you kill a huge chunk of phishing before the click.

### The tools that pull this apart

| Tool | What it does | When you reach for it |
|---|---|---|
| **WHOIS** | Registration metadata — registrar, creation date, registrant | Triaging a suspicious domain from a phishing email |
| **dig / nslookup** | Manual DNS queries | Verifying records, checking SPF/DKIM/DMARC, reproducing what a victim saw |
| **VirusTotal** | Multi-engine reputation on domains/IPs/hashes | First-pass reputation check on any IoC |
| **AbuseIPDB** | Crowd-sourced IP reputation | Pivot from a DNS resolution to an IP — is anyone else reporting it? |
| **Wireshark** | Packet capture and protocol decode | When the resolver logs aren't enough and you need to see the actual query/response bytes |
| **passive DNS (pDNS)** | Historical record of who resolved what to what, when | Threat hunting across time — "did this domain ever resolve to a known-bad IP?" |
| **Sandboxes (Cuckoo, Joe Sandbox)** | Detonate suspicious file/URL, observe DNS callouts | Extract C2 domains from a malware sample before it hits production |

### Interpreting suspicious DNS in the SIEM

Your SIEM should be ingesting either Sysmon Event ID 22 (DNS query), Windows DNS Analytical logs, or resolver logs (BIND query log, Unbound, AD DNS). Correlation rules to write:

- Endpoint generates > N NXDOMAIN responses in 5 minutes → possible DGA
- Query length > 50 characters → possible tunneling
- TXT query volume from a single host exceeds baseline → possible exfil
- Query to domain registered < 30 days ago → possible phishing infrastructure
- Resolution to an IP on threat intel feed → known-bad callout
- DNS query from a process that has no business doing DNS (e.g., `notepad.exe` querying an external domain) → pivot to EDR immediately

> **CompTIA exam trap:** A DNS query alone is not proof of compromise. The query may have come from a browser preview, an email client rendering a link, an EDR sandbox detonation, or a security tool itself doing reputation lookups. Always correlate the DNS event with **process-level telemetry** (which PID made the query?) before calling it an incident. CompTIA loves the question where the "obvious" answer is "block the domain" and the right answer is "investigate the originating process."

### DNS in the kill chain

DNS shows up at almost every phase:

- **Reconnaissance** — attacker enumerates your subdomains, MX records, NS records
- **Delivery** — phishing email contains a link to a malicious domain (the user's mail client does the DNS lookup, often pre-click via link preview)
- **Command and control** — beacon resolves the C2 domain, often through a DGA or fast-flux
- **Exfiltration** — DNS tunneling over TXT records
- **Actions on objectives** — domain hijack of the victim's own infrastructure

## SOC reality

- The 3am alert is rarely "malware detected." It's usually "host generated 4,200 NXDOMAIN responses in the last hour." You pull the process tree from EDR, confirm it's not Chrome doing prefetch nonsense, and if it's `svchost.exe` or some unsigned binary, you're in a DGA-driven C2 investigation. Containment call goes up the chain.
- L1's first move on a phishing report: pull the URL out of the headers, **WHOIS** the domain, hit **VirusTotal** and **AbuseIPDB**, check the SPF/DKIM/DMARC results in the original email's `Authentication-Results` header. Five minutes, done. Escalate if anything is sketchy or if more than one user reported it.
- The CISO does not ask "what DNS records did you query." The CISO asks: *"Did anyone else in the org resolve that domain? When did the first resolution happen? Is the host containing now?"* You need passive DNS and SIEM correlation queries ready before they ask.
- Never promise leadership "we've blocked the domain so we're safe." The attacker rotates domains in minutes. Blocking is a speed bump, not a fix. The fix is finding every host that already resolved it and triaging each one.
- Handoff point: L1 confirms the IoC and scopes initial impact. L2 / IR takes over once there's evidence of C2 or lateral movement. Legal and comms get looped in only when data exfil is confirmed or strongly suspected — never on speculation.

*The DNS log is the cheapest, loudest signal you'll ever get. Tune it well and you'll see attacks before the attacker finishes typing.*

## Related concepts

[[SIEM]] · [[EDR]] · [[Phishing]] · [[Email analysis]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[WHOIS]] · [[VirusTotal]] · [[AbuseIPDB]] · [[Wireshark]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[Command and control]] · [[DNS tunneling]] · [[Domain generation algorithm]] · [[Indicators of compromise]] · [[Log analysis and correlation]] · [[Passive DNS]] · [[Threat intelligence]]

*Source: VIRGIL knowledge base — 2026-05-11*