# Security Controls

## What it is

In Portal, GLaDOS doesn't trust you with portals near the incinerator, so she puts up emancipation grids that vaporize anything you try to carry through. Cameras watch your every move, turrets shoot intruders, and the test chamber walls are non-portalable — every layer is a different kind of safeguard doing a different kind of job. That's exactly what **security controls** are — the layered safeguards an organization deploys to reduce risk to its assets.

A **security control** is any administrative, technical, physical, managerial, or operational measure implemented to prevent, detect, deter, correct, compensate for, or direct response to a security threat.

## Why it matters

Without categorized controls, you can't prove due diligence, pass an audit, or recover from incidents in any structured way. Frameworks like NIST 800-53, ISO 27001, and PCI-DSS are entirely built around control catalogs — fail to map your defenses to them and you fail compliance, lose cyber insurance payouts, and face regulatory fines.

**Exam angle:** Objective 1.1 expects you to classify controls by **category** (Technical, Managerial, Operational, Physical) AND by **type** (Preventive, Deterrent, Detective, Corrective, Compensating, Directive). CompTIA's favorite trap is a single control that fits multiple buckets — a security guard is *Physical* (category) and can be *Preventive*, *Deterrent*, *Detective*, OR *Directive* depending on what they're doing. Read the scenario carefully.

## Key facts

### Control Categories (the WHO/WHAT implements it)

| Category | What it is | Examples |
|---|---|---|
| **[[Technical Controls]]** | Implemented through technology | [[Firewall]], [[Encryption]], [[IDS/IPS]], [[MFA]], [[ACL]] |
| **[[Managerial Controls]]** | Strategic, policy/risk-based | [[Risk Assessment]], [[Security Policy]], [[SDLC]] planning |
| **[[Operational Controls]]** | Day-to-day people processes | [[Security Awareness Training]], [[Incident Response]] procedures, change management execution |
| **[[Physical Controls]]** | Tangible, real-world barriers | [[Bollards]], [[Fences]], [[Locks]], [[Security Guards]], [[Badges]], [[Mantraps]] |

### Control Types (the WHY/HOW it functions)

| Type | Purpose | Example |
|---|---|---|
| **[[Preventive Control]]** | Stop incident before it happens | [[Firewall]] blocking traffic, door [[Lock]], [[MFA]] |
| **[[Deterrent Control]]** | Discourage attacker from trying | Warning sign, visible camera, "Beware of Dog" |
| **[[Detective Control]]** | Identify incident in progress or after | [[SIEM]] alerts, [[IDS]], [[Log Review]], motion sensor |
| **[[Corrective Control]]** | Fix damage after incident | [[Backups]], [[Patch Management]], [[Antivirus]] quarantine |
| **[[Compensating Control]]** | Alternative when primary control isn't feasible | [[Network Segmentation]] when a legacy system can't be patched |
| **[[Directive Control]]** | Tells people what to do | [[Acceptable Use Policy]], regulatory guidelines, posted procedures |

### One control, many hats

A single control often spans multiple types:

- **CCTV camera (visible)** → Physical category; *Deterrent* (you see it, you behave) AND *Detective* (it records the break-in)
- **Security guard** → Physical; can be *Preventive*, *Deterrent*, *Detective*, or *Directive*
- **Firewall** → Technical; *Preventive* (blocks) and *Detective* (logs)
- **Backups** → Technical; purely *Corrective*

### Defense in Depth

Controls are layered intentionally — no single safeguard is trusted alone. This is **[[Defense in Depth]]**: if the [[Firewall]] fails, [[IDS]] catches it; if [[IDS]] misses, [[EDR]] on the host catches it; if EDR misses, [[Backups]] recover from it.

### Common exam misclassifications

- **Encryption** → Technical + Preventive (not Detective — it doesn't find anything, it stops disclosure)
- **Audit logs** → Technical + Detective (logs themselves don't prevent; reviewing them detects)
- **Policies** → Managerial category, Directive type
- **Training** → Operational category, Preventive/Directive type

## Related concepts

[[Risk Management]] · [[Defense in Depth]] · [[CIA Triad]] · [[NIST 800-53]] · [[ISO 27001]] · [[Gap Analysis]] · [[Zero Trust]]

---
*Source: VIRGIL knowledge base — 2026-05-08*