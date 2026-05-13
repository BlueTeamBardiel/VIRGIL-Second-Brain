# CASB — Cloud Access Security Broker

## What it is

In **StarCraft**, a Terran player walls off the ramp with Supply Depots and a Barracks, then parks a Bunker behind it. Every Zergling that wants into the main base has to squeeze through that chokepoint — and the Marines inside the Bunker get to decide what lives, what dies, and what gets reported to the minimap. The wall doesn't replace the rest of your defense. It funnels traffic through one inspectable seam. That's exactly what a CASB does — it's the chokepoint you build between your users and the cloud apps they're using, so every upload, download, and login has to walk past your guards.

Technically: a **Cloud Access Security Broker** is a policy enforcement point that sits in the traffic path between cloud consumers and cloud service providers. It enforces enterprise security policies — authentication, authorization, [[encryption]], [[DLP]], malware scanning, activity logging, anomaly detection — on traffic destined for SaaS, IaaS, and PaaS platforms the org doesn't own. Gartner originally framed CASB on four pillars: **visibility, compliance, data security, threat protection.** Memorize those four. CompTIA likes them.

## Why it matters

The org's perimeter dissolved the moment Finance started uploading spreadsheets to a personal Dropbox and Marketing signed up for a SaaS tool on a corporate card without telling anyone. That's **shadow IT**, and it's the default state of every company over fifty people. Your firewall logs show the DNS query to `dropbox.com`; they don't show what file got uploaded, who uploaded it, or whether it contained [[PII]] or [[CHD]]. A CASB does.

For CS0-003 Objective 1.1, CASB shows up as part of the cloud and [[hybrid]] architecture toolkit alongside [[SASE]], [[Zero Trust]], and [[SDN]]. The exam wants you to know *where* a CASB lives in the architecture, *what* it inspects, and *how* it differs from a [[DLP]] appliance or a forward proxy. In the field, CASB is how the SOC gets log ingestion from cloud apps that don't natively talk to your [[SIEM]] — it's the broker, the translator, the chokepoint, all in one.

## Key facts

### The four pillars (memorize these)

| Pillar | What it does | SOC artifact |
|---|---|---|
| **Visibility** | Discovers sanctioned and unsanctioned cloud apps in use | Shadow IT report, app risk scores |
| **Compliance** | Enforces regulatory controls (PCI, HIPAA, GDPR) on cloud data | Audit logs, policy violation events |
| **Data security** | DLP, encryption, tokenization, access controls on cloud-stored data | DLP alerts, blocked uploads |
| **Threat protection** | UEBA, malware scanning, anomaly detection on cloud activity | Impossible-travel alerts, mass-download events |

### Deployment modes

CompTIA loves making you pick the right mode for the scenario. There are three, and they have real tradeoffs:

**API-based (out-of-band).** The CASB talks to the SaaS provider's management API (Microsoft 365, Salesforce, Google Workspace). No traffic redirection. The CASB sees activity *after* it happens, scans data *at rest* in the cloud tenant, and can quarantine retroactively. Pros: zero latency, sees managed devices and unmanaged equally, covers east-west cloud-to-cloud. Cons: not real-time — a malicious upload exists for seconds-to-minutes before the CASB notices and yanks it.

**Forward proxy (in-band).** Endpoint agent or PAC file routes user traffic through the CASB before it hits the cloud. Real-time inspection, can block on the way out. Pros: real-time enforcement, sees unsanctioned apps. Cons: only works on managed endpoints with the agent, breaks if the user is on a BYOD device or off-VPN.

**Reverse proxy (in-band).** Identity provider redirects authenticated sessions through the CASB. No agent. Works on unmanaged devices. Pros: BYOD coverage, real-time. Cons: only works for apps integrated with your [[SSO]] / [[federation]] — and certificate pinning in mobile apps breaks reverse proxy regularly.

> **CompTIA exam trap:** If the scenario says "unmanaged BYOD device accessing Office 365" — that's **reverse proxy** territory. If it says "discover shadow IT and scan data at rest in Salesforce" — that's **API-based**. If it says "block uploads of sensitive data in real time from corporate laptops" — that's **forward proxy**. CompTIA will give you the constraint and expect you to pick the mode.

### Where CASB sits in the architecture

```
[ User ] ──► [ IdP / SSO ] ──► [ CASB ] ──► [ Cloud SaaS/IaaS ]
                                  │
                                  ├──► SIEM (log ingestion)
                                  ├──► DLP engine
                                  └──► Threat intel feed
```

CASB is the **policy enforcement point**. The [[IAM]] system authenticates *who* you are. The CASB decides *what you can do once you're in*. That separation matters — they are not the same control, and CompTIA tests the distinction.

### CASB vs SASE vs SWG vs DLP

These overlap, and the exam will try to confuse them:

- **CASB** — cloud apps specifically. SaaS-aware. Knows the difference between "share externally" and "share internally" in SharePoint.
- **SWG (Secure Web Gateway)** — all web traffic. URL filtering, malware scanning. Doesn't understand cloud-app semantics.
- **[[DLP]]** — content inspection. Lives anywhere — endpoint, network, cloud. A CASB *uses* DLP engines as one of its functions.
- **[[SASE]]** — the umbrella architecture. SASE = SD-WAN + SWG + CASB + ZTNA + FWaaS, delivered as cloud edge. CASB is a *component* of SASE, not a replacement for it.

