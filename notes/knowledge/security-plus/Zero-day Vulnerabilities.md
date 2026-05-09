# Zero-day Vulnerabilities

## What it is

In Mortal Kombat, the original arcade release shipped with Reptile as a hidden character no one knew existed — players had to discover the secret fight on The Pit by landing a flawless double-flawless victory under a passing silhouette. The developers knew. Players didn't. That's exactly what a zero-day is — a flaw that exists in the wild but only the attacker knows the input combo to trigger it.

A **zero-day vulnerability** is a software, firmware, or hardware flaw that is unknown to the vendor and unpatched at the time of discovery or exploitation, leaving defenders with zero days to prepare a fix.

## Why it matters

Zero-days bypass signature-based defenses entirely because no signature exists yet — your IDS, AV, and patch management are all blind. They are the preferred tool of nation-state actors and ransomware crews precisely because detection and response are reactive by nature. SY0-701 Objective 2.3 lists "zero-day" explicitly under vulnerability types, and the trap CompTIA sets is conflating zero-day with **unpatched** — a missing Tuesday patch is not a zero-day; it's negligence. Zero-day means the vendor itself has no patch to deploy.

## Key facts

### The lifecycle

| Stage | What happens | Defender's position |
|---|---|---|
| **0-day** | Vuln exists, vendor unaware | Blind |
| **Disclosure** | Researcher or attacker reveals | Race begins |
| **N-day** | Patch released, exploit public | Patch window |
| **Forever-day** | Patch never coming (EOL gear) | Compensating controls only |

### Where they live

- **Operating systems** — kernel privilege escalation, sandbox escapes
- **Browsers** — JavaScript engines (V8, SpiderMonkey), rendering bugs
- **Network appliances** — VPN concentrators, firewalls, edge devices (Ivanti, Fortinet, Citrix have all bled in recent years)
- **Firmware / hardware** — [[Spectre]], [[Meltdown]], baseband processors
- **Supply chain libraries** — [[Log4Shell]] was a zero-day in `log4j` that lit the internet on fire in December 2021

### Who uses them

- **Nation-state actors** — [[APT]] groups stockpile zero-days (see: NSA's EternalBlue, leaked by Shadow Brokers, weaponized as [[WannaCry]])
- **Exploit brokers** — Zerodium, NSO Group; iOS RCE chains have sold for $2M+
- **Ransomware operators** — increasingly burning zero-days for initial access at scale

### Defenses that work without a signature

Since you cannot patch what isn't patched yet, you defend in depth:

| Control | Mechanism |
|---|---|
| **[[Endpoint Detection and Response]] (EDR)** | Behavioral analysis — catches the *action*, not the *exploit* |
| **[[Application Allowlisting]]** | Unknown binary doesn't execute, exploit or not |
| **[[Network Segmentation]]** | Limits blast radius post-compromise |
| **[[Threat Intelligence]] feeds** | IOCs from peer breaches shorten your blind window |
| **[[Virtual Patching]] (WAF / IPS rules)** | Block the exploit pattern at the perimeter while waiting for vendor patch |
| **[[Principle of Least Privilege]]** | RCE as a service account beats RCE as SYSTEM |
| **[[Sandboxing]]** | Detonate suspicious payloads in isolation |

### Exam-precise distinctions

- **Zero-day** ≠ **unpatched known vuln** ≠ **misconfiguration**
- A **CVE** with no patch yet is still a zero-day until the vendor ships a fix
- **N-day** exploitation is what happens when you don't patch fast enough — that's on you, not the vendor

## Related concepts

[[Vulnerability Management]] · [[Patch Management]] · [[Threat Actors]] · [[Advanced Persistent Threat]] · [[Common Vulnerabilities and Exposures]] · [[CVSS]] · [[Indicators of Compromise]] · [[Exploit Kit]] · [[Responsible Disclosure]] · [[Defense in Depth]]

---
*Source: VIRGIL knowledge base — 2026-05-08*