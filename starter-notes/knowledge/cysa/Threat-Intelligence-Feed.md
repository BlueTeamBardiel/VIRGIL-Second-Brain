---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Threat Intelligence Feed
**Curated databases of known-bad artifacts that help analysts recognize previously encountered attack indicators in seconds**

---

## Overview

A threat intelligence feed is essentially a crowdsourced library of "digital mugshots"—collections of malicious file hashes, suspicious domains, compromised IP addresses, and malware-hosting URLs that security vendors and researchers have catalogued from real-world attacks. Security analysts subscribe to these feeds to instantly cross-reference indicators they find in their own networks against a global database of known threats, dramatically accelerating investigation triage and response decisions.

---

## Key Concepts

### Indicators of Compromise (IOCs)

**Analogy**: Think of IOCs like license plates of getaway cars—you know the vehicle was used in a crime, so any sighting of that plate gets flagged immediately.

**Definition**: Specific artifacts (file hashes, domain names, IP addresses, URLs) directly observed during past attack campaigns that analysts can hunt for in their own environment.

Related: [[SIEM]], [[EDR]], [[Malware Analysis]]

| IOC Type | Example | Use Case |
|----------|---------|----------|
| File Hash (MD5/SHA256) | `a1b2c3d4e5f6...` | Identify if malware variant exists on disk |
| IP Address | `192.168.1.105` | Block C2 callbacks, flag inbound connections |
| Domain Name | `malware-c2.ru` | Detect DNS queries, flag domain resolution |
| URL | `http://evil.com/payload.exe` | Identify infected files, detect downloads |

### Feed Sources & Reputation Systems

**Analogy**: Different feed providers are like different crime databases—the FBI, local police, and international Interpol all maintain separate records, but a smart detective checks all three.

**Definition**: Multiple public and commercial services ([[VirusTotal]], [[Cisco Talos Intelligence]], [[AlienVault OTX]]) aggregate threat data and assign reputation scores based on how many vendors flagged an IOC as malicious.

**Key Insight**: A single vendor flagging an IOC ≠ high confidence. Cross-referencing multiple feeds reduces false positives.

### The "No Results" Problem

**Analogy**: A mugshot database doesn't contain photos of people who haven't been arrested yet—just because a criminal isn't in the system doesn't mean they're innocent.

**Definition**: When an IOC returns zero hits across threat feeds, it does NOT prove the artifact is safe. It may be:
- Newly weaponized by an attacker (zero-day or custom malware)
- Legitimately used infrastructure being misused temporarily
- Not yet catalogued by vendors

[[Static Analysis]] and [[Dynamic Analysis]] become mandatory when feeds return clean results.

### Infrastructure Reuse & False Positives

**Analogy**: Cloud providers constantly lease and reassign server IPs like a car rental company recycling vehicles. Yesterday's getaway car is today's soccer mom's minivan.

**Definition**: Threat feeds flag malicious IPs and domains based on historical use, but cloud infrastructure (AWS, Azure, GCP) gets recycled constantly. An IP flagged as C2 six months ago may now host a legitimate blog.

**Critical For Analysts**: Always validate timing, check WHOIS registration dates, and correlate with actual suspicious behavior—historical malicious status ≠ current threat.

---

## Analyst Relevance

### Real SOC Scenario

You're triaging a SIEM alert: a user's workstation made an HTTP request to domain `fileserver-update.top`. Your threat feed immediately tags this domain as associated with Emotet botnet activity from Q3 2024.

**What you do next:**
1. Cross-check the alert timestamp—was this request recent or from months ago?
2. Review the user's EDR logs—are there process execution anomalies or suspicious parent processes?
3. Check the domain's current reputation across 3+ independent feeds (not just one source)
4. Investigate the context—did the user actually intend to visit this domain, or was it a drive-by infection?
5. Escalate to containment if behavior confirms current malicious activity

The feed gave you a **starting point**, not a conclusion. Your analysis determines if this is a real compromise or a false alarm triggered by a reused domain.

---

## Exam Tips

### Question Type 1: Interpreting Negative Feed Results
- *"A file hash was submitted to VirusTotal and returned zero detections. What should the analyst conclude?"*
  - **Wrong Answer**: "The file is safe and poses no threat"
  - **Correct Answer**: "The file may be newly weaponized, custom malware, or legitimate. Further analysis (sandbox testing, behavior review, EDR telemetry) is required"
- **Trick**: Exam will try to make you equate "not in feeds" with "not malicious"

### Question Type 2: Cloud Infrastructure Scenarios
- *"An IP address was flagged as malicious in a threat feed from 8 months ago. Today, a user accessed a legitimate web service hosted on that IP with no suspicious indicators. Why might this occur?"*
  - **Correct Answer**: "Cloud IP reuse—the IP was reassigned from an attacker to a legitimate business after the threat activity ended"
- **Trick**: Don't assume historical maliciousness = current threat without correlating other evidence

### Question Type 3: Feed Source Prioritization
- *"Which finding is most actionable: (A) One vendor flagged the hash, (B) Eight vendors flagged the hash, (C) The hash has zero detections?"*
  - **Correct Answer**: **(B)** — consensus across multiple independent vendors = high confidence
  - **Trick**: Single vendor flags can indicate either a novel threat or a false positive; consensus matters

---

## Common Mistakes

### Mistake 1: Treating Feeds as Definitive Truth
**Wrong**: "The threat feed said it's malicious, so I'll immediately isolate the asset without reviewing context"
**Right**: "The threat feed flagged this IOC. Now I'll correlate with timestamps, user behavior, EDR logs, and network context to confirm if this is an actual compromise"
**Impact on Exam**: CySA+ heavily tests threat analyst judgment—feeds are **enrichment tools**, not decision-makers. You will be asked scenarios where feed hits are false alarms.

### Mistake 2: Overweighting Single-Vendor Detections
**Wrong**: "VirusTotal says one vendor flagged this file as malicious, so it's definitely malware"
**Right**: "One vendor detection could be a false positive. Check if 3+ independent vendors agree before escalating"
**Impact on Exam**: Questions will show you IOCs with mixed vendor opinions. You need to know when to investigate further vs. when consensus is strong enough to act immediately.

### Mistake 3: Ignoring Temporal Context
**Wrong**: "This IP was in our threat feed, so any connection to it today is malicious"
**Right**: "Check when the IP was flagged as malicious and whether the organization still owns/controls it. A reused AWS IP from a legitimate company now is different from active C2"
**Impact on Exam**: Real-world SOC work requires you to say "maybe" and dig deeper. Exam questions reward analysts who validate assumptions with timeline evidence.

### Mistake 4: Relying Solely on Feeds Without Analysis
**Wrong**: "The feed returned zero results, so I'll mark this ticket closed—the artifact is safe"
**Right**: "The feed returned zero results. I'll proceed to static/dynamic analysis, EDR review, and sandbox detonation to determine if this is novel malware"
**Impact on Exam**: Expect questions about **what to do after feeds return negative results**. Advanced analysis is mandatory.

---

## Related Topics
- [[Indicators of Compromise (IOCs)]]
- [[SIEM]] enrichment and alert validation
- [[Threat Intelligence]] frameworks (STIX, TAXII)
- [[VirusTotal]] and reputation scoring
- [[Malware Analysis]] (static and dynamic)
- [[EDR]] correlation with feed hits
- [[False Positives]] in alerting
- [[Cloud Infrastructure]] and IP reuse risks
- [[CySA+]]

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | [[Threat Intelligence]]*