### What CASB actually enforces

| Control | Example |
|---|---|
| **Authentication** | Require [[MFA]] before accessing Box from off-network |
| **Authorization** | Block external share links containing [[PII]] |
| **Encryption / Tokenization** | Encrypt CHD before it hits the SaaS tenant |
| **DLP** | Quarantine uploads matching SSN regex |
| **Threat protection** | Flag impossible travel (login from NYC, then Moscow 20 min later) |
| **Compliance** | Block unsanctioned regions for GDPR-tagged data |
| **Visibility** | Discover the 200 SaaS apps Finance signed up for last quarter |

### Log ingestion — why the SOC cares

The CASB is often the *only* source of structured logs for SaaS activity. Your [[SIEM]] gets the firewall and EDR feeds easily; getting "user X downloaded 4GB from SharePoint at 2am" requires CASB → SIEM integration. Make sure:

- **Time synchronization** is NTP-locked across CASB, SIEM, and identity provider. A 5-minute clock skew makes impossible-travel detection fire on legitimate sessions.
- **Logging levels** are tuned. Full verbose floods the SIEM; too sparse misses the breach. Start at info-level, raise to debug only during investigations.
- **Field normalization** matches your SIEM schema. CASB exports `user.email`; your SIEM expects `src_user`. Map it once, save the L1 analyst three hours per incident.

### CASB and the broader architecture

CASB plays nicely with — and is required by — adjacent CS0-003 concepts:

- **[[Zero Trust]]:** CASB enforces continuous verification on cloud sessions. No implicit trust because the user already authenticated.
- **[[IAM]] / [[SSO]] / [[Federation]]:** CASB rides the SAML/OIDC flow from your IdP. Without federation, reverse-proxy CASB doesn't work.
- **[[PKI]] / [[SSL]]:** CASB terminates TLS to inspect traffic. That means it needs trusted certs deployed to endpoints, and it breaks anything using cert pinning.
- **[[Network segmentation]]:** CASB is a *logical* segmentation point for cloud — the same way a VLAN segments on-prem.
- **[[SDN]] / SDN inspection:** in cloud-native deployments, CASB hooks into the SDN fabric to redirect traffic without endpoint agents.
- **Passwordless / MFA:** CASB can require step-up auth (FIDO2, passkey) for sensitive actions even after initial SSO login.

### CASB limitations — the fragility your baseline noted

> **CompTIA exam trap:** A CASB is *not* a replacement for endpoint security, identity governance, or backups. It is *one* enforcement point. If the CASB is bypassed (user on personal device, on home Wi-Fi, hitting a SaaS app that isn't onboarded), it sees nothing. CompTIA scenarios that ask "what additional control is needed" often want you to layer EDR, ZTNA, or IAM on top of CASB — not pile more CASB on the problem.

Fragility specifics:

- **Misconfigured DLP policies** generate thousands of false positives, analysts burn out, real alerts get missed
- **Cert pinning** in mobile apps breaks reverse-proxy CASB silently
- **API-only mode** has detection latency — a ransomware upload exists in the tenant before quarantine fires
- **Unsanctioned apps** the CASB doesn't know about are invisible to it
- **Shadow IT discovery** depends on log feeds from your firewall/proxy — no feed, no discovery

## SOC reality

- The 3am alert from your CASB usually reads: *"Impossible travel: user@corp.com authenticated from San Jose (10:42) and Lagos (10:51)."* L1's first move is check the IdP log for the source IPs, check if a known VPN or mobile carrier IP is involved, and check if MFA was satisfied in both sessions. 80% of these are travel + corporate VPN. The 20% that aren't are how you find account takeover.
- The CISO asks one question after a SaaS data exposure: *"Do we have CASB logs for that tenant, and how far back?"* If the answer is "we onboarded that app last month," you're reconstructing the incident from the SaaS vendor's audit log, which may have a 90-day retention cliff.
- Never tell leadership *"the CASB blocked it"* without confirming the policy actually fired in **enforcement** mode and not **monitor-only** mode. Half of CASB deployments sit in monitor-only for months because nobody wanted to be the one who broke Finance's workflow.
- The handoff: L1 confirms the alert, L2 pulls the CASB session detail and correlates with EDR on the endpoint, IR decides whether to revoke tokens via the IdP. Token revocation is the actual containment action — blocking at the CASB doesn't kill an already-issued OAuth refresh token.
- *I learned this the hard way: a CASB in monitor-only mode is a very expensive logging product. Verify enforcement on every policy you care about, every quarter.*

## Related concepts

[[SASE]] · [[Zero Trust]] · [[DLP]] · [[IAM]] · [[SSO]] · [[Federation]] · [[MFA]] · [[Encryption]] · [[PKI]] · [[Network segmentation]] · [[SDN]] · [[SIEM]] · [[Shadow IT]] · [[PII]] · [[CHD]] · [[Hybrid cloud]] · [[Serverless]] · [[Containerization]] · [[Virtualization]]

*Source: VIRGIL knowledge base — 2026-05-11*