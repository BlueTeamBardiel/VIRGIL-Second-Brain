# Security testing

## What it is
Like a locksmith hired to try every key, pick, and bypass technique on your front door *before* a burglar does, security testing is the deliberate, systematic attempt to find weaknesses in systems, networks, and applications. It encompasses a spectrum of methods — from automated vulnerability scanning to manual penetration testing — all aimed at discovering exploitable flaws before adversaries do.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records because a known Apache Struts vulnerability (CVE-2017-5638) went unpatched and undetected. Routine security testing — specifically authenticated vulnerability scanning — would have flagged the outdated component weeks before attackers exploited it, making the difference between a patched server and a catastrophic data breach.

## Key facts
- **Vulnerability scanning** is passive and automated; **penetration testing** is active and simulates real attacker behavior — Security+ distinguishes these explicitly
- The four main security testing types are: vulnerability assessment, penetration test, security audit, and red team exercise — each with increasing attacker realism
- **Rules of Engagement (RoE)** must be documented before any pentest; testing without written authorization is illegal under the CFAA regardless of intent
- CVSS scores (0–10) are used to prioritize findings from security tests; a CVSS ≥ 9.0 is Critical and demands immediate remediation
- **False positives** (flagging safe systems as vulnerable) waste resources; **false negatives** (missing real vulnerabilities) are the more dangerous failure mode in scanners

## Related concepts
[[Penetration Testing]] [[Vulnerability Scanning]] [[CVE and CVSS]] [[Red Team vs Blue Team]] [[OWASP Testing Guide]]