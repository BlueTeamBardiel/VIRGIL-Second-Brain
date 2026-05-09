# Zero Trust

## What it is

In Hitman, Agent 47 walks into Sapienza wearing a chef's outfit, and despite the disguise, the actual head chef sees through him instantly because he's an "enforcer" — someone whose job requires them to verify, not assume. Every NPC in that mission grants 47 access based on continuous evaluation: who is this person, where are they supposed to be, are they holding the right item, did they just walk out of a restricted zone? Trust evaporates the moment behavior shifts. That's exactly what **Zero Trust** does — it treats every user, device, and request as untrusted by default and verifies continuously, no matter how legitimate the disguise looks.

**Zero Trust** is a security architecture model that eliminates implicit trust based on network location and instead requires continuous authentication, authorization, and validation of every subject and request before granting access to resources.

## Why it matters

Traditional perimeter security assumes anyone inside the network is friendly — which is precisely how ransomware affiliates pivot from one phished workstation to encrypting an entire domain in 48 hours. Zero Trust limits **lateral movement**, contains breaches, and is now mandated for U.S. federal agencies under [[OMB M-22-09]]. On the SY0-701 exam, Objective 1.2 explicitly tests **Control Plane** vs. **Data Plane** components — CompTIA loves to ask which element does what. The classic trap: confusing the [[Policy Engine]] (decides) with the [[Policy Enforcement Point]] (acts), or forgetting that [[Adaptive Identity]] lives on the Control Plane.

## Key facts

### The two planes

Zero Trust splits responsibilities into two logical planes. Memorize this — CompTIA tests it directly.

| Plane | Purpose | Components |
|-------|---------|------------|
| **Control Plane** | Decides who gets in and under what conditions | [[Policy Engine]], [[Policy Administrator]], [[Adaptive Identity]], [[Threat Scope Reduction]], [[Policy-Driven Access Control]] |
| **Data Plane** | Carries out the decisions and moves the actual traffic | [[Subject]], [[System]], [[Policy Enforcement Point]] (PEP), [[Implicit Trust Zones]] |

### Control Plane components

- **Policy Engine (PE)** — The brain. Evaluates access requests against policy and returns grant/deny/revoke. Think of the Hitman security guard who recognizes 47 isn't really a chef.
- **Policy Administrator (PA)** — Communicates the PE's decision to the enforcement point. Generates session tokens or credentials.
- **Adaptive Identity** — Authentication that factors in **context**: source IP, device posture, geolocation, time of day, behavioral baseline. A login from the corporate laptop at 9 a.m. ≠ the same credentials at 3 a.m. from Belarus.
- **Threat Scope Reduction** — Limiting the **blast radius**. Minimize what any single identity, device, or session can touch. Aligns with [[Least Privilege]] and [[Microsegmentation]].
- **Policy-Driven Access Control** — Access decisions derive from a defined policy, not from "you're on the LAN, so sure."

### Data Plane components

- **Subject / System** — The user or service requesting access. In Hitman terms: 47 trying to enter the restricted villa.
- **Policy Enforcement Point (PEP)** — The gate that actually allows or blocks the connection. Sits in the data path. The bouncer who acts on the verdict, not the one who issued it.
- **Implicit Trust Zones** — Segmented areas where, once admitted, some level of trust exists. Zero Trust seeks to **shrink these zones to zero** wherever possible.

### Core principles

1. **Never trust, always verify** — every request, every time.
2. **Assume breach** — design as if the attacker is already inside.
3. **Verify explicitly** — use all available signals (identity, device, location, workload, data sensitivity).
4. **Least privilege access** — just-in-time, just-enough access.
5. **Microsegmentation** — small, defined trust boundaries instead of one big LAN.

### What Zero Trust replaces

| Old model | Zero Trust |
|-----------|------------|
| **Castle-and-moat** perimeter | Identity is the new perimeter |
| VPN = full network access | Per-application authorization |
| Trust based on network location | Trust based on continuous verification |
| Static credentials | [[Continuous Authentication]] + adaptive signals |

### Common exam traps

- **PE decides, PA communicates, PEP enforces.** Learn the verbs.
- Adaptive Identity is **Control Plane**, not Data Plane — it informs decisions.
- Zero Trust is an **architecture/model**, not a single product. Vendors selling "the Zero Trust appliance" are selling marketing.
- [[NIST SP 800-207]] is the canonical reference document.

## Related concepts

[[Microsegmentation]] · [[Least Privilege]] · [[SASE]] · [[SDN]] · [[Identity and Access Management]] · [[Continuous Authentication]] · [[NIST SP 800-207]] · [[Defense in Depth]] · [[Conditional Access]] · [[Lateral Movement]]

---
*Source: VIRGIL knowledge base — 2026-05-08*