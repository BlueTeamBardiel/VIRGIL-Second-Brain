# Security Testing Types

## What it is
Like a hospital running both surprise inspections and scheduled maintenance checks, organizations test security in different ways depending on what they're trying to find. Security testing types are structured methodologies—vulnerability scanning, penetration testing, bug bounties, red teaming, and security audits—each designed to discover weaknesses at different depths and from different perspectives.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records because a known Apache Struts vulnerability went unpatched—a basic vulnerability scan would have flagged it weeks earlier. Had they also run authenticated scans with privileged credentials, internal misconfigurations would have surfaced before attackers exploited them. Choosing the wrong testing type (or none at all) directly maps to catastrophic blind spots.

## Key facts
- **Vulnerability scanning** is automated and non-exploitative; it identifies known weaknesses using CVE databases but cannot confirm actual exploitability
- **Penetration testing** actively exploits vulnerabilities to demonstrate real-world impact; scoped by rules of engagement defining what's in/out of bounds
- **Red team exercises** simulate full adversary campaigns (recon → exploitation → lateral movement) without a defined scope limit, unlike structured pen tests
- **Black box** = no prior knowledge given; **White box** = full system access/documentation provided; **Gray box** = partial knowledge (most common in real engagements)
- **Bug bounty programs** crowdsource discovery using external researchers, rewarding findings by severity; organizations like HackerOne host structured programs with defined payout tiers
- Security **audits** evaluate compliance and controls against a standard (ISO 27001, NIST) rather than actively probing for exploits

## Related concepts
[[Vulnerability Scanning]] [[Penetration Testing]] [[Red Team vs Blue Team]] [[Rules of Engagement]] [[CVE and CVSS Scoring]]