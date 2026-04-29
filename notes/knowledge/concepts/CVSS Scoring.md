# CVSS Scoring

## What it is
Think of CVSS like a triage nurse's checklist in an ER — it doesn't tell you *who* gets treated, but it gives you a standardized, reproducible score to rank how critical each patient (vulnerability) is. The Common Vulnerability Scoring System (CVSS) is an open framework that produces a numerical severity score (0.0–10.0) for vulnerabilities by evaluating characteristics like attack complexity, required privileges, and potential impact on confidentiality, integrity, and availability.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) received a CVSS base score of 10.0 — the maximum — because it required no authentication, was remotely exploitable, and granted full system compromise. This score immediately signaled to every SOC and patch team worldwide that this was a drop-everything emergency, demonstrating how CVSS converts technical complexity into an actionable priority signal.

## Key facts
- **Three metric groups:** Base (inherent vulnerability traits), Temporal (exploit maturity, patch availability), and Environmental (organization-specific context) — Security+ focuses heavily on Base metrics
- **Base score components:** Attack Vector, Attack Complexity, Privileges Required, User Interaction (Exploitability); Confidentiality, Integrity, Availability impact (Impact)
- **Score ranges:** 0.0 = None, 0.1–3.9 = Low, 4.0–6.9 = Medium, 7.0–8.9 = High, 9.0–10.0 = Critical
- **CVSS v3.1 vs v4.0:** v4.0 (released 2023) adds finer granularity and a new "Supplemental" metric group for contextual info that doesn't affect the score
- **CVSS ≠ risk:** A CVSS 9.8 vulnerability on an air-gapped, non-critical system may be lower *risk* than a CVSS 5.0 flaw on an internet-facing payment server — Environmental metrics exist to capture this

## Related concepts
[[Vulnerability Management]] [[CVE]] [[Risk Prioritization]] [[Patch Management]]