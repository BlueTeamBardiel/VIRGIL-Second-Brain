# CVE — Common Vulnerabilities and Exposures

## What it is

In **Fortnite**, when a new season drops and a weapon gets a balance pass, the patch notes give it an ID — "Heavy Sniper Rifle, damage adjusted, hitbox tuned." Every gun, every glitch, every exploit has a unique identifier so Epic, content creators, and competitive players all reference the same thing when they argue about it. When the Pump Shotgun had the frame-1 swap glitch in Chapter 1, every streamer called it the same thing because there was one canonical name. That's exactly what a **CVE** does — it gives every known software vulnerability a single globally unique ID so the entire industry can talk about the same flaw without confusion.

Technical definition: **Common Vulnerabilities and Exposures** is a public catalog maintained by MITRE (federally funded by CISA) that assigns a unique identifier — formatted `CVE-YYYY-NNNNN` — to each publicly disclosed information security vulnerability. The CVE itself is just the **name and short description**. The severity score lives in a separate but linked system, the **Common Vulnerability Scoring System ([[CVSS]])**, maintained by FIRST.org. CVE = identity. CVSS = severity. Mixing those two up is one of the most common rookie mistakes on the exam and in the war room.

## Why it matters

CVE is the lingua franca of vulnerability management. When your scanner spits out 14,000 findings, every one of them is tagged with a CVE ID. When the CISO asks "are we exposed to Log4Shell?" the only correct answer references `CVE-2021-44228`. When a vendor publishes a patch advisory, it lists the CVEs it fixes. When threat intel feeds light up about active exploitation, they list CVEs. The entire vulnerability management pipeline — scan → prioritize → patch → verify — runs on CVE identifiers as the primary key.

Exam-wise, **Objective 2.3** is built around analyzing vulnerability data to prioritize. CompTIA tests whether you understand that a CVE number alone tells you nothing about urgency — you need the CVSS vector, the exploitability data, the asset context, and the business impact before you make a triage call. They will absolutely show you a CVSS 9.8 critical and a CVSS 6.5 medium and ask which to fix first, and the answer will be the 6.5 because it's on an internet-facing crown jewel with active weaponization and the 9.8 is on an air-gapped lab segment.

## Key facts

### CVE identifier structure

| Component | Example | Meaning |
|---|---|---|
| Prefix | `CVE-` | Fixed string |
| Year | `2021` | Year the CVE was reserved (not always when disclosed) |
| Sequence | `44228` | Arbitrary serial, 4+ digits since 2014 |

CVEs are assigned by **CNAs** (CVE Numbering Authorities) — Microsoft, Red Hat, Cisco, GitHub, and hundreds of others have CNA status and can mint CVEs against their own products. MITRE is the root.

### CVSS — the score attached to the CVE

CVSS v3.1 is current on the exam (v4.0 exists but exam coverage lags). The score is **0.0–10.0** and breaks into three metric groups:

| Group | What it measures | Mutable? |
|---|---|---|
| **Base** | Intrinsic properties of the vuln | No — same everywhere |
| **Temporal** | Changes over time (exploit maturity, patch availability) | Yes — evolves |
| **Environmental** | Your specific environment's exposure | Yes — you set it |

Most scanners and feeds report **Base only**. The Base score is the headline, but it's also the most misleading number in vulnerability management because it assumes a generic worst-case environment.

### CVSS Base metrics — the eight you must know

| Metric | Values | What it asks |
|---|---|---|
| **Attack Vector (AV)** | Network / Adjacent / Local / Physical | How does the attacker reach the vuln? |
| **Attack Complexity (AC)** | Low / High | Does exploitation need special conditions? |
| **Privileges Required (PR)** | None / Low / High | What access does the attacker need first? |
| **User Interaction (UI)** | None / Required | Does a victim have to click something? |
| **Scope (S)** | Unchanged / Changed | Does the exploit jump trust boundaries? |
| **Confidentiality (C)** | None / Low / High | Data disclosure impact |
| **Integrity (I)** | None / Low / High | Data tampering impact |
| **Availability (A)** | None / Low / High | Service disruption impact |

**Scope** is the one people misread constantly. Scope is *Changed* when exploiting the vuln affects resources beyond the vulnerable component's security authority — e.g., a hypervisor escape that lets a guest VM affect the host. That's a CIA hat trick across a trust boundary, and it pushes scores hard.

### Severity rating bands

| CVSS score | Rating |
|---|---|
| 0.1–3.9 | Low |
| 4.0–6.9 | Medium |
| 7.0–8.9 | High |
| 9.0–10.0 | Critical |
| 0.0 | None |

### Context awareness — why the score isn't the answer

CVSS Base assumes the worst case. Real triage layers context on top:

- **Asset value** — is this the domain controller or a meeting-room iPad?
- **Internal vs external exposure** — internet-facing or behind three firewalls?
- **Isolated** — air-gapped, segmented, or freely reachable?
- **Exploitability / weaponization** — is there a working exploit on ExploitDB or only a theoretical PoC?
- **Compensating controls** — WAF, EDR rule, IPS signature already blocking it?
- **Business criticality** — does it run payroll on the 15th?

