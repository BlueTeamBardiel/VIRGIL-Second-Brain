# SWG — Secure Web Gateway

## What it is

In **Battlefield**, every flag on a Conquest map has a capture radius. You don't get to stand on the flag because you feel like it — you have to walk through the contested zone, get scanned by spawn beacons, eat suppression fire, and survive the squad watching the chokepoint. The map funnels every player through a handful of corridors on purpose. That's exactly what a Secure Web Gateway does — it's the chokepoint every outbound web request has to walk through before it touches the internet.

A **Secure Web Gateway (SWG)** is a forward proxy that sits between users and the public internet, inspects every HTTP/HTTPS request leaving the network, and enforces policy on what's allowed out and what comes back. URL filtering, malware scanning, **TLS/[[SSL]] inspection**, **[[DLP]]** for data going outbound, sandboxing of downloaded files, application controls — all in one inline appliance or cloud service.

Plain English: the firewall decides if a packet is allowed through. The SWG decides if the *content* of that web session is allowed. A firewall doesn't know that `cdn.totally-legit-update[.]ru/payload.exe` is a Cobalt Strike beacon. The SWG does, because it cracked the TLS, looked at the file, ran it through reputation feeds, and either blocked it or sandboxed it before your accountant's browser executed it.

CS0-003 lumps SWG in with **[[CASB]]**, **[[SASE]]**, **[[Zero Trust]]**, and **[[SDN]]** under network architecture concepts. They overlap. The SWG is the web-traffic-inspection piece of the bigger picture.

## Why it matters

The browser is the new endpoint. The vast majority of malware delivery in 2026 happens through the web — drive-by downloads, malicious ads, phishing landing pages, fake software updates, browser-in-the-browser attacks, OAuth consent phishing, exfil over HTTPS to an attacker-controlled SaaS bucket. Email gets the blame; the web gets the click.

