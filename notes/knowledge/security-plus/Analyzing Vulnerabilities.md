# Analyzing Vulnerabilities

## What it is

In Metal Gear, before Solid Snake breaches Outer Heaven, you scout the compound — noting guard patrol routes, the cardboard box you can hide in, the ventilation ducts no one patched, the door behind which the hostages are held. You don't shoot anything yet. You're cataloging weaknesses, ranking them by exploitability, and deciding which ones matter to the mission. That's exactly what **vulnerability analysis** does — it turns raw scanner output into a prioritized list of weaknesses that actually pose risk to the organization.

**Vulnerability analysis** is the process of validating, scoring, prioritizing, and contextualizing identified weaknesses to determine which require remediation, mitigation, or acceptance.

## Why it matters

A scanner can spit out 40,000 findings; only a fraction will get a CVE published, fewer still are exploitable in your environment, and a handful are actively being weaponized. Without analysis, security teams either chase noise (burning hours on findings behind three layers of compensating controls) or miss the one unauthenticated RCE on an internet-facing box. Exam angle: SY0-701 Objective 4.3 explicitly tests **confirmation (true/false positives, true/false negatives)**, **prioritization**, **CVSS**, **CVE**, **vulnerability classification**, **exposure factor**, **environmental variables**, **industry/organizational impact**, and **risk tolerance**. CompTIA's favorite trap: confusing **CVE** (the identifier) with **CVSS** (the score), or assuming the highest CVSS score automatically wins prioritization — it doesn't, because environmental context can demote a 9.8 on an air-gapped lab box below a 6.5 on the billing server.

## Key facts

### Confirmation: separating real from noise

| Result | Meaning | Consequence |
|---|---|---|
| **True positive** | Scanner flagged it, vuln exists | Triage and remediate |
| **False positive** | Scanner flagged it, vuln doesn't exist | Wasted analyst hours; tune the scanner |
| **True negative** | Scanner clean, no vuln | Desired state |
| **False negative** | Scanner clean, vuln exists | The dangerous one — undetected exposure |

Confirmation usually involves manual verification: re-running [[authenticated scans]], reviewing patch levels, or attempting controlled exploitation in a [[penetration test]].

### Prioritization inputs

- **[[CVSS]] (Common Vulnerability Scoring System)** — 0.0 to 10.0 numeric severity. Composed of **Base**, **Temporal**, and **Environmental** metrics. Severity tiers: 0.1–3.9 Low, 4.0–6.9 Medium, 7.0–8.9 High, 9.0–10.0 Critical.
- **[[CVE]] (Common Vulnerabilities and Exposures)** — the unique identifier (e.g., CVE-2024-3400). It names the bug; it does not score it.
- **[[Exposure factor]]** — percentage of asset value lost if the vuln is exploited. Used in quantitative risk math (SLE = AV × EF).
- **[[Environmental variables]]** — is the asset internet-facing? Does it hold regulated data? Is there a [[WAF]] in front of it? CVSS Environmental metrics adjust the Base score using these.
- **Industry/organizational impact** — a vuln in a medical device hits a hospital harder than a marketing firm; PCI-scope systems demand faster remediation.
- **[[Risk tolerance]]** — the organization's appetite. Low-tolerance environments patch Mediums; high-tolerance ones may accept Highs with compensating controls.
- **Exploit availability** — public PoC code, [[Metasploit]] module, or active exploitation in the wild (see **CISA KEV catalog**) accelerates priority regardless of CVSS.

### Vulnerability classification

| Class | Example |
|---|---|
| **Application** | [[SQL injection]], [[buffer overflow]], [[XSS]] |
| **Operating system** | Unpatched kernel, privilege escalation flaw |
| **Web-based** | [[CSRF]], directory traversal, broken auth |
| **Network** | Weak [[TLS]] ciphers, exposed [[SMB]] (445), open [[Telnet]] (23) |
| **Cloud-specific** | Misconfigured [[S3 bucket]], over-permissive [[IAM]] role |
| **Cryptographic** | Deprecated [[SHA-1]], weak RNG, hardcoded keys |
| **Misconfiguration** | Default credentials, unnecessary services, [[open ports]] |
| **Zero-day** | No CVE yet, no patch available |

### Analysis workflow (exam-friendly order)

1. **Identify** — output from [[vulnerability scanner]] (Nessus, Qualys, OpenVAS).
2. **Confirm** — eliminate false positives via manual validation.
3. **Classify** — by type, asset, and CVE/CVSS.
4. **Prioritize** — apply environmental context, exploitability, and business impact.
5. **Decide response** — **patch**, **mitigate** (compensating control), **transfer** (insurance), or **accept** (risk acceptance with sign-off).
6. **Validate remediation** — rescan to confirm the finding closes.

### CompTIA traps to watch

- **CVE ≠ CVSS.** One identifies, the other scores.
- A **CVSS 10.0** on an isolated test VM is lower priority than a **CVSS 7.5** on the public-facing payment portal.
- **False negatives** are worse than false positives — silence is not safety.
- **[[Zero-day]]** vulnerabilities have no CVE at disclosure and no patch; mitigation relies on detection and segmentation, not signatures.

## Related concepts

[[Vulnerability scanning]] · [[Penetration testing]] · [[CVSS]] · [[CVE]] · [[Risk management]] · [[Patch management]] · [[Threat intelligence]] · [[CISA KEV]] · [[Compensating controls]] · [[Exposure factor]] · [[SLE and ALE]]

---
*Source: VIRGIL knowledge base — 2026-05-08*