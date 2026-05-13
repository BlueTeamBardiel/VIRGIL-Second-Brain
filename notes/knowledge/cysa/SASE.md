# SASE — Secure Access Service Edge

## What it is

In **The Legend of Zelda: Breath of the Wild**, you don't carry a single fortress around with you — you carry the Sheikah Slate. Every tower you climb extends the map. Every shrine you complete is a fast-travel point. Wherever Link is on the map — Hyrule Field, Death Mountain, Gerudo Desert — the Slate authenticates him, pulls down the right tools (Magnesis, Stasis, Cryonis), and only grants what the moment needs. The security perimeter isn't a castle wall anymore. It's a Slate that travels with the user and decides, per-shrine, what gets unlocked.

That's exactly what SASE does — it collapses network security and network access into a single cloud-delivered service that follows the user instead of forcing the user back to a headquarters firewall.

Technical definition: **Secure Access Service Edge** (Gartner, 2019) converges **SD-WAN** with cloud-native security functions — **SWG** (secure web gateway), **CASB**, **ZTNA** (zero trust network access), **FWaaS** (firewall-as-a-service), and **DLP** — delivered from globally distributed PoPs (points of presence). Identity is the new perimeter. The user, device, app, and data context drive policy at the edge, not the corporate datacenter.

CompTIA's appendix expands SASE as "Secure Access Secure Edge." The industry-standard expansion is "Secure Access Service Edge." Know both — the exam may use either.

## Why it matters

The old hub-and-spoke model — every branch office and remote worker VPN'd back to HQ for inspection — broke the day SaaS adoption hit critical mass. When 80% of your traffic is destined for Microsoft 365, Salesforce, and AWS, backhauling it through a datacenter firewall in Ohio is latency theater. SASE pushes inspection to a PoP close to the user, applies policy based on identity and context, and routes the traffic the short way.

For the SOC analyst, SASE changes where the logs come from and what "the perimeter" means. Your firewall isn't a box in a rack — it's a service. Your inspection point is wherever the user is. Your DLP runs in the cloud broker, not on the endpoint alone. This is **CS0-003 Objective 1.1** territory — network architecture, [[Zero Trust]], [[CASB]], [[Identity and Access Management]], and cloud infrastructure all collapsed into one delivery model.

The exam will not ask you to design a SASE deployment. It will ask you to recognize which components belong to SASE, what problem it solves vs traditional VPN, and how it relates to [[Zero Trust]].

## Key facts

### The five core SASE components

| Component | What it does | Replaces |
|---|---|---|
| **SD-WAN** | Software-defined WAN — routes traffic optimally across MPLS, broadband, LTE | Static MPLS circuits |
| **SWG** | Secure web gateway — URL filtering, malware scanning, TLS inspection on outbound web traffic | On-prem proxy appliances |
| **CASB** | [[Cloud Access Security Broker]] — visibility and control over SaaS use (sanctioned and shadow IT) | Nothing — this was a blind spot |
| **ZTNA** | [[Zero Trust Network Access]] — app-level access based on identity + posture, no network-level trust | VPN concentrators |
| **FWaaS** | Firewall-as-a-Service — L3-L7 inspection delivered from cloud PoP | On-prem NGFW at every site |

DLP, RBI (remote browser isolation), and sandboxing usually ride along inside the SWG/CASB stack.

### SASE vs traditional perimeter

The old model: user → VPN → corporate datacenter firewall → internet → SaaS app. Two hairpin turns, two inspection points you control, latency you eat.

The SASE model: user → nearest PoP (identity check, policy decision, full inspection) → SaaS app. One inspection point, applied close to the user, latency measured in single-digit ms.

The critical shift: **trust is per-session, per-app, per-context** — not "you're inside the VPN, you can see everything." That's [[Zero Trust]] enforced at the edge.

### SASE and Zero Trust — same religion, different scripture

SASE is the **delivery model**. [[Zero Trust]] is the **architectural philosophy**. SASE is one way to implement Zero Trust for the network layer. You can do Zero Trust without SASE (on-prem ZTNA, microsegmentation, identity-aware proxies). You cannot do SASE without Zero Trust — the whole point is that there is no implicit network trust.

Components doing Zero Trust work inside SASE:
- **ZTNA** — never trust network location; verify identity + device posture + app sensitivity every session
- **[[MFA]]** — identity verification is multi-factor by default
- **[[SSO]] and [[Federation]]** — identity is centralized through an IdP (Okta, Entra ID, Ping)
- **Continuous evaluation** — session terminated if posture changes mid-session (device falls out of compliance, anomalous behavior, geo-velocity)

### Identity is the new perimeter

SASE only works if identity works. The IdP becomes the most security-critical asset in the environment — compromise it and the attacker inherits every app behind every SASE policy. This is why:

- **[[MFA]]** is non-negotiable, phishing-resistant where possible (FIDO2, hardware tokens, passkeys)
- **[[Passwordless]]** auth is the trajectory — eliminate the credential entirely
- **[[Privileged Access Management]]** wraps admin accounts in just-in-time elevation, session recording, vaulted credentials
- **[[PKI]]** issues device certs that prove the endpoint is corp-managed before SASE lets it through

### What SASE inspects and how

Encrypted traffic is the hard problem. ~95% of web traffic is TLS-encrypted. If SASE can't decrypt it, it can't inspect it — and your DLP, malware scanning, and CASB shadow-IT detection go blind.