Without an SWG, the SOC has two visibility options for outbound web traffic: NetFlow (knows the destination IP and bytes, doesn't know the URL or content) and endpoint logs (knows the URL but only after the request fired and only if EDR was watching). The SWG gives you the missing layer — full URL, full user identity, full content classification, full DLP inspection, **before** the request leaves.

**Exam relevance — Objective CS0-003 1.1.** You need to know what an SWG inspects, where it sits, how it differs from a CASB, how it composes into a SASE architecture, and why TLS inspection requires a PKI deployment. Expect questions that hand you a scenario ("users are bypassing the corporate proxy by tethering to mobile hotspots") and ask which control fixes it.

## Key facts

### What the SWG actually inspects

| Layer | What it does | Why it matters |
|---|---|---|
| **URL filtering** | Categorizes destination (gambling, malware, newly-registered domain, social) and blocks by policy | First line — stops the user from reaching the bad place at all |
| **TLS/SSL inspection** | Terminates TLS, decrypts, re-encrypts with internal CA cert | Without this, the SWG is blind to 95%+ of modern web traffic |
| **Malware scanning** | AV signatures + sandbox detonation on downloads | Catches known and zero-day file-based threats |
| **DLP** | Pattern-matches outbound content (PII, PHI, CHD, source code) | Stops exfil over web upload, webmail, paste sites |
| **Application control** | Blocks/allows specific SaaS features (e.g., allow Google Drive read, block uploads) | Granular control where URL filtering is too blunt |
| **Bandwidth/QoS** | Rate-limits or blocks streaming, large downloads | Operational, not security, but bundled |
| **Logging** | Every request, user, URL, verdict, byte count | The reason SOC loves SWG — searchable web telemetry |

### Where it sits — three deployment modes

**On-premises appliance.** Physical or virtual box in the DMZ. All web traffic routed through it via PAC file, WPAD, or explicit proxy config. Works great until the user leaves the office — then their laptop has no SWG between it and the internet.

**Cloud SWG.** SaaS service (Zscaler, Netskope, Cloudflare Gateway, Cisco Umbrella SIG). Endpoint agent or DNS redirection sends traffic to the nearest cloud PoP for inspection. Works wherever the user is — home, coffee shop, hotel. This is the dominant model in 2026.

**Hybrid.** On-prem appliance for office traffic, cloud SWG for roaming users, unified policy console. Common in regulated industries where some data can't leave the building for inspection.

### TLS inspection — the part that breaks things

TLS inspection is technically a sanctioned man-in-the-middle. The flow:

1. User's browser tries to connect to `https://example.com`
2. SWG intercepts, opens its own TLS connection to `example.com`, gets the real cert
3. SWG generates a new cert for `example.com` signed by the **internal corporate CA**
4. SWG presents that cert to the user's browser
5. Browser trusts it *only because* the corporate CA is installed in the OS/browser trust store via **[[PKI]]** deployment (GPO, MDM, Jamf)

This requires:

- **A working internal PKI** with a CA cert pushed to every managed endpoint
- **Cert pinning exclusions** — apps that pin certs (banking, some mobile apps, Microsoft 365 endpoints, certificate transparency logs) will break and must be bypassed
- **Legal/HR signoff** — you are decrypting employee web traffic. There must be a published policy.

> **CompTIA exam trap:** TLS inspection ≠ defeating encryption. The traffic is still encrypted on both sides of the SWG. The SWG is a trusted endpoint in the middle, not a cryptographic attack. Questions that frame TLS inspection as "breaking SSL" are testing whether you understand the proxy model.

### SWG vs CASB vs SASE — the constant confusion

| Tool | Scope | Primary control point |
|---|---|---|
| **SWG** | All outbound web/HTTPS traffic | Inline proxy |
| **CASB** | Sanctioned SaaS apps (M365, Salesforce, etc.) | API integration + inline |
| **SASE** | Architecture that bundles SWG + CASB + ZTNA + FWaaS + SD-WAN | Cloud-delivered network edge |

**SWG asks:** "Should this user be allowed to reach this URL, and is the content safe?"
**CASB asks:** "Inside this sanctioned SaaS app, is this user doing something they shouldn't — sharing files externally, downloading the whole CRM, creating a public link?"
**SASE asks:** "Why do we have five separate consoles when we could have one?"

> **CompTIA exam trap:** CASB is *not* the same as SWG. CASB has API mode (reads SaaS tenant logs, finds exposed shares, no traffic interception) and inline mode (proxy-like). SWG only does inline. If a question is about *discovering shadow IT exposed in OneDrive*, that's CASB. If a question is about *blocking users from reaching a malware URL*, that's SWG.

### SWG in the Zero Trust model

[[Zero Trust]] says: no implicit trust based on network location. Every request authenticated and authorized. SWG plays a role:

- **Identity-aware policy** — SWG integrates with **[[IAM]]** / **[[SSO]]** so policy is per-user, not per-IP. Finance team can reach payroll SaaS; marketing can't.
- **Device posture** — SWG can require the endpoint has EDR running, disk encryption on, OS patched, before allowing access to sensitive categories.
- **No "inside the office = trusted"** — same SWG policy applies whether you're on the corporate LAN or at a Starbucks. Network location stops being a security boundary.

### Logging — what the SOC actually gets

Every SWG transaction log entry typically contains:

- Timestamp (NTP-synchronized — see [[Time synchronization]], because correlating SWG logs with EDR and firewall logs requires sub-second accuracy)
- User identity (from SSO/SAML, not just IP)
- Source IP, destination IP, destination URL, HTTP method
- Category, reputation score, verdict (allow/block/quarantine)
- Bytes sent/received, user agent, referrer
- DLP matches (which policy, which pattern, redacted snippet)
- File hash + sandbox verdict if a download fired

This feeds the **[[SIEM]]** via syslog, CEF, or a cloud connector. Logging level matters — full transaction logging on a 10,000-user enterprise generates billions of events per day. Most shops log allow+block at info level, debug only when troubleshooting.

### What breaks with SWG (the war-room reality)

- **Cert-pinned apps** — Teams desktop client, banking apps, some mobile MDM agents. Bypass list grows over time.
- **WebSocket / non-HTTP protocols over 443** — some apps tunnel custom protocols and break under inspection
- **Latency** — every request now hops through the proxy. Cloud SWGs solve this with anycast PoPs; on-prem can become a bottleneck
- **Roaming users without the agent** — SWG only works if traffic reaches it. Captive portals, VPN split-tunneling, personal devices all create blind spots
- **Encrypted DNS (DoH/DoT)** — if the browser does its own DoH to Cloudflare or Google, the SWG never sees the DNS query and URL category lookups get bypassed. Block DoH at the firewall or force the browser to use enterprise DNS.

## SOC reality

- The SWG console is open in a tab 24/7. When a phishing report comes in, the first triage move is: "did anyone else hit that URL in the last 7 days, and did the SWG block it or pass it?" The answer scopes the incident in 30 seconds.
- *An SWG block is not the same as a contained incident.* The SWG blocked the second-stage download — fine. The first-stage macro already ran. The endpoint may still be compromised through a different channel. Never close the ticket on SWG telemetry alone.
- The CISO asks: "are we inspecting TLS?" The honest answer is usually "yes, except for [list of 47 bypass categories]." Banking, healthcare patient portals, government sites, and anything that broke when inspected. The bypass list is the real attack surface.
- DLP hits on the SWG generate a different ticket queue than malware hits. Outbound 50MB upload to a personal Dropbox tagged with PII patterns is an HR-and-legal call, not an IR call. Know which queue is which.
- The handoff: L1 triages the SWG alert against EDR and email logs. If the user clicked and the SWG blocked, document and close. If the SWG passed and EDR is now screaming, escalate to L2 / IR. *The SWG is the canary; EDR is the autopsy.*

## Related concepts

[[CASB]] · [[SASE]] · [[Zero Trust]] · [[DLP]] · [[PKI]] · [[SSL]] · [[Network segmentation]] · [[IAM]] · [[SSO]] · [[MFA]] · [[SIEM]] · [[Time synchronization]] · [[SDN]] · [[Cloud security]] · [[Hybrid architecture]]

*Source: VIRGIL knowledge base — 2026-05-11*