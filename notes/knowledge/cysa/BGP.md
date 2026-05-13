# BGP — Border Gateway Protocol

## What it is

In **Death Stranding**, Sam Porter Bridges walks west across the fractured remains of America hauling cargo between isolated cities, and the only way those cities know each other exist is the **chiral network** — every Knot City he connects re-advertises its presence to the others, and routes between them light up on the map. Cities don't have a god's-eye view of the continent; they only know their direct neighbors and what those neighbors claim they can reach. If Sam connects Lake Knot to Mountain Knot, suddenly Port Knot can route packages through that path. If a node goes dark — terrorist attack, voidout, chiral disruption — the network reconverges around whoever's still up.

That's exactly what BGP does. Every autonomous system on the internet is a Knot City. It only knows its direct peers and what they advertise. When a peer says "I can reach 8.8.8.0/24 through this AS path," the local router believes it, installs the route, and propagates the news. There is no central map of the internet. There is only what your neighbors swear is true.

**Technical definition:** BGP is the path-vector routing protocol that glues the internet's **autonomous systems (ASes)** together. It runs over TCP port **179**, exchanges **NLRI (Network Layer Reachability Information)** between peers, and selects best paths based on attributes like AS_PATH length, LOCAL_PREF, MED, and origin. **eBGP** runs between different ASes; **iBGP** runs within one AS. BGP is the **only** inter-domain routing protocol in production use on the public internet.

For CySA+, you care less about how BGP picks paths and more about how attackers abuse it, what malicious BGP activity looks like in logs, and how BGP-layer events surface as IoCs in your SIEM.

## Why it matters

BGP is the trust layer underneath everything else. TLS, DNSSEC, Zero Trust — all of it routes over BGP, and BGP itself has no native authentication of who owns what prefix. If an attacker can convince an upstream peer to accept a bogus advertisement, they can blackhole your traffic, sinkhole your customers, or quietly mirror your sessions through their infrastructure before forwarding them on. **You don't get a popup when this happens.** You get latency complaints, weird TLS warnings, and a Twitter thread from a network engineer in Amsterdam who noticed your /24 showed up in an AS it has no business being in.

For the CySA+ exam, BGP shows up in Objective **1.2 (analyzing indicators of potentially malicious activity)** — specifically under **network-related indicators**: unexpected outbound traffic, irregular peer-to-peer activity, unusual traffic spikes, rogue devices, and bandwidth consumption. A BGP hijack or route leak produces all of those at once, and the SOC analyst who can't recognize the upstream cause will chase endpoint symptoms for days.

## Key facts

### How BGP actually works (the minimum you need)

| Term | What it means |
|---|---|
| **AS (Autonomous System)** | A network under one administrative control. Identified by an **ASN** (32-bit number). Cloudflare is AS13335. Google is AS15169. |
| **eBGP** | BGP between two different ASes. Default TTL = 1. Lives on the edge router. |
| **iBGP** | BGP inside one AS, used to propagate external routes internally. Full mesh or route reflectors. |
| **Prefix / NLRI** | The advertised network block — e.g. `203.0.113.0/24`. |
| **AS_PATH** | Ordered list of ASes a route traversed. Shorter = preferred. Loop prevention works here. |
| **LOCAL_PREF** | Internal preference within an AS. Higher wins. |
| **MED** | Multi-Exit Discriminator — hint to neighbors about preferred entry point. Lower wins. |
| **TCP/179** | BGP runs over a long-lived TCP session. Drop the session, drop the routing relationship. |

### How attackers abuse BGP

**Prefix hijacking.** An attacker's AS advertises a prefix it doesn't own. Because BGP prefers **more specific prefixes**, advertising a `/24` inside someone else's `/16` wins. Victim traffic gets pulled into the attacker's AS. Famous example: the 2018 Amazon Route 53 hijack that drained ~$150k from a crypto wallet.

**Route leak.** A multi-homed AS accidentally re-advertises routes learned from one provider to another, violating the customer/peer/provider relationship. Traffic for huge swaths of the internet gets routed through some small ISP whose links instantly saturate. Not malicious per se — but indistinguishable from sabotage at 4am when your customers can't reach you.

**BGP session hijack.** Attacker on-path injects TCP packets into a BGP session (no TCP-MD5 or TCP-AO configured) and forces the peer to accept malicious updates. Rare but devastating.

**BGP flap / instability attacks.** Attacker forces a prefix to oscillate up/down rapidly. Upstream peers may **dampen** the route, blackholing legitimate traffic.

### BGP-layer IoCs in your SIEM

When the [[NOC]] hands the SOC a "we think we got hijacked" ticket, you correlate **routing telemetry** with **endpoint and flow data**. The indicators map directly to CySA+ Objective 1.2:

- **Unusual traffic spikes / anomalies** — outbound flows suddenly take a different path; geolocation of return traffic shifts continents.
- **Unexpected outbound traffic** — sessions egressing to ASNs you've never seen in baseline NetFlow.
- **Bandwidth consumption** — route leak pulls in unrelated transit traffic; uplinks saturate.
- **Irregular peer-to-peer** — your BGP session count or peer list changes without a change ticket. New eBGP neighbor = rogue device on the routing fabric.
- **Service interruption** — customers reach you over higher-latency paths or not at all; TLS warnings spike because the MITM AS terminates and re-originates.
- **Activity on unexpected ports** — TCP/179 from a host that has no business speaking BGP is a screaming rogue-router IoC.
- **Scans/sweeps** — attackers often probe before hijacking to confirm reachability.

