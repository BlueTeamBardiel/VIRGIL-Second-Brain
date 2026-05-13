# LAN — Local Area Network

## What it is

In **Stardew Valley**, your farm has a fence line. Inside the fence: your coop, your barn, the sprinklers you laid out by hand, the chest with all your iridium, the cat that does nothing useful. Everything inside that fence trusts everything else inside that fence — the chickens wander to the coop, you walk from house to greenhouse without anyone checking your ID. Outside the fence is Pelican Town, the mines, the Calico Desert, the bus stop where strangers come and go. The fence isn't magic. It just defines what's *yours* and what isn't.

That's exactly what a LAN is — the fenced-in part of the network where your devices live, trust each other by default, and talk at full speed without going through a service provider.

Technical definition: a **Local Area Network** is a group of devices sharing a common Layer 2 broadcast domain (or set of segmented domains) within a limited geographic area — typically one building, one floor, or one site. Connected via Ethernet, Wi-Fi, or fiber. Owned and administered by a single organization. Bounded on the north side by a router/firewall that separates it from the [[WAN]] and the public internet.

Plain English: the network inside the building, ending at the firewall.

## Why it matters

The LAN is where the analyst lives. It's where endpoints generate the telemetry your [[SIEM]] ingests, where the [[EDR]] agents report from, where lateral movement happens after initial access. CompTIA **Objective 1.1** puts network architecture front and center because you cannot triage what you cannot map. If you don't know which VLAN the finance servers sit on, you cannot tell whether the beaconing from 10.20.4.17 is normal or a fire.

The LAN is also the attacker's playground once they're inside the fence. The whole problem of modern security ops — segmentation, [[Zero Trust]], lateral movement detection — is one long argument with the historical assumption that "inside the LAN" meant "trusted." It doesn't anymore. The fence got porous the day someone plugged in their first laptop from home.

Exam relevance: LAN topology, segmentation, and infrastructure concepts are explicit CS0-003 1.1 sub-objectives. Expect questions on segmentation rationale, on-prem vs cloud vs hybrid, and how architectural decisions affect log visibility and IR scope.

## Key facts

### LAN anatomy — what's actually on it

| Layer | Component | What it does |
|---|---|---|
| L1 — Physical | Cabling, switches, APs | Moves frames |
| L2 — Data link | Switches, VLANs, MAC | Local addressing, broadcast domain |
| L3 — Network | Router, default gateway | Routes between VLANs and out to WAN |
| L4+ | Endpoints, servers, printers, IoT | The things that actually do work |

The **default gateway** is the door in the fence. Everything that leaves the LAN goes through it. That's also where your [[Firewall]] and egress logging live — the chokepoint where you see what's leaving and what's trying to come in.

### Network segmentation — building inner fences

A flat LAN is a horror story. One compromised endpoint can talk to every other endpoint, every server, the domain controller, the printer that hasn't been patched since 2017. **Segmentation** breaks the LAN into smaller broadcast domains so that trust is bounded.

- **VLANs** — logical Layer 2 separation on the same physical switch. Finance VLAN can't ARP the dev VLAN.
- **Subnets** — Layer 3 separation; traffic between subnets has to traverse a router where ACLs can be enforced.
- **Microsegmentation** — host-level firewalls or [[SDN]] policy where every workload has its own perimeter. The Stardew fence around each individual chicken.
- **Air gap** — physically separate network, no cable, no Wi-Fi bridge. The greenhouse with no door.

> **CompTIA exam trap:** VLAN is not a security boundary by itself. VLAN hopping (double-tagging, switch spoofing) is a known attack. Segmentation needs ACLs/firewall rules at the L3 boundary to be enforceable. A VLAN alone is a *convenience*, not a control.

### On-prem vs cloud vs hybrid — where the LAN ends

CS0-003 expects you to know how the architectural model changes your visibility.

| Model | Where the LAN sits | Analyst visibility |
|---|---|---|
| **On-premises** | All inside the org's perimeter | Full — every switch, span port, host log is yours |
| **Cloud (IaaS/PaaS/SaaS)** | Virtual network in the provider | Whatever the provider's logs expose; [[CASB]] fills SaaS gaps |
| **Hybrid** | Some on-prem, some cloud, VPN/ExpressRoute between | Split visibility — the boundary is the new battlefield |
| **Serverless / containerized** | Ephemeral workloads, no persistent LAN | Telemetry must be application-layer — no SPAN port for Lambda |

Hybrid is where breaches go to hide. The on-prem SIEM doesn't see the cloud workload. The cloud-native logging doesn't see the on-prem AD. Threat actors love the seam.

### Software-defined networking (SDN)

Traditional LAN: switches make forwarding decisions based on local config. SDN: a central controller pushes flow rules to dumb switches. Means policy can be enforced consistently, microsegmentation is feasible, and inspection points can be inserted programmatically. Also means: compromise the controller and you own the network.