The **CISA KEV** (Known Exploited Vulnerabilities) catalog is the cheat code here. If a CVE is on KEV, somebody is actively exploiting it in the wild right now. KEV beats CVSS for prioritization — a KEV-listed 7.5 outranks a non-KEV 9.8 in most mature programs.

### Exploit prediction — EPSS

**EPSS** (Exploit Prediction Scoring System) gives a 0–1 probability that a CVE will be exploited in the next 30 days. CVSS asks "how bad if exploited?" EPSS asks "how likely to be exploited?" Stack them together and you get a real prioritization model.

### Zero-day vs n-day

| Term | Meaning |
|---|---|
| **Zero-day** | Vuln exploited before the vendor knows or has a patch — no CVE may exist yet, or CVE is reserved but undisclosed |
| **N-day** | Vuln with a patch available; "n" days since disclosure |

A zero-day might not have a CVE for hours or weeks after first exploitation. The first sign in your environment is usually weird EDR telemetry, not a scanner finding.

### Validation — true/false positives and negatives

| Result | Meaning | Cost of getting it wrong |
|---|---|---|
| **True positive** | Scanner says vulnerable, host actually is | None — work the ticket |
| **False positive** | Scanner says vulnerable, host actually isn't | Wasted analyst hours, alert fatigue |
| **True negative** | Scanner says clean, host actually is | None |
| **False negative** | Scanner says clean, host actually vulnerable | This is the one that gets you breached |

False negatives are the silent killer. A scanner running uncredentialed against a server can miss vulns a credentialed scan would catch in 10 seconds. Validation — manually confirming the finding before opening a ticket or paging an owner — is where mature programs separate from compliance-checkbox programs.

### CompTIA exam traps

> **CompTIA exam trap:** CVE and CVSS are not the same thing. CVE is the *identifier*. CVSS is the *score*. If the question asks "what gives the vulnerability a severity rating," the answer is CVSS, not CVE.

> **CompTIA exam trap:** A CVSS 10.0 is not automatically your top priority. Context (asset value, exposure, compensating controls, KEV status, active weaponization) governs real-world prioritization. CompTIA will give you a scenario where the lower-scored vuln wins triage because it's internet-facing with a public exploit.

> **CompTIA exam trap:** **Scope: Changed** means the vuln impacts resources *beyond* the vulnerable component's security authority — sandbox escape, hypervisor escape, browser-to-OS. It does *not* mean "wider blast radius" in general. Read the wording carefully.

> **CompTIA exam trap:** **Privileges Required: None** plus **User Interaction: None** plus **Attack Vector: Network** is the wormable trifecta. CompTIA loves this combo because that's the EternalBlue / Log4Shell shape.

> **CompTIA exam trap:** Zero-day means no patch exists yet. It does *not* mean "newly disclosed." A vuln disclosed yesterday with a patch available is an n-day, not a zero-day.

## SOC reality

- The Tuesday-morning Tenable or Qualys dashboard shows 47,000 findings across the fleet. The L1 analyst doesn't work them in CVSS order — they work them in **KEV-and-internet-facing-first** order, then EPSS-weighted, then asset criticality. Anyone triaging strictly by CVSS desc is burning hours on lab boxes while the edge web server quietly hosts CVE-2024-something with a working Metasploit module.

- When a fresh CVE drops with media coverage (Log4Shell, MOVEit, ProxyShell), the CISO's first three questions in that order: **"Are we exposed? What's our blast radius? When can we be fully patched?"** You do not answer question one with "we're scanning now" — you answer it with the count of confirmed vulnerable assets, the count of unconfirmed, and your ETA on closing the unconfirmed gap.

- *I learned this the hard way: a "critical" finding on a host the business swore was decommissioned turned out to be the only system that still ran a vendor app for monthly billing reconciliation. The "decommissioned" box was on the internet. Validate asset inventory before you validate the vuln.*

- Never tell leadership "we've patched it" until you've **verified the patch with a re-scan** *and* confirmed the service restarted into the patched binary. Half of failed remediations are patches applied without reboot or service bounce.

- The handoff: L1 confirms the finding isn't a false positive, L2 builds the patching ticket with asset owner and change window, vuln management owns the SLA clock, system owners do the actual remediation, and IR gets involved only if active exploitation is suspected. If you're seeing CVE traffic *and* matching IoCs in the SIEM, that's no longer a vuln management ticket — that's an incident.

## Related concepts

[[CVSS]] · [[CISA KEV]] · [[EPSS]] · [[Vulnerability scanning]] · [[Credentialed vs uncredentialed scans]] · [[False positives]] · [[Zero-day]] · [[Asset inventory]] · [[Patch management]] · [[Threat intelligence]] · [[MITRE ATT&CK]] · [[Risk prioritization]] · [[Compensating controls]] · [[Exploit databases]]

*Source: VIRGIL knowledge base — 2026-05-11*