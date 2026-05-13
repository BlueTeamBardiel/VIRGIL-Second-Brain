# DoS — Denial of Service

## What it is

In **Tears of the Kingdom**, when you fight a Gleeok, the boss summons three or four elemental heads that all breathe fire, ice, or lightning at the same time. You can dodge one. You can probably dodge two. By the time the fourth head opens its mouth, you're rolling into another AOE and your stamina wheel is gone. The Gleeok didn't kill you with one big hit — it killed you by saturating every direction you could move at once. That's exactly what a DoS does to a service — saturate every available channel until legitimate users can't get through.

**Denial of Service (DoS)** is any attack that degrades or eliminates the availability of a system, service, or network for its intended users. It targets the **A in CIA** — Availability. The attack doesn't need to steal data, escalate privileges, or even compromise the target. It just needs to make the target unusable. For CySA+ purposes (Objective 1.2), DoS shows up as an **indicator of potentially malicious activity** — specifically under *unusual traffic spikes*, *bandwidth consumption*, *service interruption*, and sometimes *processor/memory consumption* on the host side.

DoS comes in two flavors the exam will test:

- **DoS** — single source, single target. One attacker, one pipe.
- **DDoS (Distributed)** — many sources, one target. Botnet of compromised hosts hammering simultaneously. Think every Bokoblin in Hyrule shooting arrows at the same gate.

## Why it matters

Availability outages cost money per minute and reputation per hour. A retail site down on Black Friday, a hospital EHR offline during triage, an ICS HMI frozen during a plant run — these are existential. For the analyst, DoS matters for three reasons:

1. **It's loud.** Easy to detect, hard to stop in real time. The traffic is already arriving.
2. **It's often a smokescreen.** While the SOC is firefighting bandwidth saturation, the real attacker is exfiltrating data through a side channel. Never assume the obvious attack is the only attack.
3. **It can be internal.** A misconfigured backup job, a runaway script, a compromised internal host beaconing aggressively — all look like DoS symptoms in the SIEM.

CySA+ tests DoS under **Domain 1.0 Security Operations**, Objective 1.2, as an IoC category. Expect questions where the indicator (traffic spike, service interruption, memory pegged) has to be classified as DoS *vs* something else — exploit attempt, exfiltration, beaconing, or legitimate spike.

## Key facts

### Categories of DoS

| Type | Mechanism | Example |
|---|---|---|
| **Volumetric** | Saturate bandwidth | UDP flood, ICMP flood |
| **Protocol** | Exhaust connection state tables | SYN flood, Ping of Death, Smurf |
| **Application-layer** | Exhaust app resources with valid-looking requests | HTTP GET/POST flood, Slowloris |
| **Amplification / Reflection** | Use third-party services to multiply traffic | DNS amplification, NTP amplification, memcached |

**Volumetric** is the Gleeok analogy — overwhelm with raw firepower. **Application-layer** is sneakier — every request looks legitimate (valid HTTP, valid TLS handshake), so the WAF doesn't drop it. You only notice when the app server's thread pool is exhausted.

### Amplification attacks — the exam favorite

The attacker spoofs the **source IP** of a small query to point at the victim. The query goes to a third-party service (DNS resolver, NTP server, memcached instance) that responds with a much larger payload. The victim gets flooded with responses to queries it never sent.

- **DNS amplification** — small query, huge response. Amplification factor ~50x.
- **NTP `monlist`** — amplification factor ~550x. Patched in modern NTP but legacy boxes still vulnerable.
- **Memcached reflection** — amplification factor up to 51,000x. GitHub took 1.3 Tbps from this in 2018.

The third party isn't compromised. It's just doing what protocols allow. The fix is **ingress filtering (BCP 38)** to block spoofed source IPs at the network edge — most ISPs still don't enforce it, which is why amplification still works.

> **CompTIA exam trap:** A reflection/amplification attack does not require compromising the third-party service. The third party is an unwitting participant responding to a spoofed source IP. If the question asks "what's compromised in a DNS amplification attack?" — the answer is **the target's availability**, not the DNS resolver.

### IoCs that look like DoS but aren't

This is where CySA+ likes to play games. Per Objective 1.2, several IoCs overlap with DoS symptoms:

- **Repeated access to the same resource** — could be a brute-force credential stuffing attack, not DoS. The traffic pattern is similar; the intent is not.
- **Scans / sweeps** — high packet rate, many destination ports. Looks volumetric. Actually reconnaissance.
- **Beaconing** — small, regular, low-volume callbacks to C2. The opposite of DoS in volume, but shows up in the same "unexpected outbound" bucket.
- **Bandwidth consumption from exfiltration** — large outbound transfer. The pipe fills. Looks like outbound DoS; is actually data theft.
- **Legitimate traffic spike** — a marketing email blast, a product launch, a Reddit hug-of-death. Indistinguishable from a low-grade DDoS in raw bandwidth terms.

