# Firewalls and Network Perimeter Security

## What it is

In **Portal**, the Aperture Science test chambers are built around one rule: you can only travel where there's a portal-receptive surface. White panels accept portals. Black panels, glass, and angled metal don't. GLaDOS designs each chamber by choosing which surfaces are paintable and which aren't — that's the entire game. You can carry a cube, you can fling yourself off a ledge, but you cannot make a portal on a wall the level designer marked as non-receptive. The geometry of the chamber decides what's possible.

That's exactly what a firewall does. It decides which network surfaces accept connections and which don't. Source IP, destination IP, port, protocol, sometimes the application itself — the firewall consults its ruleset and either paints a portal (allow) or eats the shot (deny/drop).

Technically: a **firewall** is a network security control that inspects packets traversing a boundary and enforces an access control policy. It sits at trust boundaries — between the internet and your DMZ, between the DMZ and internal, between user VLANs and the datacenter, between on-prem and [[Cloud]] — and applies an ordered ruleset (an [[ACL]]) to permit or deny traffic. Default-deny is the only sane posture. Everything else is permission.

## Why it matters

Firewalls are the skin of the network. They are the first control a packet hits and often the last one to fail silently. CySA+ tests them under **Objective 1.1** because the analyst needs to read firewall logs during an incident, understand why a piece of malware is beaconing out on TCP/443, and know whether the boundary controls are even in the right place to catch what just happened.

In the SOC, every IR call starts with "what does the firewall log show?" If the perimeter logs are missing, gapped, or not ingested into the [[SIEM]], you are flying blind. The exam will hand you scenarios about [[Network segmentation]], DMZ design, and rule ordering — and the answers all turn on the same idea: did the packet have permission to be where it ended up?

## Key facts

### Placement and the trust-boundary model

A firewall is only as useful as the boundary it sits on. The classic enterprise design has three zones:

| Zone | Trust level | What lives there |
|------|-------------|------------------|
| **Internet / untrusted** | Zero | Everything you don't control |
| **DMZ / screened subnet** | Low — semi-trusted | Public-facing web, mail relay, reverse proxy, external DNS |
| **Internal / trusted** | High | User endpoints, file servers, AD, databases |

The **screened subnet** (the modern term — "DMZ" is the term CompTIA still tests on but is being retired) is the buffer. Public services live there so that if a web server gets popped, the attacker doesn't immediately have a foothold on your AD domain controller. Two firewall layers — one between internet and DMZ, one between DMZ and internal — is the textbook design. One firewall with three legs is the budget version.

### Firewall generations

| Type | Inspects | Strengths | Limits |
|------|----------|-----------|--------|
| **Packet filter** | L3/L4 headers — IP, port, protocol | Fast, cheap | Stateless; can't tell a SYN-ACK reply from an unsolicited SYN-ACK |
| **Stateful inspection** | Tracks connection state in a state table | Knows ESTABLISHED vs NEW, drops unsolicited replies | Still blind to payload |
| **[[Application-layer firewall (proxy)]]** | L7 — full payload of specific protocols | Can enforce protocol compliance | Slow, protocol-specific |
| **Next-Generation Firewall (NGFW)** | L3–L7 + user identity + app ID + IPS + TLS inspection | App-aware, user-aware, integrates threat intel | Expensive, TLS inspection breaks pinned apps |
| **[[Web Application Firewall (WAF)]]** | HTTP/HTTPS payload — looks for [[SQL injection]], [[XSS]], path traversal | Protects the app, not the network | Only sees web traffic; signature gaps |
| **[[Unified Threat Management (UTM)]]** | Firewall + IPS + AV + URL filter + VPN in one box | SMB-friendly | Jack of all trades; chokes under load |

CySA+ wants you to know that an **NGFW is not a WAF**. NGFW is a network device that does some L7 — it can recognize that traffic on TCP/443 is actually BitTorrent over TLS. A WAF is a web-app-specific device that parses HTTP requests for injection patterns. Different jobs.

### Rule ordering and ACL discipline

Firewall rules are **evaluated top-down, first match wins**. The order is the policy. A permissive rule above a restrictive one means the restrictive one never executes.

The structure of every well-written ruleset:

1. **Explicit denies for known-bad** (bogons, threat-intel IPs, RFC1918 inbound from internet)
2. **Specific allows** for required services (web → DMZ web server on TCP/443)
3. **Logging rule** for interesting denied traffic
4. **Default deny** — the implicit final rule that catches everything else

> **CompTIA exam trap:** A firewall rule that says "permit any any" anywhere in the ruleset is a finding, full stop. If the question shows an ACL with `permit ip any any` above a specific deny, the specific deny never fires. CompTIA loves testing rule ordering. Read the ACL top-to-bottom and stop at the first match.

### Egress filtering — the part everyone forgets

Inbound rules get the attention. Outbound (egress) rules catch the actual breaches. If your endpoint is calling out to a C2 server on TCP/4444, an egress rule that only permits TCP/80, TCP/443, and DNS to approved resolvers would have killed the beacon at the perimeter.

