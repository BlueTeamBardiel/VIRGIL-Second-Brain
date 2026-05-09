# Indicators of Compromise

## What it is

In Elden Ring, you walk into a ruined village and notice the bodies are still warm, a Field of Lost Graces flickers wrong, and a Bloody Finger invader's message is scrawled near the bonfire. You weren't there for the attack — but the evidence tells you exactly what happened and that the attacker may still be nearby. That's exactly what **Indicators of Compromise** do — they're the forensic breadcrumbs that prove a system has been or is being attacked.

**Indicators of Compromise (IoCs)** are observable artifacts — log entries, file hashes, network traffic patterns, account behaviors — that signal a security incident has occurred or is in progress.

## Why it matters

IoCs are how defenders detect breaches that prevention controls already missed. Miss the indicators and dwell time stretches from hours to the industry-average 200+ days, during which attackers exfiltrate data, establish persistence, and pivot. For SY0-701, Objective 2.4 explicitly enumerates the IoC list — **account lockouts, concurrent session usage, blocked content, impossible travel, resource consumption/inaccessibility, out-of-cycle logging, published/documented attacks, and missing logs**. CompTIA's favorite trap: confusing an IoC (evidence after the fact) with a control (prevention before the fact), or asking which indicator best matches a scenario where two answers look plausible.

## Key facts

### The SY0-701 IoC list (memorize verbatim)

| Indicator | What it looks like | Likely cause |
|---|---|---|
| **[[Account lockout]]** | User locked out repeatedly | [[Password spraying]], [[brute force attack]] |
| **[[Concurrent session usage]]** | Same account logged in from two places | [[Credential theft]], [[session hijacking]] |
| **[[Blocked content]]** | DLP/proxy blocks suddenly spike | [[Data exfiltration]] attempt, [[malware]] callback |
| **[[Impossible travel]]** | Login from NYC then Moscow 10 minutes later | Stolen credentials, [[token theft]] |
| **[[Resource consumption]]** | CPU, RAM, disk, or bandwidth pegged | [[Cryptojacking]], [[ransomware]] encryption, [[DDoS]] |
| **[[Resource inaccessibility]]** | Files encrypted or services down | [[Ransomware]], [[wiper malware]] |
| **[[Out-of-cycle logging]]** | Activity at 3 AM Sunday from a finance server | Adversary operating in low-visibility windows |
| **[[Missing logs]]** | Gap in log timeline | [[Anti-forensics]], log tampering, [[log wiping]] |
| **[[Published/documented attack]]** | Vendor or [[CISA]] publishes IOCs matching your environment | Known [[APT]] campaign, [[CVE]] exploitation |

### IoC categories by source

- **Host-based**: file hashes ([[MD5]], [[SHA-256]]), registry keys, mutex names, [[scheduled tasks]], unusual process trees
- **Network-based**: suspicious domains, IPs, [[JA3]] fingerprints, [[DNS tunneling]] patterns, [[beaconing]] intervals
- **Behavioral**: [[impossible travel]], privilege escalation events, abnormal data volume, [[lateral movement]]
- **Log-based**: [[Windows Event ID 4625]] (failed logon), 4672 (special privileges), 1102 (audit log cleared)

### IoC vs. IoA

| **Indicator of Compromise (IoC)** | **Indicator of Attack (IoA)** |
|---|---|
| Reactive — proves breach occurred | Proactive — shows attack in progress |
| Hashes, IPs, domains, artifacts | TTPs, behaviors, intent |
| Static, ages quickly | Behavioral, harder to evade |

### Sharing standards

- **[[STIX]]** (Structured Threat Information eXpression) — the data format
- **[[TAXII]]** (Trusted Automated eXchange of Indicator Information) — the transport
- **[[MISP]]** — open-source threat-sharing platform
- **[[OpenIOC]]** — Mandiant's schema, still common

### How IoCs feed defense

- Loaded into [[SIEM]] correlation rules
- Pushed to [[EDR]]/[[XDR]] for endpoint blocking
- Imported into [[firewall]] and [[IDS/IPS]] signatures
- Fed into [[threat intelligence platforms]] for enrichment

### The exam trap

CompTIA will describe a scenario — "a user account logs in from Boston at 9:02 AM and from Lagos at 9:14 AM" — and offer answers like *brute force*, *impossible travel*, *concurrent session*, and *credential stuffing*. The geographic impossibility makes it **impossible travel**, not concurrent session (which is just two simultaneous logins, geography agnostic). Read the scenario, match the exact term.

## Related concepts

[[Threat hunting]] · [[SIEM]] · [[EDR]] · [[Incident response]] · [[Threat intelligence]] · [[MITRE ATT&CK]] · [[Pyramid of Pain]] · [[Dwell time]] · [[Kill chain]]

---
*Source: VIRGIL knowledge base — 2026-05-08*