**TLS / [[SSL]] inspection** at the SASE PoP requires:
- Corporate root CA installed on every managed endpoint (so the SASE PoP can MITM with a trusted cert)
- Decrypt → inspect → re-encrypt at the PoP
- Bypass list for privacy-sensitive categories (banking, healthcare) — legal and policy reasons
- Certificate pinning apps (banking apps, some mobile apps) will break — needs an allowlist

**DLP at the edge** — content inspection for [[PII]], [[CHD]], PHI, source code, classified markings. Block, alert, or coach the user. Same engine you'd run on-prem, just delivered as a service.

### Logging and the SOC

SASE generates enormous log volume. Every session, every policy decision, every DLP hit, every CASB shadow-IT detection. The SOC needs to:

- **Ingest** SASE logs into the [[SIEM]] (Zscaler, Netskope, Palo Alto Prisma, Cato — all expose APIs or syslog)
- **Normalize** — vendor schemas differ wildly; map to a common model
- **Time-synchronize** — SASE PoPs are global; without NTP discipline, your timeline reconstruction breaks across timezones
- **Tune logging levels** — debug-level on a SASE service will drown the SIEM. Production usually wants info + denies + DLP + auth events; debug only during troubleshooting.

### SASE and the cloud delivery models

SASE is itself a cloud service, but it sits in front of all your other deployment models:

| Model | SASE's job |
|---|---|
| **[[Cloud]]** (SaaS, PaaS, IaaS) | CASB controls SaaS, FWaaS protects IaaS egress |
| **[[On-premises]]** | ZTNA replaces VPN for remote-to-on-prem access |
| **[[Hybrid]]** | Single policy plane across cloud + on-prem |
| **[[Serverless]] / [[Containerization]]** | API-level inspection, workload identity |
| **[[Virtualization]]** | VM traffic still inspected if routed through SASE |

### CompTIA exam traps

> **CompTIA exam trap:** SASE vs SSE. **SSE** (Security Service Edge) is SASE *minus* SD-WAN — just the security stack (SWG + CASB + ZTNA + FWaaS + DLP). Gartner split SSE out in 2021. If a question mentions converged security without the WAN piece, the answer is SSE, not SASE.

> **CompTIA exam trap:** SASE vs Zero Trust. They are not synonyms. Zero Trust is the *strategy* ("never trust, always verify"). SASE is a *delivery architecture* that implements Zero Trust for network access. A question asking "what philosophy underlies SASE?" — answer is Zero Trust. A question asking "what cloud-delivered service converges SD-WAN and security?" — answer is SASE.

> **CompTIA exam trap:** CASB is a *component* of SASE, not a competitor. If a question lists CASB and SASE as alternatives, CASB is the narrower answer (SaaS visibility/control only). SASE includes CASB plus four other things.

> **CompTIA exam trap:** SASE replaces VPN — partially. ZTNA inside SASE is the VPN replacement. The full SASE platform does more than VPN ever did. Don't pick "VPN" as a SASE component on the exam; pick ZTNA.

### Configuration and operational reality

SASE configuration lives in the vendor portal — there's no `/etc/sase.conf` on a box you SSH into. Policy is expressed as identity-based rules ("Finance group can read Salesforce, cannot download CHD to unmanaged devices"). Change control matters because a bad policy push can break access for thousands of users simultaneously.

[[System Hardening]] still applies — to the endpoints, the IdP, the admin accounts of the SASE tenant itself. The SASE console is the new crown jewel. MFA + PAM + session recording on every admin login, no exceptions.

## SOC reality

- **The alert:** "User downloaded 2.3 GB from SharePoint to unmanaged device, geo: Lagos, last known login from Boston 40 minutes ago." SASE CASB caught it; impossible-travel rule fired. L1 confirms it isn't a known travel exception, kills the session via SASE console, locks the account in the IdP.
- **The first question from the IR lead:** "Is the session terminated, or just the alert acknowledged?" These are different things. Acknowledging an alert in the SIEM doesn't kill the SASE session. The analyst has to actually push the kill from the SASE portal or via API.
- **The CISO's question after a SaaS breach:** "Did our CASB see this app at all, or was it shadow IT?" If the answer is "we had no visibility," that's the case for SASE rollout in next quarter's budget review.
- **Never promise leadership:** "SASE means we're fully Zero Trust." SASE is one layer. East-west traffic inside your cloud workloads, on-prem segmentation, identity hygiene — all still need work. *A SASE rollout is the start of Zero Trust, not the finish line.*
- **The handoff:** L1 confirms scope (which user, which app, what data classification) → L2 pulls full session logs and DLP hits → IR escalates to legal if [[PII]]/[[CHD]] left the boundary → comms and breach notification clock starts.

*The hardest part of SASE isn't the technology — it's the org chart. Network team owned the firewalls. Identity team owned the IdP. Endpoint team owned the agents. SASE forces all three to share one policy plane, and political turf wars kill more rollouts than technical issues do.*

## Related concepts

[[Zero Trust]] · [[CASB]] · [[ZTNA]] · [[SD-WAN]] · [[Identity and Access Management]] · [[MFA]] · [[SSO]] · [[Federation]] · [[PKI]] · [[DLP]] · [[Network Segmentation]] · [[Cloud Security]] · [[Privileged Access Management]] · [[SIEM]] · [[Passwordless]] · [[System Hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*