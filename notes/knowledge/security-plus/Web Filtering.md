# Web Filtering

## What it is

In Grand Theft Auto V, when you try to drive into the military base at Fort Zancudo, an invisible boundary triggers a four-star wanted level the moment you cross it — the game decides certain destinations are off-limits and intervenes before you reach them. That's exactly what web filtering does — it inspects where users are trying to go on the internet and blocks the destinations the organization has decided are forbidden.

**Web filtering** is a security control that inspects outbound web traffic and permits, blocks, or modifies access based on URL, domain, IP, content category, or payload characteristics.

## Why it matters

Without filtering, users browse to malware drops, phishing pages, command-and-control infrastructure, and category-violating content (gambling, adult, illegal) on corporate endpoints — turning every browser into an unmanaged ingress point. Compliance regimes (PCI DSS, HIPAA, CIPA for schools) explicitly require category filtering and logging. SY0-701 Objective 4.5 lists web filtering with these exact sub-bullets the exam will test: **agent-based**, **centralized proxy**, **URL scanning**, **content categorization**, **block rules**, and **reputation**. CompTIA's favorite trap: distinguishing **agent-based** (filtering follows the device off-network) from **centralized proxy** (only works when traffic traverses the corporate network) — and pairing the right one with remote/hybrid workforces.

## Key facts

### Deployment models

| Model | How it works | Best for | Weakness |
|---|---|---|---|
| **Agent-based** | Software on the endpoint enforces policy regardless of network | Remote/roaming users, BYOD with MDM | Agent can be killed/uninstalled if not hardened |
| **Centralized proxy** | All web traffic routed through a [[forward proxy]] (explicit or transparent) for inspection | On-prem corporate LAN | Useless when user is off-VPN |
| **DNS-based filtering** | Resolver refuses or sinkholes blocked domains ([[DNS filtering]]) | Lightweight, fast, simple to deploy | Can be bypassed with hardcoded resolvers, [[DoH]], [[DoT]] |
| **Cloud [[SWG]]** (Secure Web Gateway) | Traffic tunneled to cloud inspection point ([[Zscaler]], [[Netskope]]) | Hybrid workforce, [[SASE]] architectures | Latency, vendor dependency |

### Filtering mechanisms

- **URL scanning** — exact-match or wildcard against a list (`*.malicious.example/*`).
- **Content categorization** — vendor-maintained taxonomy (Gambling, Adult, Malware, Phishing, Social Media, Anonymizer). Each domain gets one or more category tags; policy applies per category.
- **[[Reputation]]-based filtering** — score derived from age of domain, hosting history, prior abuse reports, certificate anomalies. Newly registered domains ([[NRD]]) commonly auto-blocked because phishing kits rotate fast.
- **Block rules** — explicit allow/deny lists override category logic. Order of evaluation matters: typically allow-list → block-list → category → default.
- **[[TLS inspection]]** — decrypt-inspect-re-encrypt via internal CA cert pushed to endpoints. Without it, you can only see SNI and destination IP, not the URL path or payload. Breaks [[certificate pinning]] apps.

### What gets enforced

- **Malicious content** — phishing, malware delivery, [[C2]] callbacks, [[exploit kit]] landing pages
- **Acceptable Use Policy ([[AUP]])** — productivity, harassment, legal liability categories
- **Data loss prevention** — block uploads to unsanctioned cloud storage ([[shadow IT]])
- **Bandwidth** — streaming/recreational categories throttled or blocked

### Bypass techniques candidates should recognize

- [[DNS-over-HTTPS]] (DoH) hides DNS queries from network-based DNS filters
- [[VPN]] / [[Tor]] / [[anonymizer]] proxies — categorized and blocked by reputation engines
- Direct-to-IP requests bypassing DNS-only filters
- Encrypted [[ESNI]]/[[ECH]] hides the SNI hostname during TLS handshake

### Logging and exam angle

Web filter logs feed the [[SIEM]] for threat hunting — outbound connections to known-bad domains are a primary [[IoC]] source. The exam likes pairing web filtering with **[[DLP]]**, **[[CASB]]**, and **[[SASE]]** in scenario questions about hybrid workforces.

## Related concepts

[[Forward Proxy]] · [[DNS Filtering]] · [[Secure Web Gateway]] · [[CASB]] · [[SASE]] · [[TLS Inspection]] · [[Content Categorization]] · [[URL Filtering]] · [[Reputation Services]] · [[Acceptable Use Policy]]

---
*Source: VIRGIL knowledge base — 2026-05-08*