### Zero Trust on the LAN

The old model: trust the LAN, distrust the internet. Zero Trust says: **trust nothing, verify everything, every request.** Every connection — even from the workstation next to yours — gets authenticated, authorized, and logged. [[MFA]] at the application layer. [[SSO]] with continuous session validation. Microsegmentation so a compromised endpoint can't pivot.

In Stardew terms: even your own cat needs to show ID to enter the coop. Annoying. Necessary.

### Secure Access Service Edge (SASE)

SASE is the convergence of network and security as a cloud-delivered service — combining SD-WAN, [[CASB]], [[ZTNA]], firewall-as-a-service, and secure web gateway into one stack at the edge. The LAN doesn't disappear; it just stops being the security perimeter. Identity becomes the perimeter.

### Logging on the LAN — what to ingest

LAN devices that should be sending logs to your [[SIEM]]:

- **Switches** — port up/down, MAC moves, 802.1X auth events
- **Routers/firewalls** — allow/deny, NAT translations, VPN sessions
- **Wireless controllers** — auth, association, rogue AP detection
- **DHCP** — lease assignments (correlate IP→MAC→host)
- **DNS** — query logs (gold for IoC matching against C2 domains)
- **Domain controllers** — auth (4624/4625), Kerberos (4768/4769), object access
- **Endpoints** — process creation, network connections, file mods (via [[EDR]] or Sysmon)

Don't ingest blindly. **Logging levels** matter: DEBUG fills your storage and obscures signal. INFO/WARNING/ERROR is usually the right floor for SIEM ingestion. Save DEBUG for targeted investigations.

### Time synchronization — the unsung hero

Every device on the LAN should sync to a common authoritative NTP source. Why: correlation across logs is impossible if endpoint A says 14:03:12 and the firewall says 14:11:47 for the same event. Skewed clocks turn a 30-second incident reconstruction into a 6-hour archaeological dig.

> **CompTIA exam trap:** time sync is a 1.1 sub-objective and shows up as a "best practice" answer. If a question describes correlation failures across systems, the answer is NTP, not "better SIEM." Stratum 1 or 2 source, internal NTP server on the LAN, all hosts point at it.

### System hardening on LAN devices

- Disable unused switch ports or assign them to a black-hole VLAN
- Disable CDP/LLDP on edge ports (reduces recon info leak)
- 802.1X port-based NAC so unknown devices can't just plug in
- Management plane on a separate VLAN with ACLs (no telnet, SSH only, key auth)
- Default creds — gone, first day
- Firmware patched on the same cadence as servers (everyone forgets switches)

### Encryption in transit on the LAN

Internal traffic used to be cleartext because "it's on the LAN, it's safe." Then someone ran Responder on the LAN. Now: [[TLS]] for application traffic, IPsec or [[MACsec]] for high-sensitivity segments, SMB signing on, LDAP signing on, LDAPS instead of LDAP. Disable [[SSL]] entirely — it's been deprecated for years, TLS 1.2 minimum, 1.3 preferred. [[PKI]] issues the certs that make any of this real.

## SOC reality

- The 3am alert that *actually matters* on the LAN: an internal host beaconing to an external IP that nobody on the asset team can explain. First move: confirm asset owner via DHCP/AD, check process tree in EDR, pull NetFlow for the last 24 hours.
- L1's first action on any suspicious internal traffic: pivot from IP to hostname to user via DHCP and AD logs. If you can't do that in under 5 minutes, your logging architecture is broken.
- The CISO's question is never "what fired the alert?" It's **"what's the blast radius — what else can that host talk to?"** That's a segmentation question, and if you can't answer it instantly, your network diagram is fiction.
- Never tell leadership "we've isolated the host" until you've actually confirmed the switchport shutdown OR the EDR network containment is enforced. *I learned this when a "contained" host kept beaconing for 40 minutes because the containment policy excluded the management VLAN it was sitting on.*
- The handoff: L1 confirms scope and pulls initial artifacts → L2 expands the timeline and queries lateral movement → IR lead makes the containment call (isolate vs monitor) → network team executes the segmentation change. Legal gets pulled in the moment data egress is suspected.

## Related concepts

[[WAN]] · [[VLAN]] · [[Network Segmentation]] · [[Zero Trust]] · [[SDN]] · [[SASE]] · [[CASB]] · [[Firewall]] · [[SIEM]] · [[EDR]] · [[NTP]] · [[802.1X]] · [[NAC]] · [[DHCP Logs]] · [[DNS Logs]] · [[PKI]] · [[TLS]] · [[On-premises Architecture]] · [[Hybrid Cloud]] · [[Microsegmentation]] · [[Lateral Movement]]

*Source: VIRGIL knowledge base — 2026-05-11*