Egress filtering is also how you catch [[Data exfiltration]]. Combined with [[DLP]] at the boundary, you can flag a 4GB outbound transfer to a Dropbox IP at 2am.

*If your firewall logs only show inbound denies, you have half a firewall.*

### Modern perimeter — and why "perimeter" is a lie now

The old model assumed everything inside was trusted and everything outside was hostile. That model died with mobile workforces, SaaS, and [[Cloud]] workloads. The replacements:

- **[[Zero Trust]]** — never trust, always verify. Every request is authenticated and authorized regardless of source location. Identity is the new perimeter.
- **[[SASE]] (Secure Access Service Edge)** — converged cloud-delivered networking + security. Firewall, [[CASB]], [[SWG]], [[ZTNA]] delivered as a service so the user gets the same policy whether they're in HQ or at a coffee shop.
- **[[CASB]] (Cloud Access Security Broker)** — sits between users and SaaS apps, enforces policy on Office 365, Salesforce, Box. Visibility into shadow IT.
- **[[Microsegmentation]]** — firewall policy at the workload level, often via [[SDN]]. Two VMs on the same host can have a firewall between them. Blast radius shrinks to one workload.

NGFW + microsegmentation + ZTNA is the operational reality in 2026. The "perimeter firewall" is still there, but it's one control among many, not the wall.

### Cloud firewalls

Cloud changes the model. In AWS you get **Security Groups** (stateful, instance-level, allow-only) and **NACLs** (stateless, subnet-level, allow + deny). Azure has **NSGs**. GCP has **VPC firewall rules**. CySA+ doesn't go deep on vendor specifics but expects you to know that cloud firewalls are typically **deny-by-default, stateful, and applied via tags/labels rather than IP ranges**.

### TLS inspection — the trade-off

NGFWs can decrypt TLS, inspect the payload, re-encrypt, and forward. This catches malware hiding in HTTPS. It also:

- Breaks certificate pinning (mobile apps, some thick clients)
- Requires deploying an internal CA cert to every endpoint via [[PKI]]
- Creates a privacy and legal exposure for personal traffic
- Is the single biggest performance cost on the box

You almost always exclude banking, healthcare, and personal email domains from inspection. The exclusion list becomes a policy document the legal team signs off on.

### CompTIA exam traps

> **DMZ vs screened subnet:** Same thing. CompTIA is transitioning terminology — both terms appear on CS0-003. If you see "screened subnet" in an answer choice and "DMZ" in another, they're describing the same architectural element.

> **Stateful vs stateless:** A stateless (packet filter) firewall cannot distinguish a return packet from an unsolicited one. A stateful firewall maintains a state table and only permits return traffic for an established connection. If the question mentions "tracks the connection," the answer is stateful.

> **NGFW vs WAF:** NGFW protects the network and adds app/user awareness. WAF protects a web application from web-layer attacks (OWASP Top 10). If the scenario mentions SQL injection or XSS, the answer is WAF, not NGFW.

> **Implicit deny vs explicit deny:** Implicit deny is the default behavior at the end of the ruleset (no rule matched → drop). Explicit deny is a written rule that drops specific traffic and usually logs it. CompTIA will ask which one logs — explicit does, implicit usually doesn't.

## SOC reality

- **The 3am alert.** SIEM correlation fires: internal host establishing 200+ outbound connections to a single external IP on TCP/443 over 10 minutes. L1 pulls the firewall log to confirm the connections actually completed, checks threat intel on the destination IP, and pivots to [[EDR]] to see what process initiated. The firewall log is the **timeline anchor** — when did the beaconing start, when did it stop, did it ever stop.
- **The L1's first move.** Acknowledge the alert. Pull source IP from the firewall log. Cross-reference against DHCP and AD to identify the user and machine. Check if the destination IP is in a known-bad feed. If yes — escalate to L2 and request containment via firewall block + EDR isolation. Do not block at the firewall before confirming, because blocking C2 tips off the adversary that you're watching.
- **What the IR lead asks.** "Is the block in place? Are we logging the dropped traffic so we know if the host keeps trying? Have we pivoted to other hosts hitting the same destination? Is the rule in the right firewall — perimeter, or also east-west?"
- **What never to promise.** "We've blocked the C2." You've blocked *one* C2. Adversaries rotate infrastructure. The block buys time to scope the intrusion; it doesn't end it.
- **Handoff.** L1 confirms the IoC and gets the rule pushed. L2 pivots through the SIEM looking for other hosts touching the same infrastructure. IR team owns scope, eradication, and the lessons-learned that ends up in next quarter's firewall ruleset hardening.

## Related concepts

[[Network segmentation]] · [[Zero Trust]] · [[SASE]] · [[CASB]] · [[SIEM]] · [[EDR]] · [[ACL]] · [[DMZ]] · [[NGFW]] · [[WAF]] · [[IDS-IPS]] · [[Microsegmentation]] · [[SDN]] · [[PKI]] · [[DLP]] · [[Data exfiltration]] · [[Defense in depth]] · [[OSI Model]]

*Source: VIRGIL knowledge base — 2026-05-11*