*The first hour of a "DDoS" is often spent confirming it's actually a DDoS and not a deployment that went viral.*

### Host-side DoS indicators

DoS isn't always network-borne. A malicious process can deny service locally:

- **Processor consumption** pinned at 100% — fork bomb, cryptominer, runaway loop
- **Memory consumption** climbing until OOM killer fires — memory leak exploit, ZIP bomb
- **Drive capacity consumption** filling to 100% — log flooding, ransomware staging, malicious scheduled task writing junk
- **Abnormal OS process behavior** — child processes spawning recursively, services restarting in a loop
- **Unauthorized scheduled tasks** — a task that re-launches the resource hog every minute

If your endpoint is at 100% CPU with `svchost.exe` spawning 400 children, you're not under network DDoS. You're hosting a malicious process that's denying service to its own host.

### Detection signals in the SIEM

| Signal | Source | What it suggests |
|---|---|---|
| Sudden bandwidth spike, single src IP | NetFlow / firewall | Single-source DoS |
| Bandwidth spike, many src IPs, one dst | NetFlow / WAF | DDoS |
| SYN packets without ACK completion | Firewall / IDS | SYN flood |
| HTTP 503 / 504 surge | App / load balancer logs | App-layer exhaustion |
| DNS response traffic without prior query | Resolver logs | You are a reflection target |
| DNS query volume spike outbound | Resolver logs | You are a reflection participant (your resolver is open) |
| CPU/memory alerts on app server, no traffic spike | EDR / OS metrics | Application-layer DoS or local malicious process |

### Defenses

- **Upstream scrubbing** — Cloudflare, Akamai, AWS Shield. The traffic never reaches you; it's cleaned at the ISP/CDN edge.
- **Rate limiting** — per-IP, per-session, per-endpoint. Cheap, fast, effective against script kiddies.
- **WAF rules** — Layer 7 inspection drops malformed or signature-matched requests.
- **Anycast** — distribute the target across many geographic edges so no single PoP saturates.
- **BCP 38 / ingress filtering** — prevents your network from being a source of spoofed traffic.
- **Disable open recursive DNS / NTP `monlist`** — don't be a reflection participant.
- **Tarpitting / SYN cookies** — make protocol-level floods more expensive for the attacker.

> **CompTIA exam trap:** A firewall alone does not stop a volumetric DDoS. The packets still consume the pipe upstream of the firewall. The firewall just drops them after they've already saturated the link. Mitigation requires **upstream** (ISP, CDN, scrubbing service) action, not just on-prem controls.

## SOC reality

- **3am alert: "Outbound bandwidth utilization 98% on edge link."** Your first move is *not* to block traffic. It's to confirm: is this DDoS inbound saturating return traffic, is it exfiltration outbound, or is it a backup job that escaped its window? Check NetFlow for top-talkers, both directions, before you touch a firewall rule.
- **The CISO's first question is "are we down?" — not "what attack is it?"** Lead with impact: which services, which customers, how many, ETA. Attribution comes later. Availability is the only metric anyone outside the SOC cares about during the incident.
- **Never promise "we've mitigated it."** DDoS traffic ebbs and flows; attackers pivot vectors. Say "scrubbing is engaged, traffic has dropped 80%, monitoring for re-escalation." Hedge until the post-incident review.
- **Look for the second attack.** When a DDoS hits at a weird hour for no business reason, assume it's cover. Pull EDR alerts, look for new accounts (*introduction of new accounts*), check for outbound beaconing on low-volume ports, scan for *unauthorized scheduled tasks*. The smokescreen is the loudest part; the knife is somewhere quiet.
- **Escalation path:** L1 confirms the signal isn't a false positive (legitimate spike) → L2 engages the on-call network team and scrubbing provider → IR lead decides on public comms / status page update → legal gets pulled in if it crosses thresholds for breach notification (relevant when DoS is paired with extortion — *RDDoS, ransom DDoS*).
- **Document the timeline religiously.** When did the spike start, when was scrubbing engaged, when did traffic normalize, when was the all-clear? This is what feeds the post-incident report and the eventual insurance claim.

## Related concepts

[[DDoS]] · [[Botnet]] · [[Amplification Attack]] · [[Beaconing]] · [[Bandwidth Consumption]] · [[NetFlow]] · [[SIEM]] · [[WAF]] · [[Rate Limiting]] · [[CIA Triad]] · [[Availability]] · [[Indicators of Compromise]] · [[Exfiltration]] · [[BCP 38]] · [[DNS Amplification]] · [[SYN Flood]] · [[Slowloris]] · [[Incident Response]]

*Source: VIRGIL knowledge base — 2026-05-11*