### Defenses

| Control | What it does |
|---|---|
| **RPKI (Resource Public Key Infrastructure)** | Cryptographic attestation that an ASN is authorized to originate a prefix. Routers drop **ROA-invalid** routes. Single most effective hijack defense in production today. |
| **Prefix filters / max-prefix limits** | Edge routers refuse to accept more prefixes than expected from a peer, or prefixes outside an explicit list. Kills route leaks at the door. |
| **TCP-AO / TCP-MD5** | Authenticates the BGP TCP session itself. Stops session injection. |
| **GTSM (Generalized TTL Security Mechanism)** | eBGP peers require TTL = 255, so off-path attackers can't spoof updates. |
| **BGPsec** | Cryptographic signing of the AS_PATH. Limited deployment. |
| **Monitoring (BGPmon, RIPE RIS, Cloudflare Radar)** | External feeds that alert when your prefix appears under an unexpected origin AS. |

### CompTIA exam traps

> **CompTIA exam trap:** BGP runs over **TCP/179**, not UDP. CompTIA likes to throw UDP into the answer list. BGP needs reliable, ordered delivery — that's TCP by definition.

> **CompTIA exam trap:** A **route leak** is not a **prefix hijack**. Hijack = advertising someone else's space. Leak = re-advertising routes across a relationship boundary you shouldn't. The exam may describe a scenario where a small ISP accidentally announces a Tier-1's full table — that's a leak, not a hijack. Both produce the same symptoms in the SOC.

> **CompTIA exam trap:** BGP path selection prefers the **more specific prefix** before AS_PATH length. That's why hijackers advertise `/24`s inside `/16`s. If a question asks why the attacker's advertisement won despite a longer AS path, the answer is **longest-prefix match**.

> **CompTIA exam trap:** Seeing **TCP/179 traffic from an unexpected host** inside your AS is an IoC for a **rogue device** trying to establish a BGP session. Don't mark it as benign just because BGP "is a routing protocol." Endpoints do not speak BGP. Period.

### Where BGP intersects other CySA+ indicators

A BGP-driven incident cascades down the stack. The IR ticket may start as "customer reports timeouts," but by the time you've pulled the threads:

- **Application logs** show TLS handshake failures and certificate mismatches (the hijacker's MITM is terminating sessions).
- **Unexpected outbound** flows appear in NetFlow as endpoint traffic exits via an ASN that's not your transit.
- **Beaconing** alerts may fire if the hijack is targeted exfiltration — C2 traffic now reaches the attacker through the hijacked path instead of being NAT-traversed through their infra.
- **Data exfiltration** may complete *without any endpoint IoC* because the data left through normal egress, but the path was poisoned.

That last one is the nightmare scenario. *Your EDR is clean. Your DLP is clean. Your firewall logs look normal. The bytes just went to the wrong AS.*

## SOC reality

- **The 3am alert:** Your [[external-monitoring]] feed (BGPmon, ThousandEyes, Cloudflare Radar) pages you: "Origin AS for 203.0.113.0/24 changed from AS65001 to AS65535." You did not change anything. You verify with `whois`, `bgp.tools`, and a public looking glass. If the unexpected ASN is real, you wake the NOC and start the IR phone tree.
- **L1 first action:** Confirm the hijack is real (not a monitoring false positive — RPKI ROA changes can trigger these). Pull NetFlow to confirm traffic is actually flowing to the wrong AS, not just that a route was advertised. **An advertisement is not a redirect until traffic follows it.**
- **What the CISO asks:** "Are customer sessions terminating on infrastructure we don't control? Is data leaving? Who do we call at our upstream to filter the bogus announcement? Do we have RPKI ROAs published, and if not, why not?"
- **Never promise:** "We've contained it." You don't contain a BGP hijack — your upstream provider does, by filtering the rogue ASN. Your job is to publish the evidence, coordinate with the NOC and upstream NOCs, rotate any credentials that may have transited the hijacked path, and force TLS revalidation on anything sensitive.
- **The escalation:** L1 SOC → L2 / IR lead → Network engineering (NOC) → upstream transit provider's NOC → legal/comms if customer data is implicated. BGP incidents are unusual in that the **fix lives outside your perimeter** — you cannot remediate this on your own routers. You can only stop accepting the bad path and lean on the rest of the internet to do the same.

The honest truth about BGP for a SOC analyst: you will probably never touch a BGP config. But you will absolutely sit in a war room where the senior network engineer is debugging a hijack at 4am, and your job is to correlate their routing story with the endpoint and application telemetry on your screens. The analyst who knows what AS_PATH means and why a `/24` beats a `/16` is the analyst who gets pulled into the room.

## Related concepts

[[Autonomous System]] · [[RPKI]] · [[NetFlow]] · [[DNS Hijacking]] · [[Route Leak]] · [[MITM]] · [[NOC vs SOC]] · [[Network IoCs]] · [[Beaconing]] · [[Data Exfiltration]] · [[TLS Inspection]] · [[Rogue Device Detection]] · [[Cyber Kill Chain]] · [[ATT&CK T1557 Adversary-in-the-Middle]]

*Source: VIRGIL knowledge base — 2026-05-11*